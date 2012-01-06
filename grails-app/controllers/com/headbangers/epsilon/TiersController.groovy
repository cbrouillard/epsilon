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
class TiersController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService
    def tiersService
    def chartService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        def person = springSecurityService.getCurrentUser()
        def tiers = genericService.loadUserObjects (person, Tiers.class, params)

        [tiersInstanceList: tiers, tiersInstanceTotal: tiers.totalCount]
    }

    def create = {
        def tiersInstance = new Tiers()
        tiersInstance.properties = params
        return [tiersInstance: tiersInstance]
    }

    def save = {
        def tiersInstance = new Tiers(params)

        tiersInstance.owner = springSecurityService.getCurrentUser()

        if (tiersInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'tiers.label', default: 'Tiers'), tiersInstance.name])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [tiersInstance: tiersInstance])
        }
    }

    def show = {
        def tiersInstance = Tiers.get(params.id)
        if (!tiersInstance || !tiersInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tiers.label', default: 'Tiers'), params.id])}"
            redirect(action: "list")
        }
        else {
            [tiersInstance: tiersInstance]
        }
    }

    def edit = {
        def tiersInstance = Tiers.get(params.id)
        if (!tiersInstance || !tiersInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tiers.label', default: 'Tiers'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [tiersInstance: tiersInstance]
        }
    }

    def update = {
        def tiersInstance = Tiers.get(params.id)
        if (tiersInstance && tiersInstance.owner.equals(springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (tiersInstance.version > version) {
                    
                    tiersInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tiers.label', default: 'Tiers')] as Object[], "Another user has updated this Tiers while you were editing")
                    render(view: "edit", model: [tiersInstance: tiersInstance])
                    return
                }
            }
            tiersInstance.properties = params
            if (!tiersInstance.hasErrors() && tiersInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tiers.label', default: 'Tiers'), tiersInstance.name])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [tiersInstance: tiersInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tiers.label', default: 'Tiers'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def tiersInstance = Tiers.get(params.id)
        if (tiersInstance && tiersInstance.owner.equals(springSecurityService.getCurrentUser())) {
            try {
                tiersInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tiers.label', default: 'Tiers'), tiersInstance.name])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tiers.label', default: 'Tiers'), tiersInstance.name])}"
                redirect(action: "list")
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tiers.label', default: 'Tiers'), params.id])}"
            redirect(action: "list")
        }
    }

    def autocomplete = {
        def tiers = Tiers.findAllByNameLikeAndOwner("%${params.query}%", springSecurityService.getCurrentUser())

        render(contentType: "text/xml") {
	    results() {
	        tiers.each { tier ->
		    result(){
		        name(tier.name)
                        //Optional id which will be available in onItemSelect
                        id(tier.id)
		    }
		}
            }
        }
    }

    def operations = {
        def tiers = genericService.loadUserObject (springSecurityService.getCurrentUser(), Tiers.class, params.id)
        if (tiers){
            [tiers:tiers]
        } else {
            redirect(action:"list")
        }
    }

    def operationsChart = {

        // getting category
        def person = springSecurityService.getCurrentUser()
        def tiers = genericService.loadUserObject (person, Tiers.class, params.id)
        def operations = tiersService.retrieveOperations(tiers)

        // pour une catégorie, déterminer la somme des opérations sur chaque mois
        render chartService.createByMonthOperationsChart (tiers.name, 500, "#428547", operations)
    }
    
    def search = {
        def person = springSecurityService.getCurrentUser()
        
        def tiers = Tiers.createCriteria().list(params){
            ilike ("name", "%${params.query}%")
            owner{eq("id", person.id)}
        }
        
        render (view:'list',  model:[tiersInstanceList: tiers, tiersInstanceTotal: tiers.size()])
        
    }
}