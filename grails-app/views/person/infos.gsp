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
<%@ page import="com.headbangers.epsilon.Person" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
  <div class="undernav">
    &nbsp;
  </div>
  <div class="body">
    <h1>Vos informations personnelles</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
      <table>
        <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="person.email.label" default="Email" /></td>

        <td valign="top" class="value">${fieldValue(bean: person, field: "email")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="person.username.label" default="Username" /></td>

        <td valign="top" class="value">${fieldValue(bean: person, field: "username")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="person.userRealName.label" default="UserRealName" /></td>

        <td valign="top" class="value">${fieldValue(bean: person, field: "userRealName")}</td>

        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:form action="edit" method="post">
        <span class="button"><g:actionSubmit action="edit" class="edit" name="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
      </g:form>
    </div>

    <h1>Paramètrage de l'application</h1>
    <g:form action="parameterize" method="post">
      <div class="list">
        <table>
          <thead>
            <tr>
              <th>Nom</th>
              <th>Description</th>
              <th>Valeur</th>
            </tr>
          </thead>
          <tbody>

            <tr>
              <td><g:message code="parameter.bayesian.label" /></td>
              <td><g:message code="parameter.bayesian.description" /></td>
              <td><g:checkBox name="bayesian_filter" value="${new Boolean(parameters.bayesian_filter)}" /></td>
            </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">

        <span class="button"><g:submitButton name="parameterize" class="save" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>

      </div>
    </g:form>
  </div>
</body>
</html>
