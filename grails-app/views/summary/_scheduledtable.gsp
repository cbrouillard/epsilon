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
<table class="${cssClass} table table-striped table-hover">
    <tbody>
    <g:set var="actualMonth" value="${scheduleds ? scheduleds.get(0).dateApplication.getMonth() + 1 : 0}"/>
    <g:set var="prev" value="${actualMonth}"/>
    <g:set var="amount" value="${0}"/>

    <g:if test="${scheduleds}">
        <tr>
            <td colspan="5" class="centered">
                <g:message code="month.real.${actualMonth}"/> <g:formatDate format="yyyy"
                                                                            date="${scheduleds.get(0).dateApplication}"/>
            </td>
        </tr>
    </g:if>

    <g:each in="${scheduleds}" status="i" var="scheduled">

        <g:set var="actualMonth" value="${scheduled.dateApplication.getMonth() + 1}"/>

        <g:if test="${actualMonth != prev}">
            <tr class="important">
                <td colspan="3" class="tdright fixedsize">= <g:formatNumber number="${amount}"
                                                                            format="###,###.##"/> €</td>
                <td class="tdright fixedsize">&nbsp;</td>

                <g:set var="amount" value="${0}"/>
                <g:set var="prev" value="${actualMonth}"/>
            </tr>
            <tr>
                <td colspan="5" class="centered">
                    <g:message code="month.real.${actualMonth}"/> <g:formatDate format="yyyy"
                                                                                date="${scheduled.dateApplication}"/>
                </td>
            </tr>
        </g:if>

        <tr>
            <td class="principal text-nowrap">
                <span class="badge"><g:if test="${scheduled.type.sign?.equals("-")}"><img
                        src="${assetPath(src: 'depense.png')}" alt="Dépense" width="16px" height="16px"/></g:if>
                    <g:else><img src="${assetPath(src: 'revenue.png')}" alt="Revenu" width="16px"
                                 height="16px"/></g:else></span>
                ${scheduled.name}
            </td>
            <td class="tdcenter dayofmonth"><small data-toggle="tooltip" data-placement="bottom" title="<g:formatDate format="E dd MM yyyy"
                    date="${scheduled.dateApplication}"/>"><g:formatDate formatName="date.format.onlyday"
                                                                         date="${scheduled.dateApplication}"/></small>
            </td>
            <td class="tdright text-nowrap"><g:formatNumber number="${scheduled.amount}" format="###,###.##"/> €</td>
            <td class="tdright littlefixedsize">
                <g:if test="${scheduled.automatic}">
                    <img src="${assetPath(src: 'time.png')}" alt="Automatique"/>
                </g:if>

                <g:if test="${(!filterAutomatic && !scheduled.automatic) || (forceActionDisplay)}">
                    <g:link controller="scheduled" action="apply" id="${scheduled.id}"
                            title="${message(code: "scheduled.apply")}">
                        <img src="${assetPath(src: 'enter.png')}"/>
                    </g:link>
                    <g:link controller="scheduled" action="jump" id="${scheduled.id}"
                            title="${message(code: "scheduled.ignore")}">
                        <img src="${assetPath(src: 'jump.png')}"/>
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
            <td colspan="3" class="tdright fixedsize">= <g:formatNumber number="${amount}" format="###,###.##"/> €</td>
            <td class="tdright fixedsize">&nbsp;</td>
            <g:set var="amount" value="${0}"/>
        </tr>
    </g:if>
    </tbody>
</table>
