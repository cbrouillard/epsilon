package com.headbangers.epsilon

class OperationService {

    boolean transactional = true

    def dateUtil

    def findAllDepenseForThisMonth(person) {
        return Operation.createCriteria ().list (sort:'dateApplication', order:'desc'){
            owner{eq("id", person.id)}
            category{eq("type", CategoryType.DEPENSE)}
            between("dateApplication", dateUtil.getFirstDayOfTheMonth(), dateUtil.getLastDayOfTheMonth())
        }
    }

    def findAllRevenuForThisMonth (person) {
        return Operation.createCriteria ().list (sort:'dateApplication', order:'desc'){
            owner{eq("id", person.id)}
            category{eq("type", CategoryType.REVENU)}
            between("dateApplication", dateUtil.getFirstDayOfTheMonth(), dateUtil.getLastDayOfTheMonth())
        }
    }

    def findAllOperationsForMonth (concernedAccount, date) {
        return Operation.createCriteria ().list (sort:'dateApplication', order:'desc'){
            account{eq("id", concernedAccount.id)}
            between("dateApplication", dateUtil.getFirstDayOfTheMonth(date), dateUtil.getLastDayOfTheMonth(date))
        }
    }

    def calculateDepenseForThisMonth (person){
        def operations = findAllDepenseForThisMonth(person)
        def amount = 0D
        operations.each {operation ->
            amount += operation.amount
        }

        return amount
    }

    def calculateRevenuForThisMonth (person){
        def operations = findAllRevenuForThisMonth(person)
        def amount = 0D
        operations.each {operation ->
            amount += operation.amount
        }

        return amount
    }
}
