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