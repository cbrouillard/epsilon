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

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class TiersController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService
    def tiersService
    def dateUtil

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.sort = params.sort ?: "name"
        params.order = params.order ?: "asc"

        def person = springSecurityService.getCurrentUser()
        def tiers = genericService.loadUserObjects(person, Tiers.class, params)

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
        } else {
            render(view: "create", model: [tiersInstance: tiersInstance])
        }
    }

    def show = {
        def tiersInstance = Tiers.get(params.id)
        if (!tiersInstance || !tiersInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tiers.label', default: 'Tiers'), params.id])}"
            redirect(action: "list")
        } else {
            [tiersInstance: tiersInstance]
        }
    }

    def edit = {
        def tiersInstance = Tiers.get(params.id)
        if (!tiersInstance || !tiersInstance.owner.equals(springSecurityService.getCurrentUser())) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tiers.label', default: 'Tiers'), params.id])}"
            redirect(action: "list")
        } else {
            return [tiersInstance: tiersInstance]
        }
    }

    def update = {
        def tiersInstance = Tiers.get(params.id)
        if (tiersInstance && tiersInstance.owner.equals(springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (tiersInstance.version > version) {

                    tiersInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tiers.label',
                            default: 'Tiers')] as Object[], "Another user has updated this Tiers while you were editing")
                    render(view: "edit", model: [tiersInstance: tiersInstance])
                    return
                }
            }
            tiersInstance.properties = params
            if (!tiersInstance.hasErrors() && tiersInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tiers.label', default: 'Tiers'), tiersInstance.name])}"
                redirect(action: "list")
            } else {
                render(view: "edit", model: [tiersInstance: tiersInstance])
            }
        } else {
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
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tiers.label', default: 'Tiers'), params.id])}"
            redirect(action: "list")
        }
    }

    def simpleautocomplete = {
        def tiers = Tiers.findAllByNameLikeAndOwner("%${params.query}%", springSecurityService.getCurrentUser())

        render tiers*.name as JSON
        return
    }

    def operations = {
        def tiers = genericService.loadUserObject(springSecurityService.getCurrentUser(), Tiers.class, params.id)
        if (tiers) {
            def currentYear = dateUtil.currentYear
            def oldestYear = dateUtil.getYear(tiers.operations? tiers.operations.first().dateApplication : new Date())
            def yearRange = oldestYear..currentYear

            def selectedFrom = (params.fromYear?:oldestYear) as Integer
            def selectedTo = (params.toYear?:currentYear) as Integer

            def fromDate = dateUtil.firstDayOfYear ( selectedFrom )
            def toDate = dateUtil.lastDayOfYear( selectedTo )

            def operations = Operation.createCriteria().list(params){
                between("dateApplication", fromDate, toDate)
                eq("tiers", tiers)
            }

            [tiers: tiers, yearRange: yearRange, fromYear:selectedFrom, toYear:selectedTo, operations:operations]


        } else {
            redirect(action: "list")
        }
    }

    def search = {
        def person = springSecurityService.getCurrentUser()

        def tiers = Tiers.createCriteria().list(params) {
            ilike("name", "%${params.query}%")
            owner {eq("id", person.id)}
        }

        render(view: 'list', model: [tiersInstanceList: tiers, tiersInstanceTotal: tiers.size(), query:params.query])

    }

    def pinne = {
        def person = springSecurityService.getCurrentUser()
        def tiers = genericService.loadUserObject (person, Tiers.class, params.id)

        if (tiers){
            tiers.pinned = true
            tiers.save(flush:true)

            render (template:'pinnedactions', model:[tiers: tiers])
        } else{
            redirect(action: "list")
        }

    }

    def unpinne = {
        def person = springSecurityService.getCurrentUser()
        def tiers = genericService.loadUserObject (person, Tiers.class, params.id)

        if (tiers){
            tiers.pinned = false
            tiers.save(flush:true)

            render (template:'pinnedactions', model:[tiers: tiers])
        } else{
            redirect(action: "list")
        }
    }
}
