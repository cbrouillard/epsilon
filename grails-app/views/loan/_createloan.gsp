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

<%@ page contentType="text/html;charset=UTF-8" %>
<g:form action="save" class="form-horizontal">

    <g:hiddenField name="type" value="${type}"/>

    <div class="control-group">
        <label for="name${type}" class="control-label mandatory"><g:message code="loan.name.label" default="Name"/></label>

        <div class="controls ${hasErrors(bean: loanInstance, field: 'name', 'errors')}">
            <g:textField id="name${type}" name="name" value="${fieldValue(bean: loanInstance, field: 'name')}" class="input-block-level" required="true"/>
        </div>
    </div>

    <div class="control-group">
        <label for="tiers${type}" class="control-label mandatory"><g:message code="loan.tiers.label" default="Tiers"/></label>

        <div class="controls ${hasErrors(bean: loanInstance, field: 'tiers', 'errors')}">
            <g:textField id="tiers${type}" name="tiers.name" action="${createLinkTo('dir': 'tiers/autocomplete')}"
                         value="${loanInstance?.tiers?.name}" class="input-block-level typeahead-tiers" required="true" autocomplete="off"/>
        </div>
    </div>

    <div class="control-group">
        <label for="account${type}" class="control-label mandatory"><g:message code="scheduled.account.label" default="Account"/></label>

        <div class="controls ${hasErrors(bean: scheduled, field: 'accountFrom', 'errors')}">
            <g:select id="account${type}" optionValue="name" name="accountFrom.id" from="${accounts}" optionKey="id" value="${scheduled?.accountFrom?.id}"
                      class="input-xlarge"/>
        </div>
    </div>

    <div class="control-group">
        <label for="amount${type}" class="control-label mandatory"><g:message code="loan.amount.label" default="Amount"/></label>

        <div class="controls ${hasErrors(bean: loanInstance, field: 'amount', 'errors')}">
            <div class="input-append">
                <g:textField id="amount${type}" name="amount" value="${fieldValue(bean: loanInstance, field: 'amount')}" required="true"
                             class="input-xlarge"/>
                <span class="add-on"><b>€</b></span>
            </div>
        </div>
    </div>

    <div class="control-group">
        <label for="interest${type}" class="control-label mandatory"><g:message code="loan.interest.label" default="Interest"/></label>

        <div class="controls ${hasErrors(bean: loanInstance, field: 'interest', 'errors')}">
            <div class="input-append">
                <g:textField id="interest${type}" name="interest" value="${fieldValue(bean: loanInstance, field: 'interest')}" required="true"
                             class="input-xlarge"/>
                <span class="add-on"><b>€</b></span>
            </div>
        </div>
    </div>

    <div class="control-group">
        <label for="refund${type}" class="control-label mandatory"><g:message code="loan.refundValue.label" default="Refund"/></label>

        <div class="controls ${hasErrors(bean: loanInstance, field: 'refundValue', 'errors')}">
            <div class="input-append">
                <g:textField id="refund${type}" name="refundValue" value="${fieldValue(bean: loanInstance, field: 'refundValue')}" required="true"
                             class="input-xlarge"/>
                <span class="add-on"><b>€</b></span>
            </div>
        </div>
    </div>

    <div class="control-group">
        <label for="dateApplication${type}" class="control-label mandatory"><g:message code="scheduled.dateApplication.label"
                                                                                       default="Date Application"/></label>

        <div class="controls ${hasErrors(bean: scheduled, field: 'dateApplication', 'errors')}">
            <div class="input-append">
                <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: scheduled?.dateApplication)}" name="dateApplication"
                       id="dateApplication${type}" required="true" class="datePicker input-xlarge"/>
                <span class="add-on"><i class="icon-calendar"></i></span>
            </div>
        </div>
    </div>

    <div class="control-group">
        <label for="description${type}" class="control-label"><g:message code="loan.description.label" default="Description"/></label>

        <div class="controls ${hasErrors(bean: loanInstance, field: 'description', 'errors')}">
            <g:textArea id="description${type}" name="description" cols="40" rows="5" value="${loanInstance?.description}" class="input-block-level"/>
        </div>
    </div>

    <div class="control-group">
        <div class="controls">
            <g:submitButton name="create" class="save btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </div>
    </div>
</g:form>