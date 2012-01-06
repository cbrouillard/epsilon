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
<%@ page import="com.headbangers.epsilon.Bank" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'bank.label', default: 'Bank')}" />
  <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
  <div class="undernav"> 
    <span class="menuButton"><g:link class="list" action="list">Liste des établissements</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouvel établissement</g:link></span>
  </div>
  <div class="body">

    <g:if test="${!bankInstanceList}">
      <h1 class="red">Aucun établissement enregistré !</h1>
      <ul>
        <li><g:link controller="bank" action="create"><img src="${resource(dir:'img', file:'bank.png')}" alt=">"/> Créer un nouvel établissement</g:link></li>
      </ul>
    </g:if>
    <g:else>

      <h1>Liste des établissements</h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <div class="list">
        <table>
          <thead>
            <tr>

          <g:sortableColumn property="name" title="${message(code: 'bank.name.label', default: 'Name')}" />

          <g:sortableColumn property="description" title="${message(code: 'bank.description.label', default: 'Description')}" />

          <g:sortableColumn property="dateCreated" title="${message(code: 'bank.dateCreated.label', default: 'Date Created')}" />

          <g:sortableColumn property="lastUpdated" title="${message(code: 'bank.lastUpdated.label', default: 'Last Updated')}" />

          <th>Actions</th>

          </tr>
          </thead>
          <tbody>
          <g:each in="${bankInstanceList}" status="i" var="bankInstance">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

              <td>${fieldValue(bean: bankInstance, field: "name")}</td>

              <td>${fieldValue(bean: bankInstance, field: "description")}</td>

              <td><g:formatDate date="${bankInstance.dateCreated}" /></td>

            <td><g:formatDate date="${bankInstance.lastUpdated}" /></td>

            <td class="center">
            <g:link title="Afficher les détails" class="popup" action="show" id="${bankInstance.id}"><img src="${resource(dir:'img', file:'details.png')}"/></g:link>
            <g:link title="Editer" action="edit" id="${bankInstance.id}"><img src="${resource(dir:'img', file:'edit.png')}"/></g:link>
            </td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <div class="paginateButtons">
        <g:paginate total="${bankInstanceTotal}" />
      </div>
    </g:else>
  </div>
</body>
</html>
