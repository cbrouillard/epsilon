package com.headbangers.epsilon.api

import com.headbangers.epsilon.Budget
import com.headbangers.epsilon.Person
import com.headbangers.epsilon.mobile.MobileBudget
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class WsBudgetController {

    def personService
    def genericService
    def budgetService

    private Person checkUser(HttpServletRequest request) {
        String token = request.getHeader("WWW-Authenticate")
        if (token) {
            return personService.findUserByToken(token)
        }

        return null
    }

    // "/api/budgets"
    def index() {
        def person = checkUser(request)
        List<MobileBudget> budgets = new ArrayList<MobileBudget>()
        if (person) {
            List<Budget> db = genericService.loadUserObjects(person, Budget.class, [order: 'asc', sort: 'name'])
            db = db.findAll { b -> b.active == true }

            if (db) {
                MobileBudget outBudget = new MobileBudget()
                outBudget.id = "out"
                outBudget.name = "Hors budget et échéances"
                outBudget.note = "Créé automatiquement par Epsilon"
                outBudget.maxAmount = 0D
                outBudget.usedAmount = budgetService.calculateOutOfBudgetAmount(db, person)
                budgets.add(outBudget)

                db.each { budget ->
                    budgets.add(new MobileBudget(budget))
                }
            }
        }

        render budgets as JSON
    }

    // "/api/budgets/$id
    def show() {
        def person = checkUser(request)
        MobileBudget result = new MobileBudget()
        if (person) {

            if (params.id != "out") {
                def budget = Budget.findByIdAndOwner(params.id, person)
                if (budget) {
                    result = new MobileBudget(budget)
                }
            } else {
                def budgets = Budget.findAllByOwnerAndActive(person, true)
                result = new MobileBudget()
                result.id = "out"
                result.name = "Hors budget et échéances"
                result.note = "Créé automatiquement par Epsilon"
                result.maxAmount = 0D
                result.bindOperations(
                        budgetService.retrieveOutOfBudgetOperations(budgets, person))
                result.usedAmount = budgetService.calculateOutOfBudgetAmount(budgets, person)
            }
        }

        render result as JSON
    }
}
