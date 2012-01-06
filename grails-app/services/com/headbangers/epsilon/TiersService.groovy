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

class TiersService {

    boolean transactional = true

    def findAllTiers (person){
        return Tiers.findAllByOwner (person)
    }

    def findOrCreateTiers(person, tiersName) {
        
        def tiers = Tiers.findByOwnerAndName (person, tiersName)
        if (!tiers){
            log.debug ("Creating a new Tiers : ${tiersName}")
            return new Tiers (name:tiersName, owner:person).save(flush:true);
        }
        return tiers
    }

    def retrieveOperations (forTiers){
        return Operation.createCriteria().list (order:'asc', sort:'dateApplication'){
            tiers{
                eq ("id", forTiers.id)
            }
        }
    }
}
