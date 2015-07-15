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
    <g:form action="save${type}" method="post">
        <fieldset class="form">
            <div id="formContainer">

                <div class="form-group ${hasErrors(bean: operationInstance, field: 'tiers', 'errors')}">

                    <label for="tiers${type}" class="col-sm-12 control-label mandatory"><g:message
                            code="operation.tiers.label"/></label>

                    <div class="col-sm-12">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-user"></span></span>

                            <g:textField id="tiers${type}" name="tiers.name"
                                         value="${operationInstance?.tiers?.name}"
                                         class="form-control typeahead-tiers"
                                         required="true"
                                         autocomplete="off"/>
                            <g:if test="${parameterBayesianFilter.equals("true")}">
                                <jq:jquery>
                                    jQuery('#tiers${type}').focusout (function(){tryToGuessCategoryWithTiersId(jQuery('#tiers${type}').val(), 'category${type}');});
                                </jq:jquery>
                            </g:if>

                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: operationInstance, field: 'category', 'errors')}">

                    <label for="category${type}" class="col-sm-12 control-label mandatory"><g:message
                            code="operation.category.label"/></label>

                    <div class="col-sm-12">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-tag"></span></span>

                            <g:textField id="category${type}" name="category.name"
                                         value="${operationInstance?.category?.name}" required="true"
                                         class="form-control typeahead-categories-${type}"
                                         autocomplete="off"/>

                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: operationInstance, field: 'dateApplication', 'errors')}">

                    <label for="dateApplication${type}" class="col-sm-12 control-label mandatory"><g:message
                            code="operation.dateApplication.label"/></label>

                    <div class="col-sm-12">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                            <input type="text"
                                   value="${formatDate(format: 'dd/MM/yyyy', date: operationInstance?.dateApplication)}"
                                   name="dateApplication"
                                   id="dateApplication${type}" required="true" class="datePicker form-control"/>

                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: operationInstance, field: 'amount', 'errors')}">

                    <label for="amount${type}" class="col-sm-12 control-label mandatory"><g:message
                            code="operation.amount.label"/></label>

                    <div class="col-sm-12">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-euro"></span></span>
                            <g:textField pattern="^([0-9.,])*" id="amount${type}" name="amount"
                                     value="${fieldValue(bean: operationInstance, field: 'amount')}"
                                     required="true"
                                     class="form-control"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">

                    <label for="note${type}" class="col-sm-12 control-label"><g:message
                            code="operation.note.label"/></label>

                    <div class="col-sm-12">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-star"></span></span>
                            <g:textArea name="note" id="note${type}" cols="40" rows="5"
                                        value="${operationInstance?.note}"
                                        class="form-control editor"/>

                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3  control-label" for="pointed${type}"><g:message
                            code="operation.pointed.label"/></label>

                    <div class="col-sm-9">
                        <div class="checkbox">
                            <label>
                                <g:checkBox id="pointed${type}" name="pointed"
                                            value="${operationInstance?.pointed}" class="checkbox" style="margin-top: -13px;"/>
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