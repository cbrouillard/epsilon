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
    def color = [category.color]
    def columns = [['string', "${message(code:'operations.by.month.col.month')}"], ['number', "${message(code:'operations.by.month.col.amount')}"]];
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

%>
<gvisualization:columnCoreChart elementId="operationsByMonth"
                              columns="${columns}" data="${data}"
                              legend="[position: 'top']"
                              width="100%" colors="${color}" height="500" select="goMonth"/>
<div id="operationsByMonth"></div>
<script type="text/javascript">
    function goMonth(e) {
        var item = visualization.getSelection()[0];
        var monthId = visualization_data.getFormattedValue (item.row, 0).replace (/ /g,"_");

        window.location.href = "#month"+monthId
    }
</script>