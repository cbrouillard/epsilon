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
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Editer une catégorie <small>${categoryInstance.name}</small></h1>
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

                <g:hasErrors bean="${categoryInstance}">
                    <div class="alert alert-error">
                        <g:renderErrors bean="${categoryInstance}" as="list"/>
                    </div>
                </g:hasErrors>

                <g:form method="post" class="form-horizontal">
                    <g:hiddenField name="id" value="${categoryInstance?.id}"/>
                    <g:hiddenField name="version" value="${categoryInstance?.version}"/>

                    <div class="control-group">
                        <label for="name" class="control-label mandatory"><g:message code="category.name.label" default="Name"/></label>

                        <div class="controls ${hasErrors(bean: categoryInstance, field: 'name', 'errors')}">
                            <g:textField name="name" value="${categoryInstance?.name}" class="input-block-level" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="type" class="control-label mandatory"><g:message code="category.type.label" default="Type"/></label>

                        <div class="controls ${hasErrors(bean: categoryInstance, field: 'type', 'errors')}">
                            <g:select name="type" from="${com.headbangers.epsilon.CategoryType?.values()}" value="${categoryInstance?.type}" class="input-xlarge"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="description" class="control-label"><g:message code="category.description.label" default="Description"/></label>

                        <div class="controls ${hasErrors(bean: categoryInstance, field: 'description', 'errors')}">
                            <g:textArea name="description" cols="40" rows="5" value="${categoryInstance?.description}" class="input-block-level"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <div class="controls">
                            <span class="button"><g:actionSubmit class="save btn btn-primary" action="update"
                                                                 value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
                            <span class="button"><g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code:
                                    'default.button.delete.label', default: 'Delete')}"
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
