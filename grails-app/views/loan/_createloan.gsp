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
<div class="around-border-within-tab">
    <div class="clearfix">&nbsp;</div>
    <g:form action="save" class="form-horizontal">

        <g:hiddenField name="type" value="${type}"/>

        <fieldset class="form">
            <div id="formContainer">
                <div class="form-group ${hasErrors(bean: loanInstance, field: 'name', 'has-error')}">

                    <label for="name${type}" class="col-sm-2 control-label mandatory"><g:message
                            code="loan.name.label"/></label>

                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-font"></span></span>
                            <g:textField name="name" id="name${type}" required="true" value="${loanInstance?.name}"
                                         class="form-control" autofocus=""/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: loanInstance, field: 'tiers', 'has-error')}">

                    <label for="tiers${type}" class="col-sm-2 control-label mandatory"><g:message
                            code="loan.tiers.label"/></label>

                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-user"></span></span>
                            <g:textField id="tiers${type}" name="tiers.name"
                                         action="${createLinkTo('dir': 'tiers/autocomplete')}"
                                         value="${loanInstance?.tiers?.name}" class="form-control typeahead-tiers"
                                         required="true" autocomplete="off"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: scheduled, field: 'accountFrom', 'has-error')}">

                    <label for="account${type}" class="col-sm-2 control-label mandatory"><g:message
                            code="loan.account.label"/></label>

                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-user"></span></span>
                            <g:select id="account${type}" optionValue="name" name="accountFrom.id" from="${accounts}"
                                      optionKey="id"
                                      value="${scheduled?.accountFrom?.id}"
                                      class="form-control"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: loanInstance, field: 'amount', 'has-error')}">

                    <label for="amount${type}" class="col-sm-2 control-label mandatory"><g:message
                            code="loan.amount.label"/></label>

                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-euro"></span></span>
                            <g:textField pattern="^([0-9.,])*" name="amount" id="amount${type}" required="true"
                                     value="${loanInstance?.amount}"
                                     class="form-control"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: loanInstance, field: 'interest', 'has-error')}">

                    <label for="interest${type}" class="col-sm-2 control-label mandatory"><g:message
                            code="loan.interest.label"/></label>

                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-euro"></span></span>
                            <g:textField pattern="^([0-9.,])*" name="interest" id="interest${type}" required="true"
                                     value="${loanInstance?.interest}"
                                     class="form-control"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: loanInstance, field: 'refundValue', 'has-error')}">

                    <label for="refundValue${type}" class="col-sm-2 control-label mandatory"><g:message
                            code="loan.refundValue.label"/></label>

                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-euro"></span></span>
                            <g:textField pattern="^([0-9.,])*" name="refundValue" id="refundValue${type}" required="true"
                                     value="${loanInstance?.refundValue}"
                                     class="form-control"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: loanInstance, field: 'dateApplication', 'has-error')}">

                    <label for="dateApplication${type}" class="col-sm-2 control-label mandatory"><g:message
                            code="scheduled.dateApplication.label"/></label>

                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                            <input type="text"
                                   value="${formatDate(format: 'dd/MM/yyyy', date: scheduled?.dateApplication)}"
                                   name="dateApplication"
                                   id="dateApplication${type}" required="true" class="datePicker form-control"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: loanInstance, field: 'description', 'has-error')}">

                    <label for="description${type}" class="col-sm-2 control-label"><g:message
                            code="loan.description.label"/></label>

                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-star"></span></span>
                            <g:textArea name="description" id="description${type}" cols="40" rows="5"
                                        value="${loanInstance?.description}"
                                        class="form-control editor"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

            </div>
        </fieldset>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">

                <button type="submit" class="btn btn-success">
                    <span class="glyphicon glyphicon-save"></span> ${message(code: 'default.button.create.label', default: 'Save')}
                </button>

            </div>
        </div>
    </g:form>
</div>