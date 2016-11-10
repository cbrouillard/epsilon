package com.headbangers.epsilon.api

import com.headbangers.epsilon.Account
import com.headbangers.epsilon.Budget
import com.headbangers.epsilon.CategoryType
import com.headbangers.epsilon.Operation
import com.headbangers.epsilon.OperationType
import com.headbangers.epsilon.Person
import com.headbangers.epsilon.Scheduled
import com.headbangers.epsilon.Tiers
import com.headbangers.epsilon.mobile.GraphData
import com.headbangers.epsilon.mobile.MobileChartData
import grails.converters.JSON
import org.hibernate.Criteria

import javax.servlet.http.HttpServletRequest
import java.text.SimpleDateFormat

class WsDataController {

    def personService
    def dateUtil
    def scheduledService

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

            data.specialSetGraphData(graphData)
            data.setColors(colors)
        }

        render data as JSON

    }

    def chartAccountFuture() {
        def person = checkUser(request)
        MobileChartData chartData = new MobileChartData(colors: ['#92e07f'])
        if (person) {
            Account account = Account.findByOwnerAndId(person, params.wsAccountId)
            if (account) {

                def lastDayOfMonth = dateUtil.getLastDayOfTheMonth(new Date())
                def programmedScheduleds = Scheduled.createCriteria().list {
                    createAlias('accountTo', 'accountTo', Criteria.LEFT_JOIN)
                    createAlias('accountFrom', 'accountFrom', Criteria.LEFT_JOIN)
                    lte("dateApplication", lastDayOfMonth)
                    eq("active", true)
                    eq("deleted", false)
                    gt("dateApplication", new Date())
                    or {
                        eq("accountTo.id", account.id)
                        eq("accountFrom.id", account.id)
                    }
                }

                if (!programmedScheduleds) {
                    Date todayPlusOneMonth = dateUtil.getDatePlusOneMonth(new Date())
                    lastDayOfMonth = dateUtil.getLastDayOfTheMonth(todayPlusOneMonth)
                    programmedScheduleds = Scheduled.createCriteria().list {
                        createAlias('accountTo', 'accountTo', Criteria.LEFT_JOIN)
                        createAlias('accountFrom', 'accountFrom', Criteria.LEFT_JOIN)
                        lte("dateApplication", lastDayOfMonth)
                        gt("dateApplication", new Date())
                        eq("active", true)
                        eq("deleted", false)
                        or {
                            eq("accountTo.id", account.id)
                            eq("accountFrom.id", account.id)
                        }
                    }
                }

                def futures = programmedScheduleds

                def allOperations = account?.lastOperations;
                def accountAmount = account?.lastSnapshot?.amount ?: account.amount;

                def sdf = new SimpleDateFormat("MMMM")
                def cal = Calendar.getInstance()
                def currentMonth = cal.get(Calendar.MONTH)

                def operationsSortedByDaysIncludingFutures = allOperations + futures;
                operationsSortedByDaysIncludingFutures = operationsSortedByDaysIncludingFutures.sort {
                    it.dateApplication
                }

                def actualDay = 1;
                def prevDay = actualDay;
                Date previousDate = cal.getTime()
                def bufferAmount = accountAmount;

                int i = 0;

                operationsSortedByDaysIncludingFutures.each { operation ->

                    cal.setTime(operation.dateApplication)

                    actualDay = cal.get(Calendar.DAY_OF_MONTH)
                    if (actualDay != prevDay || (currentMonth != cal.get(Calendar.MONTH) && actualDay == prevDay)) {
                        chartData.graphData.add(new GraphData(key: "$prevDay ${sdf.format(previousDate)}", value: bufferAmount, index: i))
                        prevDay = actualDay;
                        i += 1;
                    }

                    if (operation.type.equals(OperationType.DEPOT) || operation.type.equals(OperationType.VIREMENT_PLUS)) {
                        bufferAmount += operation.amount
                    } else {
                        if (operation instanceof Scheduled && operation.accountTo && operation.accountTo.id.equals(account.id)) {
                            bufferAmount += operation.amount
                        } else {
                            bufferAmount -= operation.amount
                        }
                    }
                    previousDate = operation.dateApplication

                }

                chartData.graphData.add(new GraphData(key: "$prevDay ${sdf.format(previousDate)}", value: bufferAmount, index: i))
                if (!operationsSortedByDaysIncludingFutures || operationsSortedByDaysIncludingFutures.size() == 1) {
                    cal.setTime(new Date())
                    cal.add(Calendar.MONTH, 1)
                    cal.set(Calendar.DAY_OF_MONTH, 0)
                    chartData.graphData.add(new GraphData(key: "${cal.get(Calendar.DAY_OF_MONTH)} ${sdf.format(cal.getTime())}", value: bufferAmount, index: 1))
                }
            }
        }

        render chartData as JSON

    }

    def soldStats() {
        def person = checkUser(request)
        Map<String, Double> stats = new HashMap<>();

        if (person) {
            stats = scheduledService.buildFutureStats(person)

        }

        render stats as JSON
    }

    def chartCategoryOperations() {

        MobileChartData chartData = new MobileChartData(colors: ['#92e07f'])
        def person = checkUser(request)

        if (person) {
            def category = com.headbangers.epsilon.Category.findByOwnerAndId(person, params.wsCategoryId)
            if (category) {
                chartData = new MobileChartData(colors: [category.color])

                def operations = Operation.findAllByCategory(category, [order: 'asc', sort: 'dateApplication'])
                chartData.graphData = buildChartOperations(operations);
            }
        }

        render chartData as JSON
    }

    def chartTiersOperations() {
        MobileChartData chartData = new MobileChartData(colors: ['#92e07f'])
        def person = checkUser(request)

        if (person) {
            def tiers = Tiers.findByOwnerAndId(person, params.wsTiersId)
            if (tiers) {
                chartData = new MobileChartData(colors: [tiers.color])

                def operations = Operation.findAllByTiers(tiers, [order: 'asc', sort: 'dateApplication'])
                chartData.graphData = buildChartOperations(operations);
            }
        }

        render chartData as JSON
    }

    private List<GraphData> buildChartOperations(operations) {
        List<GraphData> datas = new ArrayList<>()

        Calendar cal = Calendar.getInstance()
        Date previousDate = new Date()
        def sdf = new SimpleDateFormat("MMMM YYYY")

        def actualMonth = 0
        def bufferAmount = 0
        if (operations) {
            cal.setTime(operations.get(0).dateApplication)
            actualMonth = cal.get(Calendar.MONTH)
        }
        def prevMonth = actualMonth

        int i = 0
        operations.each { operation ->
            cal.setTime(operation.dateApplication)

            actualMonth = cal.get(Calendar.MONTH)
            if (actualMonth != prevMonth) {
                // changement de mois
                datas.add(new GraphData(key: sdf.format(previousDate), value: bufferAmount, index:i))
                prevMonth = actualMonth;

                bufferAmount = 0
                i += 1
            }

            bufferAmount += operation.amount
            previousDate = operation.dateApplication
        }

        datas.add(new GraphData(key: sdf.format(previousDate), value: bufferAmount, index:i))
        return datas
    }

}
