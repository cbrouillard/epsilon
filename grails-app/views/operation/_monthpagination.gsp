%{--<ul class="pagination pull-right">
    <li>
        <a href="#top"><span class="glyphicon glyphicon-arrow-up"/></a>
    </li>
    <li>
        <a href="#bottom"><span class="glyphicon glyphicon-arrow-down"/></a>
    </li>
</ul>--}%
<ul class="pagination">
    <g:if test="${byMonth}">
        <li><g:link controller="operation" action="list"
                    params="[account: selected?.id, byMonth: byMonth != null ? byMonth - 1 : currentMonth ? -1 : 0]"
                    title="Mois précédent"><g:message code="previous.month"/></g:link>
        </li>
    </g:if>
    <li class="disabled">
        <a href="#">
            <g:message code="month.${byMonth != null ? byMonth : currentMonth}"/>
        </a>
    </li>
    <g:if test="${byMonth < currentMonth}">
        <li>
            <g:link controller="operation" action="list"
                    params="[account: selected.id, byMonth: byMonth != null ? byMonth + 1 : currentMonth ? +1 : 0]"
                    title="Mois suivant"><g:message code="next.month"/></g:link>
        </li>
    </g:if>
    <g:if test="${byMonth != currentMonth}">
        <li>
            <g:link controller="operation" action="list"
                    params="[account: selected.id]"
                    title="Reset"><g:message code="reset"/></g:link>
        </li>
    </g:if>
</ul>

