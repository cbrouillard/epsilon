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
    <h1><g:message code="budget.list"/> <small><g:message code="budget.list.explanation"/></small> <g:link
            controller="budget" action="create"
            class="btn btn-success"><img
                src="${assetPath(src: 'coins.png')}"
                alt=">"/> <g:message code="budget.create"/></g:link></h1>

    <div class="row">
        <div class="col-sm-7">
            <div class="alert alert-info">
                <g:message code="budget.super.explanation"/>
            </div>
        </div>

        <g:set var="totalAmount" value="${0D}"/>
        <g:set var="totalUsedAmount" value="${0D}"/>
        <g:each in="${budgetInstanceList}" status="i" var="budgetInstance">
            <g:set var="totalAmount" value="${totalAmount + budgetInstance.amount}"/>
            <g:set var="totalUsedAmount" value="${totalUsedAmount + budgetInstance.currentMonthOperationsSum }"/>
        </g:each>

        <div class="col-sm-5">
            <div class="around-border">
                <div class="row">

                    <div class="counter-shower col-xs-12 col-sm-6">

                        <div class="number">
                            <span class="label label-default">
                                <g:formatNumber number="${totalAmount}"
                                                format="###,###.##"/> €
                            </span>
                        </div>

                        <div class="lbl">
                            <g:message code="budget.amount.label"/>
                        </div>

                    </div>

                    <div class="counter-shower col-xs-12 col-sm-6">

                        <div class="number">
                            <span class="label label-${totalUsedAmount > totalAmount ? 'danger' : 'success'}">
                                <g:formatNumber number="${totalUsedAmount}"
                                                format="###,###.##"/> €
                            </span>
                        </div>

                        <div class="lbl">
                            <g:message code="budget.used.amount"/>
                        </div>

                    </div>

                </div>

                <div class="clearfix">&nbsp;</div>

                <div class="row">

                    <div class="counter-shower col-xs-12 col-sm-12">

                        <div class="number">
                            <span class="label label-${outOfBudgets > 0 ? 'danger' : 'default'}">
                                <g:formatNumber number="${outOfBudgets}"
                                                format="###,###.##"/> €
                            </span>
                        </div>

                        <div class="lbl">
                            <g:message code="budget.out.operations"/>
                            <g:link title="Afficher le registre" controller="budget" action="out"><img
                                    src="${assetPath(src: 'operation.png')}"/></g:link>
                        </div>
                    </div>
                </div>

            </div>
        </div>

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
        <hr/>

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <g:sortableColumn property="name" title="${message(code: 'budget.name.label', default: 'Name')}"/>

                    <g:sortableColumn property="amount"
                                      title="${message(code: 'budget.amount.label', default: 'Amount')}"
                                      class="text-right"/>
                    <th><g:message code="budget.dates"/></th>
                    <th class="text-right"><g:message code="budget.used.amount"/></th>

                    <th><g:message code="budget.categories.label" default="Categories"/></th>
                    <g:sortableColumn property="note" title="${message(code: 'budget.note.label', default: 'Note')}"/>
                    <g:sortableColumn property="lastUpdated"
                                      title="${message(code: 'budget.lastUpdated.label', default: 'Last Updated')}"/>

                    <g:sortableColumn property="active"
                                      title="${message(code: 'budget.active.label', default: 'Active')}"
                                      class="text-center"/>
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
                                    <g:message code="budget.from.to"
                                               args="${[formatDate(date: budgetInstance.startDate)]}"/>
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
                                    <li><g:link controller="category" action="operations" id="${category.id}">${category.name}</g:link></li>
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
                            <g:link title="Editer" action="edit" id="${budgetInstance.id}"><img
                                    src="${assetPath(src: 'edit.png')}"
                                    alt="Editer"/></g:link>
                            <g:link title="Afficher le registre" controller="budget" action="operations"
                                    params="[budget: budgetInstance.id]"><img
                                    src="${assetPath(src: 'operation.png')}"/></g:link>

                            <g:link title="Afficher les stats" controller="budget" action="stats"
                                                                params="[id: budgetInstance.id]"><img
                                                                src="${assetPath(src: 'stats.png')}"/></g:link>
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
