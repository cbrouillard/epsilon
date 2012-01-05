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
