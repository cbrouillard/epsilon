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

import com.headbangers.epsilon.util.DateUtil
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured


@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class CategoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService
    DateUtil dateUtil

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        def person = springSecurityService.getCurrentUser()
        def categories = genericService.loadUserObjects (person, Category.class, params)

        [categoryInstanceList: categories, categoryInstanceTotal: categories.totalCount]
    }

    def create = {
        def categoryInstance = new Category()
        categoryInstance.properties = params
        return [categoryInstance: categoryInstance]
    }

    def save = {
        def categoryInstance = new Category(params)

        categoryInstance.owner = springSecurityService.getCurrentUser()

        if (categoryInstance.name){
            categoryInstance.color = genericService.buildColor (categoryInstance.name)
        }

        if (categoryInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.name])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [categoryInstance: categoryInstance])
        }
    }

    def show = {
        def categoryInstance = Category.get(params.id)
        if (!categoryInstance || !categoryInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])}"
            redirect(action: "list")
        }
        else {
            [categoryInstance: categoryInstance]
        }
    }

    def edit = {
        def categoryInstance = Category.get(params.id)
        if (!categoryInstance || !categoryInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [categoryInstance: categoryInstance]
        }
    }

    def update = {
        def categoryInstance = Category.get(params.id)
        if (categoryInstance && categoryInstance.owner.equals(springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (categoryInstance.version > version) {

                    categoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'category.label', default: 'Category')] as Object[], "Another user has updated this Category while you were editing")
                    render(view: "edit", model: [categoryInstance: categoryInstance])
                    return
                }
            }
            categoryInstance.properties = params
            if (!categoryInstance.hasErrors() && categoryInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.name])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [categoryInstance: categoryInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def categoryInstance = Category.get(params.id)
        if (categoryInstance && categoryInstance.owner.equals(springSecurityService.getCurrentUser())) {
            try {
                categoryInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.name])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.name])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])}"
            redirect(action: "list")
        }
    }

    def simpleautocomplete(){
        def categoryType = null
        if (params.type){
            categoryType= CategoryType.guess(params.type)
        }
        def person = springSecurityService.getCurrentUser()
        def categories = Category.createCriteria ().list {
            owner{eq("id", person.id)}
            if (categoryType && categoryType != CategoryType.VIREMENT) eq("type", categoryType)
            ilike ("name", "${params.query}%")
        }

        render categories*.name as JSON
        return
    }

    def operations = {
        // loading category
        def category = genericService.loadUserObject(springSecurityService.getCurrentUser(), Category.class, params.id)
        def currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1
        if (category) {

            def currentYear = dateUtil.currentYear
            def oldestYear = dateUtil.getYear(category.operations? category.operations.first().dateApplication : new Date())
            def yearRange = oldestYear..currentYear

            def selectedFrom = (params.fromYear?:oldestYear) as Integer
            def selectedTo = (params.toYear?:currentYear) as Integer

            def fromDate = dateUtil.firstDayOfYear ( selectedFrom )
            def toDate = dateUtil.lastDayOfYear( selectedTo )

            def operations = Operation.createCriteria().list(params){
                between("dateApplication", fromDate, toDate)
                eq("category", category)
            }

            [category: category, yearRange: yearRange, fromYear:selectedFrom, toYear:selectedTo, operations:operations, currentMonth:currentMonth]
        } else {
            redirect(action: "list")
        }
    }

    def search = {
        def person = springSecurityService.getCurrentUser()

        def categories = Category.createCriteria().list(params) {
            ilike("name", "%${params.query}%")
            owner {eq("id", person.id)}
        }

        render(view: 'list', model: [categoryInstanceList: categories, categoryInstanceTotal: categories.size(), query:params.query])

    }

    def pinne = {
        def person = springSecurityService.getCurrentUser()
        def cat = genericService.loadUserObject (person, Category.class, params.id)

        if (cat){
            cat.pinned = true
            cat.save(flush:true)

            render (template:'pinnedactions', model:[category: cat])
        } else{
            redirect(action: "list")
        }

    }

    def unpinne = {
        def person = springSecurityService.getCurrentUser()
        def cat = genericService.loadUserObject (person, Category.class, params.id)

        if (cat){
            cat.pinned = false
            cat.save(flush:true)

            render (template:'pinnedactions', model:[category: cat])
        } else{
            redirect(action: "list")
        }
    }

}
