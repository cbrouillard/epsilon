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
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="col-sm-12">
    <h1><g:message code="account.create"/></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${!banks}">
            <div class="alert alert-danger"><g:message code="no.banks.title"/></div>

            <div class="alert alert-warning"><g:message code="no.banks.warn"/> <g:link controller="bank" action="create" class="btn btn-default"><img
                    src="${resource(dir: 'img',
                            file: 'bank.png')}"/> <g:message code="bank.create"/> </g:link>

            </div>
        </g:if>
        <g:else>

            <g:if test="${flash.message}">
                <div class="alert alert-info">${flash.message}</div>
            </g:if>

            <g:hasErrors bean="${accountInstance}">
                <div class="alert alert-danger">
                    <g:renderErrors bean="${accountInstance}" as="list"/>
                </div>
            </g:hasErrors>

            <g:form action="save" method="post" class="form-horizontal">

                <fieldset class="form">
                    <div id="formContainer">

                        <div class="form-group ${hasErrors(bean: accountInstance, field: 'name', 'has-error')}">

                            <label for="name" class="col-sm-2 control-label mandatory"><g:message
                                    code="account.name.label"/></label>

                            <div class="col-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-font"></span></span>
                                    <g:textField name="name" required="true" value="${accountInstance?.name}"
                                                 class="form-control" autofocus=""/>
                                </div>

                                <div class="help-block with-errors"></div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: accountInstance, field: 'bank', 'errors')}">

                            <label for="bank.id" class="col-sm-2 control-label mandatory"><g:message
                                    code="account.bank.label"/></label>

                            <div class="col-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-piggy-bank"></span></span>
                                    <g:select optionValue="name" name="bank.id" from="${banks}" optionKey="id"
                                              value="${accountInstance?.bank?.id}"
                                              required="required" class="form-control"/>
                                </div>

                                <div class="help-block with-errors"></div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: accountInstance, field: 'type', 'errors')}">

                            <label for="type" class="col-sm-2 control-label mandatory"><g:message
                                    code="account.type.label"/></label>

                            <div class="col-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-asterisk"></span></span>
                                    <g:select name="type" from="${com.headbangers.epsilon.AccountType?.values()}"
                                              value="${accountInstance?.type}" required="required"
                                              class="form-control"/>
                                </div>

                                <div class="help-block with-errors"></div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: accountInstance, field: 'dateOpened', 'has-error')}">

                            <label for="dateOpened" class="col-sm-2 control-label mandatory"><g:message
                                    code="account.dateOpened.label"/></label>

                            <div class="col-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                                    <input type="text"
                                           value="${formatDate(format: 'dd/MM/yyyy', date: accountInstance?.dateOpened)}"
                                           name="dateOpened"
                                           id="dateOpened" required="true" class="datePicker form-control"/>
                                </div>

                                <div class="help-block with-errors"></div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: accountInstance, field: 'amount', 'has-error')}">

                            <label for="amount" class="col-sm-2 control-label mandatory"><g:message
                                    code="account.amount.label"/></label>

                            <div class="col-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-euro"></span></span>
                                    <g:textField name="amount" required="true"
                                             value="${formatNumber(number:accountInstance?.amount, format:'0.##')}"
                                             class="form-control" pattern="^([0-9.,])*"/>
                                </div>

                                <div class="help-block with-errors"></div>
                            </div>
                        </div>

                        <div class="form-group ${hasErrors(bean: accountInstance, field: 'description', 'has-error')}">

                            <label for="description" class="col-sm-2 control-label"><g:message
                                    code="bank.description.label"/></label>

                            <div class="col-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-star"></span></span>
                                    <g:textArea name="description" cols="40" rows="5"
                                                value="${accountInstance?.description}"
                                                class="form-control editor"/>
                                </div>

                                <div class="help-block with-errors"></div>
                            </div>
                        </div>

                    </div>
                </fieldset>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">

                        <button type="submit" class="btn btn-success">
                            <span class="glyphicon glyphicon-save"></span> ${message(code: 'default.button.create.label', default: 'Save')}
                        </button>

                    </div>
                </div>

            </g:form>

        </g:else>

    </div>
</div>

</body>
</html>
