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

class Loan {

    String id
    static belongsTo = [Person]
    
    Double amount
    Double refundValue
    Double currentCalculatedAmountValue
    Double interest
    
    String name
    String description
    
    Scheduled scheduled
    Person owner
    Tiers tiers
    LoanType type
    
    Date calculatedEndDate
    int nbPayedMonth = 0
    
    static constraints = {
        type nullable:false, blank:false
        tiers nullable:false
        owner nullable:false
        amount nullable:false, blank:false
        name nullable:false, blank:false
        currentCalculatedAmountValue nullable:true        
        scheduled nullable:true
        description nullable:true, blank:false, widget:'textarea'
        interest nullable:true
        calculatedEndDate nullable:false
    }
    
    static mapping = {
        id generator:'uuid'
        description type:'text'
    }

    Date dateCreated
    Date lastUpdated
}
