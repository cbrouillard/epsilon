<export:formats action="export" params="[account:selected?.id, month:byMonth?byMonth:currentMonth]"/>

<div>
  <div id="month-bar" class="help">
    <g:link controller="operation" action="list" params="[account:selected?.id, byMonth:byMonth?byMonth-1:currentMonth?-1:0]" title="Mois précédent">
      << Mois précédent ||
    </g:link><b>
      <g:message code="month.${byMonth?byMonth:currentMonth}"/></b> || <g:link controller="operation" action="list" params="[account:selected.id, byMonth:byMonth?byMonth+1:currentMonth?+1:0]" title="Mois suivant">
      Mois suivant >>
    </g:link>
  </div>

  <div class="list register">
    <table>
      <thead>
        <tr>
          <th>N°</th>
      <g:sortableColumn property="dateApplication" title="${message(code: 'operation.dateApplication.label', default: 'Date Application')}" />
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
        <g:set var="operations" value="${selected?.lastOperationsByMonth(byMonth?byMonth:0)}"/>
      </g:if>
      <g:else>
        <g:set var="operations" value="${selected?.lastOperationsByMonth(currentMonth?currentMonth:0)}"/>
      </g:else>

      <g:set var="accountAmount" value="${selected?.lastSnapshot.amount}" />
      <g:each in="${operations}" status="i" var="operationInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>${i+1}</td>
          <td><g:formatDate date="${operationInstance.dateApplication}" /></td>
        <td>${fieldValue(bean: operationInstance, field: "category.name")} - ${fieldValue(bean: operationInstance, field: "tiers.name")}</td>
        <td class="tdcenter">
          <div id="operation${operationInstance.id}-point">
            <g:render template="pointactions" model="[operation:operationInstance]"/>
          </div>
        </td>

        <td class="tdright">
        <g:if test="${operationInstance?.type == com.headbangers.epsilon.OperationType.RETRAIT || operationInstance?.type == com.headbangers.epsilon.OperationType.VIREMENT_MOINS}">
          <g:formatNumber number="${operationInstance?.amount}" format="0.##" /> €
          <g:set var="accountAmount" value="${accountAmount - operationInstance?.amount}" />
        </g:if>
        </td>
        <td class="tdright">
        <g:if test="${operationInstance?.type == com.headbangers.epsilon.OperationType.DEPOT || operationInstance?.type == com.headbangers.epsilon.OperationType.VIREMENT_PLUS}">
          <g:formatNumber number="${operationInstance?.amount}" format="0.##" /> €
          <g:set var="accountAmount" value="${accountAmount + operationInstance?.amount}" />
        </g:if>
        </td>

        <td class="tdright">
        <g:formatNumber number="${accountAmount}" format="0.##" /> €
        </td>

        <td>
        <g:link title="Afficher les détails" action="show" id="${operationInstance.id}" class="popup" rel="popup"><img src="${resource(dir:'img', file:'details.png')}" alt="Détails"/></g:link>
        <g:link title="Editer" action="edit" id="${operationInstance.id}"><img src="${resource(dir:'img', file:'edit.png')}" alt="Editer"/></g:link>
        </td>

        </tr>
      </g:each>

      </tbody>
    </table>
  </div>
</div>
<div id="operations-creator"><a name="write-operation"> &nbsp;</a>
  <richui:tabView id="tabView">
    <richui:tabLabels>
      <g:if test="${tabToDisplay=='depot'}">
        <richui:tabLabel selected="true" title="Dépôt" />
      </g:if><g:else><richui:tabLabel  title="Dépôt" /></g:else>
      <g:if test="${tabToDisplay=='virement'}">
        <richui:tabLabel selected="true" title="Virement" />
      </g:if><g:else><richui:tabLabel  title="Virement" /></g:else>
      <g:if test="${!tabToDisplay || tabToDisplay=='retrait'}">
        <richui:tabLabel selected="true" title="Retrait" />
      </g:if><g:else><richui:tabLabel  title="Retrait" /></g:else>

    </richui:tabLabels>
    <richui:tabContents>

      <richui:tabContent>
        <g:render template="createform" model="[type:'depot', selected:selected]" />
      </richui:tabContent>

      <richui:tabContent>
        <g:render template="createvirement" model="[selected:selected]" />
      </richui:tabContent>

      <richui:tabContent>
        <g:render template="createform" model="[type:'retrait', selected:selected]" />
      </richui:tabContent>

    </richui:tabContents>
  </richui:tabView>

</div>
<div class="clean">&nbsp;</div>