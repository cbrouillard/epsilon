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

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class SummaryController {

    def springSecurityService
    def genericService
    def scheduledService
    def operationService
    def budgetService
    def dateUtil

    def index = {

        def person = springSecurityService.getCurrentUser()
        def accounts = genericService.loadUserObjects(person, Account.class, [order: 'asc', sort: 'name'])

        def lateScheduled = scheduledService.findLates(person)
        def todayScheduled = scheduledService.findToday(person, false) // not automatic
        def futuresScheduled = scheduledService.findFutures(person)

        def depense = operationService.calculateDepenseForThisMonth(person)
        // def revenu = operationService.calculateRevenuForThisMonth(person)

        def budgets = genericService.loadUserObjects(person, Budget.class, [order: 'asc', sort: 'name'])
        budgets = budgets.findAll  {Budget b -> b.active == true}
        def outOfBudgets = budgetService.calculateOutOfBudgetAmount(budgets, person)

        def pinnedCategories = Category.createCriteria().list([order:'asc', sort:'name'], {
            owner {eq("id", person.id)}
            eq("pinned", true)
        })
        def pinnedTiers = Tiers.createCriteria().list([order:'asc', sort:'name'], {
            owner {eq("id", person.id)}
            eq("pinned", true)
        })

        def graphData = Operation.executeQuery(
                'select c.name, sum(o.amount) from Operation o inner join o.category c inner join o.owner p where o.dateApplication >= ? and o.dateApplication <= ? and o.type = ? and c.type = ? and p.id = ?  group by c.name order by c.name',
                [dateUtil.getFirstDayOfTheMonth(), dateUtil.getLastDayOfTheMonth(), OperationType.RETRAIT, CategoryType.DEPENSE, person.id]).asList()
        def colors = Operation.executeQuery(
                'select c.color from Operation o inner join o.category c inner join o.owner p where o.dateApplication >= ? and o.dateApplication <= ? and o.type = ? and c.type = ? and p.id = ? group by c.color, c.name order by c.name',
                [dateUtil.getFirstDayOfTheMonth(), dateUtil.getLastDayOfTheMonth(), OperationType.RETRAIT, CategoryType.DEPENSE, person.id]).asList()

        [accounts: accounts, lates: lateScheduled, today: todayScheduled,
         future  : futuresScheduled, depense: depense, person: person, budgets: budgets, graphData: graphData, colors:colors,
         pinnedCategories:pinnedCategories,pinnedTiers:pinnedTiers, revenues:scheduledService.calculateOneMonthRevenues(person),
                outOfBudget:outOfBudgets
        ]
    }
}
