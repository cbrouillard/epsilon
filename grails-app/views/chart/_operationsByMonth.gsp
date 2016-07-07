<%@ page import="com.headbangers.epsilon.CategoryType; com.headbangers.epsilon.Scheduled; com.headbangers.epsilon.Operation; com.headbangers.epsilon.OperationType; java.text.SimpleDateFormat" %>
<%
    def color = [category.color]
    def columns = [['string', 'Month'], ['number', 'Montant']];
    def data = new ArrayList();

    if (operations) {
        def operations = operations.sort { it.dateApplication }
    }

    Calendar cal = Calendar.getInstance()
    Date previousDate = new Date()
    def sdf = new SimpleDateFormat("MMMM YYYY")

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
                              legend="[position: 'bottom']"
                              width="100%" colors="${color}" height="500"/>
<div id="operationsByMonth"></div>