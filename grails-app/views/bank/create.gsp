
<%@ page import="com.headbangers.epsilon.Bank" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'bank.label', default: 'Bank')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list">Liste des établissements</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Nouvel établissement</g:link></span>
        </div>
        <div class="body">
            <h1>Créer un nouvel établissement</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${bankInstance}">
            <div class="errors">
                <g:renderErrors bean="${bankInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="bank.name.label" default="Name" />:</label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: bankInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${bankInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="bank.description.label" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bankInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${bankInstance?.description}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="url"><g:message code="bank.url.label" default="Url" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bankInstance, field: 'url', 'errors')}">
                                    <g:textField name="url" value="${bankInstance?.url}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
