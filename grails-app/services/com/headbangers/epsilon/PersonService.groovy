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

class PersonService {

    def springSecurityService

    def findUserByToken(String tokenId) {

        return Person.findByMobileToken (tokenId)

    }

    def findByLoginAndPass (login, pass){
        return Person.findByUsernameAndPasswd (login, springSecurityService.encodePassword(pass))
    }
}
