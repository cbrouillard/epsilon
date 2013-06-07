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
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'bank.label', default: 'Bank')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>

<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Editer un établissement</h1>
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
                <g:hasErrors bean="${bankInstance}">
                    <div class="alert alert-error">
                        <g:renderErrors bean="${bankInstance}" as="list"/>
                    </div>
                </g:hasErrors>

                <form class="form-horizontal" method="post">
                    <g:hiddenField name="id" value="${bankInstance?.id}"/>
                    <g:hiddenField name="version" value="${bankInstance?.version}"/>
                    <div class="control-group">
                        <label for="name" class="control-label mandatory"><g:message code="bank.name.label" default="Name"/></label>

                        <div class="controls">
                            <g:textField required="true" name="name" value="${bankInstance?.name}"
                                         class="input-block-level ${hasErrors(bean: bankInstance, field: 'name', 'errors')}"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="description" class="control-label"><g:message code="bank.description.label" default="Description"/></label>

                        <div class="controls">
                            <g:textArea name="description" cols="40" rows="5" value="${bankInstance?.description}" class="input-block-level"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="url" class="control-label"><g:message code="bank.url.label" default="URL"/></label>

                        <div class="controls">
                            <g:textField name="url" value="${bankInstance?.url}" class="input-block-level"/>
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

                </form>

            </div>
        </div>
    </div>

</div>
</body>
</html>