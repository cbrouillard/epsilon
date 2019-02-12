<table class="table table-striped table-hover">
    <tbody>
    <g:set var="pinnedAmount" value="${0D}"/>
    <g:each in="${pinned}" var="onepine" status="c">

        <g:set var="currentSold" value="${onepine.currentMonthOperationsSum}"/>

        <tr>
            <td class="principal text-nowrap"><span class="label"
                                        style="background-color: ${onepine.color};">&nbsp;</span> ${onepine.name}
            </td>
            <td class="tdright text-nowrap">
                <span class="label label-default">
                    <g:formatNumber number="${currentSold}" format="###,###.##"/> €
                </span>
            </td>
            <td class="tdright">
                <g:link title="Afficher le registre"
                        controller="${onepine.class.canonicalName.contains("Tiers") ? "tiers" :"category"}"
                        action="operations"
                        params="[id: onepine.id]"><img
                        src="${assetPath(src: 'stats.png')}"/></g:link>
            </td>
        </tr>
        <g:set var="pinnedAmount" value="${pinnedAmount + currentSold}"/>
    </g:each>
    <tr class="important">
        <td class="principal">&nbsp;</td>
        <td class="tdright">= <g:formatNumber number="${pinnedAmount}"
                                              format="###,###.##"/> €</td>
        <td class="tdright">&nbsp;</td>
    </tr>
    </tbody>
</table>