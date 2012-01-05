package com.headbangers.epsilon
import grails.plugins.springsecurity.Secured

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
        def accounts = genericService.loadUserObjects (person, Account.class, params)

        [accountInstanceList: accounts, accountInstanceTotal: accounts.totalCount]
    }

    def create = {
        def accountInstance = new Account()
        accountInstance.properties = params

        // reference data
        def person = springSecurityService.getCurrentUser()
        def banks = genericService.loadUserObjects (person, Bank.class)

        return [accountInstance: accountInstance, banks:banks]
    }

    def save = {
        def accountInstance = new Account(params)

        // settings owner
        accountInstance.owner = springSecurityService.getCurrentUser()

        // new snapshot
        def snapshot = new Snapshot (account:accountInstance, amount:accountInstance.amount)
        accountInstance.addToSnapshots (snapshot)

        if (accountInstance.save(flush:true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.name])}"
            redirect(action: "list")
        }
        else {
            // reference data
            def person = springSecurityService.getCurrentUser()
            def banks = genericService.loadUserObjects (person, Bank.class)
            render(view: "create", model: [accountInstance: accountInstance, banks:banks])
        }
    }

    def show = {
        def accountInstance = Account.get(params.id)
        if (!accountInstance || !accountInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), params.id])}"
            redirect(action: "list")
        }
        else {
            [accountInstance: accountInstance]
        }
    }

    def edit = {
        def accountInstance = Account.get(params.id)
        if (!accountInstance || !accountInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [accountInstance: accountInstance]
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
            if (!accountInstance.hasErrors() && accountInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.name])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [accountInstance: accountInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def accountInstance = Account.get(params.id)
        if (accountInstance && accountInstance.owner.equals(springSecurityService.getCurrentUser())) {
            try {
                accountInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.name])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'account.label', default: 'Account'), accountInstance.name])}"
                redirect(action: "list")
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'account.label', default: 'Account'), params.id])}"
            redirect(action: "list")
        }
    }

    def activateAccountForMobile = {
        accountService.activateAccountForMobile (springSecurityService.getCurrentUser(), Account.get(params.id))
        redirect(action:'list')
    }
}
