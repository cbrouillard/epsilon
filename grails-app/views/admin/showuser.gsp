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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="popup"/>
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<g:if test="${flash.message}">
    <div class="alert alert-info">${flash.message}</div>
</g:if>

<dl class="dl-horizontal">
    <dt><g:message code="person.id.label" default="ID"/></dt>
    <dd>${fieldValue(bean: person, field: "id")}</dd>

    <dt><g:message code="person.email.label" default="Email"/></dt>
    <dd>${fieldValue(bean: person, field: "email")}</dd>

    <dt><g:message code="person.username.label" default="Username"/></dt>
    <dd>${fieldValue(bean: person, field: "username")}</dd>

    <dt><g:message code="person.userRealName.label" default="UserRealName"/></dt>
    <dd>${fieldValue(bean: person, field: "userRealName")}</dd>
</dl>

<div class="modal-footer">
    <g:form>
        <g:hiddenField name="id" value="${person?.id}"/>
        <span class="button"><g:actionSubmit class="edit btn btn-primary" action="edituser"
                                               value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
        <span class="button"><g:actionSubmit class="delete btn btn-danger" action="deleteuser"
                                             value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                             onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
    </g:form>
</div>
</body>
</html>
