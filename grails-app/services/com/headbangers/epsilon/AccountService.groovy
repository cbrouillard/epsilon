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

class AccountService {

    boolean transactional = true

    def dateUtil
    def operationService

    def selectAccount(person, accountId) {

        return Account.createCriteria().get {
            owner {eq("id", person.id)}
            eq("id", accountId)
            maxResults(1)
        }

    }

    def rebuildAllSnapshots (){

        def accounts = Account.list ()

        accounts.each {account ->
            log.error "Treating this account ${account.name}"
            def date = account.dateCreated
            def amount = account.amount

            applyMonthAndBuildSnapshot(account, amount, date, null);
        }
    }

    private applyMonthAndBuildSnapshot (account, amount, date, previousSnapshot){
        // getting all operations for the date's month
        log.error "I have this amount : ${amount}, for this date ${date}"
        def operations = operationService.findAllOperationsForMonth (account, date)
        operations.each{ operation ->
            if (operation.type.equals (OperationType.RETRAIT)
                || operation.type.equals (OperationType.VIREMENT_MOINS)){
                amount -= operation.amount
            } else if (operation.type.equals (OperationType.DEPOT)
                || operation.type.equals (OperationType.VIREMENT_PLUS)){
                amount += operation.amount
            }
        }
        log.error "Calculated amount is ${amount}"
        
        def datePlusOneMonth = dateUtil.getDatePlusOneMonth (date)
        def currentMonth = dateUtil.getMonth ()

        def snapshot = new Snapshot (dateCreated:dateUtil.getFirstDayOfTheMonth(datePlusOneMonth),
            account:account, amount:amount, previous:previousSnapshot).save(flush:true)

        if (currentMonth > dateUtil.getMonth (datePlusOneMonth)){
            applyMonthAndBuildSnapshot (account, amount, datePlusOneMonth, snapshot)
        }
    }

    def desactivateAllAcountForMobile (person) {
        def accounts = Account.findAllByOwner (person)
        accounts.each {account ->
            account.mobileDefault = false;
            account.save()
        }
    }

    def activateAccountForMobile (person, account){
        desactivateAllAcountForMobile (person)
        account.mobileDefault = true
        account.save()
    }

    def getDefaultMobileAccount (person){
        return Account.findByOwnerAndMobileDefault (person, true)
    }
}
