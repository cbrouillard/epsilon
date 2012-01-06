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

class Category {
    String id
    static hasMany = [operations:Operation]
    static belongsTo = [Person]

    String name
    CategoryType type

    String description
    String color // la couleur dans les graphes

    Person owner

    static constraints = {
        name nullable:false, blank:false
        type nullable:false

        description nullable:true, widget: 'textarea'

        lastUpdated nullable:true
    }

    static mapping = {
        id generator:'uuid'
        description type:'text'
    }

    Date dateCreated
    Date lastUpdated

    def getSold () {
        def sold = 0D
        operations.each{operation ->
            sold += operation.amount
        }
        return sold
    }

    def getMonthOperations (int month){

        
    }
    
    public String toString (){
        return name
    }
}
