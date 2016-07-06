<%@ page import="com.headbangers.epsilon.Scheduled; com.headbangers.epsilon.Operation; com.headbangers.epsilon.OperationType; java.text.SimpleDateFormat" %>
<%
    def columns = [['string', 'Day'], ['number', 'Situation']];
    def depenseCourbe = new ArrayList();

    def allOperations = account?.lastOperationsByMonth(byMonth ? byMonth : 0);
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
    Date previousDate = new Date()
    def bufferAmount = accountAmount;

    operationsSortedByDaysIncludingFutures.each { operation ->

        cal.setTime(operation.dateApplication)

        actualDay = cal.get(Calendar.DAY_OF_MONTH)
        if (actualDay != prevDay || (currentMonth != cal.get(Calendar.MONTH) && actualDay == prevDay)) {
            depenseCourbe.add(["$prevDay ${sdf.format(previousDate)}", bufferAmount])
            prevDay = actualDay;
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

    depenseCourbe.add(["$prevDay ${sdf.format(cal.getTime())}", bufferAmount])
    if (!operationsSortedByDaysIncludingFutures) {
        cal.setTime(new Date())
        depenseCourbe.add(["${cal.get(Calendar.DAY_OF_MONTH)} ${sdf.format(cal.getTime())}", bufferAmount])
    }
    //series="${[0:[color:'red', pointSize:10], 1:[color:'black', pointSize:0]]}"
%>
<gvisualization:areaCoreChart elementId="lineChart${idChart}"
                              columns="${columns}" data="${depenseCourbe}"
                              legend="[position: 'bottom']"
                              width="100%" colors="['92e07f']"/>
<div id="lineChart${idChart}"></div>