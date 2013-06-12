/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

package com.headbangers.epsilon

class Person {
    String id
    transient springSecurityService
    
    static hasMany = [parameters:Parameter]

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

        mobileToken (blank:false, nullable:true)
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
