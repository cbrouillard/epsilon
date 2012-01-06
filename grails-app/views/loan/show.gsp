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
    <meta name="layout" content="popup" />
  <g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des prêts</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau prêt</g:link></span>
  </div>
  <div class="body">
    <h1>Détails d'un prêt</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
      <table>
        <tbody>
          
        <tr class="prop">
          <td valign="top" class="name"><g:message code="loan.type.label" default="Type" /></td>

        <td valign="top" class="value"><g:message code="loan.type.value.${fieldValue(bean: loanInstance, field: "type")}" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="loan.tiers.label" default="Tiers" /></td>

        <td valign="top" class="value"><g:link controller="tiers" action="show" id="${loanInstance?.tiers?.id}">${loanInstance?.tiers?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="loan.amount.label" default="Amount" /></td>

        <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "amount")} €</td>

        </tr>
        
        <tr class="prop">
          <td valign="top" class="name"><g:message code="loan.refundValue.label" default="Refund" /></td>

        <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "refundValue")} €</td>

        </tr>
        
        <tr class="prop">
          <td valign="top" class="name"><g:message code="loan.currentCalculatedAmountValue.label" default="Refund" /></td>

        <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "currentCalculatedAmountValue")} €</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="loan.scheduled.label" default="Scheduled" /></td>

        <td valign="top" class="value"><g:link controller="scheduled" class="popup" action="show" id="${loanInstance?.scheduled?.id}">${loanInstance?.scheduled?.name}</g:link></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="loan.description.label" default="Description" /></td>

        <td valign="top" class="value">${fieldValue(bean: loanInstance, field: "description")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="loan.dateCreated.label" default="Date Created" /></td>

        <td valign="top" class="value"><g:formatDate date="${loanInstance?.dateCreated}" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="loan.lastUpdated.label" default="Last Updated" /></td>

        <td valign="top" class="value"><g:formatDate date="${loanInstance?.lastUpdated}" /></td>

        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:form>
        <g:hiddenField name="id" value="${loanInstance?.id}" />
        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
      </g:form>
    </div>
  </div>
</body>
</html>
