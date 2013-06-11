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
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Edition d'un prêt <small>${loanInstance.name}</small></h1>
                <hr/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <div class="around-border">

                <g:if test="${flash.message}">
                    <div class="alert alert-info">${flash.message}</div>
                </g:if>

                <g:hasErrors bean="${loanInstance}">
                    <div class="alert alert-error">
                        <g:renderErrors bean="${loanInstance}" as="list"/>
                    </div>
                </g:hasErrors>

                <g:form method="post" class="form-horizontal">
                    <g:hiddenField name="id" value="${loanInstance?.id}"/>
                    <g:hiddenField name="version" value="${loanInstance?.version}"/>

                    <div class="control-group">
                        <label for="name" class="control-label mandatory"><g:message code="loan.name.label" default="Name"/></label>

                        <div class="controls ${hasErrors(bean: loanInstance, field: 'name', 'errors')}">
                            <g:textField id="name" name="name" value="${fieldValue(bean: loanInstance, field: 'name')}" class="input-block-level"
                                         required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="tiers" class="control-label mandatory"><g:message code="loan.tiers.label" default="Tiers"/></label>

                        <div class="controls ${hasErrors(bean: loanInstance, field: 'tiers', 'errors')}">
                            <richui:autoComplete id="tiers" name="tiers.name" action="${createLinkTo('dir': 'tiers/autocomplete')}"
                                                 value="${loanInstance?.tiers?.name}" class="input-block-level" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="account" class="control-label mandatory"><g:message code="scheduled.account.label" default="Account"/></label>

                        <div class="controls ${hasErrors(bean: scheduled, field: 'accountFrom', 'errors')}">
                            <g:select id="account" optionValue="name" name="accountFrom.id" from="${accounts}" optionKey="id"
                                      value="${scheduled?.accountFrom?.id}"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="refund" class="control-label mandatory"><g:message code="loan.refundValue.label" default="Refund"/></label>

                        <div class="controls ${hasErrors(bean: loanInstance, field: 'refundValue', 'errors')}">
                            <g:textField id="refund" name="refundValue" value="${fieldValue(bean: loanInstance, field: 'refundValue')}" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="dateApplication" class="control-label mandatory"><g:message code="scheduled.dateApplication.label"
                                                                                                default="Date Application"/></label>

                        <div class="controls ${hasErrors(bean: scheduled, field: 'dateApplication', 'errors')}">
                            <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: scheduled?.dateApplication)}" name="dateApplication"
                                   id="dateApplication" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="description" class="control-label"><g:message code="loan.description.label" default="Description"/></label>

                        <div class="controls ${hasErrors(bean: loanInstance, field: 'description', 'errors')}">
                            <g:textArea id="description" name="description" cols="40" rows="5" value="${loanInstance?.description}" class="input-block-level"/>
                        </div>
                    </div>


                    <div class="control-group">
                        <div class="controls">
                            <g:actionSubmit class="save btn btn-primary" action="update"
                                            value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                            <g:actionSubmit class="delete btn btn-danger" action="delete"
                                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                        </div>
                    </div>
                </g:form>

            </div>
        </div>
    </div>

</div>
</body>
</html>
