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

import com.headbangers.epsilon.*

class MobileOperation {

    String id
    String type
    String tiers
    String category

    String note
    Date dateApplication
    Double amount
    String sign

    boolean pointed

    String latitude
    String longitude

    public MobileOperation (){
        
    }

    public MobileOperation (dOperation){
        this.id = dOperation.id
        this.type = dOperation.type.name()
        this.tiers = dOperation.tiers.name
        this.category = dOperation.category.name
        this.note = dOperation.note
        this.dateApplication = dOperation.dateApplication
        this.amount = dOperation.amount
        this.pointed = dOperation.pointed
        this.sign = dOperation.type.sign
        this.latitude = dOperation.latitude
        this.longitude = dOperation.longitude
    }

    public void  initScheduled (dScheduled){
        this.id = dScheduled.id
        this.type = dScheduled.type.name()
        this.tiers = dScheduled.tiers.name
        this.category = dScheduled.category.name
        this.note = dScheduled.note
        this.dateApplication = dScheduled.dateApplication
        this.amount = dScheduled.amount
        this.sign = dScheduled.type.sign
    }
}

