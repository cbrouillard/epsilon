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
<%@ page import="com.headbangers.epsilon.SetupObjectCommand" %>
<html>
<head>
    <meta name='layout' content='login'/>
    <title>Configurer Epsilon sur votre serveur</title>
</head>

<body>
<div class="col-sm-12">
    <h1>Configuration d'Epsilon</h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">
        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:hasErrors bean="${setup}">
            <div class="alert alert-error">
                <g:renderErrors bean="${setup}" as="list"/>
            </div>
        </g:hasErrors>

        <form class="form-horizontal" method="post" action="install">

            <fieldset class="form">
                <div id="formContainer">

                    <div class="form-group">
                        <div class="col-sm-10 col-sm-offset-2">
                            <p class="form-control-static">
                            <h4>Mot de passe de l'administrateur</h4>
                        </p>
                        </div>

                    </div>

                    <div class="form-group ${hasErrors(bean: setup, field: 'adminpassword', 'has-error')}">

                        <label for="adminpassword" class="col-sm-2 control-label mandatory">
                            <g:message code="setup.adminpass.label"
                                       default="Admin password"/>
                        </label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-cog"></span></span>
                                <g:textField name="adminpassword" value="${setup?.adminpassword}" class="form-control" autofocus="" required="required"/>
                            </div>

                            <div class="help-block with-errors">
                                Le mot de passe de l'administrateur est important ! Avec ce compte
                                vous pouvez accéder à la configuration des utilisateurs d'Epsilon.
                                Pour vous connecter en tant qu'administrateur, utilisez le login 'admin'.
                            </div>
                        </div>
                    </div>

                    <hr/>

                    <div class="form-group">
                        <div class="col-sm-10 col-sm-offset-2">
                            <p class="form-control-static">
                            <h4>Création du premier utilisateur (facultatif)</h4>
                            </p>
                        </div>

                        <div class="col-sm-10 help-block with-errors col-sm-offset-2">
                            Vous pouvez vous servir de ce formulaire afin de créer votre premier
                            utilisateur pour Epsilon. Notez que l'administrateur peut créer
                            autant d'utilisateurs que souhaité.
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: setup, field: 'username', 'has-error')}">

                        <label for="username" class="col-sm-2 control-label mandatory">
                            <g:message code="person.username.label" default="Username"/>
                        </label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-user"></span></span>
                                <g:textField name="username" value="${setup?.username}" class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: setup, field: 'userRealName', 'has-error')}">

                        <label for="userRealName" class="col-sm-2 control-label mandatory">
                            <g:message code="person.userRealName.label"
                                       default="UserRealName"/>
                        </label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-font"></span></span>

                                <g:textField name="userRealName" value="${setup?.userRealName}" class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: setup, field: 'passwd', 'has-error')}">

                        <label for="passwd" class="col-sm-2 control-label mandatory">
                            <g:message code="person.pass.label" default="Pass"/>
                        </label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-cog"></span></span>

                                <g:textField name="passwd" value="${setup?.passwd}" class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <div class="form-group ${hasErrors(bean: setup, field: 'email', 'has-error')}">

                        <label for="email" class="col-sm-2 control-label mandatory">
                            <g:message code="person.email.label" default="Email"/>
                        </label>

                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon">@</span>

                                <g:textField name="email" value="${setup?.email}"  class="form-control"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                </div>
            </fieldset>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">

                    <button type="submit" class="btn btn-success">
                        <span class="glyphicon glyphicon-save"></span> ${message(code: 'setup.button.install.label', default: 'Install')}
                    </button>

                </div>
            </div>
        </form>

    </div>

</div>

</body>
</html>