package com.headbangers.epsilon.api

import com.headbangers.epsilon.Person
import com.headbangers.epsilon.mobile.MobileScheduled
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class WsScheduledController {

    def scheduledService
    def personService

    private Person checkUser(HttpServletRequest request) {
        String token = request.getHeader("WWW-Authenticate")
        if (token) {
            return personService.findUserByToken(token)
        }

        return null
    }

    def index() {
        def person = checkUser(request)
        List<MobileScheduled> result = new ArrayList<MobileScheduled>();
        if (person) {
            def scheduleds = scheduledService.findFutures(person)
            scheduleds.each { oneScheduled ->
                def mobileScheduled = new MobileScheduled(oneScheduled)
                result.add(mobileScheduled)
            }
        }

        render result as JSON
    }
}
