package com.headbangers.epsilon

class PersonService {

    static transactional = true

    def springSecurityService

    def findUserByToken(String tokenId) {

        return Person.findByMobileToken (tokenId)

    }

    def findByLoginAndPass (login, pass){
        return Person.findByUsernameAndPasswd (login, springSecurityService.encodePassword(pass))
    }
}
