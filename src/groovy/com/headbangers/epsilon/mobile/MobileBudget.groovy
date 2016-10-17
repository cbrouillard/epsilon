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
        
        dBudget.operations.sort({o1, o2 -> o2.dateApplication <=> o1.dateApplication}).each { operation ->
            operations.add(new MobileOperation(operation))
        }
    }
}

