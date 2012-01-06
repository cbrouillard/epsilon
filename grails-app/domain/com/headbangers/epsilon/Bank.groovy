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

class Bank {
    String id
    static hasMany = [accounts:Account]
    static belongsTo = [Person]

    String name
    String description
    String url

    Person owner

    static constraints = {
        url nullable:true, blank:false
        name nullable:false, blank:false
        description nullable:true, widget:'textarea'
        lastUpdated nullable:true
        owner nullable:false
    }

    static mapping = {
        id generator:'uuid'
        description type:'text'
    }

    Date dateCreated
    Date lastUpdated
}
