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

        Parameter hasPassed = Parameter.findByName('setup.passed')
        if (hasPassed) {
            // setup already done.
            redirect(controller: "summary")
        } else {

            [setup: new SetupObjectCommand()]
        }
    }

    def install = { SetupObjectCommand setup ->

        if (!setup.hasErrors()) {

            def adminRole = Role.findByAuthority('ROLE_ADMIN')
            if (!adminRole) {
                adminRole = new Role(authority: 'ROLE_ADMIN', description: 'Administrateur').save(flush: true)
            }

            def userRole = Role.findByAuthority('ROLE_USER')
            if (!userRole) {
                userRole = new Role(authority: 'ROLE_USER', description: 'Utilisateur').save(flush: true)
            }


            def adminUser = Person.findByUsername('admin')
            if (!adminUser) {
                adminUser = new Person(username: "admin",
                        userRealName: "Administrateur Epsilon",
                        password: setup.adminpassword,
                        enabled: true,
                        email: "no_email@internet.epsilon",
                        emailShow: false,
                        description: "Administrateur Epsilon",
                        accountExpired: false, accountLocked: false, passwordExpired: false).save(flush: true)
            }
            PersonRole.create adminUser, adminRole, true

            if (setup.wantToCreateUser()) {
                def firstUser = new Person(username: setup.username,
                        userRealName: setup.userRealName,
                        password: setup.passwd,
                        enabled: true,
                        email: setup.email,
                        emailShow: false,
                        description: "Premier utilisateur Epsilon",
                        accountExpired: false, accountLocked: false, passwordExpired: false).save(flush: true)

                PersonRole.create firstUser, userRole, true
                springSecurityService.reauthenticate (setup.username, setup.passwd)

            } else {
                springSecurityService.reauthenticate ('admin', setup.adminpassword)
            }

            Parameter setupPassed = new Parameter(type: 'boolean', name: "setup.passed", owner: adminUser, value: "true")
            setupPassed.save(flush: true)

            redirect controller: 'summary'

        } else {
            render view: 'configure', model: [setup: setup]
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
        adminpassword nullable: false, blank: false

        username nullable: true, blank: false
        passwd nullable: true, blank: false
        userRealName nullable: true, blank: false
        email nullable: true, blank: false
    }

    boolean wantToCreateUser() {
        return username && passwd && userRealName && email;
    }

}

