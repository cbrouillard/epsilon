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

import java.text.DecimalFormat

class Account {
    String id
    static belongsTo = [Bank, Person]
    static hasMany = [operations: Operation, snapshots: Snapshot, thresholds: Threshold]
    static transients = ['tmpAmount']

    static Double tmpAmount

    SortedSet snapshots
    //    SortedSet operations

    Bank bank
    String name
    AccountType type

    Date dateOpened
    Double amount

    String description

    Person owner

    boolean mobileDefault = false

    static constraints = {
        bank nullable: false
        name nullable: false, blank: false
        type nullable: false, blank: false
        dateOpened nullable: false
        amount nullable: false

        description nullable: true, widget: 'textarea'

        lastUpdated nullable: true
    }

    static mapping = {
        id generator: 'uuid'
        description type: 'text'
    }

    Date dateCreated
    Date lastUpdated

    def getLastSnapshot() {
        // return the last registered snapshot for this account
        // snapshots are always sorted (by date), all we have to do is to take the first in the list
        if (this.snapshots && this.snapshots.size() > 0) {
            return this.snapshots.first()
        }

        return null;
    }

    def getSnapshot(int byMonth) {
        // reste dans la meme année ex: 0, mois actuel 5
        Calendar cal = Calendar.getInstance()
        def currentMonth = cal.get(Calendar.MONTH)

        if (this.snapshots && this.snapshots.size() > 0) {
            return this.snapshots.getAt(Math.abs(currentMonth - byMonth))
        }

        return null;
    }

    def getNameAndSold() {
        return "${name} = ${getFormattedSold()}€"
    }

    def getSold() {
        // getting last snapshot amount
        def lastSnapshot = getLastSnapshot()
        def realAmount = lastSnapshot ? lastSnapshot.amount : this.amount
        // iterating through last operations
        def operations = getLastOperations()
        operations.each { operation ->
            if (operation.type.equals(OperationType.RETRAIT)
                    || operation.type.equals(OperationType.VIREMENT_MOINS)) {
                realAmount -= operation.amount
            } else if (operation.type.equals(OperationType.DEPOT)
                    || operation.type.equals(OperationType.VIREMENT_PLUS)) {
                realAmount += operation.amount
            }
        }
        return realAmount
    }

    def getFormattedSold() {
        return new DecimalFormat("###,###.##").format(getSold())
    }

    def getLastOperations() {
        // getting last snapshot
        def snapshot = getLastSnapshot()
        // now getting all operations on this account with dateApplication >= snapshot.dateCreated
        return Operation.createCriteria().list(order: 'asc', sort: 'dateApplication') {
            account { eq("id", this.id) }
            owner { eq("id", this.owner.id) }
            if (snapshot) {
                ge("dateApplication", snapshot.dateCreated)
            }
        }
    }

    def getLastNOperations(n) {
        return Operation.createCriteria().list() {
            account { eq("id", this.id) }
            owner { eq("id", this.owner.id) }
            maxResults(n)
            order("dateApplication", "desc")
        }
    }

    def lastOperationsByMonth(int month) {

        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, month);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        Date firstDay = calendar.getTime()

        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);

        Date lastDay = calendar.getTime()

        return Operation.createCriteria().list(order: 'asc', sort: 'dateApplication') {
            account { eq("id", this.id) }
            owner { eq("id", this.owner.id) }
            between("dateApplication", firstDay, lastDay)
        }
    }

    String toString() {
        return name
    }

}
