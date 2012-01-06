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

class OperationService {

    boolean transactional = true

    def dateUtil

    def findAllDepenseForThisMonth(person) {
        return Operation.createCriteria ().list (sort:'dateApplication', order:'desc'){
            owner{eq("id", person.id)}
            category{eq("type", CategoryType.DEPENSE)}
            between("dateApplication", dateUtil.getFirstDayOfTheMonth(), dateUtil.getLastDayOfTheMonth())
        }
    }

    def findAllRevenuForThisMonth (person) {
        return Operation.createCriteria ().list (sort:'dateApplication', order:'desc'){
            owner{eq("id", person.id)}
            category{eq("type", CategoryType.REVENU)}
            between("dateApplication", dateUtil.getFirstDayOfTheMonth(), dateUtil.getLastDayOfTheMonth())
        }
    }

    def findAllOperationsForMonth (concernedAccount, date) {
        return Operation.createCriteria ().list (sort:'dateApplication', order:'desc'){
            account{eq("id", concernedAccount.id)}
            between("dateApplication", dateUtil.getFirstDayOfTheMonth(date), dateUtil.getLastDayOfTheMonth(date))
        }
    }

    def calculateDepenseForThisMonth (person){
        def operations = findAllDepenseForThisMonth(person)
        def amount = 0D
        operations.each {operation ->
            amount += operation.amount
        }

        return amount
    }

    def calculateRevenuForThisMonth (person){
        def operations = findAllRevenuForThisMonth(person)
        def amount = 0D
        operations.each {operation ->
            amount += operation.amount
        }

        return amount
    }
}
