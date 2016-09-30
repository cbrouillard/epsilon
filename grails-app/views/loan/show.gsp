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
<%@ page import="com.headbangers.epsilon.Loan" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="popup"/>
</head>

<body>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
            aria-hidden="true">&times;</span></button>
</div>

<div class="modal-body">
    <g:if test="${flash.message}">
        <div class="alert alert-info">${flash.message}</div>
    </g:if>


    <dl class="dl-horizontal">
        <dt><g:message code="loan.type.label" default="Type"/></dt>
        <dd><g:message code="loan.type.value.${fieldValue(bean: loanInstance, field: "type")}"/></dd>

        <dt><g:message code="loan.tiers.label" default="Tiers"/></dt>
        <dd><g:link controller="tiers" action="edit"
                    id="${loanInstance?.tiers?.id}">${loanInstance?.tiers?.encodeAsHTML()}</g:link></dd>

        <dt><g:message code="loan.amount.label" default="Amount"/></dt>
        <dd>${fieldValue(bean: loanInstance, field: "amount")} €</dd>

        <dt><g:message code="loan.refundValue.label" default="Refund"/></dt>
        <dd>${fieldValue(bean: loanInstance, field: "refundValue")} €</dd>

        <dt><g:message code="loan.currentCalculatedAmountValue.label" default="Refund"/></dt>
        <dd>${fieldValue(bean: loanInstance, field: "currentCalculatedAmountValue")} €</dd>

        <dt><g:message code="loan.scheduled.label" default="Scheduled"/></dt>
        <dd><g:link controller="scheduled" action="edit"
                    id="${loanInstance?.scheduled?.id}">${loanInstance?.scheduled?.name}</g:link></dd>

        <dt><g:message code="loan.description.label" default="Description"/></dt>
        <dd>${fieldValue(bean: loanInstance, field: "description")}</dd>

        <dt><g:message code="loan.dateCreated.label" default="Date Created"/></dt>
        <dd><g:formatDate date="${loanInstance?.dateCreated}"/></dd>

        <dt><g:message code="loan.lastUpdated.label" default="Last Updated"/></dt>
        <dd><g:formatDate date="${loanInstance?.lastUpdated}"/></dd>

    </dl>
</div>

<div class="modal-footer">
    <g:form>
        <g:hiddenField name="id" value="${loanInstance?.id}"/>
        <g:actionSubmit class="edit btn btn-primary" action="edit"
                        value="${message(code: 'default.button.edit.label', default: 'Edit')}"/>
        <g:actionSubmit class="delete btn btn-danger" action="delete"
                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
    </g:form>
</div>

</body>
</html>
