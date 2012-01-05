package com.headbangers.epsilon
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class SummaryController {

    def springSecurityService
    def genericService
    def scheduledService
    def operationService

    def index = {

        def person = springSecurityService.getCurrentUser()
        def accounts = genericService.loadUserObjects (person, Account.class, [order:'asc', sort:'name'])

        def lateScheduled = scheduledService.findLates(person)
        def todayScheduled = scheduledService.findToday(person, false) // not automatic
        def futuresScheduled = scheduledService.findFutures(person)

        def depense = operationService.calculateDepenseForThisMonth (person)
        def revenu = operationService.calculateRevenuForThisMonth (person)

        def mobileActivation = person.mobileToken ? true : false
        
        def budgets = genericService.loadUserObjects(person, Budget.class, [order:'asc', sort:'name'])

        [accounts:accounts, lates:lateScheduled, today:todayScheduled, future:futuresScheduled, depense:depense, revenu:revenu, person:person, budgets:budgets]
    }
}
