<table class="${cssClass}">
  <tbody>
  <g:each in="${scheduleds}" status="i" var="scheduled">
    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
      <td class="principal">${scheduled.name}</td>
      <td><g:formatDate date="${scheduled.dateApplication}" /></td>
      <td class="tdright fixedsize"><g:formatNumber number="${scheduled.amount}" format="0.##" /> €</td>
      <td class="tdright fixedsize">
        <g:if test="${scheduled.automatic}">
          <img src="${resource(dir:'img', file:'time.png')}" alt="Automatique"/>
        </g:if>

    <g:if test="${!filterAutomatic && !scheduled.automatic}">
    <g:link controller="scheduled" action="apply" id="${scheduled.id}" title="Appliquer l'échéance">
      <img src="${resource(dir:'img', file:'enter.png')}"/>
    </g:link>
    <g:link controller="scheduled" action="jump" id="${scheduled.id}" title="Sauter l'échéance">
      <img src="${resource(dir:'img', file:'jump.png')}"/>
    </g:link>
    </g:if>
    </td>
    </tr>
  </g:each>
</tbody>
</table>
