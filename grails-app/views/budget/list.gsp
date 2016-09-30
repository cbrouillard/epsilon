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
<%@ page import="com.headbangers.epsilon.Budget" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="col-sm-12">
    <h1><g:message code="budget.list"/> <small><g:message code="budget.list.explanation"/></small> <g:link controller="budget" action="create"
                                                                        class="btn btn-success"><img
                src="${resource(dir: 'img', file: 'coins.png')}"
                alt=">"/> <g:message code="budget.create"/></g:link></h1>

    <div class="alert alert-info">
        <g:message code="budget.super.explanation"/>
    </div>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <div class="text-right pull-right">
            <g:render template="/generic/search"/>
        </div>

        <g:render template="/generic/listsize"/>
        <div class="clearfix"></div>

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>
        <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <g:sortableColumn property="name" title="${message(code: 'budget.name.label', default: 'Name')}"/>

                <g:sortableColumn property="amount" title="${message(code: 'budget.amount.label', default: 'Amount')}" class="text-right"/>
                <th><g:message code="budget.dates"/></th>
                <th class="text-right"><g:message code="budget.used.amount"/></th>

                <th><g:message code="budget.categories.label" default="Categories"/></th>
                <g:sortableColumn property="note" title="${message(code: 'budget.note.label', default: 'Note')}"/>
                <g:sortableColumn property="lastUpdated"
                                  title="${message(code: 'budget.lastUpdated.label', default: 'Last Updated')}"/>

                <g:sortableColumn property="active" title="${message(code: 'budget.active.label', default: 'Active')}" class="text-center"/>
                <th class="text-right"><g:message code="actions"/></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${budgetInstanceList}" status="i" var="budgetInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td>${fieldValue(bean: budgetInstance, field: "name")}</td>

                    <g:set var="currentSold" value="${budgetInstance.currentMonthOperationsSum}"/>

                    <td class="tdright"><b>${fieldValue(bean: budgetInstance, field: "amount")} €</b></td>
                    <td>
                        <g:if test="${budgetInstance.startDate || budgetInstance.endDate}">
                            <g:if test="${budgetInstance.startDate}">
                                <g:message code="budget.from.to" args="${[formatDate(date:budgetInstance.startDate)]}"/>
                            </g:if><g:else>
                                <g:message code="budget.from.firstday"/>
                            </g:else>
                            <g:if test="${budgetInstance.endDate}">
                                <g:formatDate date="${budgetInstance.endDate}"/>
                            </g:if>
                            <g:else>
                                <g:message code="budget.to.lastday"/>
                            </g:else>
                        </g:if><g:else><g:message code="budget.everymonth"/></g:else>
                    </td>

                    <g:if test="${currentSold < budgetInstance.amount}">
                        <td class="tdright">
                        <span class="label label-success">
                    </g:if>
                    <g:elseif
                            test="${currentSold >= budgetInstance.amount - 1 && currentSold <= budgetInstance.amount + 1}">
                        <td class="tdright">
                        <span class="label label-warning">
                    </g:elseif>
                    <g:elseif test="${currentSold > budgetInstance.amount}">
                        <td class="tdright">
                        <span class="label label-danger">
                    </g:elseif>
                    <g:else>
                        <td class="budget tdright">
                    </g:else>
                    <g:formatNumber number="${currentSold}" format="###,###.##" /> €</span></td>

                    <td>
                        <ul>
                            <g:each in="${budgetInstance.attachedCategories}" status="c" var="category">
                                <li>${category.name}</li>
                            </g:each>
                        </ul>
                    </td>
                    <td class="limitedSize">${fieldValue(bean: budgetInstance, field: "note")}</td>
                    <td><g:formatDate date="${budgetInstance.lastUpdated}"/></td>

                    <td class="tdcenter">
                        <div id="budget${budgetInstance.id}-activation">
                            <g:render template="activateactions" model="[budget: budgetInstance]"/>
                        </div>
                    </td>
                    <td class="text-right">
                        <g:link title="Afficher les détails" action="show" id="${budgetInstance.id}" data-toggle="modal"
                                data-target="#modalWindow_show"><img
                                src="${resource(dir: 'img', file: 'details.png')}" alt="Détails"/></g:link>
                        <g:link title="Editer" action="edit" id="${budgetInstance.id}"><img
                                src="${resource(dir: 'img', file: 'edit.png')}"
                                alt="Editer"/></g:link>
                        <g:link title="Afficher le registre" controller="budget" action="operations"
                                params="[budget: budgetInstance.id]"><img
                                src="${resource(dir: 'img', file: 'operation.png')}"/></g:link>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
            </div>

        <div class="pagination pull-right">
            <g:paginate total="${budgetInstanceTotal}"/>
        </div>

        <div class="clearfix">&nbsp;</div>
    </div>
</div>

<div class="modal fade" id="modalWindow_show" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        </div>
    </div>
</div>

</body>
</html>
