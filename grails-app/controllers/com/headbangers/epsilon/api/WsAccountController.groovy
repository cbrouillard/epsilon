package com.headbangers.epsilon.api

import com.headbangers.epsilon.Account
import com.headbangers.epsilon.Person
import com.headbangers.epsilon.mobile.MobileAccount
import com.headbangers.epsilon.mobile.MobileOperation
import com.headbangers.epsilon.mobile.MobileSimpleResult
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class WsAccountController {

    def personService
    def genericService

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
        List<MobileAccount> accounts = new ArrayList<MobileAccount>()
        if (person) {
            def db = genericService.loadUserObjects(person, Account.class, [sort: 'name', order: 'asc'])
            db.each { account ->
                accounts.add(new MobileAccount(account))
            }
        }

        render accounts as JSON
    }

    // "/api/accounts/$id"
    def show() {
        def person = checkUser(request)
        MobileAccount result = new MobileAccount()
        if (person) {
            def account = genericService.loadUserObject (person, Account.class, params.id)
            if (account) {
                result = new MobileAccount(account)
            }
        }

        render result as JSON
    }

    def operations() {
        def person = checkUser(request)
        List<MobileOperation> result = new ArrayList<MobileOperation>();
        if (person && params.wsAccountId) {
            def account = genericService.loadUserObject (person, Account.class, params.wsAccountId)
            def operations = account.getLastOperationsDesc()
            operations.each { operation ->
                result.add(new MobileOperation(operation))
            }
        }

        render result as JSON
    }

    def setDefault() {
        def person = checkUser(request)
        MobileSimpleResult result = new MobileSimpleResult("ko")
        if (person) {
            def account = genericService.loadUserObject (person, Account.class, params.wsAccountId)
            if (account) {
                Account.executeUpdate("update Account set mobileDefault = false where owner = ?", [person])
                account.setMobileDefault(new Boolean(params.isDefault))
                if (account.save(flush: true)){
                    result.setCode("ok")
                }
            }
        }

        render result as JSON
    }

}
