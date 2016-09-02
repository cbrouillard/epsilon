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
    <meta name="layout" content="popup"/>
</head>

<body>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
            aria-hidden="true">&times;</span></button>
    <h4 class="modal-title">Détails d'un compte</h4>
</div>

<g:if test="${flash.message}">
    <div class="alert alert-info">${flash.message}</div>
</g:if>

<div class="modal-body">
    <dl class="dl-horizontal">
        <dt><g:message code="account.id.label" default="ID"/></dt>
        <dd>${fieldValue(bean: accountInstance, field: "id")}</dd>

        <dt><g:message code="account.bank.label" default="Bank"/></dt>
        <dd><g:link controller="bank" action="edit"
                    id="${accountInstance?.bank?.id}">${accountInstance?.bank?.name}</g:link></dd>

        <dt><g:message code="account.name.label" default="Name"/></dt>
        <dd>${fieldValue(bean: accountInstance, field: "name")}</dd>

        <dt><g:message code="account.type.label" default="Type"/></dt>
        <dd>${accountInstance?.type?.encodeAsHTML()}</dd>

        <dt><g:message code="account.dateOpened.label" default="Date Opened"/></dt>
        <dd><g:formatDate date="${accountInstance?.dateOpened}"/></dd>

        <dt><g:message code="account.calculatedAmount.label" default="Amount"/></dt>
        <dd><g:formatNumber number="${accountInstance?.sold}" format="###,###.##"/></dd>

        <dt><g:message code="account.description.label" default="Description"/></dt>
        <dd>${fieldValue(bean: accountInstance, field: "description")}</dd>

        <dt><g:message code="account.dateCreated.label" default="Date Created"/></dt>
        <dd><g:formatDate date="${accountInstance?.dateCreated}"/></dd>

        <dt><g:message code="account.lastUpdated.label" default="Last Updated"/></dt>
        <dd><g:formatDate date="${accountInstance?.lastUpdated}"/></dd>
    </dl>
</div>

<div class="modal-footer">
    <g:form>
        <g:hiddenField name="id" value="${accountInstance?.id}"/>
        <g:link controller="operation" action="list" params="[account: accountInstance?.id]" class="btn btn-default">
            <img src="${resource(dir: 'img', file: 'operation.png')}" alt="€"/> Voir le registre
        </g:link>
        <g:actionSubmit class="edit btn btn-primary" action="edit"
                        value="${message(code: 'default.button.edit.label', default: 'Edit')}"/>
        <g:actionSubmit class="delete btn btn-danger" action="delete"
                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
    </g:form>
</div>

</body>
</html>
