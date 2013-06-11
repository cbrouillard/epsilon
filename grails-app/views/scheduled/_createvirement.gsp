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
<g:form method="post" action="savevirement" class="form-horizontal">
    <div class="row-fluid">

        <div class="span6">

            <div class="control-group">
                <label for="name" class="control-label mandatory"><g:message code="scheduled.name.label" default="Name"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'name', 'errors')}">
                    <g:textField name="name" value="${fieldValue(bean: scheduledInstance, field: 'name')}" required="true" class="input-block-level"/>
                </div>
            </div>


            <div class="control-group">
                <label for="categoryvirement" class="control-label mandatory"><g:message code="scheduled.category.label" default="Category"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'category', 'errors')}">
                    <g:textField id="categoryvirement" name="category.name" action="${createLinkTo('dir': 'category/autocomplete/' + type)}"
                                         value="${scheduledInstance?.category?.name}" required="true" class="input-block-level"/>
                </div>
            </div>

            <div class="control-group">
                <label for="amount" class="control-label mandatory"><g:message code="scheduled.amount.label" default="Amount"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'amount', 'errors')}">
                    <g:textField name="amount" value="${fieldValue(bean: scheduledInstance, field: 'amount')}" required="true"/>
                </div>
            </div>

            <div class="control-group">
                <label for="note" class="control-label mandatory"><g:message code="scheduled.note.label" default="Note"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'note', 'errors')}">
                    <g:textArea name="note" cols="40" rows="5" value="${scheduledInstance?.note}" class="input-block-level"/>
                </div>
            </div>

        </div>

        <div class="span6">

            <div class="control-group">
                <label for="dateApplicationvirement" class="control-label mandatory"><g:message code="scheduled.dateApplication.label"
                                                                                                default="Date Application"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'dateApplication', 'errors')}">
                    <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: scheduledInstance?.dateApplication)}" name="dateApplication"
                           id="dateApplicationvirement" required="true" class="datePicker"/>
                </div>
            </div>


            <div class="control-group">
                <label for="dateLastApplicationvirement" class="control-label"><g:message code="scheduled.dateLastApplication.label"
                                                                                          default="Date Last Application"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'dateLasApplication', 'errors')}">
                    <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: scheduledInstance?.dateLastApplication)}" name="dateLastApplication"
                           id="dateLastApplicationvirement" class="datePicker"/>
                </div>
            </div>

            <div class="control-group">
                <label for="accountFrom.id" class="control-label mandatory"><g:message code="scheduled.accountFrom.label" default="Account"/></label>

                <div class="controls  ${hasErrors(bean: scheduledInstance, field: 'accountFrom', 'errors')}">
                    <g:select optionValue="name" name="accountFrom.id" from="${accounts}" optionKey="id" value="${scheduledInstance?.accountFrom?.id}"
                              required="true"/>
                </div>
            </div>

            <div class="control-group">
                <label for="accountTo.id" class="control-label mandatory"><g:message code="scheduled.accountTo.label" default="Account"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'accountTo', 'errors')}">
                    <g:select optionValue="name" name="accountTo.id" from="${accounts}" optionKey="id" value="${scheduledInstance?.accountTo?.id}"
                              required="true"/>
                </div>
            </div>

            <div class="control-group">
                <label for="automatic" class="control-label"><g:message code="scheduled.automatic.label" default="Automatic"/></label>

                <div class="controls ${hasErrors(bean: scheduledInstance, field: 'automatic', 'errors')}">
                    <g:checkBox name="automatic" value="${scheduledInstance?.automatic}"/>
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
