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
<%@ page import="com.headbangers.epsilon.Category" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="popup"/>
</head>

<body>
<g:if test="${flash.message}">
    <div class="alert alert-info">${flash.message}</div>
</g:if>

<dl class="dl-horizontal">
    <dt><g:message code="category.id.label" default="Id"/></dt>
    <dd>${fieldValue(bean: categoryInstance, field: "id")}</dd>

    <dt><g:message code="category.name.label" default="Name"/></dt>
    <dd>${fieldValue(bean: categoryInstance, field: "name")}</dd>

    <dt><g:message code="category.type.label" default="Type"/></dt>
    <dd>${categoryInstance?.type?.encodeAsHTML()}</dd>

    <dt><g:message code="category.description.label" default="Description"/></dt>
    <dd>${fieldValue(bean: categoryInstance, field: "description") ?:"&nbsp"}</dd>

    <dt><g:message code="category.dateCreated.label" default="Date Created"/></dt>
    <dd><g:formatDate date="${categoryInstance?.dateCreated}"/></dd>

    <dt><g:message code="category.lastUpdated.label" default="Last Updated"/></dt>
    <dd><g:formatDate date="${categoryInstance?.lastUpdated}"/></dd>

    <dt><g:message code="category.operations.label" default="Operations"/></dt>
    <dd>
        <g:link action="operations" id="${categoryInstance?.id}">
            <img src="${resource(dir: 'img', file: 'operation.png')}" alt="€"/> Voir les opérations de cette catégorie
        </g:link>
    </dd>
</dl>


<div class="modal-footer">
    <g:form>
        <g:hiddenField name="id" value="${categoryInstance?.id}"/>
        <span
                class="button"><g:actionSubmit class="edit btn btn-primary" action="edit"
                                               value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
        <span class="button"><g:actionSubmit class="delete btn btn-danger" action="delete"
                                             value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                             onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
    </g:form>
</div>
</body>
</html>
