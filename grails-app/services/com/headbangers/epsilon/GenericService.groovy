package com.headbangers.epsilon

class GenericService {

    boolean transactional = true

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
