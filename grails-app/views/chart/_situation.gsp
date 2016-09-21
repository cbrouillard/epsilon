<%@ page import="com.headbangers.epsilon.Scheduled; com.headbangers.epsilon.Operation; com.headbangers.epsilon.OperationType; java.text.SimpleDateFormat" %>
<%
    def columns = [['string', 'Day'], ['number', 'Situation']] //, ['number', 'Seuil']];
    def depenseCourbe = new ArrayList();

    def allOperations = account?.lastOperationsByMonth(byMonth ? byMonth : 0);
    def accountAmount = 0
    if (byMonth != null){
        accountAmount = account?.getSnapshot(byMonth)?.amount ?: account.amount;
    }else {
        accountAmount = account?.lastSnapshot?.amount ?: account.amount;
    }

    def sdf = new SimpleDateFormat("MMMM")
    def cal = Calendar.getInstance()
    if (byMonth != null){
        cal.set(Calendar.MONTH, byMonth)
    }
    def currentMonth = cal.get(Calendar.MONTH)

    def operationsSortedByDaysIncludingFutures = allOperations;
    if (byMonth == null || byMonth == currentMonth){
        operationsSortedByDaysIncludingFutures += futures
    }
    operationsSortedByDaysIncludingFutures = operationsSortedByDaysIncludingFutures.sort {
        it.dateApplication
    }

    def actualDay = 1;
    def prevDay = actualDay;
    Date previousDate = cal.getTime()
    def bufferAmount = accountAmount;

    operationsSortedByDaysIncludingFutures.each { operation ->

        cal.setTime(operation.dateApplication)

        actualDay = cal.get(Calendar.DAY_OF_MONTH)
        if (actualDay != prevDay || (currentMonth != cal.get(Calendar.MONTH) && actualDay == prevDay)) {
            depenseCourbe.add(["$prevDay ${sdf.format(previousDate)}", bufferAmount]) //, 2000])
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

    depenseCourbe.add(["$prevDay ${sdf.format(previousDate)}", bufferAmount])//, 2000])
    if (!operationsSortedByDaysIncludingFutures) {
        if (byMonth != null){
            cal.set(Calendar.MONTH, byMonth +1)
            cal.set(Calendar.DAY_OF_MONTH, 0)
        } else {
            cal.setTime(new Date())
        }
        depenseCourbe.add(["${cal.get(Calendar.DAY_OF_MONTH)} ${sdf.format(cal.getTime())}", bufferAmount])//, 2000])
    }
    //series="${[0:[color:'red', pointSize:10], 1:[color:'black', pointSize:0]]}"
%>
<gvisualization:comboCoreChart elementId="lineChart${idChart}"
                               columns="${columns}" data="${depenseCourbe}"
                               legend="[position: 'bottom']"
                               width="100%" colors="['92e07f', 'red']"
                               seriesType="line" lineWidth="${0.5}"
                               series="${[0: [type: 'area', lineWidth: 2, pointsVisible: false]]}"/>
<div id="lineChart${idChart}"></div>