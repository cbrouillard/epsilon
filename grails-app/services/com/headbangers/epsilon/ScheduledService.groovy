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

import groovy.transform.EqualsAndHashCode

class ScheduledService {

    def dateUtil

    def findLates(person) {
        return Scheduled.createCriteria().list(order: 'asc', sort: 'dateApplication') {
            owner { eq("id", person.id) }
            lt("dateApplication", dateUtil.getTodayMorning())
            eq("active", true)
        }
    }

    def findToday(person, isAutomatic) {
        return Scheduled.createCriteria().list(order: 'asc', sort: 'dateApplication') {
            owner { eq("id", person.id) }
            between("dateApplication", dateUtil.getTodayMorning(), dateUtil.getTodayEvening())
            eq("automatic", isAutomatic)
            eq("active", true)
        }
    }

    def findFutures(person) {
        return Scheduled.createCriteria().list(order: 'asc', sort: 'dateApplication') {
            owner { eq("id", person.id) }
            gt("dateApplication", dateUtil.getTodayEvening())
            eq("active", true)
            eq("deleted", false)
        }
    }

    def buildOperationFromScheduled(scheduled) {

        if (scheduled.type.equals(OperationType.FACTURE)) {

            def depense = insertOperation(scheduled.accountFrom, scheduled, OperationType.RETRAIT)
            scheduled.addToPastOperations(depense)

        } else if (scheduled.type.equals(OperationType.DEPOT)) {

            def depot = insertOperation(scheduled.accountFrom, scheduled, OperationType.DEPOT)
            scheduled.addToPastOperations(depot)

        } else if (scheduled.type.equals(OperationType.VIREMENT)) {

            def depense = insertOperation(scheduled.accountFrom, scheduled, OperationType.RETRAIT)
            insertOperation(scheduled.accountTo, scheduled, OperationType.DEPOT)

            scheduled.addToPastOperations(depense)
        }

        scheduled.save(flush: true)

    }

    Map<String, Double> buildFutureStats(Person authPerson) {
        Map<String, Double> stats = new HashMap<>();

        Date today = dateUtil.todayMorning
        Date roll = dateUtil.getDatePlusOneMonth(today)
        roll = dateUtil.getDateAtEvening(roll)
        Date roll2 = dateUtil.getDateMinusOneMonth(today)
        roll2 = dateUtil.getDateAtMorning(roll2)

        def depense = 0
        Scheduled.findAllByOwnerAndType(authPerson, OperationType.FACTURE).each { scheduled ->
            if (scheduled.active && !scheduled.deleted) {
                if (scheduled.dateApplication.after(today) && scheduled.dateApplication.before(roll)) {
                    depense += scheduled.amount
                }
            }
        }

        def revenus = this.calculateOneMonthRevenues(authPerson)

        def seuil = depense
        Budget.findAllByOwnerAndStartDateAndEndDateAndActive(authPerson, null, null, true).each { budget ->
            seuil += budget.amount
        }

        stats.put("spent", depense)
        stats.put("revenue", revenus)
        stats.put("threshold", seuil)
        stats.put("saving", revenus - seuil)

        return stats
    }

    Double calculateOneMonthRevenues (Person authPerson){
        Date today = dateUtil.todayMorning
        Date roll2 = dateUtil.getDateMinusOneMonth(today)
        roll2 = dateUtil.getDateAtMorning(roll2)

        def allDepotsOperations = Operation.createCriteria().list({
            owner {
                eq("id", authPerson.id)
            }
            account {
                eq("type", AccountType.CHEQUES)
            }
            between("dateApplication", roll2, today)
            eq("type", OperationType.DEPOT)
            order("dateApplication", "desc")
        })
        Set<LightOperation> withoutDoubles = new HashSet<>()
        allDepotsOperations.each { operation ->
            withoutDoubles.add(new LightOperation(operation))
        }

        return withoutDoubles*.amount.sum(0D);
    }

    class LightOperation {
        String category
        String tiers
        Double amount

        LightOperation(Operation o) {
            category = o.category.name
            tiers = o.tiers.name
            amount = o.amount
        }

        boolean equals(o) {
            if (this.is(o)) return true
            if (getClass() != o.class) return false

            LightOperation that = (LightOperation) o

            if (category != that.category) return false
            if (tiers != that.tiers) return false

            return true
        }

        int hashCode() {
            int result
            result = category.hashCode()
            result = 31 * result + tiers.hashCode()
            return result
        }
    }


    private Operation insertOperation(account, scheduled, type) {
        return new Operation(
                type: type,
                tiers: scheduled.tiers,
                category: scheduled.category,
                account: account,
                note: "Operation créée sur échéance",
                dateApplication: scheduled.dateApplication,
                amount: scheduled.amount,
                owner: scheduled.owner,
                isFromScheduled: true
        ).save(flush: true)
    }

}
