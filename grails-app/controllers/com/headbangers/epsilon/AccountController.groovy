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
class AccountController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService
    def accountService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        def person = springSecurityService.getCurrentUser()
        def accounts = genericService.loadUserObjects(person, Account.class, params)

        [accountInstanceList: accounts, accountInstanceTotal: accounts.totalCount]
    }

    def create = {
        def accountInstance = new Account()
        accountInstance.properties = params

        // reference data
        def person = springSecurityService.getCurrentUser()
        def banks = genericService.loadUserObjects(person, Bank.class)

        return [accountInstance: accountInstance, banks: banks]
    }

    def save = {
        def accountInstance = new Account(params)

        // settings owner
        accountInstance.owner = springSecurityService.getCurrentUser()

        // new snapshot
        def snapshot = new Snapshot(account: accountInstance, amount: accountInstance.amount)
        accountInstance.addToSnapshots(snapshot)

        if (accountInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.name])}"
            redirect(action: "list")
        } else {
            // reference data
            def person = springSecurityService.getCurrentUser()
            def banks = genericService.loadUserObjects(person, Bank.class)
            render(view: "create", model: [accountInstance: accountInstance, banks: banks])
        }
    }

    def edit = {

        def person = springSecurityService.getCurrentUser()
        def banks = genericService.loadUserObjects(person, Bank.class)
        def accountInstance = Account.get(params.id)

        if (!accountInstance || !accountInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), params.id])}"
            redirect(action: "list")
        } else {
            return [accountInstance: accountInstance, banks: banks]
        }
    }

    def update = {
        def accountInstance = Account.get(params.id)
        if (accountInstance && accountInstance.owner.equals(springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (accountInstance.version > version) {

                    accountInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'account.label', default: 'Account')] as Object[], "Another user has updated this Account while you were editing")
                    render(view: "edit", model: [accountInstance: accountInstance])
                    return
                }
            }
            accountInstance.properties = params

            if (params.forcedAmount){
                accountInstance.getLastSnapshot().amount = Double.parseDouble(params.forcedAmount)
                accountInstance.getLastSnapshot().save()
            }

            if (!accountInstance.hasErrors() && accountInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.name])}"
                redirect(action: "list")
            } else {
                render(view: "edit", model: [accountInstance: accountInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), params.id])}"
            redirect(action: "list")
        }
    }

    def addjoin = {
      def accountInstance = Account.get(params.id)
      if (accountInstance && accountInstance.owner.equals(springSecurityService.getCurrentUser())) {
        render view: 'join', model: [account: accountInstance, users: Person.findAllByEnabled(true)]
      } else {
        redirect(action: "list")
      }
    }

    def setjoin = {
      def accountInstance = Account.get(params.id)
      if (accountInstance && accountInstance.owner.equals(springSecurityService.getCurrentUser())) {

          Person person = Person.findById (params.p)
          if (person && person.enabled){
            accountInstance.joinOwner = person;
            accountInstance.save(flush:true)
          }

      }

      redirect (action : "list")
    }

    def deljoin = {
      def accountInstance = Account.get(params.id)
      if (accountInstance && accountInstance.owner.equals(springSecurityService.getCurrentUser())) {
        accountInstance.joinOwner = null;
        accountInstance.save(flush:true)
      }

      redirect (action : "list")
    }

    def delete = {
        def accountInstance = Account.get(params.id)
        if (accountInstance && accountInstance.owner.equals(springSecurityService.getCurrentUser())) {
            try {
                accountInstance.snapshots.clear()
                accountInstance.operations.clear()
                Scheduled.findAllByAccountFromOrAccountTo(accountInstance, accountInstance).each { oneScheduled ->
                    oneScheduled.delete()
                }
                Wish.findAllByAccount(accountInstance).each { oneScheduled ->
                    oneScheduled.delete()
                }
                accountInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.name])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.name])}"
                redirect(action: "list")
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), params.id])}"
            redirect(action: "list")
        }
    }

    def activateAccountForMobile = {
        accountService.activateAccountForMobile(springSecurityService.getCurrentUser(), Account.get(params.id))
        redirect(action: 'list')
    }

    def linkdocument() {
        def person = springSecurityService.getCurrentUser()
        def account = Account.findByIdAndOwner(params.id, person)
        def document = Document.findByIdAndOwner(params.docId, person)

        if (document && account) {
            account.addToDocuments(document)
            account.save(flush: true)

            flash.message = "Le document est maintenant lié au compte"
            redirect(controller: 'document', action: document.type.toString().toLowerCase() + 's')
        } else {
            flash.message = "Impossible de lier le compte demandé"
            if (document) {
                redirect(controller: 'document', action: 'linkto', id: document.id)
            } else {
                redirect(controller: 'summary')
            }

        }
    }

    def listdocuments() {
        def person = springSecurityService.getCurrentUser()
        def account = Account.findByIdAndOwner(params.id, person)

        if (account) {

            render view: 'documents', model: [account: account]

        } else {
            redirect(action: "list")
        }
    }
}
