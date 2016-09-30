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

<div class="col-sm-12">
    <h1><g:message code="person.label"/> <small>${person.userRealName}</small></h1>
    <hr/>
</div>

<g:if test="${flash.message}">
    <div class="col-sm-12">
        <div class="alert alert-info">${flash.message}</div>
    </div>
</g:if>
<div class="col-sm-12">
    <div class="around-border">

        <div class="alert alert-info">
            <g:message code="person.informations.explanation"/>
        </div>

        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-2 control-label"><g:message code="person.email.label" default="Email"/></label>

                <div class="col-sm-10">
                    <p class="form-control-static">${fieldValue(bean: person, field: "email")}</p>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label"><g:message code="person.username.label" default="Username"/></label>

                <div class="col-sm-10">
                    <p class="form-control-static">${fieldValue(bean: person, field: "username")}</p>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label"><g:message code="person.userRealName.label" default="UserRealName"/></label>

                <div class="col-sm-10">
                    <p class="form-control-static">${fieldValue(bean: person, field: "userRealName")}</p>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <g:link action="edit"
                            class="btn btn-primary">${message(code: 'default.button.edit.label', default: 'Edit')}</g:link>
                </div>
            </div>
            <div class="clearfix"></div>
        </form>


    </div>
</div>

</body>
</html>
