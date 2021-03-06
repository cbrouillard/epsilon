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
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title><g:message code="budget.out.operations"/></title>
</head>

<body>

<div class="col-sm-12">
    <h1><g:message code="budget.out.operations"/> <small>pour le mois en cours</small></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th><g:message code="date"/></th>
                <th><g:message code="tiers"/></th>
                <th><g:message code="category"/></th>
                <th class="text-right"><g:message code="payment"/></th>
                <th class="text-right"><g:message code="total"/></th>
                <th class="text-right"><g:message code="actions"/></th>
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
                    <td class="text-right">
                        <g:if test="${operation.latitude && operation.longitude}">
                            <g:link controller="operation" title="Localiser" action="location" id="${operation.id}"><img
                                    src="${assetPath(src: 'location.png')}"
                                    alt="GPS"/></g:link>
                        </g:if>
                        <g:link title="Editer" action="edit" id="${operation.id}" controller="operation"><img
                                src="${assetPath(src: 'edit.png')}"
                                alt="Editer"/></g:link>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>

    </div>
</div>
</body>
</html>
