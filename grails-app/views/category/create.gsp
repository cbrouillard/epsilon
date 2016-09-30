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
<%@ page import="com.headbangers.epsilon.Category" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="col-sm-12">
    <h1><g:message code="category.create"/></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">
        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:hasErrors bean="${categoryInstance}">
            <div class="alert alert-danger">
                <g:renderErrors bean="${categoryInstance}" as="list"/>
            </div>
        </g:hasErrors>

        <g:form action="save" method="post" class="form-horizontal">

            <fieldset class="form">
                <div id="formContainer">

                    <div class="form-group ${hasErrors(bean: categoryInstance, field: 'name', 'has-error')}">

                        <label for="name" class="col-sm-2 control-label mandatory"><g:message
                                code="category.name.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-font"></span></span>
                                <g:textField name="name" required="true" value="${categoryInstance?.name}"
                                             class="form-control" autofocus=""/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: categoryInstance, field: 'color', 'has-error')}">

                        <label for="color" class="col-sm-2 control-label mandatory"><g:message code="category.color.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-tint"></span></span>
                                <g:textField name="color" required="true" value="${categoryInstance?.color}"
                                             class="form-control jscolor {hash:true}"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: categoryInstance, field: 'type', 'has-error')}">

                        <label for="type" class="col-sm-2 control-label mandatory"><g:message
                                code="category.type.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-asterisk"></span></span>
                                <g:select name="type" from="${com.headbangers.epsilon.CategoryType?.values()}"
                                          value="${categoryInstance?.type}"
                                          class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: categoryInstance, field: 'description', 'has-error')}">

                        <label for="description" class="col-sm-2 control-label mandatory"><g:message
                                code="category.description.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-star"></span></span>
                                <g:textArea name="description" cols="40" rows="5"
                                            value="${categoryInstance?.description}"
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

    </div>
</div>
</body>
</html>
