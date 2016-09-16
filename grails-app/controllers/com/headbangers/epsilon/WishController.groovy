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
    def categoryService
    def tiersService

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        boolean alreadyBought = params.b ? params.b.equals("true") : false
        String catId = params.c ?: null

        def person = springSecurityService.getCurrentUser()
        def wishes = Wish.createCriteria().list(params, {
            owner{eq ("id", person.id)}
            eq("bought", alreadyBought)
            if (catId){
                category { eq ("id", catId) }
            }
            order("price", "desc")

        });

        def totalPrice = Wish.createCriteria().get {
            owner{eq ("id", person.id)}
            eq("bought", false)
            projections {
                sum('price')
            }
        }

        def allWishes = genericService.loadUserObjects(person, Wish.class)
        List<Category> categories = ((allWishes*.category) - null).toSet()
                .sort(Category.nameComparator)

        [wishInstanceList: wishes, wishInstanceTotal: wishes.totalCount, categories:categories, totalPrice:totalPrice]
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

        if (params["category.name"]) {
            // we search for the category, if we don't find it then auto-create
            wishInstance.category = categoryService.findOrCreateCategory(person, params["category.name"], CategoryType.DEPENSE)
        }

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



                    tryToGuessData(wish, link)

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
        operationInstance.note = wishInstance.description
        operationInstance.category = wishInstance.category
        bindData(operationInstance, params)

        [wishInstance: wishInstance, operationInstance: operationInstance]
    }

    def save_operation() {
        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.wishId, person)
        if (!wishInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'wish.label', default: 'Wish'), params.wishId])
            redirect(action: "list")
            return
        }

        // Création de l'opération
        params.remove("id")
        def operationInstance = new Operation(params)
        operationInstance.type = OperationType.RETRAIT
        operationInstance.owner = person
        operationInstance.account = wishInstance.account
        if (params["category.name"]) {
            // we search for the category, if we don't find it then auto-create
            operationInstance.category = categoryService.findOrCreateCategory(person, params["category.name"], CategoryType.DEPENSE)
        }
        if (params["tiers.name"]) {
            // we search for the category, if we don't find it then auto-create
            operationInstance.tiers = tiersService.findOrCreateTiers(person, params["tiers.name"])
        }

        operationInstance.save(flush: true)
        wishInstance.bought = true
        wishInstance.boughtDate = new Date()
        wishInstance.save(flush: true)

        flash.message = "Operation créée"
        redirect(action: "list")
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

    def refresh() {
        def person = springSecurityService.getCurrentUser()
        def wishInstance = Wish.findByIdAndOwner(params.id, person)

        if (wishInstance) {

            try {
                tryToGuessData(wishInstance, wishInstance.webShopUrl)
            } catch (MalformedURLException e) {
                // de la merde
                flash.message = "Lien non valide"
            } catch (Exception e) {
                flash.message = "Lien non valide"
            }

            render(template: 'onewish', model: [wishInstance: wishInstance, refreshed: true])
            return
        }

        redirect(action: 'list')
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

        if (params["category.name"]) {
            // we search for the category, if we don't find it then auto-create
            wishInstance.category = categoryService.findOrCreateCategory(person, params["category.name"], CategoryType.DEPENSE)
            params.remove("category.name")
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
                tryToGuessData(wishInstance, params.url)
            } catch (MalformedURLException e) {
                // de la merde
                flash.message = "Lien non valide"
            } catch (Exception e) {
                flash.message = "Lien non valide"
            }

        }

        render view: 'create', model: [wishInstance: wishInstance, accounts: accounts]
    }

    private void tryToGuessData(def wishInstance, String url) {

        Document doc = Jsoup.connect(params.url).userAgent("Mozilla").get()
        wishInstance.name = doc.title()

        if (url.contains("amazon")) {
            Element price = doc.getElementById("priceblock_ourprice")
            if (!price) {
                Elements potential = doc.select("[class=\"a-color-price\"]")
                if (potential) {
                    price = potential.get(0);
                }
            }
            if (price) {
                wishInstance.priceFromWebsite = price.text()
                try {
                    wishInstance.price = new Double(price.text().substring(4).replace(",", ".").replace("€", " ").trim())
                } catch (Exception e) {
                    // ok pas grave.
                    wishInstance.price = 1D;
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
                wishInstance.price = 1D;
            }

            return
        }

        wishInstance.price = 1D;
    }
}
