<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'wish.label', default: 'wish')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>

</head>

<body>

<div class="col-sm-12">
    <h1>J'achète ! <small>${wishInstance?.name}</small></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:set var="type" value="facture"/>

        <g:form action="save_operation" method="post" class="form-horizontal">
            <g:hiddenField name="wishId" value="${wishInstance.id}"/>
            <fieldset class="form">
                <div id="formContainer">

                    <div class="form-group ${hasErrors(bean: operationInstance, field: 'tiers', 'errors')}">

                        <label for="tiers${type}" class="col-sm-2 control-label mandatory"><g:message
                                code="operation.tiers.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-user"></span></span>

                                <g:textField id="tiers${type}" name="tiers.name"
                                             value="${operationInstance?.tiers?.name}"
                                             class="form-control typeahead-tiers"
                                             required="true"
                                             autocomplete="off" autofocus="true"/>
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

                        <label for="category${type}" class="col-sm-2 control-label mandatory"><g:message
                                code="operation.category.label"/></label>

                        <div class="col-sm-10">
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

                        <label for="dateApplication${type}" class="col-sm-2 control-label mandatory"><g:message
                                code="operation.dateApplication.label"/></label>

                        <div class="col-sm-10">
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

                        <label for="amount${type}" class="col-sm-2 control-label mandatory"><g:message
                                code="operation.amount.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-euro"></span></span>
                                <g:textField pattern="^([0-9.,])*" id="amount${type}" name="amount"
                                             value="${formatNumber(number:wishInstance?.price, format:'0.##')}"
                                         required="true"
                                         class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">

                        <label for="note${type}" class="col-sm-2 control-label"><g:message
                                code="operation.note.label"/></label>

                        <div class="col-sm-10">
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

</div>
</body>
</html>
