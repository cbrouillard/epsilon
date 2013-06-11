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
<g:form method="post" action="save${type}" class="form-horizontal">
    <div class="row-fluid">

        <div class="span6">

            <div class="control-group">
                <label for="name${type}" class="control-label mandatory"><g:message code="scheduled.name.label" default="Name"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'name', 'errors')}">
                    <g:textField id="name${type}" name="name" value="${fieldValue(bean: scheduledInstance, field: 'name')}" required="true"
                                 class="input-block-level"/>
                </div>
            </div>

            <div class="control-group">
                <label for="tiers${type}" class="control-label mandatory"><g:message code="scheduled.tiers.label" default="Tiers"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'tiers', 'errors')}">
                    <g:textField id="tiers${type}" name="tiers.name" action="${createLinkTo('dir': 'tiers/autocomplete')}"
                                         value="${scheduledInstance?.tiers?.name}" class="input-block-level" required="true"/>
                </div>
            </div>

            <div class="control-group">
                <label for="category${type}" class="control-label mandatory"><g:message code="scheduled.category.label" default="Category"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'category', 'errors')}">
                    <g:textField id="category${type}" name="category.name" action="${createLinkTo('dir': 'category/autocomplete/' + type)}"
                                         value="${scheduledInstance?.category?.name}" required="true" class="input-block-level"/>
                </div>
            </div>

            <div class="control-group">
                <label for="note${type}" class="control-label mandatory"><g:message code="scheduled.note.label" default="Note"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'note', 'errors')}">
                    <g:textArea id="note${type}" name="note" cols="40" rows="5" value="${scheduledInstance?.note}" class="input-block-level"/>
                </div>
            </div>

        </div>

        <div class="span6">

            <div class="control-group">
                <label for="dateApplication${type}"
                       class="control-label mandatory"><g:message code="scheduled.dateApplication.label" default="Date Application"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'dateApplication', 'errors')}">
                    <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: scheduledInstance?.dateApplication)}" name="dateApplication"
                           id="dateApplication${type}" required="true" class="datePicker"/>
                </div>
            </div>

            <div class="control-group">
                <label for="dateLastApplication${type}" class="control-label"><g:message code="scheduled.dateLastApplication.label"
                                                                                         default="Date Last Application"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'dateLastApplication', 'errors')}">
                    <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: scheduledInstance?.dateLastApplication)}" name="dateLastApplication"
                           id="dateLastApplication${type}" class="datePicker"/>
                </div>
            </div>

            <div class="control-group">
                <label for="amount${type}" class="control-label mandatory"><g:message code="scheduled.amount.label" default="Amount"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'amount', 'errors')}">
                    <g:textField id="amount${type}" name="amount" value="${fieldValue(bean: scheduledInstance, field: 'amount')}" required="true"/>
                </div>
            </div>

            <div class="control-group">
                <label for="account${type}" class="control-label mandatory"><g:message code="scheduled.account.label" default="Account"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'accountFrom', 'errors')}">
                    <g:select id="account${type}" optionValue="name" name="accountFrom.id" from="${accounts}" optionKey="id"
                              value="${scheduledInstance?.accountFrom?.id}" required="true"/>
                </div>
            </div>

            <div class="control-group">
                <label for="automatic${type}" class="control-label"><g:message code="scheduled.automatic.label" default="Automatic"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'automatic', 'errors')}">
                    <g:checkBox id="automatic${type}" name="automatic" value="${scheduledInstance?.automatic}"/>
                </div>
            </div>

        </div>

    </div>

    <div class="row-fluid">
        <div class="span12">
            <div class="control-group">
                <div class="controls">
                    <g:submitButton name="create" class="save btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                </div>
            </div>
        </div>
    </div>

</g:form>
