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
<%@ page import="com.headbangers.epsilon.Budget" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="popup" />
  <g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des budgets</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau budget</g:link></span>
  </div>
  <div class="body">
    <h1>Détails d'un budget</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="budget.name.label" default="Name" /></td>

        <td valign="top" class="value">${fieldValue(bean: budgetInstance, field: "name")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="budget.amount.label" default="Amount" /></td>

        <td valign="top" class="value">${fieldValue(bean: budgetInstance, field: "amount")}€</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="budget.note.label" default="Note" /></td>

        <td valign="top" class="value limitedSize">${fieldValue(bean: budgetInstance, field: "note")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="budget.lastUpdated.label" default="Last Updated" /></td>

        <td valign="top" class="value"><g:formatDate date="${budgetInstance?.lastUpdated}" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="budget.active.label" default="Active" /></td>

        <td valign="top" class="value"><g:formatBoolean boolean="${budgetInstance?.active}" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="budget.attachedCategories.label" default="Attached Categories" /></td>

        <td valign="top" style="text-align: left;" class="value">
          <ul>
            <g:each in="${budgetInstance.attachedCategories}" var="a">
              <li><g:link controller="category" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
            </g:each>
          </ul>
        </td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="budget.dateCreated.label" default="Date Created" /></td>

        <td valign="top" class="value"><g:formatDate date="${budgetInstance?.dateCreated}" /></td>

        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:form>
        <g:hiddenField name="id" value="${budgetInstance?.id}" />
        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
      </g:form>
    </div>
  </div>
</body>
</html>
