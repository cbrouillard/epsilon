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

class Tiers {
    String id
    static hasMany = [operations: Operation]
    static belongsTo = [Person]

    String name
    String color
    // couleur graph
    String description

    Person owner

    SortedSet<Operation> operations

    Boolean pinned = false

    static constraints = {

        name nullable: false, blank: false
        color nullable: true
        description nullable: true, widget: 'textarea'

        lastUpdated nullable: true

        pinned nullable: true
    }

    static mapping = {
        id generator: 'uuid'
        description type: 'text'
    }

    Date dateCreated
    Date lastUpdated

    def getSold() {
        def sold = 0D
        operations.each {operation ->
            sold += operation.amount
        }
        return sold
    }

    def getMonthOperations() {
        Calendar calendar = Calendar.getInstance();
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
            tiers { eq("id", this.id) }
            owner { eq("id", this.owner.id) }
            between("dateApplication", firstDay, lastDay)
        }

    }

    def getCurrentMonthOperationsSum() {
        def operations = getMonthOperations()

        Double sum = 0D
        if (operations) {
            operations.each { oneOp ->
                sum += oneOp.amount
            }
        }

        return sum
    }

    String toString() {
        return name
    }
}
