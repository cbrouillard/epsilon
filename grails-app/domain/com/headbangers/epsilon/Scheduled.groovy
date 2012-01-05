package com.headbangers.epsilon

// No extend cause "bad" (in my opinion) Database generation :(
class Scheduled{
    String id
    static belongsTo = [Tiers, Category, Person, Account]
    static hasMany = [pastOperations:Operation]

    OperationType type
    Tiers tiers
    Category category

    Account accountFrom
    Account accountTo // usefull to manage "virement"

    String name
    String note
    Date dateApplication
    Date dateLastApplication //nullable true
    Double amount

    boolean automatic
    boolean active = true

    Person owner

    static constraints = {
        name nullable:false, blank:false
        type nullable:false, blank:false
        tiers nullable:false
        category nullable:false
        accountFrom nullable:false
        accountTo nullable:true

        dateApplication nullable:false
        dateLastApplication nullable:true
        amount nullable:false

        note nullable:true, widget:'textarea'

        lastUpdated nullable:true
    }

    static mapping = {
        id generator:'uuid'
        note type:'text'
    }

    Date dateCreated
    Date lastUpdated

    def getPastSold() {
        def sold = 0D
        pastOperations.each{ operation ->
            
            def sign = operation.type.getSign()
            if (sign.equals("-")){
                sold -= operation.amount
            } else {
                sold += operation.amount
            }
            
        }
        return sold
    }
}
