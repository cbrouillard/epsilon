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

import org.hibernate.criterion.CriteriaSpecification;

class GenericService {

    def springSecurityService

    def buildColor(name) {
        def md5 = springSecurityService.encodePassword(name).toString()
        return "#${md5.substring(0, 6)}"
    }

    def loadUserObjects(person, object) {
        return object.createCriteria().list(sort: 'dateCreated', order: 'desc') {

            if (object == Account.class) {
                createAlias("joinOwner", "j", CriteriaSpecification.LEFT_JOIN)
                or {
                    owner { eq("id", person.id) }
                    eq("j.id", person.id)
                }
            } else {

                owner { eq("id", person.id) }

            }
        }
    }

    def loadUserObjects(person, object, params) {
        return object.createCriteria()
                .list(sort: params.sort, order: params.order, max: params.max, offset: params.offset) {
            if (object == Account.class) {
                createAlias("joinOwner", "j", CriteriaSpecification.LEFT_JOIN)
                or {
                    owner { eq("id", person.id) }
                    eq("j.id", person.id)
                }
            } else {
                owner { eq("id", person.id) }
            }
        }
    }

    def loadUserObject(person, object, String objectId) {
        if (object == Operation.class) {

            Operation operation = Operation.get(objectId)
            if (operation &&
                    (operation.ownerId == person.id ||
                            person.id == operation.account.joinOwnerId ||
                            person.id == operation.account.ownerId)) {
                return operation
            } else {
                return null
            }

        } else {

            return object.createCriteria().get {
                if (object == Account.class) {
                    createAlias("joinOwner", "j", CriteriaSpecification.LEFT_JOIN)
                    or {
                        owner { eq("id", person.id) }
                        eq("j.id", person.id)
                    }
                } else {

                    owner { eq("id", person.id) }

                }
                eq("id", objectId)
                maxResults(1)
            }
        }
    }
}
