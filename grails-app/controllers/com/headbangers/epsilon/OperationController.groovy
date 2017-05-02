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
import org.hibernate.Criteria

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class OperationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def grailsApplication

    def springSecurityService
    def genericService
    def accountService
    def categoryService
    def tiersService
    def snapshotService
    def dateUtil
    def exportService
    def bayesClassifierService
    def operationService

    def parameterService

    def index = {
        redirect(action: "list", params: params)
    }

    def export = {


        def person = springSecurityService.getCurrentUser()
        def selectedAccount = accountService.selectAccount(person, params["account"])
        def month = params.int('month')

        def operations = selectedAccount.lastOperationsByMonth(month);

        response.contentType = grailsApplication.config.grails.mime.types[params.format]
        response.setHeader("Content-disposition", "attachment; filename=EPSILON_operations_${message("code": "month.${month}")}.${params.extension}")

        List fields = ["account", "type", "dateApplication", "tiers", "category", "amount", "pointed", "sold"]
        Map labels = ["account": "Compte", "type": "Type", "dateApplication": "Date", "tiers": "Tiers", "category": "Catégorie", "amount": "Montant", "pointed": "Pointée", "sold": "Solde"]


        def dateFormater = { domain, value ->
            return formatDate("date": value, "format": "dd/MM/yyyy")
        }

        def decimalFormater = { domain, value ->
            def sign = domain.type.getSign()
            return "${sign}${formatNumber("number": value, "format": "0.##")}€"
        }

        def booleanFormater = { domain, value ->
            return value ? "Oui" : "Non"
        }

        selectedAccount.tmpAmount = selectedAccount.lastSnapshot.amount
        def calculateSold = { domain, value ->
            def sign = domain.type.getSign()
            if (sign.equals("-")) {
                domain.account.tmpAmount -= domain.amount
            } else {
                domain.account.tmpAmount += domain.amount
            }
            return formatNumber("number": domain.account.tmpAmount, "format": "0.##") + "€"
        }

        Map parameters = [title: "Liste des opérations pour le mois de " + message("code": "month.${month}"), "pdf.orientation": "portrait", "xml.encoding": "UTF-8"]
        Map formatters = [dateApplication: dateFormater, amount: decimalFormater, pointed: booleanFormater, sold: calculateSold]

        exportService.export(params.format, response.outputStream, operations, fields, labels, formatters, parameters)
    }

    def list = {
        def person = springSecurityService.getCurrentUser()
        def accounts = genericService.loadUserObjects(person, Account.class) // select all user account (for selector)

        // the first account will be the default chosen one
        def selectedAccount = accountService.selectAccount(person, params["account"])
        if (!selectedAccount && accounts && accounts.size() > 0) {
            selectedAccount = accounts.get(0)
        }

        def currentMonth = dateUtil.getMonth(null)
        def month = params["byMonth"] != null ? params.int('byMonth') : currentMonth

        def graphData = Operation.executeQuery(
                'select c.name, sum(o.amount) from Operation o inner join o.category c inner join o.account a where o.dateApplication >= ? and o.dateApplication <= ? and (o.type = ? or o.type = ?) and a.id = ? group by c.name',
                [dateUtil.getFirstDayOfTheMonth(), dateUtil.getLastDayOfTheMonth(), OperationType.DEPOT, OperationType.VIREMENT_PLUS, selectedAccount.id]).asList()

        graphData += Operation.executeQuery(
                'select c.name, - sum(o.amount) from Operation o inner join o.category c inner join o.account a where o.dateApplication >= ? and o.dateApplication <= ? and (o.type = ? or o.type = ? or o.type = ?) and a.id = ? group by c.name',
                [dateUtil.getFirstDayOfTheMonth(), dateUtil.getLastDayOfTheMonth(), OperationType.FACTURE, OperationType.RETRAIT, OperationType.VIREMENT_MOINS, selectedAccount.id]).asList()

        Calendar cal = Calendar.getInstance()
        cal.set(Calendar.MONTH, month)
        def depense = operationService.calculateDepenseForThisMonthByAccount(person, selectedAccount, cal.getTime())
        def revenu = operationService.calculateRevenuForThisMonthByAccount(person, selectedAccount, cal.getTime())

        def lastDayOfMonth = dateUtil.getLastDayOfTheMonth(new Date())
        def programmedScheduleds = Scheduled.createCriteria().list {
            createAlias('accountTo', 'accountTo', Criteria.LEFT_JOIN)
            createAlias('accountFrom', 'accountFrom', Criteria.LEFT_JOIN)
            lte("dateApplication", lastDayOfMonth)
            eq("active", true)
            eq("deleted", false)
            gt("dateApplication", new Date())
            or {
                eq("accountTo.id", selectedAccount.id)
                eq("accountFrom.id", selectedAccount.id)
            }
        }

        if (!programmedScheduleds) {
            Date todayPlusOneMonth = dateUtil.getDatePlusOneMonth(new Date())
            def lastDayOfNextMonth = dateUtil.getLastDayOfTheMonth(todayPlusOneMonth)
            programmedScheduleds = Scheduled.createCriteria().list {
                createAlias('accountTo', 'accountTo', Criteria.LEFT_JOIN)
                createAlias('accountFrom', 'accountFrom', Criteria.LEFT_JOIN)
                lte("dateApplication", lastDayOfNextMonth)
                gt("dateApplication", new Date())
                eq("active", true)
                eq("deleted", false)
                or {
                    eq("accountTo.id", selectedAccount.id)
                    eq("accountFrom.id", selectedAccount.id)
                }
            }
        }

        def operationsInFuture = Operation.createCriteria().list({
            gt("dateApplication", lastDayOfMonth)
            eq("account.id", selectedAccount.id)
        })

        programmedScheduleds += operationsInFuture

        [accounts    : accounts, selected: selectedAccount, byMonth: month,
         currentMonth: currentMonth, graphData: graphData,
         depense     : depense, revenu: revenu, futures: programmedScheduleds]
    }

    private def save(Operation operationInstance, CategoryType type, params) {
        def person = springSecurityService.getCurrentUser()
        operationInstance.owner = person
        if (params["category.name"]) {
            // we search for the category, if we don't find it then auto-create
            operationInstance.category = categoryService.findOrCreateCategory(person, params["category.name"], type)
        }
        if (params["tiers.name"]) {
            // we search for the category, if we don't find it then auto-create
            operationInstance.tiers = tiersService.findOrCreateTiers(person, params["tiers.name"])
        }

        if (operationInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'operation.label', default: 'Operation'), operationInstance.id])}"

            // if the operation's date is less than the last snapshot
            if (operationInstance.dateApplication.before(operationInstance.account.lastSnapshot.dateCreated)) {
                log.error("We have to sync the snapshot")
                snapshotService.sync(operationInstance.account, operationInstance.dateApplication)
            }
            return true
        }

        return false
    }

    private def reloadlist(type, params, operationInstance) {
        def accounts = genericService.loadUserObjects(springSecurityService.getCurrentUser(), Account.class)
        def selectedAccount = accountService.selectAccount(springSecurityService.getCurrentUser(), operationInstance.account.id)
        def currentMonth = dateUtil.getMonth(null)
        render(view: "list", model: [tabToDisplay: type, operationInstance: operationInstance, accounts: accounts, selected: selectedAccount, currentMonth: currentMonth])
    }

    def saveretrait = {
        def operationInstance = new Operation(params)
        operationInstance.type = OperationType.RETRAIT
        if (save(operationInstance, CategoryType.DEPENSE, params)) {
            redirect(action: "list", params: ["account": operationInstance.account.id])
        } else {
            reloadlist('retrait', params, operationInstance)
        }
    }

    def savevirement = {
        def person = springSecurityService.getCurrentUser()
        def accountTo = accountService.selectAccount(person, params["account.to"])
        if (accountTo) {
            params.remove("account.to")
            params["tiers.name"] = person.userRealName

            def operationMoins = new Operation(params)
            operationMoins.type = OperationType.VIREMENT_MOINS

            def operationPlus = new Operation(params)
            operationPlus.type = OperationType.VIREMENT_PLUS
            operationPlus.account = accountTo

            if (save(operationMoins, CategoryType.VIREMENT, params)
                    && save(operationPlus, CategoryType.VIREMENT, params)) {
                // ok
                redirect(action: "list", params: ["account": operationMoins.account.id])
            } else {
                reloadlist('virement', params, operationMoins)
            }

        } else {
            reloadlist('virement', params)
        }
    }

    def savedepot = {
        def operationInstance = new Operation(params)
        operationInstance.type = OperationType.DEPOT
        if (save(operationInstance, CategoryType.REVENU, params)) {
            redirect(action: "list", params: ["account": operationInstance.account.id])
        } else {
            reloadlist('depot', params, operationInstance)
        }
    }

    def location() {
        String mapsApiKey = grailsApplication.config.epsilon.maps.api.key

        def operationInstance = Operation.get(params.id)
        if (!operationInstance || !operationInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'operation.label', default: 'Operation'), params.id])}"
            redirect(action: "list")
        } else {
            [operationInstance: operationInstance, apiKey: mapsApiKey]
        }
    }

    def edit = {
        def person = springSecurityService.getCurrentUser()
        def operationInstance = Operation.get(params.id)
        if (operationInstance && (operationInstance.owner.equals(person) || operationInstance.account.owner.equals(person)||operationInstance.account.joinOwner?.equals(person))) {
          return [operationInstance: operationInstance]
        } else {
          flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'operation.label', default: 'Operation'), params.id])}"
          redirect(action: "list")
        }
    }

    def update = {
        def person = springSecurityService.getCurrentUser()
        def operationInstance = Operation.get(params.id)
        if (operationInstance && (operationInstance.owner.equals(person) || operationInstance.account.owner.equals(person)||operationInstance.account.joinOwner?.equals(person))) {
            if (params.version) {
                def version = params.version.toLong()
                if (operationInstance.version > version) {

                    operationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'operation.label', default: 'Operation')] as Object[], "Another user has updated this Operation while you were editing")
                    render(view: "edit", model: [operationInstance: operationInstance])
                    return
                }
            }

            if (params["categoryname"]) {
                // we search for the category, if we don't find it then auto-create
                operationInstance.category = categoryService.findOrCreateCategory(person, params["categoryname"], operationInstance.category.type)
                params.remove("categoryname")
            }
            if (params["tiersname"]) {
                // we search for the category, if we don't find it then auto-create
                operationInstance.tiers = tiersService.findOrCreateTiers(person, params["tiersname"])
                params.remove("tiersname")
            }

            operationInstance.properties = params
            if (!operationInstance.hasErrors() && operationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'operation.label', default: 'Operation'), operationInstance.id])}"

                // if the operation's date is less than the last snapshot
                if (operationInstance.dateApplication.before(operationInstance.account.lastSnapshot.dateCreated)) {
                    log.error("We have to sync the snapshot")
                    snapshotService.sync(operationInstance.account, operationInstance.dateApplication)
                }

                redirect(action: "list", params: [account: operationInstance.account.id])
            } else {
                render(view: "edit", model: [operationInstance: operationInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'operation.label', default: 'Operation'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def person = springSecurityService.getCurrentUser()
        def operationInstance = Operation.get(params.id)
        if (operationInstance && (operationInstance.owner.equals(person) || operationInstance.account.owner.equals(person)||operationInstance.account.joinOwner?.equals(person))) {
            try {
                operationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'operation.label', default: 'Operation'), params.id])}"
                redirect(action: "list", params: [account: operationInstance.account.id])
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'operation.label', default: 'Operation'), params.id])}"
                redirect(action: "list")
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'operation.label', default: 'Operation'), params.id])}"
            redirect(action: "list")
        }
    }

    def point = {
        def operation = genericService.loadUserObject(springSecurityService.getCurrentUser(), Operation.class, params.id)
        if (operation) {
            operation.pointed = true
            operation.save(flush: true)
        }

        render(template: 'pointactions', model: [operation: operation])
    }

    def unpoint = {
        def operation = genericService.loadUserObject(springSecurityService.getCurrentUser(), Operation.class, params.id)
        if (operation) {
            operation.pointed = false
            operation.save(flush: true)
        }

        render(template: 'pointactions', model: [operation: operation])
    }

    def guessCategory = {
        def bayes = bayesClassifierService.classifyText(params.id)

        log.debug "Guessed = '${bayes}'"
        render bayes as String
    }

    def linkdocument() {

        def person = springSecurityService.getCurrentUser()
        def operation = Operation.findByIdAndOwner(params.id, person)
        def document = Document.findByIdAndOwner(params.docId, person)

        if (operation && document) {
            operation.document = document
            operation.save(flush: true)

            flash.message = "Le document est maintenant lié à l'opération"
            redirect(controller: 'document', action: document.type.toString().toLowerCase() + 's')
        } else {
            flash.message = "Impossible de lier l'opération demandée"
            if (document) {
                redirect(controller: 'document', action: 'linkto', id: document.id)
            } else {
                redirect(controller: 'summary')
            }

        }

    }

}
