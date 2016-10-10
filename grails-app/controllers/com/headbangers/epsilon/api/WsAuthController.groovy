package com.headbangers.epsilon.api

import com.headbangers.epsilon.mobile.MobileSimpleResult
import grails.converters.JSON

class WsAuthController {

    def personService

    // mapped on POST
    def save() {
        def person = personService.findByLoginAndPass(params.login, params.pass)
        def token = new MobileSimpleResult()
        if (person && person.mobileToken) {
            token.setCode(person.mobileToken)
        }

        render token as JSON
    }
}
