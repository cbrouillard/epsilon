package com.headbangers.epsilon.api

import com.headbangers.epsilon.Budget
import com.headbangers.epsilon.CategoryType
import com.headbangers.epsilon.Operation
import com.headbangers.epsilon.OperationType
import com.headbangers.epsilon.Person
import com.headbangers.epsilon.Scheduled
import com.headbangers.epsilon.mobile.MobileChartData
import grails.converters.JSON

import javax.servlet.http.HttpServletRequest

class WsDataController {

    def personService
    def dateUtil

    private Person checkUser(HttpServletRequest request) {
        String token = request.getHeader("WWW-Authenticate")
        if (token) {
            return personService.findUserByToken(token)
        }

        return null
    }

    def chartByCategoryData() {
        def person = checkUser(request)
        MobileChartData data = new MobileChartData()
        if (person) {
            def graphData = Operation.executeQuery(
                    'select c.name, sum(o.amount) from Operation o inner join o.category c inner join o.owner p where o.dateApplication >= ? and o.dateApplication <= ? and o.type = ? and c.type = ? and p.id = ?  group by c.name order by c.name',
                    [dateUtil.getFirstDayOfTheMonth(), dateUtil.getLastDayOfTheMonth(), OperationType.RETRAIT, CategoryType.DEPENSE, person.id]).asList()
            def colors = Operation.executeQuery(
                    'select c.color from Operation o inner join o.category c inner join o.owner p where o.dateApplication >= ? and o.dateApplication <= ? and o.type = ? and c.type = ? and p.id = ? group by c.color, c.name order by c.name',
                    [dateUtil.getFirstDayOfTheMonth(), dateUtil.getLastDayOfTheMonth(), OperationType.RETRAIT, CategoryType.DEPENSE, person.id]).asList()

            data.setGraphData(graphData)
            data.setColors(colors)
        }

        render data as JSON

    }

    def chartAccountFuture() {

    }

    def soldStats() {
        def person = checkUser(request)
        Map<String, Double> stats = new HashMap<>();

        if (person) {
            Date today = dateUtil.todayMorning
            Date roll = dateUtil.getDatePlusOneMonth(today)
            roll = dateUtil.getDateAtEvening(roll)

            def depense = 0
            def revenus = 0
            Scheduled.findAllByOwner(person).each { scheduled ->
                if (scheduled.active && !scheduled.deleted) {
                    if (scheduled.dateApplication.after(today) && scheduled.dateApplication.before(roll)) {
                        if (scheduled.type == OperationType.DEPOT) {
                            revenus += scheduled.amount
                        } else if (scheduled.type == OperationType.FACTURE) {
                            depense += scheduled.amount
                        }

                    }
                }
            }

            def seuil = depense
            Budget.findAllByOwnerAndStartDateAndEndDateAndActive(person, null, null, true).each { budget ->
                seuil += budget.amount
            }

            stats.put("spent", depense)
            stats.put("revenue", revenus)
            stats.put("threshold", seuil)
            stats.put("saving", revenus - seuil)

        }

        render stats as JSON
    }
}
