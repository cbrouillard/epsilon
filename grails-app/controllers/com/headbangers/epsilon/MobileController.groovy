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

import com.headbangers.epsilon.mobile.*
import grails.converters.*

class MobileController {

    def personService
    def tiersService
    def categoryService
    def scheduledService

    def accounts = {

        def person = checkUser (params.token)
        List<com.headbangers.epsilon.mobile.MobileAccount> accounts = new ArrayList<com.headbangers.epsilon.mobile.MobileAccount>()
        if (person){
            def db = Account.findAllByOwner (person)
            db.each {account ->
                accounts.add (new com.headbangers.epsilon.mobile.MobileAccount (account))
            }
        }

        render accounts as JSON
    }

    def budgets = {
        def person = checkUser(params.token)
        List<com.headbangers.epsilon.mobile.MobileBudget> budgets = new ArrayList<com.headbangers.epsilon.mobile.MobileBudget>()
        if (person){
            def db = Budget.findAllByOwner(person)
            db.each {budget ->
                budgets.add(new com.headbangers.epsilon.mobile.MobileBudget(budget))
            }
        }
        
        render budgets as JSON
    }
    
    def budget = {
        def person = checkUser(params.token)
        com.headbangers.epsilon.mobile.MobileBudget result = new com.headbangers.epsilon.mobile.MobileBudget()
        if (person){
            def budget = Budget.findByIdAndOwner(params.budget, person)
            if (budget){
                result = new com.headbangers.epsilon.mobile.MobileBudget(budget)
            }
        }
        
        render result as JSON
    }
    
    def account = {
        def person = checkUser(params.token)
        com.headbangers.epsilon.mobile.MobileAccount result = new com.headbangers.epsilon.mobile.MobileAccount()
        if (person){
            def account = Account.findByIdAndOwner (params.account, person)
            if (account){
                result = new com.headbangers.epsilon.mobile.MobileAccount (account)
            }
        }

        render result as JSON
    }

    def categories = {
        List<MobileCategory> result =new ArrayList<MobileCategory>()
        def person = checkUser(params.token)
        if (person){
            def categories = Category.findAllByOwner (person)
            categories.each { category ->
                result.add (new MobileCategory(category))
            }
        }

        render result as JSON
    }

    def categoriesName = {
        List<Category> categories = new ArrayList<Category>()
        def person = checkUser(params.token)
        if (person){
            categories = Category.findAllByOwner (person)
        }

        render categories*.name as JSON
    }

    def tiers = {
        List<MobileTiers> result =new ArrayList<MobileTiers>()
        def person = checkUser(params.token)
        if (person){
            def tiers = Tiers.findAllByOwner (person)
            tiers.each { tier ->
                result.add (new MobileTiers(tier))
            }
        }

        render result as JSON
    }

    def tiersName = {
        List<Tiers> tiers =new ArrayList<Tiers>()
        def person = checkUser(params.token)
        if (person){
            tiers = Tiers.findAllByOwner (person)
        }

        render tiers*.name as JSON
    }

    def addDepense = {
        MobileSimpleResult result = new MobileSimpleResult("ko")
        def person = checkUser (params.token)

        if (person && params.category && params.tiers && params.amount && params.account){

            def categoryName = params.category
            def tiersName = params.tiers

            def operation = new Operation ()
            operation.type = OperationType.RETRAIT
            operation.tiers = tiersService.findOrCreateTiers (person, tiersName)
            operation.category = categoryService.findOrCreateCategory (person, categoryName, CategoryType.DEPENSE)
            operation.account = Account.findByIdAndOwner(params.account, person)
            operation.dateApplication = new Date ()
            operation.amount = Double.parseDouble (params.amount.replaceAll(",", "\\."))
            operation.owner = person
            operation.pointed = false

            if (operation.save(flush: true)){
                result.setCode ("ok")
            }
        }

        render result as JSON

    }

    def addVirement = {
        MobileSimpleResult result = new MobileSimpleResult("ko")
        def person = checkUser (params.token)

        if (person && params.accountTo && params.accountFrom && params.category && params.amount){

            def tiersName = person.userRealName
            def categoryName = params.category

            def operationMoins = new Operation ()
            operationMoins.type = OperationType.VIREMENT_MOINS
            operationMoins.tiers = tiersService.findOrCreateTiers (person, tiersName)
            operationMoins.category = categoryService.findOrCreateCategory (person, categoryName, CategoryType.VIREMENT)
            operationMoins.account = Account.findByIdAndOwner(params.accountFrom, person)
            operationMoins.dateApplication = new Date ()
            operationMoins.amount = Double.parseDouble (params.amount.replaceAll(",", "\\."))
            operationMoins.owner = person
            operationMoins.pointed = false

            def operationPlus = new Operation ()
            operationPlus.type = OperationType.VIREMENT_PLUS
            operationPlus.tiers = tiersService.findOrCreateTiers (person, tiersName)
            operationPlus.category = categoryService.findOrCreateCategory (person, categoryName, CategoryType.VIREMENT)
            operationPlus.account = Account.findByIdAndOwner(params.accountTo, person)
            operationPlus.dateApplication = new Date ()
            operationPlus.amount = Double.parseDouble (params.amount.replaceAll(",", "\\."))
            operationPlus.owner = person
            operationPlus.pointed = false

            if (operationMoins.save(flush: true) && operationPlus.save(flush: true)){
                result.setCode ("ok")
            }

        }

        render result as JSON
    }

    def addRevenue = {
        MobileSimpleResult result = new MobileSimpleResult("ko")
        def person = checkUser (params.token)

        if (person && params.category && params.tiers && params.amount && params.account){

            def categoryName = params.category
            def tiersName = params.tiers

            def operation = new Operation ()
            operation.type = OperationType.DEPOT
            operation.tiers = tiersService.findOrCreateTiers (person, tiersName)
            operation.category = categoryService.findOrCreateCategory (person, categoryName, CategoryType.REVENU)
            operation.account = Account.findByIdAndOwner(params.account, person)
            operation.dateApplication = new Date ()
            operation.amount = Double.parseDouble (params.amount.replaceAll(",", "\\."))
            operation.owner = person
            operation.pointed = false

            if (operation.save(flush: true)){
                result.setCode ("ok")
            }
        }

        render result as JSON
    }

    def operationsByMonth = {
        def person = checkUser(params.token)
        List<MobileOperation> result = new ArrayList<MobileOperation>();
        if (person && params.account){
            def account = Account.findByIdAndOwner (params.account, person)
            def operations = account.getLastOperationsDesc()
            operations.each{operation ->
                result.add (new MobileOperation (operation))
            }
        }

        render result as JSON
    }

    def operationsByTiers = {
        def person = checkUser(params.token)
        List<MobileOperation> result = new ArrayList<MobileOperation>();
        if (person && params.tiers){
            def operations = Operation.findAllByTiers (tiers)
            operations.each{operation ->
                result.add (new MobileOperation (operation))
            }
        }

        render result as JSON
    }

    def operationsByCategory = {
        def person = checkUser(params.token)
        List<MobileOperation> result = new ArrayList<MobileOperation>();
        if (person && params.category){
            def operations = Operation.findAllByCategory (category)
            operations.each{operation ->
                result.add (new MobileOperation (operation))
            }
        }

        render result as JSON
    }

    def scheduled = {
        def person = checkUser(params.token)
        List<MobileOperation> result = new ArrayList<MobileOperation>();
        if (person){
            def scheduleds = scheduledService.findFutures(person)
            scheduleds.each {oneScheduled ->
                def mobileScheduled = new MobileOperation ()
                mobileScheduled.initScheduled (oneScheduled)
                result.add (mobileScheduled)
            }
        }

        render result as JSON
    }

    def checkToken = {
        def person = checkUser (params.token)
        def result = new MobileSimpleResult()
        result.setCode ( person ? "ok" : "ko" )

        render result as JSON
    }

    def register = {
        def person = personService.findByLoginAndPass(params.login, params.pass)
        def token = new MobileSimpleResult()
        if (person && person.mobileToken){
            token.setCode(person.mobileToken)
        }

        render token as JSON
    }

    private Person checkUser (String token) {
        return personService.findUserByToken (token)
    }
}
