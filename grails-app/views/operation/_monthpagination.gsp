%{--<ul class="pagination pull-right">
    <li>
        <a href="#top"><span class="glyphicon glyphicon-arrow-up"/></a>
    </li>
    <li>
        <a href="#bottom"><span class="glyphicon glyphicon-arrow-down"/></a>
    </li>
</ul>--}%
<ul class="pagination">
    <li><g:link controller="operation" action="list"
                params="[account: selected?.id, byMonth: byMonth ? byMonth - 1 : currentMonth ? -1 : 0]"
                title="Mois précédent"><< Mois précédent</g:link>
    </li>
    <li class="disabled">
        <a href="#">
            <g:message code="month.${byMonth ? byMonth : currentMonth}"/>
        </a>
    </li>
    <li>
        <g:link controller="operation" action="list"
                params="[account: selected.id, byMonth: byMonth ? byMonth + 1 : currentMonth ? +1 : 0]"
                title="Mois suivant">Mois suivant >></g:link>
    </li>
</ul>

