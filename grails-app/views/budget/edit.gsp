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
<div class="col-sm-12">
    <h1><g:message code="budget.edit"/> <small>${budgetInstance.name}</small></h1>
    <hr/>
</div>

<div class="col-sm-12">
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
            <g:hiddenField name="id" value="${budgetInstance?.id}"/>

            <fieldset class="form">
                <div id="formContainer">

                    <div class="form-group ${hasErrors(bean: budgetInstance, field: 'name', 'has-error')}">

                        <label for="name" class="col-sm-2 control-label mandatory"><g:message
                                code="budget.name.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-font"></span></span>
                                <g:textField name="name" required="true" value="${budgetInstance?.name}"
                                             class="form-control" autofocus=""/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: budgetInstance, field: 'amount', 'has-error')}">

                        <label for="amount" class="col-sm-2 control-label mandatory"><g:message
                                code="budget.amount.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-euro"></span></span>
                                <g:textField pattern="^([0-9.,])*" name="amount"
                                         value="${formatNumber(number:budgetInstance?.amount, format:'0.##')}"
                                         required="true" class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: budgetInstance, field: 'startDate', 'errors')} ${hasErrors(bean: budgetInstance, field: 'endDate', 'errors')}">

                        <label for="startDate" class="col-sm-2 control-label mandatory"><g:message
                                code="budget.dates.label"/></label>

                        <div class="col-sm-5">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                                <input type="text"
                                       value="${formatDate(format: 'dd/MM/yyyy', date: budgetInstance?.startDate)}"
                                       name="startDate"
                                       id="startDate" class="datePicker form-control"/>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>

                        <div class="col-sm-5">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                                <input type="text"
                                       value="${formatDate(format: 'dd/MM/yyyy', date: budgetInstance?.endDate)}"
                                       name="endDate"
                                       id="endDate" class="datePicker form-control"/>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>

                        <div class="help-block col-sm-10 col-sm-offset-2">
                            <g:message code="budget.date.helper"/>
                        </div>

                    </div>

                    <div class="form-group ${hasErrors(bean: budgetInstance, field: 'attachedCategories', 'has-error')}">

                        <label for="selectedCategories-select" class="col-sm-2 control-label"><g:message
                                code="budget.attachedCategories.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group" style="background-color: #eee;">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-tags"></span></span>
                                <ui:multiSelect

                                        name="selectedCategories"
                                        multiple="yes"
                                        from="${availableCategories*.name}"
                                        value="${budgetInstance.attachedCategories*.name}"
                                        noSelection="['': 'Choisissez dans la liste']"
                                        isLeftAligned="true" class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: budgetInstance, field: 'note', 'has-error')}">

                        <label for="note" class="col-sm-2 control-label"><g:message
                                code="budget.note.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-star"></span></span>
                                <g:textArea name="note" cols="40" rows="5" value="${budgetInstance?.note}"
                                            class="form-control editor"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="active" class="col-sm-2 control-label"><g:message
                                code="budget.active.label"/></label>

                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <g:checkBox name="active"
                                                value="${budgetInstance?.active}" class="checkbox"/>
                                </label>
                            </div>
                        </div>
                    </div>

                </div>
            </fieldset>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <g:actionSubmit class="save btn btn-primary" action="update"
                                    value="${message(code:
                                            'default.button.update.label', default: 'Update')}"/>
                    <g:actionSubmit class="delete btn btn-danger" action="delete"
                                    value="${message(code:
                                            'default.button.delete.label', default: 'Delete')}"
                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                </div>
            </div>
        </g:form>

    </div>
</div>

</body>
</html>