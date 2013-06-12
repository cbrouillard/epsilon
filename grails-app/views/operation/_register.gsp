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
%{--<export:formats action="export" params="[account: selected?.id, month: byMonth ? byMonth : currentMonth]"/>--}%

%{--<div class="pull-left">--}%
%{--<g:if test="${selected}">--}%
%{--<g:form action="list" method="get" class="form-inline">--}%
%{--<g:select optionValue="${{it.name + ' = ' + formatNumber('number': it.getSold(), 'format': '0.##') + '€'}}" name="account"--}%
%{--from="${accounts}"--}%
%{--optionKey="id" value="${selected?.id}" onChange="this.form.submit();"/>--}%
%{--</g:form>--}%
%{--</g:if>--}%
%{--</div>--}%
<g:render template="monthpagination"/>
<table class="table table-striped table-hover table-condensed">
    <thead>
    <tr>
        <th>N°</th>
        <th>${message(code: 'operation.dateApplication.label', default: 'Date Application')}</th>
        <th>Détails</th>
        <th>Pointée</th>
        <th>Paiement</th>
        <th>Dépôt</th>
        <th>Solde</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>

    <g:if test="${byMonth}">
        <g:set var="operations" value="${selected?.lastOperationsByMonth(byMonth ? byMonth : 0)}"/>
    </g:if>
    <g:else>
        <g:set var="operations" value="${selected?.lastOperationsByMonth(currentMonth ? currentMonth : 0)}"/>
    </g:else>

    <g:set var="accountAmount" value="${selected?.lastSnapshot?.amount}"/>
    <g:each in="${operations}" status="i" var="operationInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td>${i + 1}</td>
            <td><g:formatDate date="${operationInstance.dateApplication}"/></td>
            <td>${fieldValue(bean: operationInstance, field: "category.name")} - ${fieldValue(bean: operationInstance, field: "tiers.name")}</td>
            <td class="tdcenter">
                <div id="operation${operationInstance.id}-point">
                    <g:render template="pointactions" model="[operation: operationInstance]"/>
                </div>
            </td>

            <td class="tdright">
                <g:if test="${operationInstance?.type == com.headbangers.epsilon.OperationType.RETRAIT || operationInstance?.type == com.headbangers.epsilon.OperationType.VIREMENT_MOINS}">
                    <b><g:formatNumber number="${operationInstance?.amount}" format="0.##"/> €</b>
                    <g:set var="accountAmount" value="${accountAmount - operationInstance?.amount}"/>
                </g:if>
            </td>
            <td class="tdright">
                <g:if test="${operationInstance?.type == com.headbangers.epsilon.OperationType.DEPOT || operationInstance?.type == com.headbangers.epsilon.OperationType.VIREMENT_PLUS}">
                    <b><g:formatNumber number="${operationInstance?.amount}" format="0.##"/> €</b>
                    <g:set var="accountAmount" value="${accountAmount + operationInstance?.amount}"/>
                </g:if>
            </td>

            <td class="tdright">
                <g:formatNumber number="${accountAmount}" format="0.##"/> €
            </td>

            <td class="tdcenter">
                <g:link title="Afficher les détails" action="show" id="${operationInstance.id}" data-toggle="modal" data-target="#modalWindow_show"><img
                        src="${resource(dir: 'img', file: 'details.png')}" alt="Détails"/></g:link>
                <g:link title="Editer" action="edit" id="${operationInstance.id}"><img src="${resource(dir: 'img', file: 'edit.png')}"
                                                                                       alt="Editer"/></g:link>
            </td>

        </tr>
    </g:each>
    </tbody>
</table>

<g:render template="monthpagination"/>

