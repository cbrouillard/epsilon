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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
  <title>Liste des prêts</title>
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des prêts</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau prêt</g:link></span>
  </div>
  <div class="body">
    <h1>Liste des prêts</h1>
    
    <div class="help">
      Voici la liste des prêts que vous avez contracté.<br/><br/>
      Chaque prêt est automatiquement associé à une échéance qui est traitée mensuellement et de façon automatique.<br/>
    </div>
    
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
      <table>
        <thead>
          <tr>
        <g:sortableColumn property="name" title="${message(code: 'loan.name.label', default: 'Name')}" />
        <g:sortableColumn property="type" title="${message(code: 'loan.type.label', default: 'Type')}" />

        <th><g:message code="loan.tiers.label" default="Tiers" /></th>

        <g:sortableColumn property="amount" title="${message(code: 'loan.amount.label', default: 'Amount')}" />
        <g:sortableColumn property="interest" title="${message(code: 'loan.interest.label', default: 'Interest')}" />
        <g:sortableColumn property="refundValue" title="${message(code: 'loan.refundValue.label', default: 'Refund')}" />
        <g:sortableColumn property="currentCalculatedAmountValue" title="${message(code: 'loan.currentCalculatedAmountValue.label', default: 'Current')}" />

        <g:sortableColumn property="calculatedEndDate" title="${message(code: 'loan.calculatedEndDate.label', default: 'End date')}"/>
        
        <th>Actions</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${loanInstanceList}" status="i" var="loanInstance">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

            <td>${fieldValue(bean: loanInstance, field: "name")}</td>

            <td><g:message code="loan.type.value.${fieldValue(bean: loanInstance, field: "type")}" /></td>

            <td>${fieldValue(bean: loanInstance, field: "tiers.name")}</td>

            <td>${fieldValue(bean: loanInstance, field: "amount")} €</td>
            <td>${loanInstance.interest?formatNumber(number:loanInstance.interest,format:"0.##") + " €":"Aucun/inconnu"}</td>
            <td>${fieldValue(bean: loanInstance, field: "refundValue")} € / mois</td>
            <td>${fieldValue(bean: loanInstance, field: "currentCalculatedAmountValue")} €</td>
            
            <td><g:formatDate date="${loanInstance.calculatedEndDate}" /></td>

            <td class="center">
          <g:link title="Afficher les détails" class="popup" action="show" id="${loanInstance.id}"><img src="${resource(dir:'img', file:'details.png')}"/></g:link>
          <g:link title="Editer" action="edit" id="${loanInstance.id}"><img src="${resource(dir:'img', file:'edit.png')}"/></g:link>
          <g:link title="Afficher l'échéance associée" class="popup" controller="scheduled" action="show" params="[id:loanInstance.scheduled.id]"><img src="${resource(dir:'img', file:'echeancy.png')}"/></g:link>
          </td>

          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
    <div class="paginateButtons">
      <g:paginate total="${loanInstanceTotal}" />
    </div>
  </div>
</body>
</html>
