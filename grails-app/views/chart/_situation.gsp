<%@ page import="com.headbangers.epsilon.Scheduled; com.headbangers.epsilon.Operation; com.headbangers.epsilon.OperationType; java.text.SimpleDateFormat" %>
<%
    def columns = [['string', 'Day'], ['number', 'Situation']];
    def depenseCourbe = new ArrayList();

    def allOperations = account?.lastOperationsByMonth(byMonth ? byMonth : 0);
    def accountAmount = account?.lastSnapshot?.amount ?: account.amount;

    def cal = Calendar.getInstance()


    def sdf = new SimpleDateFormat("MMMM")
    def actualDay = cal.get(Calendar.DAY_OF_MONTH);
    def prevDay = actualDay;
    def bufferAmount = accountAmount;

    // TODAY
    depenseCourbe.add(["$actualDay ${sdf.format(cal.getTime())}", bufferAmount])

    def operationsSortedByDaysIncludingFutures = allOperations + futures;
    operationsSortedByDaysIncludingFutures = operationsSortedByDaysIncludingFutures.sort {
        it.dateApplication
    }

    operationsSortedByDaysIncludingFutures.each { operation ->

        if (operation.type.equals(OperationType.DEPOT) || operation.type.equals(OperationType.VIREMENT_PLUS)) {
            bufferAmount += operation.amount
        } else {
            if (operation instanceof Scheduled && operation.accountTo && operation.accountTo.id.equals(account.id)) {
                bufferAmount += operation.amount
            } else {
                bufferAmount -= operation.amount
            }
        }

        cal.setTime(operation.dateApplication)
        actualDay = cal.get(Calendar.DAY_OF_MONTH)
        if (actualDay != prevDay) {
            depenseCourbe.add(["$actualDay ${sdf.format(cal.getTime())}", bufferAmount])
            prevDay = actualDay;
        }

    }

    //series="${[0:[color:'red', pointSize:10], 1:[color:'black', pointSize:0]]}"
%>
<gvisualization:areaCoreChart elementId="lineChart${idChart}"
                              columns="${columns}" data="${depenseCourbe}"
                              legend="[position: 'bottom']"
                              width="100%" colors="['92e07f']" />
<div id="lineChart${idChart}"></div>