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
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class PersonController {

    static allowedMethods = [edit: "GET", update: "POST", parameterize:"POST"]
    
    def springSecurityService
    def parameterService

    def infos = {
        
        def person = springSecurityService.getCurrentUser()
        
        def parameters = new HashMap<String, String>()
        person.parameters.each{parameter -> 
            parameters.put (parameter.name, parameter.value)
        }
        
        [person : person, parameters:parameters]
        
    }
    
    def activateMobile = {

        def person = springSecurityService.getCurrentUser()

        def dbPerson = Person.get(person.id)
        dbPerson.mobileToken = UUID.randomUUID()
        dbPerson.mobileToken = dbPerson.mobileToken.replaceAll("-", "")
        dbPerson.save(flush:true)

        render (template:'/summary/mobile', model:[person:dbPerson])

    }

    def deactivateMobile = {

        def person = springSecurityService.getCurrentUser()
        
        def dbPerson = Person.get(person.id)
        dbPerson.mobileToken = null
        dbPerson.save(flush:true)

        render (template:'/summary/mobile', model:[person:dbPerson])
    }
    
    def edit = {
        def person = springSecurityService.getCurrentUser()
        [person : person]
    }
    
    def update = {
        
        def personId = springSecurityService.getCurrentUser().id
        def person = Person.get(personId)
        if (person) {
            
            def oldPass = person.password
            person.properties = params

            // Set password if needed
            person.password = params.pass ? params.pass : oldPass
            
            person.merge()
            if (!person.hasErrors() && person.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'person.label', default: 'Bank'), person.username])}"
                redirect(action: "infos")
            }
            else {
                render(view: "edit", model: [person: person])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Bank'), params.id])}"
            redirect(controller:'summary')
        }
        
    }
    
    def parameterize = {
        def person = springSecurityService.getCurrentUser()
        parameterService.setBayesianFilterParameter (person, params.bayesian_filter?true:false)
        redirect (action:'infos')
    }
}
