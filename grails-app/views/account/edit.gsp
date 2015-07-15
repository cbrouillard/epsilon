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
    <h1>Editer un compte <small>${accountInstance.name}</small></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:hasErrors bean="${accountInstance}">
            <div class="alert alert-error">
                <g:renderErrors bean="${accountInstance}" as="list"/>
            </div>
        </g:hasErrors>

        <g:form action="save" method="post" class="form-horizontal">
            <g:hiddenField name="id" value="${accountInstance?.id}"/>
            <g:hiddenField name="version" value="${accountInstance?.version}"/>

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

                    <div class="form-group ${hasErrors(bean: accountInstance, field: 'type', 'errors')}">

                        <label for="type" class="col-sm-2 control-label mandatory"><g:message
                                code="account.type.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-asterisk"></span></span>
                                <g:select name="type" from="${com.headbangers.epsilon.AccountType?.values()}"
                                          value="${accountInstance?.type}" required="true"
                                          class="form-control"/>
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