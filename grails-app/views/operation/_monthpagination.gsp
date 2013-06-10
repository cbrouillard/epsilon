<div class="pagination text-right">
    <ul>
        <li><g:link controller="operation" action="list" params="[account: selected?.id, byMonth: byMonth ? byMonth - 1 : currentMonth ? -1 : 0]"
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

    <ul>
        <li>
            <a href="#top"><i class="icon-arrow-up"></i></a>
        </li>
        <li>
            <a href="#bottom"><i class="icon-arrow-down"></i></a>
        </li>
    </ul>
</div>
