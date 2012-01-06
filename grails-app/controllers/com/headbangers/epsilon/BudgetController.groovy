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
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class BudgetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService
    def categoryService
    
    def index = {
        redirect(action: "list", params: params)
    }

    def operations = {
        def person = springSecurityService.getCurrentUser()
        
        def budget = Budget.findByIdAndOwner (params.budget, person)
        [budget:budget]
    }
    
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        def person = springSecurityService.getCurrentUser()
        def budgets = genericService.loadUserObjects (person, Budget.class, params)
        
        [budgetInstanceList: budgets, budgetInstanceTotal: budgets.totalCount]
    }

    def findAvailableCategories (){
        def person = springSecurityService.getCurrentUser()
        def categories = Category.createCriteria ().list (order:'asc', sort:'name') {
            owner{eq("id", person.id)}
            eq("type", CategoryType.DEPENSE)
        }
        
        return categories
    }
    
    def fillBudgetWithSelectedCategories (person, budget, selectedCategories){
        if (selectedCategories instanceof String){
            def oneCat = categoryService.findOrCreateCategory (person, selectedCategories, CategoryType.DEPENSE)
            if (oneCat){
                budget.addToAttachedCategories (oneCat)
            }
        } else {
            selectedCategories.each { category ->
                //log.error("branchement de: "+category)
                def oneCat = categoryService.findOrCreateCategory (person, category, CategoryType.DEPENSE)
                if (oneCat){
                    budget.addToAttachedCategories (oneCat)
                }
            }
        }
        
        return budget
    }
    
    def create = {
        def budgetInstance = new Budget()
        budgetInstance.properties = params
        return [budgetInstance: budgetInstance, availableCategories:findAvailableCategories()]
    }

    def save = {
        def person = springSecurityService.getCurrentUser()
        def budgetInstance = new Budget(params)
        budgetInstance.owner = person
        
        budgetInstance = fillBudgetWithSelectedCategories (person, budgetInstance, params.selectedCategories)
        
        if (budgetInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'budget.label', default: 'Budget'), budgetInstance.id])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [budgetInstance: budgetInstance, availableCategories:findAvailableCategories()])
        }
    }

    def show = {
        def budgetInstance = Budget.get(params.id)
        if (!budgetInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'budget.label', default: 'Budget'), params.id])}"
            redirect(action: "list")
        }
        else {
            [budgetInstance: budgetInstance]
        }
    }

    def edit = {
        def budgetInstance = Budget.get(params.id)
        if (!budgetInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'budget.label', default: 'Budget'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [budgetInstance: budgetInstance,  availableCategories:findAvailableCategories()]
        }
    }

    def update = {
        def person = springSecurityService.getCurrentUser()
        def budgetInstance = Budget.get(params.id)
        if (budgetInstance && budgetInstance.owner.equals(person)) {
            
            budgetInstance.attachedCategories.clear()
            budgetInstance = fillBudgetWithSelectedCategories (person, budgetInstance, params.selectedCategories)
            
            if (params.version) {
                def version = params.version.toLong()
                if (budgetInstance.version > version) {
                    
                    budgetInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'budget.label', default: 'Budget')] as Object[], "Another user has updated this Budget while you were editing")
                    render(view: "edit", model: [budgetInstance: budgetInstance, availableCategories:findAvailableCategories()])
                    return
                }
            }
            params.remove("selectedCategories")
            budgetInstance.properties = params
            if (!budgetInstance.hasErrors() && budgetInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'budget.label', default: 'Budget'), budgetInstance.id])}"
                redirect(action: "list")

            }
            else {
                render(view: "edit", model: [budgetInstance: budgetInstance,  availableCategories:findAvailableCategories()])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'budget.label', default: 'Budget'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def budgetInstance = Budget.get(params.id)
        if (budgetInstance) {
            try {
                budgetInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'budget.label', default: 'Budget'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'budget.label', default: 'Budget'), params.id])}"
                redirect(action: "list")

            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'budget.label', default: 'Budget'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def deactivate = {
        def person = springSecurityService.getCurrentUser()
        def budget = genericService.loadUserObject (person, Budget.class, params.id)

        if (budget){
            budget.active = false
            budget.save(flush:true)

            render (template:'activateactions', model:[budget:budget])
        } else{
            redirect(action: "list")
        }

    }

    def activate = {
        def person = springSecurityService.getCurrentUser()
        def budget = genericService.loadUserObject (person, Budget.class, params.id)

        if (budget){
            budget.active = true
            budget.save(flush:true)

            render (template:'activateactions', model:[budget:budget])
        } else{
            redirect(action: "list")
        }
    }
}
