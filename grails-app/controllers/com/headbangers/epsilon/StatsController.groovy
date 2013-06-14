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

import grails.converters.JSON
import jofc2.model.Chart
import jofc2.model.elements.BarChart
import jofc2.model.elements.LineChart
import jofc2.model.axis.YAxis
import jofc2.model.axis.XAxis
import jofc2.model.axis.Label
import jofc2.model.axis.Label.Rotation

import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class StatsController {

    def dateUtil
    def springSecurityService
    def categoryService
    def genericService
    def chartService

    def index = {
    }

    def thismonthoperationsChart = {
        // toutes les opérations de ce mois, toutes catégories confondues, rangées par catégories pour un compte donné (parametre)
        def person = springSecurityService.getCurrentUser()
        def account = Account.findByOwnerAndId(person, params.account)

        def operations = account.getLastOperations()

        // Construction de la MAP
        Map<String, List<Operation>> byCategories = new HashMap<String, List<Operation>>()
        operations.each {operation ->
            def inMap = byCategories.get(operation.category.name)
            if (!inMap) {
                inMap = new ArrayList<Operation>()
                byCategories.put(operation.category.name, inMap)
            }

            inMap.add(operation)
        }

        // Construction du CHART
        def chart = new Chart(account.name)
        def yAxis = new YAxis()
        def axis = new XAxis()
        yAxis.setMax(1000)
        yAxis.setSteps(500)
        def barChart = new BarChart(BarChart.Style.NORMAL)
        byCategories.each {catName, operationsList ->
            axis.addLabels(new Label(catName).setRotation(Rotation.DIAGONAL))

            if (operationsList) {
                def sum = (operationsList*.amount).sum()
                def color = operationsList[0].category.color
                def type = operationsList[0].type

                def operationsBar = new BarChart.Bar(sum, color)
                operationsBar.setTooltip("${catName} #val# €<br>${type}")
                operationsBar.setOnClick("goToCategory('" + operationsList[0].category.id + "')")
                barChart.addBars(operationsBar)

                if (sum >= yAxis.getMax()) {
                    yAxis.setMax(sum + 100)
                }
            }
        }
        chart.setYAxis(yAxis)
        chart.setXAxis(axis)
        chart.addElements(barChart)

        render chart
    }

    def revenuesChart = {
        def person = springSecurityService.getCurrentUser()

        // affichage des catégories par mois
        // zone par défaut - (MAINTENANT-6) > MAINTENANT
        def today = new Date()
        def monthStart = params["month.start"] ? params["month.start"] : 0
        //dateUtil.getSixMonthAgo (today)
        def monthEnd = params["month.end"] ? params["month.end"] : dateUtil.getMonth(today)

        def year = params["year"] ? params["year"] : dateUtil.getCurrentYear()

        params["sort"] = "name"
        params["order"] = "asc"

        // récupération des Categories de l'utilisateur
        def categories = genericService.loadUserObjects(person, Category.class, params)

        // création du chart global
        def chart = new Chart("Opérations de revenus par catégories")
        def yAxis = new YAxis()
        yAxis.setMax(100)
        yAxis.setSteps(100)

        categories.each {category ->

            if (category.type == CategoryType.REVENU) {

                // calcul des dates d'intervalles
                def firstDate = dateUtil.getFirstDayOfTheMonth(monthStart)
                def endDate = dateUtil.getLastDayOfTheMonth(monthEnd)
                log.info "Traitement de la catégorie ${category.name} : du ${firstDate} au ${endDate}"

                // somme des operations par mois
                def lineChart = new LineChart()
                lineChart.setColour(category.color)
                def dots = new ArrayList<LineChart.Dot>()
                def sums = categoryService.sumRevenueForEachMonth(monthStart, monthEnd, category)
                sums.each {sum ->
                    def dot = new LineChart.Dot(sum)
                    dot.tooltip = "${category.name} #val# €"
                    dot.onClick = "goToCategory('" + category.id + "')"
                    dots.add(dot)
                }
                lineChart.addDots(dots)

                sums.each {sum ->
                    if (sum > yAxis.getMax()) {
                        yAxis.setMax(sum + 50)
                    }
                }

                // ajout de la ligne au chart global
                chart.addElements(lineChart)
            }
        }

        def xAxis = new XAxis()
        def cpt = monthStart
        while (cpt <= monthEnd) {
            xAxis.addLabels(new Label("${message(code: 'month.' + cpt)}").setRotation(Rotation.DIAGONAL))
            cpt++
        }

        chart.setYAxis(yAxis)
        chart.setXAxis(xAxis)
        render chart
    }

    def categoryChart = {

        def person = springSecurityService.getCurrentUser()

        // affichage des catégories par mois
        // zone par défaut - (MAINTENANT-6) > MAINTENANT
        def today = new Date()
        def monthStart = params["month.start"] ? params["month.start"] : 0
        //dateUtil.getSixMonthAgo (today)
        def monthEnd = params["month.end"] ? params["month.end"] : dateUtil.getMonth(today)

        def year = params["year"] ? params["year"] : dateUtil.getCurrentYear()

        params["sort"] = "name"
        params["order"] = "asc"

        // récupération des Categories de l'utilisateur
        def categories = genericService.loadUserObjects(person, Category.class, params)

        // création du chart global
        def chart = new Chart("Opérations de dépenses par catégories")
        def yAxis = new YAxis()
        yAxis.setMax(100)
        yAxis.setSteps(100)

        categories.each {category ->

            if (category.type == CategoryType.DEPENSE) {

                // calcul des dates d'intervalles
                def firstDate = dateUtil.getFirstDayOfTheMonth(monthStart)
                def endDate = dateUtil.getLastDayOfTheMonth(monthEnd)
                log.info "Traitement de la catégorie ${category.name} : du ${firstDate} au ${endDate}"

                // somme des operations par mois
                def lineChart = new LineChart()
                lineChart.setColour(category.color)
                def dots = new ArrayList<LineChart.Dot>()
                def sums = categoryService.sumDepenseForEachMonth(monthStart, monthEnd, category)
                sums.each {sum ->
                    def dot = new LineChart.Dot(sum)
                    dot.tooltip = "${category.name} #val# €"
                    dot.onClick = "goToCategory('" + category.id + "')"
                    dots.add(dot)
                }
                lineChart.addDots(dots)

                sums.each {sum ->
                    if (sum > yAxis.getMax()) {
                        yAxis.setMax(sum + 50)
                    }
                }

                // ajout de la ligne au chart global
                chart.addElements(lineChart)
            }
        }

        def xAxis = new XAxis()
        def cpt = monthStart
        while (cpt <= monthEnd) {
            xAxis.addLabels(new Label("${message(code: 'month.' + cpt)}").setRotation(Rotation.DIAGONAL))
            cpt++
        }

        chart.setYAxis(yAxis)
        chart.setXAxis(xAxis)
        render chart

    }
}
