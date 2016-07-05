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

class Budget {

    String id
    static belongsTo = [Person]
    static hasMany = [attachedCategories: Category]

    String name
    String note
    Double amount

    Person owner

    boolean active = true

    Date startDate
    Date endDate

    static constraints = {
        name nullable: false, blank: false
        amount nullable: false

        note nullable: true, widget: 'textarea'

        startDate nullable:true
        endDate nullable:true

        lastUpdated nullable: true
    }

    static mapping = {
        id generator: 'uuid'
        note type: 'text'
    }

    def getOperations() {
        Date firstDay
        Date lastDay

        Calendar calendar = Calendar.getInstance();

        if (this.startDate || this.endDate){

            if (this.startDate) {
                calendar.setTime(this.startDate)
            } else {
                calendar.set(Calendar.DAY_OF_MONTH, 1);
            }

            calendar.set(Calendar.HOUR_OF_DAY, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 0);
            calendar.set(Calendar.MILLISECOND, 0);
            firstDay = calendar.getTime()

            if (this.endDate){
                calendar.setTime(this.endDate)
            } else {
                calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            }

            calendar.set(Calendar.HOUR_OF_DAY, 23);
            calendar.set(Calendar.MINUTE, 59);
            calendar.set(Calendar.SECOND, 59);

            lastDay = calendar.getTime()

        } else {

            calendar.set(Calendar.DAY_OF_MONTH, 1);
            calendar.set(Calendar.HOUR_OF_DAY, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 0);
            calendar.set(Calendar.MILLISECOND, 0);

            firstDay = calendar.getTime()

            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            calendar.set(Calendar.HOUR_OF_DAY, 23);
            calendar.set(Calendar.MINUTE, 59);
            calendar.set(Calendar.SECOND, 59);

            lastDay = calendar.getTime()
        }

        // renvoie, pour le mois en cours, la somme des dépenses effectuées
        // pour ce budget
        // 1. chercher toutes les opérations DEPENSE ayant pour catégorie une de celles
        // présentes dans attachedCategories pour le mois actuel !

        def operations = Operation.createCriteria().list() {
            owner {eq("id", this.owner.id)}
            between("dateApplication", firstDay, lastDay)
            if (this.attachedCategories) {
                'in'("category", this.attachedCategories)
            }
            eq("type", OperationType.RETRAIT)
        }

        return operations
    }

    def getCurrentMonthOperationsSum() {
        def operations = getOperations()

        Double sum = 0

        operations.each {oneOp ->
            sum += oneOp.amount
        }

        return sum
    }


    Date dateCreated
    Date lastUpdated
}
