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
<%@ page import="com.headbangers.epsilon.Budget" %>
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
    <dt><g:message code="budget.name.label" default="Name"/></dt>
    <dd>${fieldValue(bean: budgetInstance, field: "name")}</dd>

    <dt><g:message code="budget.amount.label" default="Amount"/></dt>
    <dd>${fieldValue(bean: budgetInstance, field: "amount")} €</dd>

    <dt><g:message code="budget.note.label" default="Note"/></dt>
    <dd>${fieldValue(bean: budgetInstance, field: "note")}</dd>

    <dt><g:message code="budget.lastUpdated.label" default="Last Updated"/></dt>
    <dd><g:formatDate date="${budgetInstance?.lastUpdated}"/></dd>

    <dt><g:message code="budget.active.label" default="Active"/></dt>
    <dd><g:formatBoolean boolean="${budgetInstance?.active}"/></dd>

    <dt><g:message code="budget.attachedCategories.label" default="Attached Categories"/></dt>
    <dd>
        <ul>
            <g:each in="${budgetInstance.attachedCategories}" var="a">
                <li><g:link controller="category" action="operations" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
            </g:each>
        </ul>
    </dd>

    <dt><g:message code="budget.dateCreated.label" default="Date Created"/></dt>
    <dd><g:formatDate date="${budgetInstance?.dateCreated}"/></dd>

</dl>

<div class="modal-footer">
    <g:form>
        <g:hiddenField name="id" value="${budgetInstance?.id}"/>
        <span class="button"><g:actionSubmit class="edit btn btn-primary" action="edit"
                                             value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
        <span class="button"><g:actionSubmit class="delete btn btn-danger" action="delete"
                                             value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                             onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
    </g:form>
</div>
</body>
</html>
