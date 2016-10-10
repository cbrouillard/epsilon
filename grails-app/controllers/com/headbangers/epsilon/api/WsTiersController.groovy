package com.headbangers.epsilon.api

import com.headbangers.epsilon.Operation
import com.headbangers.epsilon.Person
import com.headbangers.epsilon.Tiers
import com.headbangers.epsilon.mobile.MobileOperation
import com.headbangers.epsilon.mobile.MobileTiers
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class WsTiersController {

    def personService

    private Person checkUser(HttpServletRequest request) {
        String token = request.getHeader("WWW-Authenticate")
        if (token) {
            return personService.findUserByToken(token)
        }

        return null
    }

    def index() {
        List<MobileTiers> result = new ArrayList<MobileTiers>()
        def person = checkUser(request)
        if (person) {
            def tiers = Tiers.findAllByOwner(person, [sort: 'name', order: 'asc'])
            tiers.each { tier ->
                result.add(new MobileTiers(tier))
            }
        }

        render result as JSON
    }

    def names() {
        List<Tiers> tiers = new ArrayList<Tiers>()
        def person = checkUser(request)
        if (person) {
            tiers = Tiers.findAllByOwner(person, [sort: 'name', order: 'asc'])
        }

        render tiers*.name as JSON
    }

    def operations() {
        def person = checkUser(request)
        List<MobileOperation> result = new ArrayList<MobileOperation>();
        if (person && params.wsTiersId) {
            def tiers = Tiers.findByOwnerAndId(person, params.wsTiersId)
            if (tiers) {
                def operations = Operation.findAllByTiers(tiers)
                operations.each { operation ->
                    result.add(new MobileOperation(operation))
                }
            }
        }

        render result as JSON
    }
}
