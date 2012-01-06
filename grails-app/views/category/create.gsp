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
<%@ page import="com.headbangers.epsilon.Category" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list">Liste des catégories</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Nouvelle catégorie</g:link></span>
        </div>
        <div class="body">
            <h1>Créer un nouvelle catégorie</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${categoryInstance}">
            <div class="errors">
                <g:renderErrors bean="${categoryInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="category.name.label" default="Name" />:</label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: categoryInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${categoryInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="category.type.label" default="Type" />:</label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: categoryInstance, field: 'type', 'errors')}">
                                    <g:select name="type" from="${com.headbangers.epsilon.CategoryType?.values()}" value="${categoryInstance?.type}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="category.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: categoryInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${categoryInstance?.description}" />
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
