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
<%@ page import="com.headbangers.epsilon.Operation" %>
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
    <dt><g:message code="operation.id.label" default="ID"/></dt>
    <dd>${fieldValue(bean: operationInstance, field: "id")}</dd>

    <dt><g:message code="operation.type.label" default="Type"/></dt>
    <dd>${operationInstance?.type?.encodeAsHTML()}</dd>

    <dt><g:message code="operation.tiers.label" default="Tiers"/></dt>
    <dd><g:link controller="tiers" action="edit"
                id="${operationInstance?.tiers?.id}">${operationInstance?.tiers?.name}</g:link></dd>

    <dt><g:message code="operation.category.label" default="Category"/></dt>
    <dd><g:link controller="category" action="edit"
                id="${operationInstance?.category?.id}">${operationInstance?.category?.name}</g:link></dd>

    <dt><g:message code="operation.dateApplication.label" default="Date Application"/></dt>
    <dd><g:formatDate date="${operationInstance?.dateApplication}"/></dd>

    <dt><g:message code="operation.amount.label" default="Amount"/></dt>
    <dd><g:formatNumber number="${operationInstance?.amount}" format="0.##"/> €</dd>

    <dt><g:message code="operation.note.label" default="Note"/></dt>
    <dd>${fieldValue(bean: operationInstance, field: "note")}</dd>

    <dt><g:message code="operation.dateCreated.label" default="Date Created"/></dt>
    <dd><g:formatDate date="${operationInstance?.dateCreated}"/></dd>

    <dt><g:message code="operation.lastUpdated.label" default="Last Updated"/></dt>
    <dd><g:formatDate date="${operationInstance?.lastUpdated}"/></dd>

    <dt><g:message code="operation.pointed.label" default="Pointed"/></dt>
    <dd><g:formatBoolean boolean="${operationInstance?.pointed}"/></dd>

</dl>

<div class="modal-footer">
    <g:form>
        <g:hiddenField name="id" value="${operationInstance?.id}"/>
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
