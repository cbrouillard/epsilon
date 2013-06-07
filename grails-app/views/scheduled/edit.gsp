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

<%@ page import="com.headbangers.epsilon.Scheduled" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'scheduled.label', default: 'Scheduled')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>

</head>

<body>
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Editer une échéance</h1>
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

                <g:hasErrors bean="${scheduledInstance}">
                    <div class="alert alert-error">
                        <g:renderErrors bean="${scheduledInstance}" as="list"/>
                    </div>
                </g:hasErrors>

                <g:form method="post" class="form-horizontal">
                    <g:hiddenField name="id" value="${scheduledInstance?.id}"/>
                    <g:hiddenField name="version" value="${scheduledInstance?.version}"/>

                    <div class="control-group">
                        <label for="tiers" class="control-label mandatory"><g:message code="scheduled.tiers.label" default="Tiers"/></label>

                        <div class="controls ${hasErrors(bean: scheduledInstance, field: 'tiers', 'errors')}">
                            <richui:autoComplete id="tiers" name="tiersname" action="${createLinkTo('dir': 'tiers/autocomplete')}"
                                                 value="${scheduledInstance?.tiers?.name}" required="true" class="input-block-level"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="category" class="control-label mandatory"><g:message code="scheduled.category.label" default="Category"/></label>

                        <div class="controls ${hasErrors(bean: scheduledInstance, field: 'category', 'errors')}">
                            <richui:autoComplete id="category" name="categoryname" action="${createLinkTo('dir': 'category/autocomplete/')}"
                                                 value="${scheduledInstance?.category?.name}" required="true" class="input-block-level"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="dateApplication" class="control-label mandatory"><g:message code="scheduled.dateApplication.label"
                                                                                                default="Date Application"/></label>

                        <div class="controls ${hasErrors(bean: scheduledInstance, field: 'dateApplication', 'errors')}">
                            <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: scheduledInstance?.dateApplication)}" name="dateApplication"
                                   id="dateApplication" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="dateLastApplication" class="control-label"><g:message code="scheduled.dateLastApplication.label"
                                                                                          default="Date Application"/></label>

                        <div class="controls ${hasErrors(bean: scheduledInstance, field: 'dateLastApplication', 'errors')}">
                            <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: scheduledInstance?.dateLastApplication)}"
                                   name="dateLastApplication"
                                   id="dateLastApplication"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="amount" class="control-label mandatory"><g:message code="scheduled.amount.label" default="Amount"/></label>

                        <div class="controls ${hasErrors(bean: scheduledInstance, field: 'amount', 'errors')}">
                            <g:textField name="amount" value="${fieldValue(bean: scheduledInstance, field: 'amount')}" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="note" class="control-label"><g:message code="scheduled.note.label" default="Note"/></label>

                        <div class="controls ${hasErrors(bean: scheduledInstance, field: 'note', 'errors')}">
                            <g:textArea name="note" cols="40" rows="5" value="${scheduledInstance?.note}" class="input-block-level"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="automatic" class="control-label"><g:message code="scheduled.automatic.label" default="Automatic"/></label>

                        <div class="controls ${hasErrors(bean: scheduledInstance, field: 'automatic', 'errors')}">
                            <g:checkBox name="automatic" value="${scheduledInstance?.automatic}"/>
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
