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

<%@ page import="com.headbangers.epsilon.Account; com.headbangers.epsilon.Scheduled" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'scheduled.label', default: 'Scheduled')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>

</head>

<body>
<div class="col-sm-12">
    <h1>Editer une échéance <small>${scheduledInstance.name}</small></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:hasErrors bean="${scheduledInstance}">
            <div class="alert alert-error">
                <g:renderErrors bean="${scheduledInstance}" as="list"/>
            </div>
        </g:hasErrors>

        <g:form method="post" class="form-horizontal">
            <g:hiddenField name="id" value="${scheduledInstance?.id}"/>
            <g:hiddenField name="version" value="${scheduledInstance?.version}"/>

            <fieldset class="form">
                <div id="formContainer">

                    <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'tiers', 'errors')}">

                        <label for="tiers" class="col-sm-2 control-label mandatory"><g:message
                                code="scheduled.tiers.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-user"></span></span>

                                <g:textField id="tiers" name="tiersname" action="${createLinkTo('dir': 'tiers/autocomplete')}"
                                             value="${scheduledInstance?.tiers?.name}" required="true"
                                             class="form-control typeahead-tiers"
                                             autocomplete="off"/>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'category', 'errors')}">

                        <label for="category" class="col-sm-2 control-label mandatory"><g:message
                                code="scheduled.category.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-tag"></span></span>

                                <g:textField id="category" name="categoryname"
                                             action="${createLinkTo('dir': 'category/autocomplete/')}"
                                             value="${scheduledInstance?.category?.name}" required="true"
                                             class="form-control typeahead-categories-${scheduledInstance.type}"
                                             autocomplete="off"/>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                </div>
            </fieldset>

            <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'dateApplication', 'errors')}">

                <label for="dateApplication" class="col-sm-2 control-label mandatory"><g:message
                        code="scheduled.dateApplication.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-calendar"></span></span>
                        <input type="text"
                               value="${formatDate(format: 'dd/MM/yyyy', date: scheduledInstance?.dateApplication)}"
                               name="dateApplication"
                               id="dateApplication" required="true" class="datePicker form-control"/>

                    </div>

                    <div class="help-block with-errors"></div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'dateLastApplication', 'errors')}">

                <label for="dateLastApplication" class="col-sm-2 control-label"><g:message
                        code="scheduled.dateLastApplication.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-calendar"></span></span>
                        <input type="text"
                               value="${formatDate(format: 'dd/MM/yyyy', date: scheduledInstance?.dateLastApplication)}"
                               name="dateLastApplication"
                               id="dateLastApplication" class="datePicker form-control"/>

                    </div>

                    <div class="help-block with-errors"></div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'accountFrom', 'errors')}">

                <label for="accountFrom" class="col-sm-2 control-label mandatory"><g:message
                        code="scheduled.account.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-piggy-bank"></span></span>
                        <g:select id="accountFrom" optionValue="name" name="accountFrom.id"
                                  from="${Account.findAllByOwner(scheduledInstance.owner)}"
                                  optionKey="id"
                                  value="${scheduledInstance?.accountFrom?.id}"
                                  required="true"
                                  class="form-control"/>
                    </div>

                    <div class="help-block with-errors"></div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'amount', 'errors')}">

                <label for="amount" class="col-sm-2 control-label mandatory"><g:message
                        code="scheduled.amount.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-euro"></span></span>
                        <g:textField pattern="^([0-9.,])*" id="amount" name="amount"
                                 value="${fieldValue(bean: scheduledInstance, field: 'amount')}"
                                 required="true"
                                 class="form-control"/>
                    </div>

                    <div class="help-block with-errors"></div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'note', 'errors')}">

                <label for="note" class="col-sm-2 control-label"><g:message
                        code="scheduled.note.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-star"></span></span>
                        <g:textArea name="note" id="note" cols="40" rows="5"
                                    value="${scheduledInstance?.note}"
                                    class="form-control editor"/>

                    </div>

                    <div class="help-block with-errors"></div>
                </div>
            </div>

            <div class="form-group">
                <label for="automatic" class="col-sm-2 control-label"><g:message
                        code="scheduled.automatic.label"/></label>

                <div class="col-sm-10">
                    <div class="checkbox">
                        <label>
                            <g:checkBox id="automatic" name="automatic"
                                        value="${scheduledInstance?.automatic}" class="checkbox"/>
                        </label>
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'cronExpression', 'errors')}" id="cronExpressionSelector">

                <label for="accountFrom" class="col-sm-2 control-label mandatory"><g:message
                        code="scheduled.cron.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group " id="cronExpressionSelector">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-cog"></span></span>
                        <g:select name="cronExpressionChoice" from="${com.headbangers.epsilon.Scheduled.PreBuiltCronExpression.values()}"
                                  value="${scheduledInstance?.cronExpressionAsPrebuilt}"
                                  class="form-control" valueMessagePrefix="prebuiltcronexpression"/>
                    </div>
                    <div class="help-block with-errors"></div>
                    <div class="alert alert-info">Attention : la date de prochaine application n'est pas mise à jour avec un changement de périodicité !</div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <g:actionSubmit class="save btn btn-primary" action="update"
                                    value="${message(code: 'default.button.update.label', default: 'Update')}"/>
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
