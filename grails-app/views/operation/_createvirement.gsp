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
<g:form action="savevirement" method="post">
    <input name="account.id" type="hidden" value="${selected?.id}"/>

    <div class="control-group">
        <label for="account.to" class="control-label mandatory">Virement vers</label>

        <div class="controls ">
            <g:select optionValue="${{it.name + ' = ' + formatNumber('number': it.getSold(), 'format': '0.##') + '€'}}" name="account.to"
                      from="${accounts}" optionKey="id" class="input-block-level" required="true"/>
        </div>
    </div>

    <div class="control-group">
        <label for="categoryvirement" class="control-label mandatory"><g:message code="operation.category.label" default="Category"/></label>

        <div class="controls ${hasErrors(bean: operationInstance, field: 'category', 'errors')}">
            <richui:autoComplete id="categoryvirement" name="category.name" action="${createLinkTo('dir': 'category/autocomplete/' + type)}"
                                 value="${operationInstance?.category?.name}" class="input-block-level" required="true"/>
        </div>
    </div>

    <div class="control-group">
        <label for="dateApplicationvirement" class="control-label mandatory"><g:message code="operation.dateApplication.label"
                                                                                        default="Date Application"/></label>

        <div class="controls ${hasErrors(bean: operationInstance, field: 'dateApplication', 'errors')}">
            <input type="text" value="${formatDate(format: 'dd/MM/yyyy', date: operationInstance?.dateApplication)}" name="dateApplication"
                   id="dateApplicationvirement" class="input-block-level" required="true"/>
        </div>
    </div>

    <div class="control-group">
        <label for="amount" class="control-label mandatory"><g:message code="operation.amount.label" default="Amount"/></label>

        <div class="controls ${hasErrors(bean: operationInstance, field: 'amount', 'errors')}">
            <g:textField name="amount" value="${fieldValue(bean: operationInstance, field: 'amount')}" class="input-block-level" required="true"/>
        </div>
    </div>

    <div class="control-group">
        <label for="note" class="control-label"><g:message code="operation.note.label" default="Note"/></label>

        <div class="controls ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">
            <g:textArea name="note" cols="40" rows="5" value="${operationInstance?.note}" class="input-block-level"/>
        </div>
    </div>

    <div class="control-group">
        <label for="pointed">
            <g:message code="operation.pointed.label" default="Pointed"/>
            <g:checkBox name="pointed" value="${operationInstance?.pointed}"/>
        </label>
    </div>

    <div class="control-group">
        <div class="controls ">
            <g:submitButton name="create" class="save btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </div>
    </div>
</g:form>
