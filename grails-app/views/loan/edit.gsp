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
<div class="col-sm-12">
    <h1><g:message code="loan.edit"/> <small>${loanInstance.name}</small></h1>
    <hr/>
</div>

<div class="col-sm-12">
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

            <fieldset class="form">
                <div id="formContainer">
                    <div class="form-group ${hasErrors(bean: loanInstance, field: 'name', 'has-error')}">

                        <label for="name${type}" class="col-sm-2 control-label mandatory"><g:message
                                code="loan.name.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-font"></span></span>
                                <g:textField name="name" id="name${type}" required="true" value="${loanInstance?.name}"
                                             class="form-control" autofocus=""/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: loanInstance, field: 'tiers', 'has-error')}">

                        <label for="tiers${type}" class="col-sm-2 control-label mandatory"><g:message
                                code="loan.tiers.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-user"></span></span>
                                <g:textField id="tiers${type}" name="tiers.name"
                                             action="${createLinkTo('dir': 'tiers/autocomplete')}"
                                             value="${loanInstance?.tiers?.name}" class="form-control typeahead-tiers"
                                             required="true" autocomplete="off"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: loanInstance?.scheduled, field: 'accountFrom', 'has-error')}">

                        <label for="account${type}" class="col-sm-2 control-label mandatory"><g:message
                                code="loan.account.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-user"></span></span>
                                <g:select id="account${type}" optionValue="name" name="loanInstance.accountFrom.id"
                                          from="${accounts}"
                                          optionKey="id"
                                          value="${loanInstance?.scheduled?.accountFrom?.id}"
                                          class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: loanInstance, field: 'refundValue', 'has-error')}">

                        <label for="refundValue${type}" class="col-sm-2 control-label mandatory"><g:message
                                code="loan.refundValue.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-euro"></span></span>

                                <g:textField pattern="^([0-9.,])*" name="refundValue" id="refundValue${type}" required="true"
                                         value="${formatNumber(number:loanInstance?.refundValue, format:'0.##')}"
                                         class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: loanInstance, field: 'currentCalculatedAmountValue', 'has-error')}">

                        <label for="currentCalculatedAmountValue" class="col-sm-2 control-label mandatory"><g:message
                                code="loan.currentCalculatedAmountValue.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-euro"></span></span>

                                <g:textField pattern="^([0-9.,])*" name="currentCalculatedAmountValue" id="currentCalculatedAmountValue" required="true"
                                             value="${formatNumber(number:loanInstance?.currentCalculatedAmountValue, format:'0.##')}"
                                             class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: loanInstance, field: 'dateApplication', 'has-error')}">

                        <label for="dateApplication${type}" class="col-sm-2 control-label mandatory"><g:message
                                code="scheduled.dateApplication.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                                <input type="text"
                                       value="${formatDate(format: 'dd/MM/yyyy', date: loanInstance?.scheduled?.dateApplication)}"
                                       name="dateApplication"
                                       id="dateApplication${type}" required="true" class="datePicker form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: loanInstance, field: 'description', 'has-error')}">

                        <label for="description${type}" class="col-sm-2 control-label"><g:message
                                code="loan.description.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-star"></span></span>
                                <g:textArea name="description" id="description${type}" cols="40" rows="5"
                                            value="${loanInstance?.description}"
                                            class="form-control editor"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                </div>
            </fieldset>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
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
</body>
</html>
