
<%@ page import="com.headbangers.epsilon.Account" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}" />
  <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des comptes</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau compte</g:link></span>
  </div>
  <div class="body">

    <g:if test="${!accountInstanceList}">
      <h1 class="red">Aucun compte enregistré.</h1>
      <ul>
        <li><g:link controller="account" action="create"><img src="${resource(dir:'img', file:'account.png')}" alt=">"/> Créer un nouveau compte</g:link></li>
      </ul>
    </g:if>
    <g:else>
      <h1>Liste des comptes</h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <div class="list">
        <table>
          <thead>
            <tr>

              <th><g:message code="account.bank.label" default="Bank" /></th>

          <g:sortableColumn property="name" title="${message(code: 'account.name.label', default: 'Name')}" />

          <g:sortableColumn property="type" title="${message(code: 'account.type.label', default: 'Type')}" />

          <g:sortableColumn property="dateOpened" title="${message(code: 'account.dateOpened.label', default: 'Date Opened')}" />

          <g:sortableColumn property="amount" title="${message(code: 'account.calculatedAmount.label', default: 'Amount')}" />

          <th>Actions</th>
          <th>Téléphone</th>
          </tr>
          </thead>
          <tbody>
          <g:each in="${accountInstanceList}" status="i" var="accountInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

              <td>${fieldValue(bean: accountInstance, field: "bank.name")}</td>

              <td>${fieldValue(bean: accountInstance, field: "name")}</td>

              <td>${fieldValue(bean: accountInstance, field: "type")}</td>

              <td><g:formatDate date="${accountInstance.dateOpened}" /></td>

            <td class="tdright"><g:formatNumber number="${accountInstance?.sold}" format="0.##" /> €</td>

            <td class="center">
            <g:link title="Afficher les détails" class="popup" action="show" id="${accountInstance.id}"><img src="${resource(dir:'img', file:'details.png')}"/></g:link>
            <g:link title="Editer" action="edit" id="${accountInstance.id}"><img src="${resource(dir:'img', file:'edit.png')}"/></g:link>
            <g:link title="Afficher le registre" controller="operation" action="list" params="[account:accountInstance.id]"><img src="${resource(dir:'img', file:'operation.png')}"/></g:link>
            </td>

            <td class="center">
            <g:link title="Activer ce compte pour l'utilisation sur le téléphone" action="activateAccountForMobile"  id="${accountInstance.id}" >
              <g:if test="${accountInstance.mobileDefault}">
                <img src="${resource(dir:'img', file:'phone_on.png')}" height="16px"/>
              </g:if>
              <g:else>
                <img src="${resource(dir:'img', file:'phone_off.png')}" height="16px"/>
              </g:else>
            </g:link>
            </td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <div class="paginateButtons">
        <g:paginate total="${accountInstanceTotal}" />
      </div>
    </g:else>
  </div>
</body>
</html>
