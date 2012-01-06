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

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class LoanController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService
    
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        def person = springSecurityService.getCurrentUser()
        def loans = genericService.loadUserObjects (person, Loan.class, params)
        
        [loanInstanceList: loans, loanInstanceTotal: loans.totalCount]
    }

    def create = {
        def loanInstance = new Loan()
        loanInstance.properties = params
        return [loanInstance: loanInstance]
    }

    def save = {
        def loanInstance = new Loan(params)
        if (loanInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'loan.label', default: 'Loan'), loanInstance.id])}"
            redirect(action: "show", id: loanInstance.id)
        }
        else {
            render(view: "create", model: [loanInstance: loanInstance])
        }
    }

    def show = {
        def loanInstance = Loan.get(params.id)
        if (!loanInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
            redirect(action: "list")
        }
        else {
            [loanInstance: loanInstance]
        }
    }

    def edit = {
        def loanInstance = Loan.get(params.id)
        if (!loanInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [loanInstance: loanInstance]
        }
    }

    def update = {
        def loanInstance = Loan.get(params.id)
        if (loanInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (loanInstance.version > version) {
                    
                    loanInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'loan.label', default: 'Loan')] as Object[], "Another user has updated this Loan while you were editing")
                    render(view: "edit", model: [loanInstance: loanInstance])
                    return
                }
            }
            loanInstance.properties = params
            if (!loanInstance.hasErrors() && loanInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'loan.label', default: 'Loan'), loanInstance.id])}"
                redirect(action: "show", id: loanInstance.id)
            }
            else {
                render(view: "edit", model: [loanInstance: loanInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def loanInstance = Loan.get(params.id)
        if (loanInstance) {
            try {
                loanInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])}"
            redirect(action: "list")
        }
    }
}
