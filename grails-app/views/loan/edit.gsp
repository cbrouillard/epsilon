

<%@ page import="com.headbangers.epsilon.Loan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loanInstance}">
            <div class="errors">
                <g:renderErrors bean="${loanInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${loanInstance?.id}" />
                <g:hiddenField name="version" value="${loanInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="type"><g:message code="loan.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'type', 'errors')}">
                                    <g:select name="type" from="${com.headbangers.epsilon.LoanType?.values()}" keys="${com.headbangers.epsilon.LoanType?.values()*.name()}" value="${loanInstance?.type?.name()}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tiers"><g:message code="loan.tiers.label" default="Tiers" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'tiers', 'errors')}">
                                    <g:select name="tiers.id" from="${com.headbangers.epsilon.Tiers.list()}" optionKey="id" value="${loanInstance?.tiers?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="owner"><g:message code="loan.owner.label" default="Owner" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'owner', 'errors')}">
                                    <g:select name="owner.id" from="${com.headbangers.epsilon.Person.list()}" optionKey="id" value="${loanInstance?.owner?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="amount"><g:message code="loan.amount.label" default="Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: loanInstance, field: 'amount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="scheduled"><g:message code="loan.scheduled.label" default="Scheduled" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'scheduled', 'errors')}">
                                    <g:select name="scheduled.id" from="${com.headbangers.epsilon.Scheduled.list()}" optionKey="id" value="${loanInstance?.scheduled?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="startDate"><g:message code="loan.startDate.label" default="Start Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'startDate', 'errors')}">
                                    <g:datePicker name="startDate" precision="day" value="${loanInstance?.startDate}" default="none" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="endDate"><g:message code="loan.endDate.label" default="End Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'endDate', 'errors')}">
                                    <g:datePicker name="endDate" precision="day" value="${loanInstance?.endDate}" default="none" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="loan.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${loanInstance?.description}" />
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
