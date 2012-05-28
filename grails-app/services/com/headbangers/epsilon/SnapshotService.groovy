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

class SnapshotService {

    def dateUtil

    def sync(accountToSync, date) {
        log.debug "Syncing this account : ${accountToSync.name} for all snapshots concerned by this date : ${date}"

        // getting all snapshots created after the date
        def snapshots = Snapshot.createCriteria().list (order:'asc', sort:'dateCreated'){
            account{eq("id", accountToSync.id)}
            ge ("dateCreated", dateUtil.getFirstDayOfTheMonth(date))
        }

        // for each snapshots
        snapshots.each { snapshot ->            
            // reinit the amount (recalculate it)
            snapshot.amount = calculateSnapshotAmount(snapshot)
            snapshot.save()
        }
    }

    private calculateSnapshotAmount (snapshot){
        log.debug "Calculating the new snapshot amount (${snapshot}) - ${snapshot.dateCreated}"
        // getting back all operations for this snapshot (between the snapshot dateCreated and the 1st of the previous month)
        def operations = Operation.createCriteria().list (order:'asc', sort:'dateApplication'){
            account{eq("id", snapshot.account.id)}
            between ("dateApplication",dateUtil.getDateMinusOneMonth(snapshot.dateCreated), snapshot.dateCreated )
        }

        def amount = snapshot.previous ? snapshot.previous.amount : snapshot.account.amount
        operations.each { operation ->
            log.debug "This operation is available : ${operation} ${operation.type} ${operation.amount}"
            if (operation.type.equals (OperationType.RETRAIT)
                || operation.type.equals (OperationType.VIREMENT_MOINS)){
                amount -= operation.amount
            } else if (operation.type.equals (OperationType.DEPOT)
                || operation.type.equals (OperationType.VIREMENT_PLUS)){
                amount += operation.amount
            }
        }
        log.debug "Calculated amount for this snapshot is ${amount}"
        return amount
    }
}
