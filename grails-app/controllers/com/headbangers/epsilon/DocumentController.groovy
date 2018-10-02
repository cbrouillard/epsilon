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

import com.headbangers.epsilon.command.SearchCommand
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class DocumentController {

    def springSecurityService
    def genericService

    def invoices() {
        params.max = Math.min(params.max ? params.int('max') : 20, 80)
        params.sort = "dateCreated"
        params.order = "desc"

        def person = springSecurityService.getCurrentUser()
        def documents = fetchByType person, Document.Type.INVOICE, params

        render(view: 'list', model: [documents: documents, type: Document.Type.INVOICE])
    }

    def banks() {
        params.max = Math.min(params.max ? params.int('max') : 20, 80)
        params.sort = "dateCreated"
        params.order = "desc"

        def person = springSecurityService.getCurrentUser()
        def documents = fetchByType person, Document.Type.BANK, params

        render(view: 'list', model: [documents: documents, type: Document.Type.BANK])
    }

    def accounts() {
        params.max = Math.min(params.max ? params.int('max') : 20, 80)
        params.sort = "dateCreated"
        params.order = "desc"

        def person = springSecurityService.getCurrentUser()
        def documents = fetchByType person, Document.Type.ACCOUNT, params

        render(view: 'list', model: [documents: documents, type: Document.Type.ACCOUNT, accounts: Account.findAllByOwner(person)])
    }

    def salarys() {
        chain(action: "salaries")
    }

    def salaries() {
        params.max = Math.min(params.max ? params.int('max') : 20, 80)
        params.sort = "dateCreated"
        params.order = "desc"

        def person = springSecurityService.getCurrentUser()
        def documents = fetchByType person, Document.Type.SALARY, params

        render(view: 'list', model: [documents: documents, type: Document.Type.SALARY, accounts: Account.findAllByOwner(person)])
    }

    def imaboss() {
        params.max = Math.min(params.max ? params.int('max') : 20, 80)
        params.sort = "dateCreated"
        params.order = "desc"

        def person = springSecurityService.getCurrentUser()
        def documents = fetchByType person, Document.Type.IMABOSS, params

        render(view: 'list', model: [documents: documents, type: Document.Type.IMABOSS, accounts: Account.findAllByOwner(person)])
    }

    def imabosss() {
        chain(action: "imaboss")
    }

    private List<Document> fetchByType(Person person, Document.Type type, params) {
        return Document.createCriteria().list(sort: params.sort, order: params.order, max: params.max, offset: params.offset) {
            owner { eq("id", person.id) }
            eq("type", type)
        }
    }

    def create() {
        if (!params.type) {
            redirect(action: 'invoices')
            return
        }

        def type = Document.Type.valueOf(params.type)
        Document document = new Document(type: type)

        return [document: document]
    }

    def save() {
        def person = springSecurityService.getCurrentUser()
        Document document = new Document(params)
        document.owner = person

        MultipartFile file = request.getFile("data")
        if (file) {
            String originalName = file.getOriginalFilename()
            if (!document.name) {
                document.name = originalName
            } else {
                if (!document.name.contains(".")) {
                    try {
                        document.name = document.name + originalName.substring(originalName.indexOf("."))
                    } catch (Exception e) {
                        // bourrin mais tant pis. osef l'extension si y en a pas.
                    }
                }
            }

            document.data = file.getBytes()
        }

        if (document.validate() && document.save(flush: true)) {
            flash.message = "Document créé"
            redirect(action: "${document.type.toString().toLowerCase()}s")
        } else {
            render view: 'create', model: [document: document]
        }
    }

    def download() {
        def person = springSecurityService.getCurrentUser()
        Document document = Document.findByIdAndOwner(params.id, person)

        if (document) {
            response.setContentType("application/pdf")
            response.setHeader("Content-disposition", "attachment;filename=\"${document.name}\"")
            response.setHeader("Content-Length", "${document.data.size()}")
            response.outputStream << document.data
        } else {
            redirect(action: 'invoices')
        }
    }

    def search = {
        params.max = Math.min(params.max ? params.int('max') : 20, 80)
        def person = springSecurityService.getCurrentUser()

        def documents = Document.createCriteria().list(params) {
            ilike("name", "%${params.query}%")
            owner { eq("id", person.id) }
        }

        render(view: 'list', model: [documents: documents, scheduledInstanceTotal: documents.size(), type: 'mixed', query: params.query])

    }

    def simpleautocomplete() {
        def person = springSecurityService.getCurrentUser()
        def documents = Document.createCriteria().list {
            owner { eq("id", person.id) }
            ilike("name", "%${params.query}%")
        }

        render documents*.name as JSON
        return
    }

    def linkto() {
        def person = springSecurityService.getCurrentUser()
        Document document = Document.findByIdAndOwner(params.id, person)

        if (document) {

            List<Account> accounts = Account.findAllByOwner(person)
            render view: document.type.linkView, model: [document: document, accounts: accounts]

        } else {
            redirect(action: 'invoices')
        }
    }

    def searchoperation(SearchCommand search) {
        def person = springSecurityService.getCurrentUser()
        Document document = Document.findByIdAndOwner(search.id, person)

        if (document) {

            List<Account> accounts = Account.findAllByOwner(person)
            def operations = new ArrayList()

            if (search.couldApply()) {
                operations = Operation.createCriteria().list([order: 'desc', sort: 'dateApplication']) {
                    if (search.tiers) {
                        tiers { eq("name", search.tiers) }
                    }
                    if (search.category) {
                        category { eq("name", search.category) }
                    }
                    if (search.beforeDate) {
                        le("dateApplication", search.beforeDate)
                    }
                    if (search.afterDate) {
                        ge("dateApplication", search.afterDate)
                    }

                    owner { eq("id", person.id) }
                }
            } else {
                flash.message = "Recherche trop imprécise."
            }

            render view: document.type.linkView, model: [document: document, accounts: accounts,
                                                         searched: search.couldApply(), searchedOperations: operations,
                                                         search  : search]
        } else {
            redirect(action: 'invoices')
        }
    }
}
