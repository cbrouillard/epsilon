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
<div class="around-border-within-tab">
    <g:form action="savevirement" method="post">
        <fieldset class="form">
            <div id="formContainer">

                <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'accountTo', 'errors')}">

                    <label for="account.to"
                           class="col-sm-12 control-label mandatory"><g:message code="operation.accountmove" args="[selected.name]"/></label>

                    <div class="col-sm-12">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-piggy-bank"></span></span>
                            <g:select optionValue="${{
                                it.name + ' = ' + formatNumber('number': it.getSold(), 'format': '###,###.##') + '€'
                            }}" name="account.to"
                                      from="${accounts}" optionKey="id" class="form-control" required="true"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: operationInstance, field: 'category', 'errors')}">

                    <label for="categoryvirement" class="col-sm-12 control-label mandatory"><g:message
                            code="operation.category.label"/></label>

                    <div class="col-sm-12">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-tag"></span></span>

                            <g:textField id="categoryvirement" name="category.name"
                                         value="${operationInstance?.category?.name}" required="true"
                                         class="form-control typeahead-categories-virement"
                                         autocomplete="off"/>

                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: operationInstance, field: 'dateApplication', 'errors')}">

                    <label for="dateApplicationvirement" class="col-sm-12 control-label mandatory"><g:message
                            code="operation.dateApplication.label"/></label>

                    <div class="col-sm-12">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                            <input type="text"
                                   value="${formatDate(format: 'dd/MM/yyyy', date: operationInstance?.dateApplication)}"
                                   name="dateApplication"
                                   id="dateApplicationvirement" required="true" class="datePicker form-control"/>

                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: operationInstance, field: 'amount', 'errors')}">

                    <label for="amount" class="col-sm-12 control-label mandatory"><g:message
                            code="operation.amount.label"/></label>

                    <div class="col-sm-12">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-euro"></span></span>
                            <g:textField pattern="^([0-9.,])*" id="amount" name="amount"
                                     value="${formatNumber(number:operationInstance?.amount, format:'0.##')}"
                                     required="true"
                                     class="form-control"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">

                    <label for="note" class="col-sm-12 control-label"><g:message
                            code="operation.note.label"/></label>

                    <div class="col-sm-12">
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
                    <label class="col-sm-3  control-label" for="pointed"><g:message
                            code="operation.pointed.label"/></label>

                    <div class="col-sm-9">
                        <div class="checkbox">
                            <label>
                                <g:checkBox id="pointed" name="pointed"
                                            value="${operationInstance?.pointed}" class="checkbox"
                                            style="margin-top: -13px;"/>
                            </label>
                        </div>

                    </div>
                </div>

            </div>
        </fieldset>

        <div class="form-group">
            <div class="col-sm-12">
                <button type="submit" class="btn btn-success">
                    <span class="glyphicon glyphicon-save"></span> ${message(code: 'default.button.create.label', default: 'Save')}
                </button>
            </div>
        </div>
        <input name="account.id" type="hidden" value="${selected?.id}"/>

        <div class="clearfix">&nbsp;</div>
    </g:form>
</div>
