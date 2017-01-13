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

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class ScheduledController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService
    def categoryService
    def tiersService
    def scheduledService
    def dateUtil
    def snapshotService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)


        def person = springSecurityService.getCurrentUser()
        def scheduleds = Scheduled.createCriteria().list(params) {
            eq 'deleted', false
            owner { eq("id", person.id) }
        }

        Map<String, Double> stats = scheduledService.buildFutureStats(person)

        [scheduledInstanceList: scheduleds, scheduledInstanceTotal: scheduleds.totalCount, depense: stats.spent, revenus: stats.revenue, seuil: stats.threshold]
    }

    def create = {
        def scheduledInstance = new Scheduled()
        scheduledInstance.properties = params

        // loading reference data
        def person = springSecurityService.getCurrentUser()
        def accounts = genericService.loadUserObjects(person, Account.class)

        return [scheduledInstance: scheduledInstance, accounts: accounts]
    }

    private def save(Scheduled scheduledInstance, CategoryType type, params) {
        def person = springSecurityService.getCurrentUser()
        scheduledInstance.owner = person

        if (params["category.name"]) {
            scheduledInstance.category = categoryService.findOrCreateCategory(person, params["category.name"], type)
        }

        if (params["tiers.name"]) {
            scheduledInstance.tiers = tiersService.findOrCreateTiers(person, params["tiers.name"])
        }

        if (scheduledInstance.automatic && params.cronExpressionChoice) {
            CronExpression cron = CronExpression.get(params.cronExpressionChoice)
            scheduledInstance.cronExpression = cron.expression
            scheduledInstance.cronName = cron.name
        }

        if (scheduledInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'scheduled.label', default: 'Scheduled'), scheduledInstance.id])}"
            return true
        }

        return false
    }

    def savefacture = {
        def scheduledInstance = new Scheduled(params)
        scheduledInstance.type = OperationType.FACTURE
        if (save(scheduledInstance, CategoryType.DEPENSE, params)) {
            redirect(action: "list")
        } else {
            def accounts = genericService.loadUserObjects(springSecurityService.getCurrentUser(), Account.class)
            render(view: "create", model: [scheduledInstance: scheduledInstance, accounts: accounts, tabToDisplay: 'facture'])
        }
    }

    def savedepot = {
        def scheduledInstance = new Scheduled(params)
        scheduledInstance.type = OperationType.DEPOT
        if (save(scheduledInstance, CategoryType.REVENU, params)) {
            redirect(action: "list")
        } else {
            def accounts = genericService.loadUserObjects(springSecurityService.getCurrentUser(), Account.class)
            render(view: "create", model: [scheduledInstance: scheduledInstance, accounts: accounts, tabToDisplay: 'depot'])
        }
    }

    def savevirement = {
        def scheduledInstance = new Scheduled(params)
        scheduledInstance.type = OperationType.VIREMENT
        params["tiers.name"] = springSecurityService.getCurrentUser().userRealName
        if (save(scheduledInstance, CategoryType.VIREMENT, params)) {
            redirect(action: "list")
        } else {
            def accounts = genericService.loadUserObjects(springSecurityService.getCurrentUser(), Account.class)
            render(view: "create", model: [scheduledInstance: scheduledInstance, accounts: accounts, tabToDisplay: 'virement'])
        }
    }

    def edit = {
        def scheduledInstance = Scheduled.get(params.id)
        if (!scheduledInstance || !scheduledInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'scheduled.label', default: 'Scheduled'), params.id])}"
            redirect(action: "list")
        } else {
            return [scheduledInstance: scheduledInstance]
        }
    }

    def update = {
        def person = springSecurityService.getCurrentUser()
        def scheduledInstance = Scheduled.get(params.id)
        if (scheduledInstance && scheduledInstance.owner.equals(person)) {
            if (params.version) {
                def version = params.version.toLong()
                if (scheduledInstance.version > version) {

                    scheduledInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'scheduled.label', default: 'Scheduled')] as Object[], "Another user has updated this Scheduled while you were editing")
                    render(view: "edit", model: [scheduledInstance: scheduledInstance])
                    return
                }
            }

            if (params["categoryname"] && !params["categoryname"].equals(scheduledInstance.category.name)) {
                def category = categoryService.findOrCreateCategory(person, params["categoryname"], scheduledInstance.category.type)
                scheduledInstance.category = category
                params.remove("categoryname")
            }

            if (params["tiersname"] && !params["tiersname"].equals(scheduledInstance.tiers.name)) {
                def tiers = tiersService.findOrCreateTiers(person, params["tiersname"])
                scheduledInstance.tiers = tiers
                params.remove("tiersname")
            }

            if (params.automatic && params.cronExpressionChoice) {
                CronExpression cron = CronExpression.get(params.cronExpressionChoice)
                scheduledInstance.cronExpression = cron.expression
                scheduledInstance.cronName = cron.name
            } else {
                scheduledInstance.cronExpression = null
                scheduledInstance.cronName = null
            }

            scheduledInstance.properties = params

            if (!scheduledInstance.hasErrors() && scheduledInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'scheduled.label', default: 'Scheduled'), scheduledInstance.name])}"
                redirect(action: "list")
            } else {
                render(view: "edit", model: [scheduledInstance: scheduledInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'scheduled.label', default: 'Scheduled'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def scheduledInstance = Scheduled.get(params.id)
        if (scheduledInstance && scheduledInstance.owner.equals(springSecurityService.getCurrentUser())) {
            try {
                scheduledInstance.deleted = true
                scheduledInstance.active = false
                scheduledInstance.save(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'scheduled.label', default: 'Scheduled'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'scheduled.label', default: 'Scheduled'), params.id])}"
                redirect(action: "list")
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'scheduled.label', default: 'Scheduled'), params.id])}"
            redirect(action: "list")
        }
    }

    def apply = {
        def person = springSecurityService.getCurrentUser()
        def scheduled = genericService.loadUserObject(person, Scheduled.class, params.id)

        if (scheduled) {

            scheduledService.buildOperationFromScheduled(scheduled)

            // if the operation's date is less than the last snapshot
            if (scheduled.dateApplication.before(scheduled.accountFrom.lastSnapshot.dateCreated)) {
                log.error("We have to sync the snapshot")
                snapshotService.sync(scheduled.accountFrom, scheduled.dateApplication)

                if (scheduled.accountTo) {
                    snapshotService.sync(scheduled.accountTo, scheduled.dateApplication)
                }
            }

            scheduled.dateApplication = dateUtil.getDatePlusOneMonth(scheduled.dateApplication)

            redirect(controller: "summary")

        } else {
            redirect(action: "list")
        }
    }

    def jump = {
        // the (almost) same code as apply ... not really cool :(
        def person = springSecurityService.getCurrentUser()
        def scheduled = genericService.loadUserObject(person, Scheduled.class, params.id)

        if (scheduled) {

            scheduled.dateApplication = dateUtil.getDatePlusOneMonth(scheduled.dateApplication)

            redirect(controller: "summary")

        } else {
            redirect(action: "list")
        }
    }

    def deactivate = {
        def person = springSecurityService.getCurrentUser()
        def scheduled = genericService.loadUserObject(person, Scheduled.class, params.id)

        if (scheduled) {
            scheduled.active = false
            scheduled.save(flush: true)

            render(template: 'activateactions', model: [scheduled: scheduled])
        } else {
            redirect(action: "list")
        }

    }

    def activate = {
        def person = springSecurityService.getCurrentUser()
        def scheduled = genericService.loadUserObject(person, Scheduled.class, params.id)

        if (scheduled) {
            scheduled.active = true
            scheduled.save(flush: true)

            render(template: 'activateactions', model: [scheduled: scheduled])
        } else {
            redirect(action: "list")
        }
    }

    def search = {
        def person = springSecurityService.getCurrentUser()

        def scheduled = Scheduled.createCriteria().list(params) {
            ilike("name", "%${params.query}%")
            owner { eq("id", person.id) }
        }

        Map<String, Double> stats = scheduledService.buildFutureStats(person)

        render(view: 'list', model: [scheduledInstanceList: scheduled, scheduledInstanceTotal: scheduled.size(), query: params.query,
                                     depense              : stats.spent, revenus: stats.revenue, seuil: stats.threshold])

    }

    def simpleautocomplete() {
        def person = springSecurityService.getCurrentUser()
        def scheduled = Scheduled.createCriteria().list {
            owner { eq("id", person.id) }
            ilike("name", "${params.query}%")
        }

        render scheduled*.name as JSON
        return
    }

}
