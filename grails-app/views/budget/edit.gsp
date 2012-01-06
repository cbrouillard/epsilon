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
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}" />
  <title><g:message code="default.edit.label" args="[entityName]" /></title>

  <resource:autoComplete skin="default" />
  <ui:resources includeJQuery="false"/>
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des budgets</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau budget</g:link></span>
  </div>
  <div class="body">
    <h1>Editer un budget</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${budgetInstance}">
      <div class="errors">
        <g:renderErrors bean="${budgetInstance}" as="list" />
      </div>
    </g:hasErrors>
    <g:form method="post" >
      <g:hiddenField name="id" value="${budgetInstance?.id}" />
      <div class="dialog">
        <table>
          <tbody>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="name"><g:message code="budget.name.label" default="Name" /></label>
              </td>
              <td valign="top" class="mandatory value ${hasErrors(bean: budgetInstance, field: 'name', 'errors')}">
          <g:textField name="name" value="${budgetInstance?.name}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="amount"><g:message code="budget.amount.label" default="Amount" /></label>
            </td>
            <td valign="top" class="mandatory value ${hasErrors(bean: budgetInstance, field: 'amount', 'errors')}">
          <g:textField name="amount" value="${fieldValue(bean: budgetInstance, field: 'amount')}" />
          </td>
          </tr>
          
          <tr class="prop">
            <td valign="top" class="name">
              <label for="categories"><g:message code="budget.attachedCategories.label" default="Categories" /></label>
            </td>
            <td valign="top" class="mandatory value ${hasErrors(bean: budgetInstance, field: 'attachedCategories', 'errors')}">
                             
              <ui:multiSelect 
                     name="selectedCategories"
                     multiple="yes"
                     from="${availableCategories*.name}" 
                     value="${budgetInstance.attachedCategories*.name}"
                     noSelection="['':'Choisissez dans la liste']" 
                     isLeftAligned="true"/>
                   
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="note"><g:message code="budget.note.label" default="Note" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: budgetInstance, field: 'note', 'errors')}">
          <g:textArea name="note" cols="40" rows="5" value="${budgetInstance?.note}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="active"><g:message code="budget.active.label" default="Active" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: budgetInstance, field: 'active', 'errors')}">
          <g:checkBox name="active" value="${budgetInstance?.active}" />
          </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
      </div>
    </g:form>
  </div>
</body>
</html>
