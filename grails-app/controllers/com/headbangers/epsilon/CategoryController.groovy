package com.headbangers.epsilon
import grails.plugins.springsecurity.Secured


@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class CategoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService
    def dateUtil
    def categoryService
    def chartService

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
            categoryInstance.color = categoryService.buildColor (categoryInstance.name)
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

    def autocomplete = {

        def categoryType = null
        if (params.type){
            categoryType= params.type.equals ("depot") ? CategoryType.REVENU : CategoryType.DEPENSE
        }
        def person = springSecurityService.getCurrentUser()
        def categories = Category.createCriteria ().list {
            owner{eq("id", person.id)}
            if (categoryType) eq("type", categoryType)
            ilike ("name", "${params.query}%")
        }

        render(contentType: "text/xml") {
	    results() {
	        categories.each { category ->
		    result(){
		        name(category.name)
                        //Optional id which will be available in onItemSelect
                        id(category.id)
		    }
		}
            }
        }
    }

    def operations = {
        // loading category
        def category = genericService.loadUserObject(springSecurityService.getCurrentUser(), Category.class, params.id)
        if (category){
            [category:category]
        } else {
            redirect(action:"list")
        }
    }

    def operationsChart = {

        // getting category
        def person = springSecurityService.getCurrentUser()
        def cat = genericService.loadUserObject (person, Category.class, params.id)
        def operations = categoryService.retrieveOperations(cat)
        
        // pour une catégorie, déterminer la somme des opérations sur chaque mois
        render chartService.createByMonthOperationsChart (cat.name, 500, "#428547", operations)
    }

    
    def search = {
        def person = springSecurityService.getCurrentUser()
        
        def categories = Category.createCriteria().list(params){
            ilike ("name", "%${params.query}%")
            owner{eq("id", person.id)}
        }
        
        render (view:'list',  model:[categoryInstanceList: categories, categoryInstanceTotal: categories.size()])
        
    }
    
}
