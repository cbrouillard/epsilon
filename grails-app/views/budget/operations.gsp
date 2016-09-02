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
    <h1>Opérations sur un budget <small>${budget.name}
    <g:if test="${budget.startDate || budget.endDate}">
        <g:if test="${budget.startDate}">
            du <g:formatDate date="${budget.startDate}"/> au
        </g:if><g:else>
        du premier jour du mois au
    </g:else>
        <g:if test="${budget.endDate}">
            <g:formatDate date="${budget.endDate}"/>
        </g:if>
        <g:else>
            dernier jour du mois
        </g:else>
    </g:if>
    </small></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:set var="operations" value="${budget.operations}"/>
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th>Date</th>
                <th>Tiers</th>
                <th>Catégorie</th>
                <th class="text-right">Paiement</th>
                <th class="text-right">Total</th>
            </tr>
            </thead>
            <tbody>
            <g:set var="total" value="${0D}"/>
            <g:each in="${operations}" status="i" var="operation">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td><g:formatDate date="${operation.dateApplication}"/></td>
                    <td>${operation.tiers.name}</td>
                    <td>${operation.category.name}</td>
                    <td class="tdright"><b><g:formatNumber number="${operation?.amount}" format="###,###.##"/> €</b>
                        <g:set var="total" value="${total + operation?.amount}"/>
                    </td>

                    <td class="tdright"><g:formatNumber number="${total}" format="###,###.##"/> €</td>
                </tr>
            </g:each>
            </tbody>
        </table>

    </div>
</div>
</body>
</html>
