package com.headbangers.epsilon.api

import com.headbangers.epsilon.Account
import com.headbangers.epsilon.CategoryType
import com.headbangers.epsilon.Operation
import com.headbangers.epsilon.OperationType
import com.headbangers.epsilon.Person
import com.headbangers.epsilon.mobile.MobileSimpleResult
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class WsOperationController {

    static allowedMethods = [addDepense: "POST", addRevenue: "POST", addVirement: "POST", editOperation: "POST"]

    def personService
    def tiersService
    def categoryService
    def snapshotService

    private Person checkUser(HttpServletRequest request) {
        String token = request.getHeader("WWW-Authenticate")
        if (token) {
            return personService.findUserByToken(token)
        }

        return null
    }

    def addDepense() {
        MobileSimpleResult result = new MobileSimpleResult("ko")
        def person = checkUser(request)

        if (person && params.category && params.tiers && params.amount && params.account) {

            def categoryName = params.category
            def tiersName = params.tiers

            def operation = new Operation()
            operation.type = OperationType.RETRAIT
            operation.tiers = tiersService.findOrCreateTiers(person, tiersName)
            operation.category = categoryService.findOrCreateCategory(person, categoryName, CategoryType.DEPENSE)
            operation.account = Account.findByIdAndOwner(params.account, person)
            operation.dateApplication = new Date()
            operation.amount = Double.parseDouble(params.amount.replaceAll(",", "\\."))
            operation.owner = person
            operation.pointed = false
            operation.latitude = params.latitude
            operation.longitude = params.longitude

            if (operation.save(flush: true)) {
                result.setCode("ok")
            }
        }

        render result as JSON
    }

    def addRevenue() {
        MobileSimpleResult result = new MobileSimpleResult("ko")
        def person = checkUser(request)

        if (person && params.category && params.tiers && params.amount && params.account) {

            def categoryName = params.category
            def tiersName = params.tiers

            def operation = new Operation()
            operation.type = OperationType.DEPOT
            operation.tiers = tiersService.findOrCreateTiers(person, tiersName)
            operation.category = categoryService.findOrCreateCategory(person, categoryName, CategoryType.REVENU)
            operation.account = Account.findByIdAndOwner(params.account, person)
            operation.dateApplication = new Date()
            operation.amount = Double.parseDouble(params.amount.replaceAll(",", "\\."))
            operation.owner = person
            operation.pointed = false

            if (operation.save(flush: true)) {
                result.setCode("ok")
            }
        }

        render result as JSON
    }

    def addVirement() {
        MobileSimpleResult result = new MobileSimpleResult("ko")
        def person = checkUser(request)

        if (person && params.accountTo && params.accountFrom && params.category && params.amount) {

            def tiersName = person.userRealName
            def categoryName = params.category

            def operationMoins = new Operation()
            operationMoins.type = OperationType.VIREMENT_MOINS
            operationMoins.tiers = tiersService.findOrCreateTiers(person, tiersName)
            operationMoins.category = categoryService.findOrCreateCategory(person, categoryName, CategoryType.VIREMENT)
            operationMoins.account = Account.findByIdAndOwner(params.accountFrom, person)
            operationMoins.dateApplication = new Date()
            operationMoins.amount = Double.parseDouble(params.amount.replaceAll(",", "\\."))
            operationMoins.owner = person
            operationMoins.pointed = false

            def operationPlus = new Operation()
            operationPlus.type = OperationType.VIREMENT_PLUS
            operationPlus.tiers = tiersService.findOrCreateTiers(person, tiersName)
            operationPlus.category = categoryService.findOrCreateCategory(person, categoryName, CategoryType.VIREMENT)
            operationPlus.account = Account.findByIdAndOwner(params.accountTo, person)
            operationPlus.dateApplication = new Date()
            operationPlus.amount = Double.parseDouble(params.amount.replaceAll(",", "\\."))
            operationPlus.owner = person
            operationPlus.pointed = false

            if (operationMoins.save(flush: true) && operationPlus.save(flush: true)) {
                result.setCode("ok")
            }

        }

        render result as JSON
    }

    def editOperation() {
        MobileSimpleResult result = new MobileSimpleResult("ko")
        def person = checkUser(request)
        def operation = Operation.findByOwnerAndId(person, params.wsOperationId)

        def category = params.category
        def tiers = params.tiers
        def amount = params.amount

        if (person && operation && category && tiers && amount) {

            operation.tiers = tiersService.findOrCreateTiers(person, tiers)
            operation.category = categoryService.findOrCreateCategory(person, category, operation.category.type)
            operation.amount = Double.parseDouble(amount.replaceAll(",", "\\."))

            if (operation.dateApplication.before(operation.account.lastSnapshot.dateCreated)) {
                log.error("We have to sync the snapshot")
                snapshotService.sync(operation.account, operation.dateApplication)
            }

            if (operation.save(flush: true)) {
                result.setCode("ok")
            }
        }

        render result as JSON
    }

    def delete() {
        MobileSimpleResult result = new MobileSimpleResult("ko")
        def person = checkUser(request)
        def operation = Operation.findByOwnerAndId(person, params.id)

        if (person && operation) {
            operation.delete(flush: true)
            result.setCode("ok")
        }

        render result as JSON
    }
}
