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
<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Liste des utilisateurs Epsilon <small>Attention ! Administration.</small>
                    <g:link class="create btn" action="createuser">
                        <img src="${resource(dir: 'img', file: 'personal-information.png')}" alt=">"/>
                        Nouvel utilisateur</g:link>
                </h1>
                <hr/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <div class="around-border">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <g:sortableColumn property="username" title="${message(code: 'person.username.label', default: 'Username')}"/>
                        <g:sortableColumn property="userRealName" title="${message(code: 'person.userRealName.label', default: 'userRealName')}"/>
                        <th>Activé</th>
                        <g:sortableColumn property="email" title="${message(code: 'person.email.label', default: 'Email')}"/>
                        <th>Actions</th>

                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${persons}" status="i" var="person">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td>${fieldValue(bean: person, field: "username")}</td>
                            <td>${fieldValue(bean: person, field: "userRealName")}</td>
                            <td>
                                <div id="person${person.id}-enable">
                                    <g:render template="enableactions" model="[person: person]"/>
                                </div>
                            </td>
                            <td><a href="mailto:${fieldValue(bean: person, field: "email")}">${fieldValue(bean: person, field: "email")}</a></td>
                            <td class="tdcenter">
                                <g:link title="Afficher les détails" data-toggle="modal" data-target="#modalWindow_show" action="showuser" id="${person.id}"><img
                                        src="${resource(dir: 'img', file: 'details.png')}"/></g:link>
                                <g:link title="Editer" action="edituser" id="${person.id}"><img src="${resource(dir: 'img', file: 'edit.png')}"/></g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination text-right">
                    <g:paginate total="${total}"/>
                </div>
            </div>
        </div>
    </div>

</div>

<div id="modalWindow_show" class="modal hide fade">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">×</a>

        <h3>Détails d'un utilisateur</h3>
    </div>

    <div class="modal-body">
        <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
    </div>
</div>

</body>
</html>
