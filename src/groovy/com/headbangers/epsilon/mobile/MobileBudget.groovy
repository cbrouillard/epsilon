package com.headbangers.epsilon.mobile

import com.headbangers.epsilon.*

/**
 *
 * @author cyril
 */
class MobileBudget {

    String id
    String name
    
    Double maxAmount
    Double usedAmount
    
    String note
    
    List<MobileCategory> categories = new ArrayList<MobileCategory>()
    List<MobileOperation> operations = new ArrayList<MobileOperation>()
    
    public MobileBudget (){
    }
    
    public MobileBudget (dBudget){
        this.id = dBudget.id
        this.name = dBudget.name
        this.maxAmount = dBudget.amount
        this.usedAmount = dBudget.currentMonthOperationsSum
        this.note = dBudget.note
        
        dBudget.attachedCategories.each  { category -> 
            categories.add (new MobileCategory(category))
        }
        
        dBudget.operations.each { operation ->
            operations.add(new MobileOperation(operation))
        }
    }
}

