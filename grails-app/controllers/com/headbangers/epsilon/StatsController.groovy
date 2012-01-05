package com.headbangers.epsilon
import jofc2.model.Chart
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
        redirect (action:category)
    }

    def category = {        
    }
    
    def revenues = {}
    
    
    def revenuesChart = {
        def person = springSecurityService.getCurrentUser()

        // affichage des catégories par mois
        // zone par défaut - (MAINTENANT-6) > MAINTENANT
        def today = new Date()
        def monthStart = params["month.start"] ? params["month.start"] : 0 //dateUtil.getSixMonthAgo (today)
        def monthEnd = params["month.end"] ? params["month.end"] : dateUtil.getMonth (today)

        def year = params["year"] ? params["year"] : dateUtil.getCurrentYear ()
        
        params["sort"] = "name"
        params["order"] = "asc"

        // récupération des Categories de l'utilisateur
        def categories = genericService.loadUserObjects (person, Category.class, params)

        // création du chart global
        def chart = new Chart("Opérations de revenus par catégories")
        def yAxis = new YAxis()
        yAxis.setMax (100)
        yAxis.setSteps(100)

        categories.each { category ->
            
            if (category.type == CategoryType.REVENU){
            
            
                // calcul des dates d'intervalles
                def firstDate = dateUtil.getFirstDayOfTheMonth(monthStart)
                def endDate = dateUtil.getLastDayOfTheMonth(monthEnd)
                log.info "Traitement de la catégorie ${category.name} : du ${firstDate} au ${endDate}"
            
                // somme des operations par mois
                def lineChart = new LineChart()
                lineChart.setColour (category.color)
                def sums = categoryService.sumRevenueForEachMonth (monthStart, monthEnd, category)
                lineChart.addValues (sums)
                lineChart.setTooltip ("${category.name}<br>#val# €")

                sums.each {sum ->
                    if (sum > yAxis.getMax()){
                        yAxis.setMax(sum+50)
                    }
                }

                // ajout de la ligne au chart global
                chart.addElements(lineChart)
            }
        }

        def xAxis = new XAxis ()
        def cpt = monthStart
        while (cpt <= monthEnd){
            xAxis.addLabels (new Label("${message(code:'month.'+cpt)}").setRotation(Rotation.DIAGONAL))
            cpt++
        }

        chart.setYAxis(yAxis)
        chart.setXAxis (xAxis)
        render chart
    }
    
    def categoryChart = {

        def person = springSecurityService.getCurrentUser()

        // affichage des catégories par mois
        // zone par défaut - (MAINTENANT-6) > MAINTENANT
        def today = new Date()
        def monthStart = params["month.start"] ? params["month.start"] : 0 //dateUtil.getSixMonthAgo (today)
        def monthEnd = params["month.end"] ? params["month.end"] : dateUtil.getMonth (today)

        def year = params["year"] ? params["year"] : dateUtil.getCurrentYear ()
        
        params["sort"] = "name"
        params["order"] = "asc"

        // récupération des Categories de l'utilisateur
        def categories = genericService.loadUserObjects (person, Category.class, params)

        // création du chart global
        def chart = new Chart("Opérations de dépenses par catégories")
        def yAxis = new YAxis()
        yAxis.setMax (100)
        yAxis.setSteps(100)

        categories.each { category ->
            
            if (category.type == CategoryType.DEPENSE){
            
            
                // calcul des dates d'intervalles
                def firstDate = dateUtil.getFirstDayOfTheMonth(monthStart)
                def endDate = dateUtil.getLastDayOfTheMonth(monthEnd)
                log.info "Traitement de la catégorie ${category.name} : du ${firstDate} au ${endDate}"
            
                // somme des operations par mois
                def lineChart = new LineChart()
                lineChart.setColour (category.color)
                def sums = categoryService.sumDepenseForEachMonth (monthStart, monthEnd, category)
                lineChart.addValues (sums)
                lineChart.setTooltip ("${category.name}<br>#val# €")

                sums.each {sum ->
                    if (sum > yAxis.getMax()){
                        yAxis.setMax(sum+50)
                    }
                }

                // ajout de la ligne au chart global
                chart.addElements(lineChart)
            }
        }

        def xAxis = new XAxis ()
        def cpt = monthStart
        while (cpt <= monthEnd){
            xAxis.addLabels (new Label("${message(code:'month.'+cpt)}").setRotation(Rotation.DIAGONAL))
            cpt++
        }

        chart.setYAxis(yAxis)
        chart.setXAxis (xAxis)
        render chart

    }
}
