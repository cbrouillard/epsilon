package com.headbangers.epsilon

class Role {
    String id
    String authority
    String description

    static mapping = {
        cache true
        id generator:'uuid'
    }

    static constraints = {
        authority blank: false, unique: true
    }
}
