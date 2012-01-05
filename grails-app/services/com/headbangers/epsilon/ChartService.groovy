package com.headbangers.epsilon

import jofc2.model.Chart
import jofc2.model.elements.LineChart
import jofc2.model.elements.BarChart.Bar
import jofc2.model.elements.BarChart
import jofc2.model.axis.YAxis
import jofc2.model.axis.Label
import jofc2.model.axis.XAxis
import jofc2.model.axis.Label.Rotation
import org.springframework.context.MessageSource;

class ChartService {

    static transactional = true

    def dateUtil
    MessageSource messageSource

    def randomColor (){
        return "#aaddbb"
    }

    def buildColor (string){
        def color= "#${string.getAt(5)}${string.getAt(18)}${string.getAt(9)}${string.getAt(2)}${string.getAt(31)}${string.getAt(24)}";
        log.info color
        return color
    }

    def createByMonthOperationsChart(name, maximum, barColor, operations) {
        def chart = new Chart(name)
        def yAxis = new YAxis()
        def axis = new XAxis()
        yAxis.setMax (maximum)
        yAxis.setSteps(50)

        def currentMonth
        def prevMonth
        def totalMonthAmount = 0
        if (operations && operations.size() > 0){
            prevMonth = dateUtil.getMonth (operations.get(0).dateApplication)
        }

        def barChart = new BarChart(BarChart.Style.GLASS)
        operations.each {operation ->
            log.info "Adding this operation : ${operation.id} : ${operation.amount} // ${operation.dateApplication}"
            currentMonth = dateUtil.getMonth(operation.dateApplication)

            if (currentMonth != prevMonth){
                // on a changé de mois !
                axis.addLabels (new Label("${messageSource.getMessage('month.'+prevMonth,null,new Locale("fr"))}").setRotation(Rotation.DIAGONAL))

                def operationBar = new BarChart.Bar(totalMonthAmount,barColor)
                operationBar.setTooltip("${messageSource.getMessage('month.'+prevMonth,null,new Locale("fr"))}<br>#val# €");
                barChart.addBars(operationBar)

                if (totalMonthAmount >= yAxis.getMax()){
                    yAxis.setMax (totalMonthAmount+100)
                }

                totalMonthAmount = operation.amount
                prevMonth = currentMonth

            } else {
                // toujours dans le meme mois
                totalMonthAmount += operation.amount
            }
        }

        if (totalMonthAmount!=0){
            axis.addLabels (new Label("${messageSource.getMessage('month.'+prevMonth,null,new Locale("fr"))}").setRotation(Rotation.DIAGONAL))

            if (totalMonthAmount >= yAxis.getMax()){
                yAxis.setMax (totalMonthAmount+100)
            }

            
            def operationBar = new BarChart.Bar(totalMonthAmount,barColor)
            operationBar.setTooltip("${messageSource.getMessage('month.'+prevMonth,null,new Locale("fr"))}<br>#val# €");
            barChart.addBars(operationBar)
        }

        chart.setYAxis(yAxis)
        chart.setXAxis (axis)
        chart.addElements(barChart)

        return chart
    }
}
