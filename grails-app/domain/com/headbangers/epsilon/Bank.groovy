package com.headbangers.epsilon

class Bank {
    String id
    static hasMany = [accounts:Account]
    static belongsTo = [Person]

    String name
    String description
    String url

    Person owner

    static constraints = {
        url nullable:true, blank:false
        name nullable:false, blank:false
        description nullable:true, widget:'textarea'
        lastUpdated nullable:true
        owner nullable:false
    }

    static mapping = {
        id generator:'uuid'
        description type:'text'
    }

    Date dateCreated
    Date lastUpdated
}
