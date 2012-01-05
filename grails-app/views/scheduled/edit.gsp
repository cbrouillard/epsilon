
<%@ page import="com.headbangers.epsilon.Scheduled" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'scheduled.label', default: 'Scheduled')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>

        <resource:autoComplete skin="default" />
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list">Liste des échéances</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">Nouvelle échéance</g:link></span>
        </div>
        <div class="body">
            <h1>Editer une échéance</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${scheduledInstance}">
            <div class="errors">
                <g:renderErrors bean="${scheduledInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${scheduledInstance?.id}" />
                <g:hiddenField name="version" value="${scheduledInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tiers"><g:message code="scheduled.tiers.label" default="Tiers" /></label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'tiers', 'errors')}">
                                    <richui:autoComplete id="tiers" name="tiersname" action="${createLinkTo('dir': 'tiers/autocomplete')}" value="${scheduledInstance?.tiers?.name}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="category"><g:message code="scheduled.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'category', 'errors')}">
                                <richui:autoComplete id="category" name="categoryname" action="${createLinkTo('dir': 'category/autocomplete/')}"  value="${scheduledInstance?.category?.name}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateApplication"><g:message code="scheduled.dateApplication.label" default="Date Application" /></label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'dateApplication', 'errors')}">
                                    <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:scheduledInstance?.dateApplication)}" name="dateApplication" id="dateApplication"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateLastApplication"><g:message code="scheduled.dateLastApplication.label" default="Date Application" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: scheduledInstance, field: 'dateLastApplication', 'errors')}">
                                    <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:scheduledInstance?.dateLastApplication)}" name="dateLastApplication" id="dateLastApplication"/>
                                </td>
                            </tr>

                            <jq:jquery>
                              jQuery("#dateApplication").datePicker({clickInput:true, startDate:'01/01/1996'});
                              jQuery("#dateLastApplication").datePicker({clickInput:true, startDate:'01/01/1996'});
                            </jq:jquery>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="amount"><g:message code="scheduled.amount.label" default="Amount" /></label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: scheduledInstance, field: 'amount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="note"><g:message code="scheduled.note.label" default="Note" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: scheduledInstance, field: 'note', 'errors')}">
                                    <g:textArea name="note" cols="40" rows="5" value="${scheduledInstance?.note}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="automatic"><g:message code="scheduled.automatic.label" default="Automatic" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: scheduledInstance, field: 'automatic', 'errors')}">
                                    <g:checkBox name="automatic" value="${scheduledInstance?.automatic}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
