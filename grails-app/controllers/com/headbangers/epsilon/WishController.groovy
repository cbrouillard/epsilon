package com.headbangers.epsilon

import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.jsoup.nodes.Element
import org.jsoup.select.Elements
import org.springframework.dao.DataIntegrityViolationException
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class WishController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def genericService

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        def person = springSecurityService.getCurrentUser()
        def wishes = genericService.loadUserObjects(person, Wish.class, params)

        [wishInstanceList: wishes, wishInstanceTotal: wishes.totalCount]
    }

    def create() {

        def person = springSecurityService.getCurrentUser()
        def accounts = Account.findAllByOwner(person)

        [wishInstance: new Wish(params), accounts: accounts]
    }

    def save() {

        def person = springSecurityService.getCurrentUser()
        def wishInstance = new Wish(params)

        wishInstance.owner = person

        if (!wishInstance.save(flush: true)) {
            def accounts = Account.findAllByOwner(person)
            render(view: "create", model: [wishInstance: wishInstance, accounts: accounts])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'wish.label', default: 'Wish'), wishInstance.id])
        redirect(action: "list")
    }

    def bulksave() {
        def person = springSecurityService.getCurrentUser()

        String data = params.bulkData
        params.remove("bulkData")
        if (data) {

            String[] links = data.split("\n")
            links.each { link ->
                try {
                    Wish wish = new Wish(params)
                    wish.owner = person
                    wish.webShopUrl = link

                    Document doc = Jsoup.connect(link).userAgent("Mozilla").get()
                    wish.name = doc.title()

                    tryToGuessPrice(wish, link, doc)

                    wish.save(flush: true)
                } catch (Exception e) {
                    // next
                }
            }
            redirect(action: "list")
            return
        }
        redirect(action: "create")
    }

    def create_operation() {
        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)

        if (!wishInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
            return
        }

        params.remove("id")
        def operationInstance = new Operation()
        operationInstance.amount = wishInstance.price
        operationInstance.dateApplication = new Date()
        bindData(operationInstance, params)

        [wishInstance: wishInstance, operationInstance: operationInstance]
    }

    def save_operation() {
        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)

        // Création de l'opération
    }

    def show() {
        def wishInstance = Wish.get(params.id)
        def person = springSecurityService.getCurrentUser()

        if (!wishInstance || !wishInstance.owner.equals(person)) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
            return
        }

        [wishInstance: wishInstance]
    }

    def edit() {

        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)

        if (!wishInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
            return
        }

        def accounts = Account.findAllByOwner(person)
        [wishInstance: wishInstance, accounts: accounts]
    }

    def update() {
        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)

        if (!wishInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (wishInstance.version > version) {
                wishInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'wish.label', default: 'Wish')] as Object[],
                        "Another user has updated this Wish while you were editing")
                render(view: "edit", model: [wishInstance: wishInstance])
                return
            }
        }

        wishInstance.properties = params

        if (!wishInstance.save(flush: true)) {
            render(view: "edit", model: [wishInstance: wishInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'wish.label', default: 'Wish'), wishInstance.id])
        redirect(action: "list")
    }

    def delete() {
        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)

        if (!wishInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
            return
        }

        try {
            wishInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'wish.label', default: 'Wish'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    def guess() {
        def wishInstance = new Wish(params)
        def person = springSecurityService.getCurrentUser()
        def accounts = Account.findAllByOwner(person)
        if (params.url) {
            wishInstance.webShopUrl = params.url

            try {
                Document doc = Jsoup.connect(params.url).userAgent("Mozilla").get()
                wishInstance.name = doc.title()

                tryToGuessPrice(wishInstance, params.url, doc)
            } catch (MalformedURLException e) {
                // de la merde
                flash.message = "Lien non valide"
            } catch (Exception e) {
                flash.message = "Lien non valide"
            }

        }

        render view: 'create', model: [wishInstance: wishInstance, accounts: accounts]
    }

    private void tryToGuessPrice(def wishInstance, String url, Document doc) {
        if (url.contains("amazon")) {
            Element price = doc.getElementById("priceblock_ourprice")
            if (price) {
                wishInstance.priceFromWebsite = price.text()
                try {
                    wishInstance.price = new Double(price.text().substring(4).replace(",", ".").replace("€", " ").trim())
                } catch (Exception e) {
                    // ok pas grave.
                }
            }

            return
        }

        Elements elements = doc.select("[itemprop=\"price\"]")
        if (!elements) {
            elements = doc.select("[class=\"currentPrice\"")
        }

        if (elements) {
            String price = elements.get(0).text()
            wishInstance.priceFromWebsite = price
            try {
                wishInstance.price = new Double(price.replace(",", ".").replace("€", " ").trim().reverse().replaceFirst(" ", ".").reverse())
            } catch (Exception e) {
                // ok pas grave.
            }

            return
        }

        wishInstance.price = 0D;
    }
}
