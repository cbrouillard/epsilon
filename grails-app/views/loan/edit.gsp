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
  <title><g:message code="default.edit.label" args="[entityName]" /></title>

  <resource:autoComplete skin="default" />
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des prêts</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau prêt</g:link></span>
  </div>
  <div class="body">
    <h1>Edition d'un prêt</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${loanInstance}">
      <div class="errors">
        <g:renderErrors bean="${loanInstance}" as="list" />
      </div>
    </g:hasErrors>
    <g:form method="post" >
      <g:hiddenField name="id" value="${loanInstance?.id}" />
      <g:hiddenField name="version" value="${loanInstance?.version}" />
      <div class="dialog">
        <table>
          <tbody>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="name"><g:message code="loan.name.label" default="Name" /></label>
              </td>
              <td valign="top" class="mandatory value ${hasErrors(bean: loanInstance, field: 'name', 'errors')}">
          <g:textField name="name" value="${fieldValue(bean: loanInstance, field: 'name')}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="tiers"><g:message code="loan.tiers.label" default="Tiers" /></label>
            </td>
            <td valign="top" class="mandatory value ${hasErrors(bean: loanInstance, field: 'tiers', 'errors')}">
          <richui:autoComplete id="tiers${type}" name="tiers.name" action="${createLinkTo('dir': 'tiers/autocomplete')}" value="${loanInstance?.tiers?.name}"/>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="accountFrom"><g:message code="scheduled.account.label" default="Account" />:</label>
            </td>
            <td valign="top" class="mandatory value ${hasErrors(bean: scheduled, field: 'accountFrom', 'errors')}">
          <g:select optionValue="name" name="accountFrom.id" from="${accounts}" optionKey="id" value="${scheduled?.accountFrom?.id}"  />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="refundValue"><g:message code="loan.refundValue.label" default="Refund" /></label>
            </td>
            <td valign="top" class="mandatory value ${hasErrors(bean: loanInstance, field: 'refundValue', 'errors')}">
          <g:textField name="refundValue" value="${fieldValue(bean: loanInstance, field: 'refundValue')}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="dateApplication"><g:message code="scheduled.dateApplication.label" default="Date Application" /></label>
            </td>
            <td valign="top" class="mandatory value ${hasErrors(bean: loanInstance.scheduled, field: 'dateApplication', 'errors')}">
              <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:loanInstance?.scheduled.dateApplication)}" name="dateApplication" id="dateApplication"/>
            </td>

          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description"><g:message code="loan.description.label" default="Description" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'description', 'errors')}">
          <g:textArea name="description" cols="40" rows="5" value="${loanInstance?.description}" />
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
  
  <jq:jquery>
    jQuery("#dateApplication").datePicker({clickInput:true, startDate:'01/01/1996'});
  </jq:jquery>
</body>
</html>
