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
    <title>Liste des prêts</title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Liste des prêts <small>Prêts et emprunts</small> <g:link controller="loan" action="create" class="btn"><img
                        src="${resource(dir: 'img', file: 'loan.png')}"
                        alt=">"/> Créer un nouveau prêt</g:link></h1>

                <div class="alert alert-info">
                    Voici la liste des prêts que vous avez contracté.
                    Chaque prêt est automatiquement associé à une échéance qui est traitée mensuellement et de façon automatique.<br/>
                </div>
                <hr/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <div class="around-border">

                <g:if test="${flash.message}">
                    <div class="alert alert-info">${flash.message}</div>
                </g:if>

                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <g:sortableColumn property="name" title="${message(code: 'loan.name.label', default: 'Name')}"/>
                        <g:sortableColumn property="type" title="${message(code: 'loan.type.label', default: 'Type')}"/>

                        <th><g:message code="loan.tiers.label" default="Tiers"/></th>

                        <g:sortableColumn property="amount" title="${message(code: 'loan.amount.label', default: 'Amount')}"/>
                        <g:sortableColumn property="interest" title="${message(code: 'loan.interest.label', default: 'Interest')}"/>
                        <g:sortableColumn property="refundValue" title="${message(code: 'loan.refundValue.label', default: 'Refund')}"/>
                        <g:sortableColumn property="currentCalculatedAmountValue"
                                          title="${message(code: 'loan.currentCalculatedAmountValue.label', default: 'Current')}"/>

                        <g:sortableColumn property="calculatedEndDate" title="${message(code: 'loan.calculatedEndDate.label', default: 'End date')}"/>

                        <th>Actions</th>

                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${loanInstanceList}" status="i" var="loanInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td>${fieldValue(bean: loanInstance, field: "name")}</td>

                            <td><g:message code="loan.type.value.${fieldValue(bean: loanInstance, field: "type")}"/></td>

                            <td>${fieldValue(bean: loanInstance, field: "tiers.name")}</td>

                            <td class="tdright"><b>${fieldValue(bean: loanInstance, field: "amount")} €</b></td>
                            <td class="tdright">${loanInstance.interest ? formatNumber(number: loanInstance.interest, format: "0.##") + " €" : "Aucun/inconnu"}</td>
                            <td class="tdright"><b>${fieldValue(bean: loanInstance, field: "refundValue")} € / mois</b></td>
                            <td class="tdright">${fieldValue(bean: loanInstance, field: "currentCalculatedAmountValue")} €</td>

                            <td><g:formatDate date="${loanInstance.calculatedEndDate}"/></td>

                            <td class="tdcenter">
                                <g:link title="Afficher les détails" data-toggle="modal" data-target="#modalWindow_show" action="show"
                                        id="${loanInstance.id}"><img
                                        src="${resource(dir: 'img', file: 'details.png')}"/></g:link>
                                <g:link title="Editer" action="edit" id="${loanInstance.id}"><img src="${resource(dir: 'img', file: 'edit.png')}"/></g:link>
                                <g:link title="Afficher l'échéance associée" class="popup" controller="scheduled" action="show" data-toggle="modal" data-target="#modalWindow_show"
                                        params="[id: loanInstance.scheduled.id]"><img src="${resource(dir: 'img', file: 'echeancy.png')}"/></g:link>
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination text-right">
                    <g:paginate total="${loanInstanceTotal}"/>
                </div>

            </div>
        </div>
    </div>

</div>

<div id="modalWindow_show" class="modal hide fade">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>

        <h3>Détails d'un prêt/emprunt</h3>
    </div>

    <div class="modal-body">
        <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
    </div>
</div>

</body>
</html>
