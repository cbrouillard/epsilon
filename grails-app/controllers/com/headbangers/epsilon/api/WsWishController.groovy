package com.headbangers.epsilon.api

import com.headbangers.epsilon.Account
import com.headbangers.epsilon.CategoryType
import com.headbangers.epsilon.Person
import com.headbangers.epsilon.Wish
import com.headbangers.epsilon.mobile.MobileSimpleResult
import com.headbangers.epsilon.mobile.MobileWish
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class WsWishController {

    def personService
    def categoryService

    private Person checkUser(HttpServletRequest request) {
        String token = request.getHeader("WWW-Authenticate")
        if (token) {
            return personService.findUserByToken(token)
        }

        return null
    }

    def index() {
        def person = checkUser(request)
        List<MobileWish> wishes = new ArrayList<MobileWish>()
        if (person) {
            def db = Wish.findAllByOwnerAndBought(person, false, [sort: 'name', order: 'asc'])
            db.each { wish ->
                wishes.add(new MobileWish(wish))
            }
        }

        render wishes as JSON

    }

    def show () {
        def person = checkUser(request)
        MobileWish wish = new MobileWish( )
        if (person && params.id){
            def db = Wish.findByOwnerAndId (person, params.id)
            if (db){
                wish = new MobileWish (db)
            }
        }

        render wish as JSON
    }

    def save (){
        MobileSimpleResult result = new MobileSimpleResult("ko")
        def person = checkUser(request)

        if (person){
            def account = Account.findByOwnerAndId (person, params.account)

            if (account) {
                Wish wish = new Wish()
                wish.owner = person
                wish.name = params.name
                wish.price = Double.parseDouble(params.price.replaceAll(",", "\\."))
                wish.account = account
                wish.category = categoryService.findOrCreateCategory(person, params.category, CategoryType.DEPENSE)

                if (wish.save(flush:true)){
                    result.setCode("ok")
                }
            }
        }

        render result as JSON
    }
}
