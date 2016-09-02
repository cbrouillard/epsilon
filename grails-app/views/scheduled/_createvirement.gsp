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
    <div class="clearfix">&nbsp;</div>
    <g:form method="post" action="savevirement" class="form-horizontal">
        <fieldset class="form">
            <div id="formContainer">
                <div class="col-sm-6">

                    <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'name', 'has-error')}">

                        <label for="name" class="col-sm-3 control-label mandatory"><g:message
                                code="scheduled.name.label"/></label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-font"></span></span>
                                <g:textField name="name" id="name" required="true"
                                             value="${scheduledInstance?.name}"
                                             class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>


                    <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'category', 'errors')}">

                        <label for="categoryvirement" class="col-sm-3 control-label mandatory"><g:message
                                code="scheduled.category.label"/></label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-tag"></span></span>

                                <g:textField id="categoryvirement" name="category.name"
                                             value="${scheduledInstance?.category?.name}" required="true"
                                             class="form-control typeahead-categories-virement"
                                             autocomplete="off"/>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'amount', 'errors')}">

                        <label for="amount" class="col-sm-3 control-label mandatory"><g:message
                                code="scheduled.amount.label"/></label>

                        <div class="col-sm-9">
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

                        <label for="note" class="col-sm-3 control-label"><g:message
                                code="scheduled.note.label"/></label>

                        <div class="col-sm-9">
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
                </div>

                <div class="col-sm-6">

                    <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'dateApplication', 'errors')}">

                        <label for="dateApplicationvirement" class="col-sm-3 control-label mandatory"><g:message
                                code="scheduled.dateApplication.label"/></label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                                <input type="text"
                                       value="${formatDate(format: 'dd/MM/yyyy', date: scheduledInstance?.dateApplication)}"
                                       name="dateApplication"
                                       id="dateApplicationvirement" required="true" class="datePicker form-control"/>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>


                    <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'dateLastApplication', 'errors')}">

                        <label for="dateLastApplicationvirement" class="col-sm-3 control-label"><g:message
                                code="scheduled.dateLastApplication.label"/></label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                                <input type="text"
                                       value="${formatDate(format: 'dd/MM/yyyy', date: scheduledInstance?.dateLastApplication)}"
                                       name="dateLastApplication"
                                       id="dateLastApplicationvirement" class="datePicker form-control"/>

                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'accountFrom', 'errors')}">

                        <label for="accountFrom.id" class="col-sm-3 control-label mandatory"><g:message
                                code="scheduled.accountFrom.label"/></label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-piggy-bank"></span></span>
                                <g:select optionValue="name" name="accountFrom.id"
                                          from="${accounts}"
                                          optionKey="id"
                                          value="${scheduledInstance?.accountFrom?.id}" required="true"
                                          class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'accountTo', 'errors')}">

                        <label for="accountTo.id" class="col-sm-3 control-label mandatory"><g:message
                                code="scheduled.accountTo.label"/></label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-piggy-bank"></span></span>
                                <g:select optionValue="name" name="accountTo.id"
                                          from="${accounts}"
                                          optionKey="id"
                                          value="${scheduledInstance?.accountTo?.id}" required="true"
                                          class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="automatic" class="col-sm-3 control-label"><g:message
                                code="scheduled.automatic.label"/></label>

                        <div class="col-sm-9">
                            <div class="checkbox">
                                <label>
                                    <g:checkBox id="automatic" name="automatic"
                                                value="${scheduledInstance?.automatic}" class="checkbox"/>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: scheduledInstance, field: 'cronExpression', 'errors')}">

                        <label for="cronExpressionChoice" class="col-sm-3 control-label"><g:message
                                code="scheduled.cron.label"/></label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-cog"></span></span>
                                <g:select id="cronExpressionSelector" name="cronExpressionChoice"
                                          from="${com.headbangers.epsilon.Scheduled.PreBuiltCronExpression.values()}"
                                          value="${scheduledInstance?.cronExpressionAsPrebuilt}"
                                          class="form-control" valueMessagePrefix="prebuiltcronexpression"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                </div>

            </div>
        </fieldset>

        <div class="form-group">
            <div class="col-sm-6">
                <div class="col-sm-offset-3 col-sm-9">
                    <div class="control-group">
                        <button type="submit" class="btn btn-success">
                            <span class="glyphicon glyphicon-save"></span> ${message(code: 'default.button.create.label', default: 'Save')}
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </g:form>
</div>
