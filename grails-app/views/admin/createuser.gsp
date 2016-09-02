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
    <title><g:message code="default.create.label" args="[entityName]"/></title>
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
    <h1>Créer un nouvel utilisateur <small>Attention ! Administration.</small></h1>
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

        <g:form action="saveuser" method="post" class="form-horizontal">

            <div class="form-group ${hasErrors(bean: person, field: 'username', 'has-error')}">

                <label for="username" class="col-sm-2 control-label mandatory"><g:message
                        code="person.username.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-font"></span></span>
                        <g:textField name="username" id="username" required="true" value="${person?.username}"
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
                                class="glyphicon glyphicon-font"></span></span>
                        <g:textField name="userRealName" id="userRealName" required="true" value="${person?.userRealName}"
                                     class="form-control" />
                    </div>

                    <div class="help-block with-errors"></div>
                </div>
            </div>


            <div class="form-group ${hasErrors(bean: person, field: 'passwd', 'has-error')}">

                <label for="password" class="col-sm-2 control-label mandatory"><g:message
                        code="person.pass.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-cog"></span></span>
                        <g:textField name="password" id="password" required="true" value="${person?.password}"
                                     class="form-control" />
                    </div>

                    <div style="color:green;font-weight: bold;" id='result'></div>
                    <div class="help-block with-errors"></div>
                </div>
            </div>


            <div class="form-group ${hasErrors(bean: person, field: 'email', 'has-error')}">

                <label for="userRealName" class="col-sm-2 control-label mandatory"><g:message
                        code="person.email.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon">@</span></span>
                        <g:textField name="email" id="email" required="true" value="${person?.email}"
                                     class="form-control" />
                    </div>

                    <div class="help-block with-errors"></div>
                </div>
            </div>

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
</div>
</body>
</html>
