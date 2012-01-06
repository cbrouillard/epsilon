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
<%@ page import="com.headbangers.epsilon.Account" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}" />
  <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des comptes</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau compte</g:link></span>
  </div>
  <div class="body">

    <g:if test="${!banks}">
      <h1 class="red">Il n'y aucun établissement enregistré !</h1>
      <div class="help">Vous ne pourrez pas créer un compte sans avoir<br/>
        préalablement ajouté un établissement.

      </div>
      <ul>
        <li><g:link controller="bank" action="create"><img src="${resource(dir:'img', file:'bank.png')}" alt=">"/> Créer un nouvel établissement</g:link></li>
      </ul>
    </g:if>
    <g:else>
      <h1>Créer un nouveau compte</h1>

      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${accountInstance}">
        <div class="errors">
          <g:renderErrors bean="${accountInstance}" as="list" />
        </div>
      </g:hasErrors>
      <g:form action="save" method="post" >
        <div class="dialog">
          <table>
            <tbody>

              <tr class="prop">
                <td valign="top" class="name">
                  <label for="bank"><g:message code="account.bank.label" default="Bank" />:</label>
                </td>
                <td valign="top" class="mandatory value ${hasErrors(bean: accountInstance, field: 'bank', 'errors')}">
            <g:select optionValue="name" name="bank.id" from="${banks}" optionKey="id" value="${accountInstance?.bank?.id}"  />
            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="name"><g:message code="account.name.label" default="Name" /></label>
              </td>
              <td valign="top" class="mandatory value ${hasErrors(bean: accountInstance, field: 'name', 'errors')}">
            <g:textField name="name" value="${accountInstance?.name}" />
            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="type"><g:message code="account.type.label" default="Type" /></label>
              </td>
              <td valign="top" class="mandatory value ${hasErrors(bean: accountInstance, field: 'type', 'errors')}">
            <g:select name="type" from="${com.headbangers.epsilon.AccountType?.values()}" value="${accountInstance?.type}"  />
            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="dateOpened"><g:message code="account.dateOpened.label" default="Date Opened" /></label>
              </td>
              <td valign="top" class="mandatory value ${hasErrors(bean: accountInstance, field: 'dateOpened', 'errors')}">
                <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:accountInstance?.dateOpened)}" name="dateOpened" id="dateOpened"/>
              </td>
            </tr>

            <jq:jquery>
              jQuery("#dateOpened").datePicker({clickInput:true, startDate:'01/01/1996'})
              .val(new Date().asString()).trigger('change');
            </jq:jquery>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="amount"><g:message code="account.amount.label" default="Amount" /></label>
              </td>
              <td valign="top" class="mandatory value ${hasErrors(bean: accountInstance, field: 'amount', 'errors')}">
            <g:textField name="amount" value="${fieldValue(bean: accountInstance, field: 'amount')}" />
            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="description"><g:message code="account.description.label" default="Description" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: accountInstance, field: 'description', 'errors')}">
            <g:textArea name="description" cols="40" rows="5" value="${accountInstance?.description}" />
            </td>
            </tr>

            </tbody>
          </table>
        </div>
        <div class="buttons">
          <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
        </div>
      </g:form>
    </g:else>
  </div>
</body>
</html>
