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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}"/>
    <title>Compte joint</title>
</head>

<body>

<div class="col-sm-12">
    <h1>Configurer un second propriétaire <small>${account.name}</small></h1>
    <hr/>
</div>

<div class="col-sm-12">
  <div class="around-border">
    <table class="table table-striped table-hover">
      <thead>
      <tr>
          <g:sortableColumn property="username"
                            title="${message(code: 'person.username.label', default: 'Username')}"/>
          <g:sortableColumn property="userRealName"
                            title="${message(code: 'person.userRealName.label', default: 'userRealName')}"/>

          <th class="text-right">&nbsp;</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${users}" status="i" var="person">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

              <td>${fieldValue(bean: person, field: "username")}</td>
              <td>${fieldValue(bean: person, field: "userRealName")}</td>

              <td class="text-right">
                  <g:link action="setjoin" id="${account.id}" params="[p:person.id]" class="btn btn-default">Choisir</g:link>
              </td>
          </tr>
      </g:each>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
