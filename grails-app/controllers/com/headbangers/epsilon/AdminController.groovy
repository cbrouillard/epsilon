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
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class AdminController {

    def springSecurityService

    def index = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [persons:Person.list(params), total:Person.count()]
    }

    def showuser = {
        def person = Person.get(params.id)
        if (person){

            [person:person]

        } else {
            flash.message = "Utilisateur introuvable"
            redirect(action:'index')
        }
    }

    def createuser = {
        def person = new Person ()
        person.properties = params
        [person : person]
    }

    def saveuser = {
        def person = new Person(params)

        // encode passwd
        if (params.pass){
            //person.passwd = springSecurityService.passwordEncoder(person.pass)
            person.password = params.pass
        }

        if (person.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'person.label', default: 'Person'), person.username])}"

            def role = Role.findByAuthority ("ROLE_USER")
            if (!role) {
                // Should not happen
                role = new Role(authority: "ROLE_USER").save(flush: true)
            }
            PersonRole.create(person, role, true)
            redirect(action: "index")
        }
        else {
            render(view: "createuser", model: [person: person])
        }
    }

    def edituser = {
        def person = Person.get(params.id)
        if (person){

            [person:person]

        } else {
            flash.message = "Personne introuvable"
            redirect(action:'index')
        }
    }

    def updateuser = {
        def person = Person.get(params.id)
        if (person) {
            if (params.version) {
                def version = params.version.toLong()
                if (person.version > version) {

                    person.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'person.label', default: 'Person')] as Object[], "Another user has updated this Bank while you were editing")
                    render(view: "edituser", model: [person: person])
                    return
                }
            }
            person.properties = params
            if (params.pass){
                //person.password = springSecurityService.passwordEncoder(person.pass)
                person.password = params.pass
            }
            if (!person.hasErrors() && person.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'person.label', default: 'Bank'), person.username])}"
                redirect(action: "index")
            }
            else {
                render(view: "edituser", model: [person: person])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
            redirect(action: "list")
        }
    }

    def deleteuser = {
        def person = Person.get(params.id)
        if (person){

            person.delete(flush:true)
            flash.message = "Personne ${person.username} effacée"

        } else {
            flash.message = "Personne introuvable"
        }

        redirect(action:'index')
    }

    def enableuser = {
        def person = Person.get(params.id)
        if (person){
            person.enabled = true
            person.save(flush:true)
        }
        render(template:'enableactions', model:[person:person])
    }

    def disableuser = {
        def person = Person.get(params.id)
        if (person){
            person.enabled = false
            person.save(flush:true)
        }
        render(template:'enableactions', model:[person:person])
    }
}
