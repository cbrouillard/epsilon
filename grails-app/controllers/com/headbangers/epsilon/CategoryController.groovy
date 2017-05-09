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
        params.sort = params.sort ?: "name"
        params.order = params.order ?: "asc"

        def person = springSecurityService.getCurrentUser()
        def categories = genericService.loadUserObjects(person, Category.class, params)

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

        if (categoryInstance.name) {
            categoryInstance.color = genericService.buildColor(categoryInstance.name)
        }

        if (categoryInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.name])}"
            redirect(action: "list")
        } else {
            render(view: "create", model: [categoryInstance: categoryInstance])
        }
    }

    def edit = {
        def categoryInstance = Category.get(params.id)
        if (!categoryInstance || !categoryInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])}"
            redirect(action: "list")
        } else {
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
            } else {
                render(view: "edit", model: [categoryInstance: categoryInstance])
            }
        } else {
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
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])}"
            redirect(action: "list")
        }
    }

    def simpleautocomplete() {
        def categoryType = null
        if (params.type) {
            categoryType = CategoryType.guess(params.type)
        }
        def person = springSecurityService.getCurrentUser()
        def categories = Category.createCriteria().list {
            owner { eq("id", person.id) }
            if (categoryType && categoryType != CategoryType.VIREMENT) eq("type", categoryType)
            ilike("name", "${params.query}%")
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
            def oldestYear = dateUtil.getYear(category.operations ? category.operations.first().dateApplication : new Date())
            def yearRange = oldestYear..currentYear

            def selectedFrom = (params.fromYear ?: oldestYear) as Integer
            def selectedTo = (params.toYear ?: currentYear) as Integer

            def fromDate = dateUtil.firstDayOfYear(selectedFrom)
            def toDate = dateUtil.lastDayOfYear(selectedTo)

            params.sort = "dateApplication"
            params.order = "desc"

            def operations = Operation.createCriteria().list(params) {
                between("dateApplication", fromDate, toDate)
                eq("category", category)
            }

            [category: category, yearRange: yearRange, fromYear: selectedFrom, toYear: selectedTo, operations: operations, currentMonth: currentMonth]
        } else {
            redirect(action: "list")
        }
    }

    def byname = {
        def category = Category.findByOwnerAndName(springSecurityService.getCurrentUser(), params.name)
        if (category) {
            redirect(action: 'operations', id: category.id)
        } else {
            redirect(action: "list")
        }
    }

    def search = {
        if (!params.query) {
            redirect(action: "list")
            return
        }

        def person = springSecurityService.getCurrentUser()

        def categories = Category.createCriteria().list(params) {
            ilike("name", "%${params.query}%")
            owner { eq("id", person.id) }
        }

        render(view: 'list', model: [categoryInstanceList: categories, categoryInstanceTotal: categories.size(), query: params.query])

    }

    def pinne = {
        def person = springSecurityService.getCurrentUser()
        def cat = genericService.loadUserObject(person, Category.class, params.id)

        if (cat) {
            cat.pinned = true
            cat.save(flush: true)

            render(template: 'pinnedactions', model: [category: cat])
        } else {
            redirect(action: "list")
        }

    }

    def unpinne = {
        def person = springSecurityService.getCurrentUser()
        def cat = genericService.loadUserObject(person, Category.class, params.id)

        if (cat) {
            cat.pinned = false
            cat.save(flush: true)

            render(template: 'pinnedactions', model: [category: cat])
        } else {
            redirect(action: "list")
        }
    }

    def askmerge = {
      def person = springSecurityService.getCurrentUser()
      def cat = genericService.loadUserObject(person, Category.class, params.id)

      if (cat) {

        def allCategories = genericService.loadUserObjects(person, Category.class, ['order':'asc', 'sort': 'name'])
        render (view:'merge', model:[leftCategory:cat, categories:allCategories])

      } else {
          redirect(action: "list")
      }
    }

    def merge = {
      def person = springSecurityService.getCurrentUser()

      def catToMerge = genericService.loadUserObject(person, Category.class, params.catToMerge)
      def mergeIn = genericService.loadUserObject(person, Category.class, params.mergeIn)

      if (catToMerge && mergeIn){

        if (catToMerge.id.equals(mergeIn.id)){
          flash.message = "Sélectionnez deux categories différentes !"
          chain (action:'askmerge', id:catToMerge.id)
          return
        }

        if (catToMerge.type != mergeIn.type) {
          flash.message = "Les deux catégories ne sont pas du même type. Impossible de les fusionner."
          chain (action:'askmerge', id:catToMerge.id)
          return
        }

        // TOUTES les opérations ayant comme categorie = catToMerge prennent mergeIn comme catégorie.
        // la catégorie catToMerge est ensuite supprimées
        def operations = Operation.findAllByCategory (catToMerge)
        if (operations){
          operations.each {ope ->
              ope.category = mergeIn
              ope.save()
          }
        }

        def budgets = genericService.loadUserObjects(person, Budget.class)
        if (budgets){
          budgets.each { budget ->
            if (budget.attachedCategories.contains(catToMerge)){
              budget.removeFromAttachedCategories (catToMerge)
              budget.save()
            }
          }
        }

        def scheduleds = Scheduled.findAllByCategory(catToMerge)
        if (scheduleds){
          scheduleds.each { sch ->
            sch.category = mergeIn
            sch.save()
          }
        }

        def wishes = Wish.findAllByCategory (catToMerge)
        if (wishes){
          whishes.each { wish ->
            wish.category = mergeIn
            wish.save()
          }
        }

        catToMerge.delete(flush:true)

        flash.message = "Fusion effectuée"
        chain (action:'operations', id:mergeIn.id)

      } else {
          redirect(action: "list")
      }
    }

}
