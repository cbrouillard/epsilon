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

import java.util.Calendar

class Snapshot implements Comparable{
    
    static belongsTo = [Account]

    String id
    Account account

    Double amount

    Snapshot previous

    static constraints = {
        previous nullable:true
        account nullable:false
        amount nullable:false
    }

    static mapping = {
        id generator:'uuid'
        autoTimestamp false

    }

    Date dateCreated

    public int compareTo(def other) {
        return other?.dateCreated <=> dateCreated
    }

    private getFirstDayOfMonth (){
        // this method is not really cool... (see DateUtil)
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }

    def beforeInsert ={
        this.dateCreated = getFirstDayOfMonth()
    }
}
