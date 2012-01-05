package com.headbangers.epsilon
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class PersonController {

    static allowedMethods = [edit: "POST", update: "POST"]
    
    def springSecurityService

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
    
    def infos = {
        
        def person = springSecurityService.getCurrentUser()
        [person : person]
        
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
            if (params.pass){
                person.password = springSecurityService.passwordEncoder(person.pass)
            } else {
                person.password = oldPass
            }
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
}
