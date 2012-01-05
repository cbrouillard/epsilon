package com.headbangers.epsilon


class ScheduledJob {
    def timeout = 30000l // execute job once in 5 seconds

    def scheduledService
    def dateUtil
    def notificationService
    
    //cron name:'dev2mn', cronExpression: "0 0/2 * * * ?"
    //cron name: 'touslesjoursa3h', cronExpression: "0 0 3 * * ?"
    static triggers = {
        cron name: 'touslesjoursa3h', cronExpression: "0 0 3 * * ?"
    }

    def execute() {

        def persons = Person.list()

        persons.each { person ->
            log.debug "[ ${person.username} ] ::."

            // getting back all scheduled operations for today and automatic
            def scheduleds = Scheduled.createCriteria().list {
                eq("automatic", true)
                eq("active", true)
                owner{eq("id", person.id)}
                between("dateApplication", dateUtil.getTodayMorning(), dateUtil.getTodayEvening())                
            }

            scheduleds.each { scheduled->
                log.debug ("Treating this scheduled : ${scheduled.name}")
                scheduledService.buildOperationFromScheduled(scheduled)

                // let's go for the next month
                scheduled.dateApplication = dateUtil.getTodayPlusOneMonth()
                    
                if (scheduled.dateLastApplication && scheduled.dateApplication >= scheduled.dateLastApplication){
                    log.debug ("This scheduled is no more active : ${scheduled.name}")
                    scheduled.active = false
                }
                    
                scheduled.save(flush:true)
            }

            if (scheduleds){
                notificationService.sendScheduledDoneMail (person, scheduleds)
            }

        }        
        
    }
}
