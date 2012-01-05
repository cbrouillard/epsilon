
<%@ page import="com.headbangers.epsilon.Person" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="undernav">
          <span class="menuButton"><g:link class="list" action="index">Liste des utilisateurs</g:link></span>
          <span class="menuButton"><g:link class="create" action="createuser">Nouvel utilisateur</g:link></span>
        </div>
        <div class="body">
            <h1>Liste des utilisateurs Epsilon</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
              </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="username" title="${message(code: 'person.username.label', default: 'Username')}" />
                            <g:sortableColumn property="userRealName" title="${message(code: 'person.userRealName.label', default: 'userRealName')}" />
                            <th>Activé</th>
                            <g:sortableColumn property="email" title="${message(code: 'person.email.label', default: 'Email')}" />
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
                                <g:render template="enableactions" model="[person:person]"/>
                              </div>
                            </td>
                            <td><a href="mailto:${fieldValue(bean: person, field: "email")}">${fieldValue(bean: person, field: "email")}</a></td>
                            <td class="center">
                              <g:link title="Afficher les détails" class="popup" action="showuser" id="${person.id}"><img src="${resource(dir:'img', file:'details.png')}"/></g:link>
                              <g:link title="Editer" action="edituser" id="${person.id}"><img src="${resource(dir:'img', file:'edit.png')}"/></g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${total}" />
            </div>
        </div>
    </body>
</html>
