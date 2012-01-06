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

class SetupController {

    def springSecurityService
    
    def configure = {
        
        [setup : new SetupObjectCommand()]
    }
    
    def install = { SetupObjectCommand setup ->
    
        if (!setup.hasErrors()) {

            // Création de l'utilisateur admin
            //            def user_admin = new Person(username:"admin",
            //                userRealName:"Administrateur Epsilon",
            //                passwd: md5pass,
            //                enabled:true,
            //                email:"no_email@internet.epsilon",
            //                emailShow:false,
            //                description:"Administrateur Epsilon").save(flush:true)
            
            // Création du premier utilisateur
            //            def firstUser = new Person(username:setup.username,
            //                userRealName:setup.userRealName,
            //                passwd: userPass,
            //                enabled:true,
            //                email:setup.email,
            //                emailShow:false,
            //                description:"Premier utilisateur Epsilon").save(flush:true)
            //            
            //            PersonRole.create (user_admin, role_admin, true);
            //            PersonRole.create (firstUser, role_user, true);
            
            
            def adminRole = new Role(authority: 'ROLE_ADMIN', description:'Administrateur').save(flush: true) 
            def userRole = new Role(authority: 'ROLE_USER', description:'Utilisateur').save(flush: true)

            def adminUser = new Person(username:"admin",
                userRealName:"Administrateur Epsilon",
                password: setup.adminpassword,
                enabled:true,
                email:"no_email@internet.epsilon",
                emailShow:false,
                description:"Administrateur Epsilon",
                accountExpired:false, accountLocked:false, passwordExpired:false).save(flush:true) 
            
            def firstUser = new Person(username:setup.username,
                userRealName:setup.userRealName,
                password: setup.passwd,
                enabled:true,
                email:setup.email,
                emailShow:false,
                description:"Premier utilisateur Epsilon",
                accountExpired:false, accountLocked:false, passwordExpired:false).save(flush:true)

            PersonRole.create adminUser, adminRole, true
            PersonRole.create firstUser, userRole, true
            
            redirect controller:'summary'
            
        } else {
            render view:'configure', model:[setup:setup]
        }
    
    }
}

class SetupObjectCommand {
	
    String adminpassword
    String username
    String passwd
    String userRealName
    String email
    
    static constraints = {
        adminpassword nullable:false, blank:false
        username nullable:false, blank:false
        passwd nullable:false, blank:false
        userRealName nullable:false, blank:false
        email nullable:false, blank:false
    }
    
}

