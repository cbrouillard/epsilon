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
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="login">
    <title><g:message code="app.name"/></title>
</head>

<body>

<g:if test='${flash.message}'>
    <div class='alert-info alert'>${flash.message}</div>
</g:if>

<div class="col-lg-4 col-lg-offset-4 col-md-12">

    <div class="panel panel-warning">

        <div class="panel-heading">
            <h4><g:message code="springSecurity.login.header"/></h4>
        </div>

        <div class="panel-body">

            <form action='${postUrl}' method='POST' id='loginForm' autocomplete='off'
                  data-toggle="validator">

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-user"></span></span>
                        <input type="text" name='j_username' id='username' class="form-control"
                               placeholder="${message(code: 'springSecurity.login.username.label')}"
                               required
                               autofocus>
                    </div>

                    <div class="help-block with-errors"></div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-cog"></span></span>
                        <input type="password" name='j_password' id='password' class="form-control"
                               placeholder="${message(code: 'springSecurity.login.password.label')}"
                               required>
                    </div>

                    <div class="help-block with-errors"></div>
                </div>

                <button class="btn btn-lg btn-success btn-block" type="submit"><g:message
                        code="springSecurity.login.button"/></button>

            </form>
        </div>

    </div>

</div>

</body>
</html>