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

<%@ page import="com.headbangers.epsilon.Budget" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>

    <ui:resources includeJQuery="false"/>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Editer un budget</h1>
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

                <g:hasErrors bean="${budgetInstance}">
                    <div class="alert alert-error">
                        <g:renderErrors bean="${budgetInstance}" as="list"/>
                    </div>
                </g:hasErrors>

                <g:form action="save" class="form-horizontal">
                    <g:hiddenField name="id" value="${budgetInstance?.id}" />

                    <div class="control-group">
                        <label for="name" class="control-label mandatory"><g:message code="budget.name.label" default="Name"/></label>

                        <div class="controls ${hasErrors(bean: budgetInstance, field: 'name', 'errors')}">
                            <g:textField name="name" value="${budgetInstance?.name}" class="input-block-level" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="amount" class="control-label mandatory"><g:message code="budget.amount.label" default="Amount"/></label>

                        <div class="controls ${hasErrors(bean: budgetInstance, field: 'amount', 'errors')}">
                            <g:textField name="amount" value="${fieldValue(bean: budgetInstance, field: 'amount')}" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="selectedCategories-select" class="control-label mandatory"><g:message code="budget.attachedCategories.label"
                                                                                                          default="Categories"/></label>

                        <div class="controls ${hasErrors(bean: budgetInstance, field: 'attachedCategories', 'errors')}">
                            <ui:multiSelect
                                    name="selectedCategories"
                                    multiple="yes"
                                    from="${availableCategories*.name}"
                                    value="${budgetInstance.attachedCategories*.name}"
                                    noSelection="['': 'Choisissez dans la liste']"
                                    isLeftAligned="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="note" class="control-label"><g:message code="budget.note.label" default="Note"/></label>

                        <div class="controls ${hasErrors(bean: budgetInstance, field: 'note', 'errors')}">
                            <g:textArea name="note" cols="40" rows="5" value="${budgetInstance?.note}" class="input-block-level"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="active" class="control-label"><g:message code="budget.active.label" default="Active"/></label>

                        <div class="controls ${hasErrors(bean: budgetInstance, field: 'active', 'errors')}">
                            <g:checkBox name="active" value="${budgetInstance?.active}"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <div class="controls">
                            <span class="button"><g:actionSubmit class="save btn btn-primary" action="update" value="${message(code:
                                    'default.button.update.label', default: 'Update')}" /></span>
                            <span class="button"><g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code:
                                    'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                        </div>
                    </div>
                </g:form>

            </div>
        </div>
    </div>

</div>

<div class="body">

</div>
</body>
</html>