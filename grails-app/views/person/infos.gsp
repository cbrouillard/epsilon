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
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Utilisateur <small>${person.userRealName}</small></h1>
                <hr/>
            </div>
        </div>
    </div>

    <g:if test="${flash.message}">
        <div class="row">
            <div class="span12">
                <div class="alert alert-info">${flash.message}</div>
            </div>
        </div>
    </g:if>

    <div class="row">
        <div class="span6">
            <div class="around-border">

                <div class="alert alert-info">
                    Paramètrage de l'application
                </div>

                <g:form action="parameterize" method="post" class="form-horizontal">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Description</th>
                            <th>Valeur</th>
                        </tr>
                        </thead>
                        <tbody>

                        <tr>
                            <td><g:message code="parameter.bayesian.label"/></td>
                            <td><g:message code="parameter.bayesian.description"/></td>
                            <td class="tdright"><g:checkBox name="bayesian_filter" value="${new Boolean(parameters.bayesian_filter)}"/></td>
                        </tr>

                        </tbody>
                    </table>


                    <div class="control-group">
                        <div class="controls text-right">

                            <span class="button"><g:submitButton name="parameterize" class="save btn btn-primary"
                                                                 value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
                        </div>
                    </div>
                </g:form>

            </div>
        </div>

        <div class="span6">
            <div class="around-border">

                <div class="alert alert-info">
                    Vos informations personnelles
                </div>

                <dl class="dl-horizontal">
                    <dt><g:message code="person.email.label" default="Email"/></dt>
                    <dd>${fieldValue(bean: person, field: "email")}</dd>

                    <dt><g:message code="person.username.label" default="Username"/></dt>
                    <dd>${fieldValue(bean: person, field: "username")}</dd>

                    <dt><g:message code="person.userRealName.label" default="UserRealName"/></dt>
                    <dd>${fieldValue(bean: person, field: "userRealName")}</dd>
                </dl>


                <g:form action="edit" method="post" class="form-horizontal">
                    <div class="control-group">
                        <div class="controls">
                            <span class="button"><g:actionSubmit action="edit" class="edit btn btn-primary" name="edit"
                                                                 value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
                        </div>
                    </div>
                </g:form>

            </div>
        </div>

    </div>
</div>
</body>
</html>
