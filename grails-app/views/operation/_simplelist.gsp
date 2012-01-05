<div class="list">
  <table>
    <thead>
      <tr>
        <th>Date</th>
        <th>Catégorie</th>
        <th>Paiement</th>
        <th>Dépôt</th>
        <th>Total</th>
      </tr>
    </thead>
    <tbody>
    <g:set var="total" value="${0D}" />
    <g:each in="${operations}" status="i" var="operation">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td><g:formatDate date="${operation.dateApplication}" /></td>
      <td>${operation.category.name}</td>
      <td class="tdright">
      <g:if test="${operation?.type == com.headbangers.epsilon.OperationType.RETRAIT || operation?.type == com.headbangers.epsilon.OperationType.VIREMENT_MOINS}">
<g:formatNumber number="${operation?.amount}" format="0.##" /> €
        <g:set var="total" value="${total - operation?.amount}" />
      </g:if>
      </td>
      <td class="tdright">
      <g:if test="${operation?.type == com.headbangers.epsilon.OperationType.DEPOT || operation?.type == com.headbangers.epsilon.OperationType.VIREMENT_PLUS}">
<g:formatNumber number="${operation?.amount}" format="0.##" /> €
        <g:set var="total" value="${total + operation?.amount}" />
      </g:if>
      </td>
      <td class="tdright"><g:formatNumber number="${total}" format="0.##" /> €</td>
      </tr>
    </g:each>
    </tbody>
  </table>
</div>