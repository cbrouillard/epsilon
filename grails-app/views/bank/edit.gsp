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

<div class="row-fluid">
    <div class="col-sm-12">
        <h1>Editer un établissement <small>${bankInstance.name}</small></h1>
        <hr/>
    </div>
</div>

<div class="col-sm-12">
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
            <fieldset class="form">
                <div id="formContainer">

                    <div class="form-group ${hasErrors(bean: bankInstance, field: 'name', 'has-error')}">

                        <label for="name" class="col-sm-2 control-label mandatory"><g:message
                                code="bank.name.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-font"></span></span>
                                <g:textField name="name" required="true" value="${bankInstance?.name}"
                                             class="form-control" autofocus=""/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: bankInstance, field: 'description', 'has-error')}">

                        <label for="description" class="col-sm-2 control-label"><g:message
                                code="bank.description.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-star"></span></span>
                                <g:textArea name="description" cols="40" rows="5" value="${bankInstance?.description}"
                                            class="form-control editor"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: bankInstance, field: 'url', 'has-error')}">

                        <label for="url" class="col-sm-2 control-label"><g:message
                                code="bank.url.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-link"></span></span>
                                <g:textField name="url" value="${bankInstance?.url}"
                                             class="form-control" autofocus=""/>
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

        </form>

    </div>
</div>
</body>
</html>