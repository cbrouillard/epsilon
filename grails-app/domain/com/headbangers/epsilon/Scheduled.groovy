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

// No extend cause "bad" (in my opinion) Database generation :(
class Scheduled {
    String id
    static belongsTo = [Tiers, Category, Person, Account]
    static hasMany = [pastOperations: Operation]

    OperationType type
    Tiers tiers
    Category category

    Account accountFrom
    Account accountTo // usefull to manage "virement"

    String name
    String note
    Date dateApplication
    Date dateLastApplication //nullable true
    Double amount

    boolean automatic
    boolean active = true

    Person owner

    String cronExpression
    String cronName

    boolean deleted = false

    static constraints = {
        name nullable: false, blank: false
        type nullable: false, blank: false
        tiers nullable: false
        category nullable: false
        accountFrom nullable: false
        accountTo nullable: true

        dateApplication nullable: false
        dateLastApplication nullable: true
        amount nullable: false

        note nullable: true, widget: 'textarea'

        lastUpdated nullable: true
        deleted nullable: true, default: false
        cronExpression nullable: true, blank: true
        cronName nullable: true, blank: true
    }

    static mapping = {
        id generator: 'uuid'
        note type: 'text'
    }

    Date dateCreated
    Date lastUpdated

    def getPastSold() {
        def sold = 0D
        pastOperations.each { operation ->

            def sign = operation.type.getSign()
            if (sign.equals("-")) {
                sold -= operation.amount
            } else {
                sold += operation.amount
            }

        }
        return sold
    }

    public int getApplicationDayInMonth() {
        Calendar cal = Calendar.getInstance();
        cal.setTime(this.dateApplication)
        return cal.get(Calendar.DAY_OF_MONTH)
    }
}
