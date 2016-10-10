package com.headbangers.epsilon.api

import com.headbangers.epsilon.Budget
import com.headbangers.epsilon.Person
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class WsBudgetController {

    def personService
    def genericService

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
        List<com.headbangers.epsilon.mobile.MobileBudget> budgets = new ArrayList<com.headbangers.epsilon.mobile.MobileBudget>()
        if (person) {
            List<Budget> db = genericService.loadUserObjects(person, Budget.class, [order: 'asc', sort: 'name'])
            db = db.findAll { b -> b.active == true }

            db.each { budget ->
                budgets.add(new com.headbangers.epsilon.mobile.MobileBudget(budget))
            }
        }

        render budgets as JSON
    }

    // "/api/budgets/$id
    def show() {
        def person = checkUser(request)
        com.headbangers.epsilon.mobile.MobileBudget result = new com.headbangers.epsilon.mobile.MobileBudget()
        if (person) {
            def budget = Budget.findByIdAndOwner(params.id, person)
            if (budget) {
                result = new com.headbangers.epsilon.mobile.MobileBudget(budget)
            }
        }

        render result as JSON
    }
}
