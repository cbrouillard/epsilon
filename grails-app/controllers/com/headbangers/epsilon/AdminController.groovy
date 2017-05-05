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

@Secured(['ROLE_ADMIN'])
class AdminController {

    def springSecurityService
    def notificationService

    def index = {
        redirect(action: "users")
    }

    def testplatform = {
        render(view: 'testplatform')
    }

    def users = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        render(view: "index", model: [persons: Person.list(params), total: Person.count()])
    }

    def crons = {
        render(view: 'crons', model: [newExpression: null])
    }

    def validatecron = {
        def cron = new CronExpression()
        cron.expression = params.expression
        render(view: 'crons', model: [newExpression: cron])
    }

    def editcron = {
        def cron = CronExpression.get(params.id)
        render(view: 'crons', model: [newExpression: cron])
    }

    def deletecron = {
        def cron = CronExpression.get(params.id)
        cron.delete(flush: true)
        redirect(action: "crons")
    }

    def savecron = {
        def cron = null
        if (params.id) {
            cron = CronExpression.get(params.id)
        }
        if (!cron) {
            cron = new CronExpression()
        }
        cron.expression = params.expression
        cron.name = params.name
        if (!cron.name) {
            cron.name = "CRON: " + cron.expression
        }

        if (!cron.validateProperly()) {
            render(view: 'crons', model: [newExpression: cron])
            return
        } else {
            cron.save(flush: true)
            redirect(action: "crons")
        }
    }

    def createuser = {
        def person = new Person()
        person.properties = params
        [person: person]
    }

    def saveuser = {
        def person = new Person(params)

        // encode passwd
        if (params.pass) {
            //person.passwd = springSecurityService.passwordEncoder(person.pass)
            person.password = params.pass
        }

        if (person.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'person.label', default: 'Person'), person.username])}"

            def role = Role.findByAuthority("ROLE_USER")
            if (!role) {
                // Should not happen
                role = new Role(authority: "ROLE_USER").save(flush: true)
            }
            PersonRole.create(person, role, true)
            redirect(action: "index")
        } else {
            render(view: "createuser", model: [person: person])
        }
    }

    def setadminuser = {
        def person = Person.get(params.id)
        def role = Role.findByAuthority("ROLE_ADMIN")

        if (params.role == 'true') {
            PersonRole.create(person, role, true)
        } else {
            PersonRole.remove(person, role, true)
        }

        render(template: 'setadminactions', model: [person: person])
    }

    def edituser = {
        def person = Person.get(params.id)
        if (person) {

            [person: person]

        } else {
            flash.message = "Personne introuvable"
            redirect(action: 'index')
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
            if (params.pass) {
                //person.password = springSecurityService.passwordEncoder(person.pass)
                person.password = params.pass
            }
            if (!person.hasErrors() && person.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'person.label', default: 'Bank'), person.username])}"
                redirect(action: "index")
            } else {
                render(view: "edituser", model: [person: person])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
            redirect(action: "list")
        }
    }

    def deleteuser = {
        def person = Person.get(params.id)
        if (person) {
            person.accountLocked = true
            person.enabled = false
            person.save(flush: true)
            flash.message = "Personne ${person.username} effacée"

        } else {
            flash.message = "Personne introuvable"
        }

        redirect(action: 'index')
    }

    def enableuser = {
        def person = Person.get(params.id)
        if (person) {
            person.enabled = true
            person.save(flush: true)
        }
        render(template: 'enableactions', model: [person: person])
    }

    def disableuser = {
        def person = Person.get(params.id)
        if (person) {
            person.enabled = false
            person.save(flush: true)
        }
        render(template: 'enableactions', model: [person: person])
    }

    def sendmail = {
        def fakeScheduled = new ArrayList<Scheduled> ()
        def user_admin = springSecurityService.getCurrentUser()

        def bank = new Bank (name:"FAKE Bank",
            description:"FAKE Test Bank",
            owner:user_admin)
        def tiers = new Tiers (
            name:"Epsilon Enterprise",
            description:"Ma société",
            owner:user_admin)
        def category = new Category (
            name:"FAKE Category",
            type:CategoryType.DEPENSE,
            description:"Dépense pour FAKE.",
            owner:user_admin)
        def account = new Account (name:"Compte FAKE",
            bank:bank,
            type: AccountType.CHEQUES,
            dateOpened:new Date(),
            amount: 1000.8784D,
            description:"Un compte de test",
            owner:user_admin)

        def scheduled = new Scheduled (
            type:OperationType.FACTURE,
            tiers:tiers,
            category:category,
            accountFrom:account,
            name:"Echeance test",
            dateApplication:new Date(),
            amount:45D,
            automatic:true, owner:user_admin)

        fakeScheduled.add (scheduled)
        notificationService.sendScheduledDoneMail (user_admin, fakeScheduled)
        flash.message = "Mail sent. Check your mail (${user_admin.email})"
        render (view:"testplatform")
    }
}
