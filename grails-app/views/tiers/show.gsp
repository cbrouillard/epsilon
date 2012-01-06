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
<%@ page import="com.headbangers.epsilon.Tiers" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="popup" />
        <g:set var="entityName" value="${message(code: 'tiers.label', default: 'Tiers')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list">Liste des tiers</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Nouveau tiers</g:link></span>
        </div>
        <div class="body">
            <h1>Détails d'un tiers</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tiers.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tiersInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tiers.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tiersInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tiers.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tiersInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tiers.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${tiersInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tiers.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${tiersInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tiers.operations.label" default="Operations" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <g:link action="operations" id="${tiersInstance.id}"><img src="${resource(dir:'img', file:'operation.png')}"/> Voir les opérations pour ce tiers</g:link>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="important">
              Solde pour ce tiers : <g:formatNumber number="${tiersInstance?.sold}" format="0.##" /> €
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${tiersInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
