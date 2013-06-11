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

<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Créer un nouvel utilisateur <small>Attention ! Administration.</small></h1>
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

                <g:hasErrors bean="${person}">
                    <div class="alert alert-error">
                        <g:renderErrors bean="${person}" as="list"/>
                    </div>
                </g:hasErrors>

                <g:form action="saveuser" method="post" class="form-horizontal">
                    <div class="control-group">
                        <label for="username" class="control-label mandatory"><g:message code="person.username.label" default="Username"/></label>

                        <div class="controls ${hasErrors(bean: person, field: 'username', 'errors')}">
                            <g:textField name="username" id="username" value="${person?.username}" class="input-block-level" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="userRealName" class="control-label mandatory"><g:message code="person.userRealName.label" default="UserRealName"/></label>

                        <div class="controls ${hasErrors(bean: person, field: 'userRealName', 'errors')}">
                            <g:textField name="userRealName" value="${person?.userRealName}" class="input-block-level" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="password" class="control-label mandatory"><g:message code="person.pass.label" default="Pass"/></label>

                        <div class="controls ${hasErrors(bean: person, field: 'passwd', 'errors')}">
                            <g:textField id="password" name="pass" value="${person?.password}" class="password input-block-level" required="true"/>
                            <div style="color:green" id='result'></div>
                        </div>
                    </div>

                    <div class="control-group">
                        <label for="email" class="control-label mandatory"><g:message code="person.email.label" default="Email"/></label>

                        <div class="controls ${hasErrors(bean: person, field: 'email', 'errors')}">
                            <g:textField name="email" value="${person?.email}" class="input-block-level" required="true"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <div class="controls">
                            <g:submitButton name="create" class="save btn btn-primary"
                                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                        </div>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
