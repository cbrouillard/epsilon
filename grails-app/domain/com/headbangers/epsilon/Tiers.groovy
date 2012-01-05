package com.headbangers.epsilon

class Tiers {
    String id
    static hasMany = [operations:Operation]
    static belongsTo = [Person]

    String name
    String description

    Person owner

    static constraints = {

        name nullable:false, blank:false

        description nullable:true, widget:'textarea'

        lastUpdated nullable:true
    }

    static mapping = {
        id generator:'uuid'
        description type:'text'
    }

    Date dateCreated
    Date lastUpdated

    def getSold (){
        def sold = 0D
        operations.each {operation ->
            sold += operation.amount
        }
        return sold
    }
    
    String toString(){
        return name
    }
}
