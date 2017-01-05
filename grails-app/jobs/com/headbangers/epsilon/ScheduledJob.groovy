/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

package com.headbangers.epsilon

class ScheduledJob {
    def timeout = 30000l // execute job once in 5 seconds

    def scheduledService
    def dateUtil
    def notificationService

    //cron name:'dev5mn', cronExpression: "0 0/5 * * * ?"
    //cron name: 'touslesjoursa3h', cronExpression: "0 0 3 * * ?"
    static triggers = {
        cron name: 'touslesjoursa6h', cronExpression: "0 0 6 * * ?"
    }

    def execute() {

        def persons = Person.list()

        persons.each { person ->
            log.debug "[ ${person.username} ] ::."

            // getting back all scheduled operations for today and automatic
            def scheduleds = Scheduled.createCriteria().list {
                eq("automatic", true)
                eq("active", true)
                owner { eq("id", person.id) }
                between("dateApplication", dateUtil.getTodayMorning(), dateUtil.getTodayEvening())
            }

            scheduleds.each { zeScheduled ->
                log.debug("Treating this scheduled : ${zeScheduled.name}")
                scheduledService.buildOperationFromScheduled(zeScheduled)

                // let's go for the next month
                if (!zeScheduled.cronExpression) {
                    zeScheduled.dateApplication = dateUtil.getTodayPlusOneMonth()
                } else {
                    CronExpression expression = new CronExpression(expression:zeScheduled.cronExpression)
                    Date expressedDate = expression.getNextDate()
                    zeScheduled.dateApplication = expressedDate
                }

                if (zeScheduled.dateLastApplication && zeScheduled.dateApplication > zeScheduled.dateLastApplication) {
                    log.debug("This scheduled is no more active : ${zeScheduled.name}")
                    zeScheduled.active = false
                }

                zeScheduled.save(flush: true)

                // if scheduled is part of loan, then update the loan
                def loan = Loan.createCriteria().get {
                    scheduled { eq("id", zeScheduled.id) }
                }

                if (loan) {
                    log.debug("This scheduled is part of a loan. We have to update it too.")
                    loan.currentCalculatedAmountValue -= loan.refundValue
                    loan.nbPayedMonth += 1
                    loan.save(flush: true)
                }
            }

            if (scheduleds) {
                notificationService.sendScheduledDoneMail(person, scheduleds)
            }

        }

    }
}
