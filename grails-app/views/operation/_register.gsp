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
<g:render template="monthpagination"/>
<div class="table-responsive">
    <table class="table table-striped table-hover table-condensed">
        <thead>
        <tr>
            <th><g:message code="operation.number"/></th>
            <th>${message(code: 'operation.dateApplication.label', default: 'Date Application')}</th>
            <th>&nbsp;</th>
            <th><g:message code="details"/></th>
            <th class="text-center"><g:message code="operation.pointed.label"/></th>
            <th class="text-right"><g:message code="operation.type.payment"/></th>
            <th class="text-right"><g:message code="operation.type.receipt"/></th>
            <th class="text-right"><g:message code="operation.total"/></th>
            <th class="text-right"><g:message code="actions"/></th>
        </tr>
        </thead>
        <tbody>

        <g:if test="${byMonth != null}">
            <g:set var="operations" value="${selected?.lastOperationsByMonth(byMonth != null ? byMonth : 0)}"/>
            <g:set var="accountAmount" value="${selected?.getSnapshot(byMonth)?.amount ?: selected.amount}"/>
        </g:if>
        <g:else>
            <g:set var="operations" value="${selected?.lastOperationsByMonth(currentMonth ? currentMonth : 0)}"/>
            <g:set var="accountAmount" value="${selected?.lastSnapshot?.amount ?: selected.amount}"/>
        </g:else>

        <g:set var="currentDay" value="${null}"/>
        <g:set var="previousDay" value="${null}"/>
        <g:each in="${operations}" status="i" var="operationInstance">

            <g:set var="currentDay" value="${operationInstance.applicationDayInMonth}"/>
            <g:if test="${currentDay != previousDay}">
                <g:set var="previousDay" value="${currentDay}"/>

                <tr>
                    <td colspan="4"></td>
                    <td class="text-center"><small><g:formatDate date="${operationInstance.dateApplication}" format="d MMMM"/></small></td>
                    <td colspan="4">&nbsp;</td>
                </tr>
            </g:if>

            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td>${i + 1}</td>
                <td><g:formatDate date="${operationInstance.dateApplication}"/></td>
                <td>
                    <g:if test="${operationInstance.isFromScheduled}">
                        <img src="${assetPath(src:"time.png")}" title="${operationInstance.note}"/>
                    </g:if>
                    <g:else>
                        &nbsp;
                    </g:else>
                </td>
                <td>${fieldValue(bean: operationInstance, field: "category.name")} - ${fieldValue(bean: operationInstance, field: "tiers.name")}</td>
                <td class="tdcenter">
                    <div id="operation${operationInstance.id}-point">
                        <g:render template="pointactions" model="[operation: operationInstance]"/>
                    </div>
                </td>

                <td class="tdright">
                    <g:if test="${operationInstance?.type == com.headbangers.epsilon.OperationType.RETRAIT || operationInstance?.type == com.headbangers.epsilon.OperationType.VIREMENT_MOINS}">
                        <b><g:formatNumber number="${operationInstance?.amount}" format="###,###.##"/> €</b>
                        <g:set var="accountAmount" value="${accountAmount - operationInstance?.amount}"/>
                    </g:if>
                </td>
                <td class="tdright">
                    <g:if test="${operationInstance?.type == com.headbangers.epsilon.OperationType.DEPOT || operationInstance?.type == com.headbangers.epsilon.OperationType.VIREMENT_PLUS}">
                        <b><g:formatNumber number="${operationInstance?.amount}" format="###,###.##"/> €</b>
                        <g:set var="accountAmount" value="${accountAmount + operationInstance?.amount}"/>
                    </g:if>
                </td>

                <td class="tdright">
                    <g:formatNumber number="${accountAmount}" format="###,###.##"/> €
                    <g:set var="finalAmount" value="${accountAmount}"/>
                </td>

                <td class="text-right">
                    <g:if test="${operationInstance.document}">
                        <g:link controller="document" title="Télécharger" action="download" id="${operationInstance.document.id}">
                            <img src="${assetPath(src: 'invoice.png')}" alt="Download"/></g:link>
                    </g:if>
                    <g:if test="${operationInstance.latitude && operationInstance.longitude}">
                        <g:link controller="operation" title="Localiser" action="location" id="${operationInstance.id}"><img
                                src="${assetPath(src: 'location.png')}"
                                alt="GPS"/></g:link>
                    </g:if>
                    <g:link title="Editer" action="edit" id="${operationInstance.id}"><img
                            src="${assetPath(src: 'edit.png')}"
                            alt="Editer"/></g:link>
                </td>

            </tr>
        </g:each>
        <tr>
            <td colspan="7">&nbsp;</td>
            <td class="tdright important">
                <g:if test="${operations}">
                    = <g:formatNumber number="${finalAmount}" format="###,###.##"/> €
                </g:if>
                <g:else>
                    = <g:formatNumber number="${accountAmount}" format="###,###.##"/> €
                </g:else>
            </td>
            <td>&nbsp;</td>
        </tr>
        </tbody>
    </table>
</div>

<g:render template="monthpagination"/>
