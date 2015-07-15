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
<%@ page import="com.headbangers.epsilon.Scheduled" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="popup"/>
</head>

<body>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
            aria-hidden="true">&times;</span></button>
    <h4 class="modal-title">Détails d'une échéance</h4>
</div>

<div class="modal-body">
    <g:if test="${flash.message}">
        <div class="alert alert-info">${flash.message}</div>
    </g:if>

%{--<div class="alert alert-info">--}%
%{--Solde passé pour cette échéance : <g:formatNumber number="${scheduledInstance?.pastSold}" format="0.##"/> €--}%
%{--</div>--}%

    <dl class="dl-horizontal">
        <dt><g:message code="scheduled.id.label" default="ID"/></dt>
        <dd>${fieldValue(bean: scheduledInstance, field: "id")}</dd>

        <dt><g:message code="scheduled.type.label" default="Type"/></dt>
        <dd>${scheduledInstance?.type?.encodeAsHTML()}</dd>

        <dt><g:message code="scheduled.tiers.label" default="Tiers"/></dt>
        <dd><g:link controller="tiers" action="operations"
                    id="${scheduledInstance?.tiers?.id}">${scheduledInstance?.tiers?.name}</g:link></dd>

        <dt><g:message code="scheduled.category.label" default="Category"/></dt>
        <dd><g:link controller="category" action="operations"
                    id="${scheduledInstance?.category?.id}">${scheduledInstance?.category?.name}</g:link></dd>

        <dt><g:message code="scheduled.dateApplication.label" default="Date Application"/></dt>
        <dd><g:formatDate date="${scheduledInstance?.dateApplication}"/></dd>

        <dt><g:message code="scheduled.amount.label" default="Amount"/></dt>
        <dd><g:formatNumber number="${scheduledInstance?.amount}" format="0.##"/> €</dd>

        <dt><g:message code="scheduled.note.label" default="Note"/></dt>
        <dd>${fieldValue(bean: scheduledInstance, field: "note") ?: " "}</dd>

        <dt><g:message code="scheduled.lastUpdated.label" default="Last Updated"/></dt>
        <dd><g:formatDate date="${scheduledInstance?.lastUpdated}"/></dd>

        <dt><g:message code="scheduled.automatic.label" default="Automatic"/></dt>
        <dd><g:formatBoolean boolean="${scheduledInstance?.automatic}"/></dd>

        <dt><g:message code="scheduled.dateCreated.label" default="Date Created"/></dt>
        <dd><g:formatDate date="${scheduledInstance?.dateCreated}"/></dd>

    </dl>
</div>

<div class="modal-footer">
    <g:form>
        <g:hiddenField name="id" value="${scheduledInstance?.id}"/>
        <g:actionSubmit class="edit btn btn-primary" action="edit"
                        value="${message(code: 'default.button.edit.label', default: 'Edit')}"/>
        <g:actionSubmit class="delete btn btn-danger" action="delete"
                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
    </g:form>
</div>
</body>
</html>
