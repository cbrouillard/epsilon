package com.headbangers.epsilon

class Threshold {

    static belongsTo = [Account]

    String id
    String name
    Double value
    String color
    boolean active = true

    static constraints = {
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
