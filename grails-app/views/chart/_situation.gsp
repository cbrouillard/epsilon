<%@ page import="com.headbangers.epsilon.Scheduled; com.headbangers.epsilon.Operation; com.headbangers.epsilon.OperationType; java.text.SimpleDateFormat" %>
<%
    def columns = [['string', 'Day'], ['number', 'Situation']];
    def depenseCourbe = new ArrayList();

    def allOperations = account?.lastOperationsByMonth(byMonth ? byMonth : 0);
    def accountAmount = account?.lastSnapshot?.amount ?: account.amount;

    def cal = Calendar.getInstance()
    if (allOperations) {
        cal.setTime(allOperations.get(0).dateApplication)
    }
    def sdf = new SimpleDateFormat("MMMM")
    def actualDay = cal.get(Calendar.DAY_OF_MONTH);
    def prevDay = actualDay;
    def bufferAmount = accountAmount;

    def operationsSortedByDaysIncludingFutures = allOperations + futures;
    operationsSortedByDaysIncludingFutures = operationsSortedByDaysIncludingFutures.sort {
        it.dateApplication
    }

    operationsSortedByDaysIncludingFutures.each { operation ->

        cal.setTime(operation.dateApplication)
        actualDay = cal.get(Calendar.DAY_OF_MONTH)
        if (actualDay != prevDay) {
            depenseCourbe.add(["$prevDay ${sdf.format(cal.getTime())}", bufferAmount])
            prevDay = actualDay;
        }

        if (operation.type.equals(OperationType.DEPOT) || operation.type.equals(OperationType.VIREMENT_PLUS)) {
            bufferAmount += operation.amount
        } else {
            bufferAmount -= operation.amount
        }
    }
    depenseCourbe.add(["$prevDay ${sdf.format(cal.getTime())}", bufferAmount])
%>
<gvisualization:areaCoreChart elementId="lineChart${idChart}"
                              columns="${columns}" data="${depenseCourbe}"
                              legend="[position: 'bottom']"
                              width="100%"/>
<div id="lineChart${idChart}"></div>