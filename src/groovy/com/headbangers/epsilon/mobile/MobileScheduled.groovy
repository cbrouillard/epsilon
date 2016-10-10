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

package com.headbangers.epsilon.mobile

import com.headbangers.epsilon.Scheduled

class MobileScheduled {

    String id
    String type
    String tiers
    String category

    String note
    Date dateApplication
    Double amount
    String sign
    boolean automatic
    String cronName
    Date lastApplication

    public MobileScheduled(){

    }

    public MobileScheduled(Scheduled dScheduled){
        this.id = dScheduled.id
        this.type = dScheduled.type.name()
        this.tiers = dScheduled.tiers.name
        this.category = dScheduled.category.name
        this.note = dScheduled.note
        this.dateApplication = dScheduled.dateApplication
        this.amount = dScheduled.amount
        this.sign = dScheduled.type.sign

        this.automatic = dScheduled.automatic
        this.cronName = dScheduled.cronName
        this.lastApplication = dScheduled.dateLastApplication
    }
}

