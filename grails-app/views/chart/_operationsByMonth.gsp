<!--
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
-->
<%@ page import="com.headbangers.epsilon.CategoryType; com.headbangers.epsilon.Scheduled; com.headbangers.epsilon.Operation; com.headbangers.epsilon.OperationType; java.text.SimpleDateFormat" %>
<%
    def color = [category ? category.color : "#555555", category? category.invertedColor : "#aaaaaa"]
    def columns = [['string', "${message(code:'operations.by.month.col.month')}"], ['number', "${message(code:'operations.by.month.col.amount')}"],
    , ['number', "${message(code:'operations.by.month.col.avg')}"]];
    def data = new ArrayList();

    if (operations) {
        def operations = operations.sort { it.dateApplication }
    }

    Calendar cal = Calendar.getInstance()
    Date previousDate = new Date()
    def sdf = new SimpleDateFormat("${message(code: 'operations.by.month.dateformat')}")

    def actualMonth = 0
    def bufferAmount = 0
    if (operations){
        cal.setTime(operations.get(0).dateApplication)
        actualMonth = cal.get(Calendar.MONTH)
    }
    def prevMonth = actualMonth

    operations.each {operation ->

        cal.setTime(operation.dateApplication)

        actualMonth = cal.get(Calendar.MONTH)
        if (actualMonth != prevMonth){
            // changement de mois
            data.add(["${sdf.format(previousDate)}", bufferAmount])
            prevMonth = actualMonth;

            bufferAmount = 0
        }
        bufferAmount += operation.amount
        previousDate = operation.dateApplication
    }

    data.add(["${sdf.format(previousDate)}", bufferAmount])

	def sum = 0
    data.each { d ->
        sum += d[1];
    }
    def avg = sum / data.size()
    def data2 = new ArrayList()
    data.each { d ->
        data2.add (d + avg);
    }


%>
<gvisualization:comboCoreChart elementId="operationsByMonth"
                              columns="${columns}" data="${data2}"
                              legend="[position: 'top']"
                              width="100%" colors="${color}" height="500" select="goMonth"
                              seriesType="area" series="${[0: [type: 'bars']]}"/>
<div id="operationsByMonth"></div>
<script type="text/javascript">
    function goMonth(e) {
        var item = visualization.getSelection()[0];
        var monthId = visualization_data.getFormattedValue (item.row, 0).replace (/ /g,"_");

        window.location.href = "#month"+monthId
    }
</script>