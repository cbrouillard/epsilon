package com.headbangers.epsilon

import grails.plugin.springsecurity.annotation.Secured


@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class ThresholdController {
    def springSecurityService
    def genericService

    def create = {
        def threshold = new Threshold()

        def person = springSecurityService.currentUser
        threshold.owner = person

        def account = genericService.loadUserObject(person, Account.class, params.id)
        if (!account) {
            flash.message = "Unable to load account"
        } else {
            threshold.account = account
        }

        return [threshold: threshold]
    }

    def save = {
        def threshold = new Threshold(params)

        // settings owner
        threshold.owner = springSecurityService.getCurrentUser()

        if (threshold.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'threshold.label', default: 'Threshold'), threshold.name])}"
            redirect(controller: 'operation', action: "list", params: [account: threshold.account.id])
        } else {
            render(view: "create", model: [threshold: threshold])
        }
    }

    def edit = {
        def threshold = Threshold.get(params.id)
        if (!threshold || !threshold.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'threshold.label', default: 'Threshold'), params.id])}"
            redirect(controller: "summary")
        } else {
            return [threshold: threshold]
        }
    }

    def update = {
        def threshold = Threshold.get(params.id)
        if (threshold && threshold.owner.equals(springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (threshold.version > version) {

                    threshold.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'threshold.label', default: 'Threshold')] as Object[], "Another user has updated this Account while you were editing")
                    render(view: "edit", model: [threshold: threshold])
                    return
                }
            }
            threshold.properties = params
            if (!threshold.hasErrors() && threshold.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'threshold.label', default: 'Threshold'), threshold.name])}"
                redirect(controller: 'operation', action: "list", params: [account: threshold.account.id])
            }
            else {
                render(view: "edit", model: [threshold: threshold])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'threshold.label', default: 'Threshold'), params.id])}"
            redirect(controller: "summary")
        }
    }

    def delete = {
        def threshold = Threshold.get(params.id)
        if (threshold && threshold.owner.equals(springSecurityService.currentUser)) {
            def accountId = threshold.account.id
            try {
                threshold.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'threshold.label', default: 'Threshold'), params.id])}"
                redirect(controller: 'operation', action: "list", params: [account: accountId])
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'threshold.label', default: 'Threshold'), params.id])}"
                redirect(controller: 'operation', action: "list", params: [account: accountId])

            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'threshold.label', default: 'Threshold'), params.id])}"
            redirect(controller: 'summary')
        }
    }
}
