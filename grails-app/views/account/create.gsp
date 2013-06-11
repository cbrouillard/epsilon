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

<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Créer un nouveau compte</h1>
                <hr/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <div class="around-border">

                <g:if test="${!banks}">
                    <div class="alert alert-error">Il n'y aucun établissement enregistré !</div>

                    <div class="alert alert-warning">Vous ne pourrez pas créer un compte sans avoir
                    préalablement ajouté un établissement. <g:link controller="bank" action="create" class="btn"><img src="${resource(dir: 'img',
                            file: 'bank.png')}"/> Créer un nouvel établissement</g:link>

                    </div>
                </g:if>
                <g:else>

                    <g:if test="${flash.message}">
                        <div class="alert alert-info">${flash.message}</div>
                    </g:if>

                    <g:hasErrors bean="${accountInstance}">
                        <div class="alert alert-error">
                            <g:renderErrors bean="${accountInstance}" as="list"/>
                        </div>
                    </g:hasErrors>

                    <g:form action="save" method="post" class="form-horizontal">

                        <div class="control-group">
                            <label for="name" class="control-label mandatory"><g:message code="account.name.label" default="Name"/></label>

                            <div class="controls ${hasErrors(bean: accountInstance, field: 'name', 'errors')}">
                                <g:textField name="name" value="${accountInstance?.name}" class="input-block-level" required="true"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label for="bank.id" class="control-label mandatory"><g:message code="account.bank.label" default="Bank"/></label>

                            <div class="controls ${hasErrors(bean: accountInstance, field: 'bank', 'errors')}">
                                <g:select optionValue="name" name="bank.id" from="${banks}" optionKey="id" value="${accountInstance?.bank?.id}"
                                          required="true"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label for="type" class="control-label mandatory"><g:message code="account.type.label" default="Type"/></label>

                            <div class="controls ${hasErrors(bean: accountInstance, field: 'type', 'errors')}">
                                <g:select name="type" from="${com.headbangers.epsilon.AccountType?.values()}" value="${accountInstance?.type}" required="true"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label for="dateOpened" class="control-label mandatory"><g:message code="account.dateOpened.label" default="Date Opened"/></label>

                            <div class="controls ${hasErrors(bean: accountInstance, field: 'dateOpened', 'errors')}">
                                <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: accountInstance?.dateOpened)}" name="dateOpened"
                                       id="dateOpened" required="true" class="datePicker"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label for="amount" class="control-label mandatory"><g:message code="account.amount.label" default="Amount"/></label>

                            <div class="controls ${hasErrors(bean: accountInstance, field: 'amount', 'errors')}">
                                <g:textField name="amount" value="${fieldValue(bean: accountInstance, field: 'amount')}" required="true"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label for="description" class="control-label"><g:message code="account.description.label" default="Description"/></label>

                            <div class="controls ${hasErrors(bean: accountInstance, field: 'description', 'errors')}">
                                <g:textArea name="description" cols="40" rows="5" value="${accountInstance?.description}" class="input-block-level"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <div class="controls">
                                <g:submitButton name="create" class="save btn btn-primary"
                                                value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                            </div>
                        </div>

                    </g:form>

                </g:else>

            </div>
        </div>
    </div>
</div>

</body>
</html>
