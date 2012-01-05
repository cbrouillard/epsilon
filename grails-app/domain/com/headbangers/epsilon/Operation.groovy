package com.headbangers.epsilon

class Operation /*implements Comparable*/{
    String id
    static belongsTo = [Tiers, Category, Person, Account]

    OperationType type
    Tiers tiers
    Category category
    Account account

    String note
    Date dateApplication
    Double amount

    boolean pointed

    Person owner

    static constraints = {

        type nullable:false, blank:false
        tiers nullable:false
        category nullable:false
        account nullable:false

        dateApplication nullable:false
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

//    public int compareTo(def other) {
//        return dateApplication <=> other?.dateApplication
//    }
//
//    int hashCode (){
//        return (id.hashCode()+dateApplication.hashCode()+dateCreated.hashCode()+type.hashCode())*500*35
//    }
//
//    boolean equals (Object o){
//        return id.equals(o.id) && type.equals(o.type) && dateApplication.equals(o.dateApplication) && dateCreated.equals(o.dateCreated)
//    }

}
