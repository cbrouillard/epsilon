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
  <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
  <script language="javascript">
jQuery(document).ready(function() {
  jQuery('#result').html(passwordStrength(jQuery('#password').val(),jQuery('#username').val()));
        jQuery('#username').keyup(function(){jQuery('#result').html(passwordStrength(jQuery('#password').val(),jQuery('#username').val()))})
        jQuery('#password').keyup(function(){jQuery('#result').html(passwordStrength(jQuery('#password').val(),jQuery('#username').val()))})
})
  </script>

  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="index">Liste des utilisateurs</g:link></span>
    <span class="menuButton"><g:link class="create" action="createuser">Nouvel utilisateur</g:link></span>
  </div>

  <div class="body">
    <h1>Editer un utilisateur</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${person}">
      <div class="errors">
        <g:renderErrors bean="${person}" as="list" />
      </div>
    </g:hasErrors>
    <g:form method="post" >
      <g:hiddenField name="id" value="${person?.id}" />
      <g:hiddenField name="version" value="${person?.version}" />
      <div class="dialog">
        <table>
          <tbody>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="username"><g:message code="person.username.label" default="Username" />:</label>
              </td>
              <td valign="top" class="mandatory value ${hasErrors(bean: person, field: 'username', 'errors')}">
          <g:textField name="username" id="username" value="${person?.username}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="userRealName"><g:message code="person.userRealName.label" default="UserRealname" />:</label>
            </td>
            <td valign="top" class="mandatory value ${hasErrors(bean: person, field: 'userRealName', 'errors')}">
          <g:textField name="userRealName" value="${person?.userRealName}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="pass"><g:message code="person.pass.label" default="Pass" />:</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: person, field: 'pass', 'errors')}">
          <g:textField name="pass" value="" id="password"/>
          <div style="color:green" id='result'></div> 
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email"><g:message code="person.email.label" default="Email" />:</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: person, field: 'email', 'errors')}">
          <g:textField name="email" value="${person?.email}" />
          </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <span class="button"><g:actionSubmit class="save" action="updateuser" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
        <span class="button"><g:actionSubmit class="delete" action="deleteuser" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
      </div>
    </g:form>
  </div>
</body>
</html>
