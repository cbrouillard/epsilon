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
<%@ page import="com.headbangers.epsilon.Person" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}"/>
    <title><g:message code="person.edit.cool"/></title>
</head>

<body>
<script language="javascript">
    jQuery(document).ready(function () {
        jQuery('#result').html(passwordStrength(jQuery('#password').val(), jQuery('#username').val()));
        jQuery('#username').keyup(function () {
            jQuery('#result').html(passwordStrength(jQuery('#password').val(), jQuery('#username').val()))
        })
        jQuery('#password').keyup(function () {
            jQuery('#result').html(passwordStrength(jQuery('#password').val(), jQuery('#username').val()))
        })
    })
</script>

<div class="col-sm-12">
    <h1><g:message code="person.label"/> <small>${person.userRealName}</small></h1>

    <div class="alert alert-info">
        <g:message code="person.edit.explanation"/>
    </div>

    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">
        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${person}">
            <div class="alert alert-error">
                <g:renderErrors bean="${person}" as="list"/>
            </div>
        </g:hasErrors>

        <g:form method="post" action="update" class="form-horizontal">
            <g:hiddenField name="id" value="${person?.id}"/>
            <g:hiddenField name="version" value="${person?.version}"/>

            <fieldset class="form">
                <div id="formContainer">

                    <div class="form-group ${hasErrors(bean: person, field: 'username', 'has-error')}">

                        <label for="username" class="col-sm-2 control-label mandatory"><g:message
                                code="person.username.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-font"></span></span>
                                <g:textField name="username" required="true" value="${person?.username}"
                                             class="form-control" autofocus=""/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: person, field: 'userRealName', 'has-error')}">

                        <label for="userRealName" class="col-sm-2 control-label mandatory"><g:message
                                code="person.userRealName.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-text-background"></span></span>
                                <g:textField name="userRealName" required="true" value="${person?.userRealName}"
                                             class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: person, field: 'pass', 'has-error')}">

                        <label for="password" class="col-sm-2 control-label"><g:message
                                code="person.pass.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-lock"></span></span>
                                <g:textField name="pass" value="" id="password" class="form-control"/>
                            </div>

                            <div class="help-block with-errors">
                                <div style="color:green;" id='result'></div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: person, field: 'email', 'has-error')}">

                        <label for="email" class="col-sm-2 control-label mandatory"><g:message
                                code="person.email.label"/></label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon">@</span>
                                <g:textField name="email" value="${person?.email}" class="form-control"
                                             required="true"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                </div>
            </fieldset>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <g:actionSubmit class="save btn btn-primary" action="update"
                                                         value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                </div>
            </div>
        </g:form>

    </div>
</div>
</body>
</html>
