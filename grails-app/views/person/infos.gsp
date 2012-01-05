
<%@ page import="com.headbangers.epsilon.Person" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
      <div class="undernav">
        &nbsp;
      </div>
        <div class="body">
            <h1>Vos informations personnelles</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="person.email.label" default="Email" /></td>

                            <td valign="top" class="value">${fieldValue(bean: person, field: "email")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="person.username.label" default="Username" /></td>

                            <td valign="top" class="value">${fieldValue(bean: person, field: "username")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="person.userRealName.label" default="UserRealName" /></td>

                            <td valign="top" class="value">${fieldValue(bean: person, field: "userRealName")}</td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form action="edit" method="post">
                    <span class="button"><g:actionSubmit action="edit" class="edit" name="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
