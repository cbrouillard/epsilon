package com.headbangers.epsilon.api

import com.headbangers.epsilon.Account
import com.headbangers.epsilon.Person
import com.headbangers.epsilon.mobile.MobileOperation
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class WsAccountController {

    def personService

    private Person checkUser(HttpServletRequest request) {
        String token = request.getHeader("WWW-Authenticate")
        if (token) {
            return personService.findUserByToken(token)
        }

        return null
    }

    // "/api/accounts"
    def index() {
        def person = checkUser(request)
        List<com.headbangers.epsilon.mobile.MobileAccount> accounts = new ArrayList<com.headbangers.epsilon.mobile.MobileAccount>()
        if (person) {
            def db = Account.findAllByOwner(person, [sort: 'name', order: 'asc'])
            db.each { account ->
                accounts.add(new com.headbangers.epsilon.mobile.MobileAccount(account))
            }
        }

        render accounts as JSON
    }

    // "/api/accounts/$id"
    def show() {
        def person = checkUser(request)
        com.headbangers.epsilon.mobile.MobileAccount result = new com.headbangers.epsilon.mobile.MobileAccount()
        if (person) {
            def account = Account.findByIdAndOwner(params.id, person)
            if (account) {
                result = new com.headbangers.epsilon.mobile.MobileAccount(account)
            }
        }

        render result as JSON
    }

    def operations (){
        def person = checkUser(request)
        List<MobileOperation> result = new ArrayList<MobileOperation>();
        if (person && params.wsAccountId) {
            def account = Account.findByIdAndOwner(params.wsAccountId, person)
            def operations = account.getLastOperationsDesc()
            operations.each { operation ->
                result.add(new MobileOperation(operation))
            }
        }

        render result as JSON
    }

}
