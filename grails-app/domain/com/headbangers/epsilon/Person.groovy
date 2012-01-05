package com.headbangers.epsilon

class Person {
    String id
    transient springSecurityService

    String username
    String password
    boolean enabled
    boolean accountExpired = false
    boolean accountLocked = false
    boolean passwordExpired = false
        
    String userRealName
    String email
    boolean emailShow
        
    String mobileToken

    static constraints = {
        username blank: false, unique: true
        password blank: false
        
        mobileToken (blank:false, nullable:true, unique:true)
        userRealName blank:false
    }

    static mapping = {
        password column: 'passwd'
        id generator:'uuid'
    }

    Set<Role> getAuthorities() {
        PersonRole.findAllByPerson(this).collect { it.role } as Set
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }
}
