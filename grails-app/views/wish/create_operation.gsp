<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'wish.label', default: 'Wish')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>

</head>

<body>

<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>J'achète !</h1>
                <hr/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <div class="around-border">

                <g:if test="${flash.message}">
                    <div class="alert alert-info">${flash.message}</div>
                </g:if>

                <g:set var="type" value="DEPENSE"/>

                <g:form action="save_operation" method="post" class="form-horizontal">
                    <g:hiddenField name="whish.id" value="${wishInstance.id}"/>
                    <div class="row-fluid">

                        <div class="span6">

                            <div class="control-group">
                                <label for="tiers${type}" class="control-label mandatory"><g:message code="operation.tiers.label" default="Tiers"/></label>

                                <div class="controls ${hasErrors(bean: operationInstance, field: 'tiers', 'errors')}">
                                    <richui:autoComplete id="tiers${type}" name="tiers.name"
                                                         action="${createLinkTo('dir': 'tiers/autocomplete')}"
                                                         value="${operationInstance?.tiers?.name}" class="input-block-level" required="true"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label for="category${type}" class="control-label mandatory"><g:message code="operation.category.label"
                                                                                                        default="Category"/></label>

                                <div class="controls ${hasErrors(bean: operationInstance, field: 'category', 'errors')}">
                                    <richui:autoComplete id="category${type}" name="category.name"
                                                         action="${createLinkTo('dir': 'category/autocomplete/' + type)}"
                                                         value="${operationInstance?.category?.name}"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label for="note" class="control-label"><g:message code="operation.note.label" default="Note"/></label>

                                <div class="controls ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">
                                    <g:textArea name="note" cols="40" rows="5" value="${wishInstance?.description}" class="input-block-level"/>
                                </div>
                            </div>

                        </div>

                        <div class="span6">

                            <div class="control-group">
                                <label for="dateApplication${type}" class="control-label mandatory"><g:message code="operation.dateApplication.label"
                                                                                                               default="Date Application"/></label>

                                <div class="controls ${hasErrors(bean: operationInstance, field: 'dateApplication', 'errors')}">
                                    <input type="text"
                                           value="${formatDate(format: 'dd/MM/yyyy', date: operationInstance?.dateApplication)}"
                                           name="dateApplication" id="dateApplication${type}"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label for="amount" class="control-label mandatory"><g:message code="operation.amount.label" default="Amount"/></label>

                                <div class="controls ${hasErrors(bean: operationInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: wishInstance, field: 'price')}"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label for="pointed" class="control-label"><g:message code="operation.pointed.label" default="Pointed"/></label>

                                <div class="controls ${hasErrors(bean: operationInstance, field: 'pointed', 'errors')}">
                                    <g:checkBox name="pointed" value="${operationInstance?.pointed}"/>
                                </div>
                            </div>

                        </div>

                    </div>

                    <div class="row-fluid">
                        <div class="span12">
                            <div class="control-group">
                                <div class="controls">
                                    <g:submitButton name="create" class="save btn btn-primary"
                                                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:form>

            </div>
        </div>
    </div>

</div>
</body>
</html>
