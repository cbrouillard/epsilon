
<%@ page import="com.headbangers.epsilon.Operation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'operation.label', default: 'Operation')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>

        <resource:autoComplete skin="default" />
    </head>
    <body>
        <div class="undernav">
            <span class="menuButton"><g:link class="list" action="list" params="[account:operationInstance?.account.id]">Liste des opérations</g:link></span>
        </div>
        <div class="body">
            <h1>Editer une opération</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${operationInstance}">
            <div class="errors">
                <g:renderErrors bean="${operationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${operationInstance?.id}" />
                <g:hiddenField name="version" value="${operationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tiers"><g:message code="operation.tiers.label" default="Tiers" /></label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'tiers', 'errors')}">
                                    <richui:autoComplete id="tiers" name="tiersname" action="${createLinkTo('dir': 'tiers/autocomplete')}" value="${operationInstance?.tiers?.name}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="category"><g:message code="operation.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'category', 'errors')}">
                                    <richui:autoComplete id="category" name="categoryname" action="${createLinkTo('dir': 'category/autocomplete/')}"  value="${operationInstance?.category?.name}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dateApplication"><g:message code="operation.dateApplication.label" default="Date Application" /></label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'dateApplication', 'errors')}">
                                    <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:operationInstance?.dateApplication)}" name="dateApplication" id="dateApplication"/>
                                </td>
                            </tr>

                            <jq:jquery>
                              jQuery("#dateApplication").datePicker({clickInput:true, startDate:'01/01/1996'});
                            </jq:jquery>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="amount"><g:message code="operation.amount.label" default="Amount" /></label>
                                </td>
                                <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: operationInstance, field: 'amount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="note"><g:message code="operation.note.label" default="Note" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">
                                    <g:textArea name="note" cols="40" rows="5" value="${operationInstance?.note}" />
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="pointed"><g:message code="operation.pointed.label" default="Pointed" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: operationInstance, field: 'pointed', 'errors')}">
                                    <g:checkBox name="pointed" value="${operationInstance?.pointed}" />
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
