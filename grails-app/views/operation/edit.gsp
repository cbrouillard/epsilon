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
<%@ page import="com.headbangers.epsilon.Loan" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'operation.label')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1>Edition d'une opération <small>${operationInstance.id}</small></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:hasErrors bean="${operationInstance}">
            <div class="alert alert-error">
                <g:renderErrors bean="${operationInstance}" as="list"/>
            </div>
        </g:hasErrors>

        <g:form method="post" class="form-horizontal">
            <g:hiddenField name="id" value="${operationInstance?.id}"/>
            <g:hiddenField name="version" value="${operationInstance?.version}"/>

            <fieldset class="form">
                <div id="formContainer">

                    <div class="form-group ${hasErrors(bean: operationInstance, field: 'tiers', 'errors')}">

                        <label for="tiers" class="col-sm-2 control-label mandatory"><g:message
                                code="operation.tiers.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-user"></span></span>

                                <g:textField id="tiers" name="tiers.name"
                                             value="${operationInstance?.tiers?.name}"
                                             class="form-control typeahead-tiers"
                                             required="true"
                                             autocomplete="off"/>
                                <g:if test="${parameterBayesianFilter.equals("true")}">
                                    <jq:jquery>
                                        jQuery('#tiers').focusout (function(){tryToGuessCategoryWithTiersId(jQuery('#tiers').val(), 'category');});
                                    </jq:jquery>
                                </g:if>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: operationInstance, field: 'category', 'errors')}">

                        <label for="category" class="col-sm-2 control-label mandatory"><g:message
                                code="operation.category.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-tag"></span></span>

                                <g:textField id="category" name="category.name"
                                             value="${operationInstance?.category?.name}" required="true"
                                             class="form-control typeahead-categories-"
                                             autocomplete="off"/>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: operationInstance, field: 'dateApplication', 'errors')}">

                        <label for="dateApplication" class="col-sm-2 control-label mandatory"><g:message
                                code="operation.dateApplication.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                                <input type="text"
                                       value="${formatDate(format: 'dd/MM/yyyy', date: operationInstance?.dateApplication)}"
                                       name="dateApplication"
                                       id="dateApplication" required="true" class="datePicker form-control"/>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: operationInstance, field: 'amount', 'errors')}">

                        <label for="amount" class="col-sm-2 control-label mandatory"><g:message
                                code="operation.amount.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-euro"></span></span>
                                <g:textField pattern="^([0-9.,])*" id="amount" name="amount"
                                         value="${fieldValue(bean: operationInstance, field: 'amount')}"
                                         required="true"
                                         class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">

                        <label for="note" class="col-sm-2 control-label"><g:message
                                code="operation.note.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-star"></span></span>
                                <g:textArea name="note" id="note" cols="40" rows="5"
                                            value="${operationInstance?.note}"
                                            class="form-control editor"/>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2  control-label" for="pointed"><g:message
                                code="operation.pointed.label"/></label>

                        <div class="col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <g:checkBox id="pointed" name="pointed"
                                                value="${operationInstance?.pointed}" class="checkbox"/>
                                </label>
                            </div>

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
