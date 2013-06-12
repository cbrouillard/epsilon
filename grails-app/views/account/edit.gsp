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
                <h1>Editer un compte <small>${accountInstance.name}</small></h1>
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

                <g:hasErrors bean="${accountInstance}">
                    <div class="alert alert-error">
                        <g:renderErrors bean="${accountInstance}" as="list"/>
                    </div>
                </g:hasErrors>

                <g:form action="save" method="post" class="form-horizontal">
                    <g:hiddenField name="id" value="${accountInstance?.id}"/>
                    <g:hiddenField name="version" value="${accountInstance?.version}"/>

                    <div class="control-group">
                        <label for="name" class="control-label mandatory"><g:message code="account.name.label" default="Name"/></label>

                        <div class="controls ${hasErrors(bean: accountInstance, field: 'name', 'errors')}">
                            <g:textField name="name" value="${accountInstance?.name}" class="input-block-level" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="type" class="control-label mandatory"><g:message code="account.type.label" default="Type"/></label>

                        <div class="controls ${hasErrors(bean: accountInstance, field: 'type', 'errors')}">
                            <g:select name="type" from="${com.headbangers.epsilon.AccountType?.values()}" value="${accountInstance?.type}" required="true"
                                      class="input-xlarge"/>
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
                            <span class="button"><g:actionSubmit class="save btn btn-primary" action="update"
                                                                 value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
                            <span class="button"><g:actionSubmit class="delete btn btn-danger" action="delete"
                                                                 value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                                 onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                        </div>
                    </div>

                </g:form>
            </div>
        </div>
    </div>
</div>

</body>
</html>