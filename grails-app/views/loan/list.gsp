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
<%@ page import="com.headbangers.epsilon.Loan" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}"/>
    <title><g:message code="loan.list"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1><g:message code="loan.list"/> <small><g:message code="loan.list.explanation"/></small> <g:link controller="loan" action="create"
                                                                 class="btn btn-success"><img
                src="${resource(dir: 'img', file: 'loan.png')}"
                alt=">"/> <g:message code="loan.create"/></g:link></h1>

    <div class="alert alert-info">
        <g:message code="loan.list.super.explanation"/>
    </div>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <g:sortableColumn property="name" title="${message(code: 'loan.name.label', default: 'Name')}"/>
                    <g:sortableColumn property="type" title="${message(code: 'loan.type.label', default: 'Type')}"/>

                    <th><g:message code="loan.tiers.label" default="Tiers"/></th>

                    <g:sortableColumn property="amount" title="${message(code: 'loan.amount.label', default: 'Amount')}"
                                      class="text-right"/>
                    <g:sortableColumn property="interest"
                                      title="${message(code: 'loan.interest.label', default: 'Interest')}"
                                      class="text-right"/>
                    <g:sortableColumn property="refundValue"
                                      title="${message(code: 'loan.refundValue.label', default: 'Refund')}"
                                      class="text-right"/>
                    <g:sortableColumn property="currentCalculatedAmountValue"
                                      title="${message(code: 'loan.currentCalculatedAmountValue.label', default: 'Current')}"
                                      class="text-right"/>

                    <g:sortableColumn property="calculatedEndDate"
                                      title="${message(code: 'loan.calculatedEndDate.label', default: 'End date')}"/>

                    <th class="text-right"><g:message code="actions"/></th>

                </tr>
                </thead>
                <tbody>
                <g:each in="${loanInstanceList}" status="i" var="loanInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                        <td>${fieldValue(bean: loanInstance, field: "name")}</td>

                        <td><g:message code="loan.type.value.${fieldValue(bean: loanInstance, field: "type")}"/></td>

                        <td>${fieldValue(bean: loanInstance, field: "tiers.name")}</td>

                        <td class="tdright"><b>${fieldValue(bean: loanInstance, field: "amount")} €</b></td>
                        <td class="tdright">${loanInstance.interest ? formatNumber(number: loanInstance.interest, format: "0.##") + " €" : message(code:'unknown')}</td>
                        <td class="tdright"><b>${fieldValue(bean: loanInstance, field: "refundValue")} € <g:message code="bymonth.light"/></b></td>
                        <td class="tdright">${fieldValue(bean: loanInstance, field: "currentCalculatedAmountValue")} €</td>

                        <td><g:formatDate date="${loanInstance.calculatedEndDate}"/></td>

                        <td class="text-right">
                            %{--<g:link title="Afficher les détails" data-toggle="modal" data-target="#modalWindow_show"
                                    action="show"
                                    id="${loanInstance.id}"><img
                                    src="${resource(dir: 'img', file: 'details.png')}"/></g:link>--}%
                            <g:link title="Editer" action="edit" id="${loanInstance.id}"><img
                                    src="${resource(dir: 'img', file: 'edit.png')}"/></g:link>
                            <g:link title="Afficher l'échéance associée" class="popup" controller="scheduled"
                                    action="show"
                                    data-toggle="modal" data-target="#modalWindow_show"
                                    params="[id: loanInstance.scheduled.id]"><img
                                    src="${resource(dir: 'img', file: 'echeancy.png')}"/></g:link>
                        </td>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="pagination pull-right">
            <g:paginate total="${loanInstanceTotal}"/>
        </div>

        <div class="clearfix">&nbsp;</div>

    </div>
</div>

<div class="modal fade" id="modalWindow_show" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        </div>
    </div>
</div>

</body>
</html>
