package com.headbangers.epsilon.api

import com.headbangers.epsilon.Operation
import com.headbangers.epsilon.Person
import com.headbangers.epsilon.mobile.MobileCategory
import com.headbangers.epsilon.mobile.MobileOperation
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class WsCategoryController {

    def personService

    private Person checkUser(HttpServletRequest request) {
        String token = request.getHeader("WWW-Authenticate")
        if (token) {
            return personService.findUserByToken(token)
        }

        return null
    }

    def index() {
        List<MobileCategory> result = new ArrayList<MobileCategory>()
        def person = checkUser(request)
        if (person) {
            def categories = com.headbangers.epsilon.Category.findAllByOwner(person, [sort: 'name', order: 'asc'])
            categories.each { category ->
                result.add(new MobileCategory(category))
            }
        }

        render result as JSON
    }

    def show() {
        MobileCategory result = new MobileCategory()
        def person = checkUser(request)
        if (person) {
            com.headbangers.epsilon.Category category = com.headbangers.epsilon.Category.findByOwnerAndId(person, params.id)

            if (category) {
                result = new MobileCategory(category)
                def operations = category.getMonthOperations()
                result.operations = new ArrayList<>()
                operations.each { op ->
                    result.operations.add(new MobileOperation(op))
                }
            }
        }

        render result as JSON
    }

    def names() {
        List<com.headbangers.epsilon.Category> categories = new ArrayList<com.headbangers.epsilon.Category>()
        def person = checkUser(request)
        if (person) {
            categories = com.headbangers.epsilon.Category.findAllByOwner(person, [sort: 'name', order: 'asc'])
        }

        render categories*.name as JSON
    }

    // all operations !!
    def operations() {
        def person = checkUser(request)
        List<MobileOperation> result = new ArrayList<MobileOperation>();
        if (person && params.wsCategoryId) {
            def category = com.headbangers.epsilon.Category.findByOwnerAndId(person, params.wsCategoryId)

            if (category) {
                def operations = Operation.findAllByCategory(category)
                operations.each { operation ->
                    result.add(new MobileOperation(operation))
                }
            }
        }

        render result as JSON
    }
}
