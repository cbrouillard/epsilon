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
<div class="table-responsive">
    <table class="table table-striped table-hover table-condensed table-fixed">
        <thead>
        <tr>
            <th><g:message code="date"/></th>
            <th>&nbsp;</th>
            <th><g:message code="category"/></th>
            <th class="text-right"><g:message code="operation.type.payment"/></th>
            <th class="text-right"><g:message code="operation.type.receipt"/></th>
            <th class="text-right"><g:message code="total"/></th>
            <th class="text-right"><g:message code="actions"/></th>
        </tr>
        </thead>
        <tbody>

        <g:set var="total" value="${0D}"/>
        <g:set var="actualMonth" value="${operations ? operations.get(0).dateApplication.getMonth() + 1 : 0}"/>
        <g:set var="prev" value="${actualMonth}"/>

        <g:if test="${operations}">
            <tr id="month${formatDate(format: 'MMMM_yyyy', date:operations.get(0).dateApplication)}">
                <td colspan="7" class="centered" >
                    <g:message code="month.real.${actualMonth}"/> <g:formatDate format="yyyy" date="${operations.get(0).dateApplication}"/>
                </td>
            </tr>
        </g:if>

        <g:each in="${operations}" status="i" var="operation">

            <g:set var="actualMonth" value="${operation.dateApplication.getMonth() + 1}"/>

            <g:if test="${actualMonth != prev}">
                <tr id="month${formatDate(format: 'MMMM_yyyy', date:operation.dateApplication)}">
                    <td colspan="7" class="centered" >
                        <g:message code="month.real.${actualMonth}"/> <g:formatDate format="yyyy" date="${operation.dateApplication}"/>
                    </td>
                </tr>
                <g:set var="prev" value="${actualMonth}"/>
            </g:if>

            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td><g:formatDate date="${operation.dateApplication}"/></td>
                <td>
                    <g:if test="${operation.isFromScheduled}">
                        <img src="${resource(dir:"img", file:"time.png")}" title="${operation.note}"/>
                    </g:if>
                    <g:else>
                        &nbsp;
                    </g:else>
                </td>
                <td>${operation.category.name} - ${operation.tiers.name}</td>
                <td class="tdright">
                    <g:if test="${operation?.type == com.headbangers.epsilon.OperationType.RETRAIT || operation?.type == com.headbangers.epsilon.OperationType.VIREMENT_MOINS}">
                        <b><g:formatNumber number="${operation?.amount}" format="###,###.##"/> €</b>
                        <g:set var="total" value="${total - operation?.amount}"/>
                    </g:if>
                </td>
                <td class="tdright">
                    <g:if test="${operation?.type == com.headbangers.epsilon.OperationType.DEPOT || operation?.type == com.headbangers.epsilon.OperationType.VIREMENT_PLUS}">
                        <b><g:formatNumber number="${operation?.amount}" format="###,###.##"/> €</b>
                        <g:set var="total" value="${total + operation?.amount}"/>
                    </g:if>
                </td>
                <td class="tdright"><g:formatNumber number="${total}" format="###,###.##"/> €</td>

                <td class="text-right">
                    <g:if test="${operation.latitude && operation.longitude}">
                        <g:link controller="operation" title="Localiser" action="location" id="${operation.id}"><img
                                src="${resource(dir: 'img', file: 'location.png')}"
                                alt="GPS"/></g:link>
                    </g:if>

                    <g:link controller="operation" title="Editer" action="edit" id="${operation.id}"><img
                            src="${resource(dir: 'img', file: 'edit.png')}"
                            alt="Editer"/></g:link>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<ul class="pagination pull-right">
    <li>
        <a href="#top"><span class="glyphicon glyphicon-arrow-up"/></a>
    </li>
</ul>

<div class="clearfix">&nbsp;</div>