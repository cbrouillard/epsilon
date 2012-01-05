
<%@ page import="com.headbangers.epsilon.Scheduled" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="popup" />
        <g:set var="entityName" value="${message(code: 'scheduled.label', default: 'Scheduled')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list">Liste des échéances</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Nouvelle échéance</g:link></span>
        </div>
        <div class="body">
            <h1>Détails d'une échéance</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="scheduled.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: scheduledInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="scheduled.type.label" default="Type" /></td>
                            
                            <td valign="top" class="value">${scheduledInstance?.type?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="scheduled.tiers.label" default="Tiers" /></td>
                            
                            <td valign="top" class="value"><g:link controller="tiers" action="operations" id="${scheduledInstance?.tiers?.id}">${scheduledInstance?.tiers?.name}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="scheduled.category.label" default="Category" /></td>
                            
                            <td valign="top" class="value"><g:link controller="category" action="operations" id="${scheduledInstance?.category?.id}">${scheduledInstance?.category?.name}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="scheduled.dateApplication.label" default="Date Application" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${scheduledInstance?.dateApplication}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="scheduled.amount.label" default="Amount" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${scheduledInstance?.amount}" format="0.##" /> €</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="scheduled.note.label" default="Note" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: scheduledInstance, field: "note")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="scheduled.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${scheduledInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="scheduled.automatic.label" default="Automatic" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${scheduledInstance?.automatic}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="scheduled.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${scheduledInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="important">
              Solde passé pour cette échéance : <g:formatNumber number="${scheduledInstance?.pastSold}" format="0.##" /> €
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${scheduledInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
