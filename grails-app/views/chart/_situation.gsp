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
<%@ page import="com.headbangers.epsilon.Scheduled; com.headbangers.epsilon.Operation; com.headbangers.epsilon.OperationType; java.text.SimpleDateFormat" %>
<%
    def thresholds = account?.thresholds?.findAll({it.active})
    def depenseCourbe = new ArrayList();
    def columns = [['string', "${message(code:'situation.col.day')}"], ['number', "${message(code:'situation.col.situationamount')}"]]
    def colors = ['92e07f']

    thresholds.each {th ->
        columns = columns + [['number', th.name]]
        colors = colors + [th.color]
    }

    def allOperations = account?.lastOperationsByMonth(byMonth ? byMonth : 0);
    def accountAmount = 0
    if (byMonth != null) {
        accountAmount = account?.getSnapshot(byMonth)?.amount ?: account.amount;
    } else {
        accountAmount = account?.lastSnapshot?.amount ?: account.amount;
    }

    def sdf = new SimpleDateFormat("MMMM")
    def cal = Calendar.getInstance()
    if (byMonth != null) {
        cal.set(Calendar.MONTH, byMonth)
    }
    def currentMonth = cal.get(Calendar.MONTH)

    def operationsSortedByDaysIncludingFutures = allOperations;
    if (byMonth == null || byMonth == Calendar.getInstance().get(Calendar.MONTH)) {
        operationsSortedByDaysIncludingFutures += futures
    }
    operationsSortedByDaysIncludingFutures = operationsSortedByDaysIncludingFutures.sort {
        it.dateApplication
    }

    def actualDay = 1;
    def prevDay = actualDay;
    def buffer
    Date previousDate = cal.getTime()
    def bufferAmount = accountAmount;

    operationsSortedByDaysIncludingFutures.each { operation ->

        cal.setTime(operation.dateApplication)

        actualDay = cal.get(Calendar.DAY_OF_MONTH)
        if (actualDay != prevDay || (currentMonth != cal.get(Calendar.MONTH) && actualDay == prevDay)) {
            buffer = ["$prevDay ${sdf.format(previousDate)}", bufferAmount]
            thresholds.each { th ->
                buffer = buffer + [th.value]
            }
            depenseCourbe.add(buffer)
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

    buffer = ["$prevDay ${sdf.format(previousDate)}", bufferAmount]
    thresholds.each { th ->
        buffer = buffer + [th.value]
    }
    depenseCourbe.add(buffer)
    if (!operationsSortedByDaysIncludingFutures) {
        if (byMonth != null) {
            cal.set(Calendar.MONTH, byMonth + 1)
            cal.set(Calendar.DAY_OF_MONTH, 0)
        } else {
            cal.setTime(new Date())
        }
        buffer = ["${cal.get(Calendar.DAY_OF_MONTH)} ${sdf.format(cal.getTime())}", bufferAmount]
        thresholds.each { th ->
            buffer = buffer + [th.value]
        }
        depenseCourbe.add(buffer)
    }
%>
<gvisualization:comboCoreChart elementId="lineChart${idChart}"
                               columns="${columns}" data="${depenseCourbe}"
                               legend="[position: 'top']"
                               width="100%" colors="${colors}"
                               seriesType="line"
                               series="${[0: [type: 'area']]}"/>
<div id="lineChart${idChart}"></div>