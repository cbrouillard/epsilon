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
<g:form action="save${type}" method="post">
    <input name="account.id" type="hidden" value="${selected?.id}"/>

    <div class="control-group">
        <label for="tiers${type}" class="control-label mandatory"><g:message code="operation.tiers.label" default="Tiers"/></label>

        <div class="controls ${hasErrors(bean: operationInstance, field: 'tiers', 'errors')}">
            <g:textField id="tiers${type}" name="tiers.name"
                         value="${operationInstance?.tiers?.name}"
                         class="input-block-level typeahead-tiers" required="true" autocomplete="off"/>
            <g:if test="${parameterBayesianFilter.equals("true")}">
                <jq:jquery>
                    jQuery('#tiers${type}').focusout (function(){
                      tryToGuessCategoryWithTiersId(jQuery('#tiers${type}').val(), 'category${type}');
                    });
                </jq:jquery>
            </g:if>
        </div>
    </div>

    <div class="control-group">
        <label for="category${type}" class="control-label mandatory"><g:message code="operation.category.label" default="Category"/></label>

        <div class="controls ${hasErrors(bean: operationInstance, field: 'category', 'errors')}">
            <g:textField id="category${type}" name="category.name"
                         value="${operationInstance?.category?.name}"
                         class="input-block-level typeahead-categories-${type}"
                         required="true" autocomplete="off"/>
        </div>
    </div>

    <div class="control-group">
        <label for="dateApplication${type}" class="control-label mandatory"><g:message code="operation.dateApplication.label"
                                                                                       default="Date Application"/></label>

        <div class="controls ${hasErrors(bean: operationInstance, field: 'dateApplication', 'errors')}">
            <div class="input-append">
                <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: operationInstance?.dateApplication)}" name="dateApplication"
                       id="dateApplication${type}" class="datePicker-inner input-xlarge" required="true"/>
                <span class="add-on"><i class="icon-calendar"></i></span>
            </div>
        </div>
    </div>

    <div class="control-group">
        <label for="amount${type}" class="control-label mandatory"><g:message code="operation.amount.label" default="Amount"/></label>

        <div class="controls ${hasErrors(bean: operationInstance, field: 'amount', 'errors')}">
            <div class="input-append">
                <g:textField id="amount${type}" name="amount" value="${fieldValue(bean: operationInstance, field: 'amount')}" class="input-xlarge"
                             required="true"/>
                <span class="add-on"><b>€</b></span>
            </div>
        </div>
    </div>

    <div class="control-group">
        <label for="note${type}" class="control-label"><g:message code="operation.note.label" default="Note"/></label>

        <div class="controls ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">
            <g:textArea id="note${type}" name="note" cols="40" rows="5" value="${operationInstance?.note}" class="input-block-level"/>
        </div>
    </div>

    <div class="control-group">
        <label for="pointed${type}">
            <g:message code="operation.pointed.label"
                       default="Pointed"/>
            <g:checkBox id="pointed${type}" name="pointed" value="${operationInstance?.pointed}"/>
        </label>
    </div>

    <div class="control-group">
        <div class="controls ">
            <g:submitButton name="create" class="save btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </div>
    </div>
</g:form>
