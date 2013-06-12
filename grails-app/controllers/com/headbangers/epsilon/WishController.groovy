package com.headbangers.epsilon

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class WishController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        def person = springSecurityService.getCurrentUser()
        def wishes = genericService.loadUserObjects (person, Wish.class, params)

        [wishInstanceList: wishes, wishInstanceTotal: wishes.totalCount]
    }

    def create() {

        def person = springSecurityService.getCurrentUser()
        def accounts = Account.findAllByOwner(person)

        [wishInstance: new Wish(params), accounts: accounts]
    }

    def save() {

        def person = springSecurityService.getCurrentUser()
        def wishInstance = new Wish(params)

        wishInstance.owner = person

        if (!wishInstance.save(flush: true)) {
            def accounts = Account.findAllByOwner(person)
            render(view: "create", model: [wishInstance: wishInstance, accounts: accounts])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'wish.label', default: 'Wish'), wishInstance.id])
        redirect(action: "list")
    }

    def create_operation() {
        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)


        if (!wishInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
            return
        }

        params.remove("id")
        def operationInstance = new Operation()
        operationInstance.amount = wishInstance.price
        bindData(operationInstance, params)

        [wishInstance: wishInstance, operationInstance: operationInstance]
    }

    def save_operation() {
        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)

        // Création de l'opération
    }

    def show() {
        def wishInstance = Wish.get(params.id)
        def person = springSecurityService.getCurrentUser()

        if (!wishInstance || !wishInstance.owner.equals(person)) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
            return
        }

        [wishInstance: wishInstance]
    }

    def edit() {

        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)

        if (!wishInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
            return
        }

        def accounts = Account.findAllByOwner(person)
        [wishInstance: wishInstance, accounts: accounts]
    }

    def update() {
        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)

        if (!wishInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (wishInstance.version > version) {
                wishInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'wish.label', default: 'Wish')] as Object[],
                        "Another user has updated this Wish while you were editing")
                render(view: "edit", model: [wishInstance: wishInstance])
                return
            }
        }

        wishInstance.properties = params

        if (!wishInstance.save(flush: true)) {
            render(view: "edit", model: [wishInstance: wishInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'wish.label', default: 'Wish'), wishInstance.id])
        redirect(action: "list")
    }

    def delete() {
        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)

        if (!wishInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
            return
        }

        try {
            wishInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
