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

class GenericService {

    def loadUserObjects(person, object) {
        return object.createCriteria().list(sort:'dateCreated', order:'desc'){
            owner {eq ("id", person.id)}
        }
    }

    def loadUserObjects(person, object, params) {
        return object.createCriteria()
            .list(sort:params.sort, order:params.order, max:params.max, offset:params.offset){
                owner {eq ("id", person.id)}
            }
    }

    def loadUserObject (person, object, objectId){
        return object.createCriteria().get {
            owner {eq ("id", person.id)}
            eq ("id", objectId)
            maxResults(1)
        }
    }
}
