package com.headbangers.epsilon.mobile

import com.headbangers.epsilon.*

class MobileAccount {

    String id
    String bank
    String name
    String type

    Date dateOpened
    Double sold

    String description
    boolean mobileDefault

    List<MobileOperation> lastFiveOperations = new ArrayList<MobileOperation>()

    public MobileAccount (){
    }

    public MobileAccount (dAccount){
        this.id = dAccount.id
        this.bank = dAccount.bank.name
        this.name = dAccount.name
        this.type = dAccount.type.name()
        this.dateOpened = dAccount.dateOpened
        this.sold = dAccount.getSold()
        this.mobileDefault = dAccount.mobileDefault

        def operations = dAccount.getLastNOperations(5)
        operations.each{operation ->
            lastFiveOperations.add (new MobileOperation (operation))
        }
    }
}

