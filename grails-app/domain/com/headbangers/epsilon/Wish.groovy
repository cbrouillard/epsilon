package com.headbangers.epsilon

class Wish {

    String id
    static belongsTo = [Person]
    
    String name
    String description
    Double price
    String webShopUrl
    
    boolean bought = false
    Date boughtDate
    
    Date previsionBuy
    
    Person owner
    Account account
    
    static constraints = {
        name nullable:false, blank:false
        description nullable:true
        price nullable:false
        webShopUrl nullable:true
        boughtDate nullable:true
        previsionBuy nullable:true
    }
    
    static mapping = {
        id generator:'uuid'
        description type:'text'
    }

    Date dateCreated
    Date lastUpdated
}
