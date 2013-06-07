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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="popup"/>
</head>

<body>
<div class="body">
    <g:if test="${flash.message}">
        <div class="alert alert-info">${flash.message}</div>
    </g:if>

    <dl class="dl-horizontal">
        <dt><g:message code="bank.id.label" default="ID"/></dt>
        <dd>${fieldValue(bean: bankInstance, field: "id")}</dd>

        <dt><g:message code="bank.name.label" default="Name"/></dt>
        <dd>${fieldValue(bean: bankInstance, field: "name")}</dd>

        <dt><g:message code="bank.description.label" default="Description"/></dt>
        <dd>${fieldValue(bean: bankInstance, field: "description")}</dd>

        <dt><g:message code="bank.dateCreated.label" default="Date Created"/></dt>
        <dd><g:formatDate date="${bankInstance?.dateCreated}"/></dd>

        <dt><g:message code="bank.lastUpdated.label" default="Last Updated"/></dt>
        <dd><g:formatDate date="${bankInstance?.lastUpdated}"/></dd>

        <dt><g:message code="bank.accounts.label" default="Accounts"/></dt>
        <dd>
            <ul>
                <g:each in="${bankInstance?.accounts}" var="a">
                    <li><g:link controller="operation" action="list" params="[account: a.id]">
                        <img src="${resource(dir: 'img', file: 'operation.png')}" alt="€"/> ${a?.name}</g:link></li>
                </g:each>
            </ul>
        </dd>
    </dl>

    <div class="modal-footer">
        <g:form>
            <g:hiddenField name="id" value="${bankInstance?.id}"/>
            <span
                    class="button"><g:actionSubmit class="btn btn-primary edit" action="edit"
                                                   value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
            <span class="button"><g:actionSubmit class="btn btn-danger delete" action="delete"
                                                 value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                 onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </g:form>
    </div>
</div>
</body>
</html>
