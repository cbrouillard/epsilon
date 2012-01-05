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

