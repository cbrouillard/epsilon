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
        <meta name="layout" content="popup" />
        <g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list">Liste des catégories</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Nouvelle catégorie</g:link></span>
        </div>
        <div class="body">
            <h1>Détails d'une catégorie</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="category.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: categoryInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="category.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: categoryInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="category.type.label" default="Type" /></td>
                            
                            <td valign="top" class="value">${categoryInstance?.type?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="category.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: categoryInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="category.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${categoryInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="category.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${categoryInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="category.operations.label" default="Operations" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <g:link action="operations" id="${categoryInstance?.id}">
                                  <img src="${resource(dir:'img', file:'operation.png')}" alt="€"/> Voir les opérations de cette catégorie
                                </g:link>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="important">
              Solde pour cette catégorie : <g:formatNumber number="${categoryInstance?.sold}" format="0.##" /> €
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${categoryInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
