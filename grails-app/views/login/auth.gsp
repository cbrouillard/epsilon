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
<html>
<head>
    <meta name='layout' content='login'/>
    <title><g:message code="springSecurity.login.title"/></title>
    <style type='text/css' media='screen'>
    .form-signin {
        /*max-width: 350px;*/
        /*margin-top: 20px;*/
        padding: 19px 29px 29px;
        /*margin: 0 auto 20px;*/
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
        -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
        box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
    }
    </style>
</head>

<body>
<g:if test='${flash.message}'>
    <div class="row-fluid">
        <div class="span12">
            <div class="alert alert-error">${flash.message}</div>
        </div>
    </div>
</g:if>

<div class="row-fluid">

    <div class="span2">&nbsp;</div>

    <div class="span4">

        <form class="form-signin" action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>
            <h2 class="form-signin-heading alert alert-success"><g:message code="springSecurity.login.header"/></h2>
            <input type="text" class="input-block-level" placeholder="${message(code: 'springSecurity.login.username.label')}"
                   name='j_username' required="true">
            <input type="password" class="input-block-level" placeholder="${message(code: 'springSecurity.login.password.label')}"
                   name='j_password' required="true">

            <div class="pull-right">
                <label>
                    <g:message code="springSecurity.login.remember.me.label"/>
                    <input type="checkbox" name='${rememberMeParameter}'
                           <g:if test='${hasCookie}'>checked='checked'</g:if>>
                </label>
                <button class="btn btn-large btn-primary" type="submit"><g:message code="springSecurity.login.button"/></button>
            </div>

            <div class="clearfix">&nbsp;</div>
        </form>

    </div>

    <div class="span6">&nbsp;</div>

</div>

<script type='text/javascript'>
    <!--
    (function () {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
    // -->
</script>
</body>
</html>
