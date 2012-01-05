package com.headbangers.epsilon

import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class BankController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        def person = springSecurityService.getCurrentUser()
        def banks = genericService.loadUserObjects (person, Bank.class, params)

        [bankInstanceList: banks, bankInstanceTotal: banks.totalCount]
    }

    def create = {
        def bankInstance = new Bank()
        bankInstance.properties = params
        return [bankInstance: bankInstance]
    }

    def save = {
        def bankInstance = new Bank(params)

        // setting owner
        bankInstance.owner = springSecurityService.getCurrentUser()

        if (bankInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'bank.label', default: 'Bank'), bankInstance.name])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [bankInstance: bankInstance])
        }
    }

    def show = {
        def bankInstance = Bank.get(params.id)
        if (!bankInstance || !bankInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
            redirect(action: "list")
        }
        else {
            [bankInstance: bankInstance]
        }
    }

    def edit = {
        def bankInstance = Bank.get(params.id)
        if (!bankInstance || !bankInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [bankInstance: bankInstance]
        }
    }

    def update = {
        def bankInstance = Bank.get(params.id)
        if (bankInstance && bankInstance.owner.equals(springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (bankInstance.version > version) {
                    
                    bankInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'bank.label', default: 'Bank')] as Object[], "Another user has updated this Bank while you were editing")
                    render(view: "edit", model: [bankInstance: bankInstance])
                    return
                }
            }
            bankInstance.properties = params
            if (!bankInstance.hasErrors() && bankInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'bank.label', default: 'Bank'), bankInstance.name])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [bankInstance: bankInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def bankInstance = Bank.get(params.id)
        if (bankInstance && bankInstance.owner.equals(springSecurityService.getCurrentUser())) {
            try {
                bankInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'bank.label', default: 'Bank'), bankInstance.name])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'bank.label', default: 'Bank'), bankInstance.name])}"
                redirect(action: "list")
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'bank.label', default: 'Bank'), params.id])}"
            redirect(action: "list")
        }
    }
}
