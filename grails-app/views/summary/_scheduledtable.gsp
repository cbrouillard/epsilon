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
<table class="${cssClass} table table-striped">
    <tbody>
    <g:set var="actualMonth" value="${scheduleds ? scheduleds.get(0).dateApplication.getMonth() + 1 : 0}"/>
    <g:set var="prev" value="${actualMonth}"/>
    <g:set var="amount" value="${0}"/>

    <tr>
        <td colspan="5" class="centered">
            <g:message code="month.real.${actualMonth}"/>
        </td>
    </tr>

    <g:each in="${scheduleds}" status="i" var="scheduled">

        <g:set var="actualMonth" value="${scheduled.dateApplication.getMonth() + 1}"/>

        <g:if test="${actualMonth != prev}">
            <tr class="important">
                <td colspan="2">Reste en dépense</td>
                <td class="tdright fixedsize">= <g:formatNumber number="${amount}" format="0.##"/> €</td>
                <td class="tdright fixedsize">&nbsp;</td>

                <g:set var="amount" value="${0}"/>
                <g:set var="prev" value="${actualMonth}"/>
            </tr>
            <tr>
                <td colspan="5" class="centered">
                    <g:message code="month.real.${actualMonth}"/>
                </td>
            </tr>
        </g:if>

        <tr>
            <td class="principal">
                <g:if test="${scheduled.type.sign.equals("-")}">
                </g:if>
                <g:else>

                </g:else>

                ${scheduled.name}</td>
            <td><g:formatDate date="${scheduled.dateApplication}"/></td>
            <td class="tdright fixedsize"><g:formatNumber number="${scheduled.amount}" format="0.##"/> €</td>
            <td class="tdright fixedsize">
                <g:if test="${scheduled.automatic}">
                    <img src="${resource(dir: 'img', file: 'time.png')}" alt="Automatique"/>
                </g:if>

                <g:if test="${(!filterAutomatic && !scheduled.automatic) || (forceActionDisplay)}">
                    <g:link controller="scheduled" action="apply" id="${scheduled.id}" title="Appliquer l'échéance">
                        <img src="${resource(dir: 'img', file: 'enter.png')}"/>
                    </g:link>
                    <g:link controller="scheduled" action="jump" id="${scheduled.id}" title="Sauter l'échéance">
                        <img src="${resource(dir: 'img', file: 'jump.png')}"/>
                    </g:link>
                </g:if>
            </td>
        </tr>

        <g:if test="${scheduled.type.sign.equals("-")}">
            <g:set var="amount" value="${amount + scheduled.amount}"/>
        </g:if>

    </g:each>
    <g:if test="${scheduleds}">
        <tr class="important">
            <td colspan="2">Reste en dépense</td>
            <td class="tdright fixedsize">= <g:formatNumber number="${amount}" format="0.##"/> €</td>
            <td class="tdright fixedsize">&nbsp;</td>
            <g:set var="amount" value="${0}"/>
        </tr>
    </g:if>
    </tbody>
</table>
