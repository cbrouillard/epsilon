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
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1><g:message code="person.list"/> <small><g:message code="person.list.explanation"/></small>
        <g:link class="create btn btn-success" action="createuser">
            <img src="${assetPath(src: 'personal-information.png')}" alt=">"/>
            <g:message code="person.create"/> </g:link>
    </h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <g:sortableColumn property="username"
                                  title="${message(code: 'person.username.label', default: 'Username')}"/>
                <g:sortableColumn property="userRealName"
                                  title="${message(code: 'person.userRealName.label', default: 'userRealName')}"/>
                <th class="text-center"><g:message code="admin"/></th>
                <th class="text-center"><g:message code="active"/></th>
                <g:sortableColumn property="email"
                                  title="${message(code: 'person.email.label', default: 'Email')}"/>
                <th class="text-right"><g:message code="actions"/></th>

            </tr>
            </thead>
            <tbody>
            <g:each in="${persons}" status="i" var="person">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td>${fieldValue(bean: person, field: "username")}</td>
                    <td>${fieldValue(bean: person, field: "userRealName")}</td>
                    <td class="text-center">
                        <div id="person${person.id}-admin">
                            <g:render template="setadminactions" model="[person: person]"/>
                        </div>
                    </td>
                    <td class="text-center">
                        <div id="person${person.id}-enable">
                            <g:render template="enableactions" model="[person: person]"/>
                        </div>
                    </td>
                    <td><a href="mailto:${fieldValue(bean: person, field: "email")}">${fieldValue(bean: person, field: "email")}</a>
                    </td>
                    <td class="text-right">

                        <g:link title="Editer" action="edituser" id="${person.id}"><img
                                src="${assetPath(src: 'edit.png')}"/></g:link>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="pagination pull-right">
            <g:paginate total="${total}"/>
        </div>
        <div class="clearfix">&nbsp;</div>
    </div>
</div>

</div>

</body>
</html>
