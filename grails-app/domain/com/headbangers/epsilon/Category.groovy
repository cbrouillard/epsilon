package com.headbangers.epsilon

class Category {
    String id
    static hasMany = [operations:Operation]
    static belongsTo = [Person]

    String name
    CategoryType type

    String description
    String color // la couleur dans les graphes

    Person owner

    static constraints = {
        name nullable:false, blank:false
        type nullable:false

        description nullable:true, widget: 'textarea'

        lastUpdated nullable:true
    }

    static mapping = {
        id generator:'uuid'
        description type:'text'
    }

    Date dateCreated
    Date lastUpdated

    def getSold () {
        def sold = 0D
        operations.each{operation ->
            sold += operation.amount
        }
        return sold
    }

    def getMonthOperations (int month){

        
    }
    
    public String toString (){
        return name
    }
}
