package com.headbangers.epsilon

class Threshold {

    static belongsTo = [Account, Person]

    String id
    String name
    Double value
    String color
    boolean active = true

    Person owner
    Account account

    static constraints = {
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
