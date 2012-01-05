<%@ page import="com.headbangers.epsilon.Tiers" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title>Epsilon</title>
  </head>
  <body>
    <div class="undernav">

    </div>
    <div class="body">


      <div class="accounts list">
        <g:if test="${accounts}">
          <h1>Vos comptes</h1>
          <table class="simple">
            <tbody>
            <g:set var="accountAmount" value="${0D}" />
            <g:each in="${accounts}" status="i" var="account">
              <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td class="principal">${account.name}</td>
                <td class="tdright fixedsize"><g:formatNumber number="${account.sold}" format="0.##" /> €</td>
              <td class="tdright fixedsize">
              <g:link controller="operation" action="list" params="[account:account.id]" title="Afficher le registre">
                <img src="${resource(dir:'img', file:'operation.png')}"/>
              </g:link>
              </td>
              </tr>

              <g:set var="accountAmount" value="${accountAmount + account.sold}" />
            </g:each>
            <g:if test="${accounts}">
              <tr class="important">
                <td class="principal">&nbsp;</td>
                <td class="tdright fixedsize">= <g:formatNumber number="${accountAmount}" format="0.##" /> €</td>
              <td class="tdright fixedsize">&nbsp;</td>
              </tr>
            </g:if>
            </tbody>
          </table>
        </g:if>
        <g:else>
          <h1 class="red">Aucun compte enregistré.</h1>
          <div class="help">
            Il semble que ce soit la première fois que vous accédez à Epsilon.<br/>
            Avant toute chose, il va falloir créer un "compte". <br/><br/>Un compte est obligatoirement 
            lié à un "établissement". <br/>Commencez donc par <g:link controller="bank" action="create" >créer un nouvel établissement bancaire</g:link> (ex: Crédit Agricole, BNP, ...).<br/><br/>
            Une fois l'établissement enregistré, <g:link controller="account" action="create">ajoutez simplement un nouveau compte</g:link> et commencez à utiliser Epsilon !
          </div>
          <ul>
            <li><g:link controller="bank" action="create"><img src="${resource(dir:'img', file:'bank.png')}" alt=">"/> Créer un nouvel établissement</g:link></li>
            <li><g:link controller="account" action="create"><img src="${resource(dir:'img', file:'account.png')}" alt=">"/> Créer un nouveau compte</g:link></li>
          </ul>
        </g:else>
      </div>

      <g:if test="${budgets}">
        <div class="budgets list">
          <h1>Les budgets</h1>
          <table class="simple">
            <tbody>
            <g:set var="budgetAmount" value="${0D}" />
            <g:set var="budgetUsedAmount" value="${0D}" />
            <g:each in="${budgets}" var="budget" status="b">
              <tr class="${(b % 2) == 0 ? 'odd' : 'even'}">
                <td class="principal">${budget.name}</td>

              <g:set var="currentSold" value="${budget.currentMonthOperationsSum}" />

              <g:if test="${currentSold < budget.amount}">
                <td class="tdright budget-OK">
              </g:if>
              <g:elseif test="${currentSold >= budget.amount - 1 && currentSold <= budget.amount + 1}">
                <td class="tdright  budget-REACHED">
              </g:elseif>
              <g:elseif test="${currentSold > budget.amount}">
                <td class="tdright budget-KO">
              </g:elseif>
              <g:else>
                <td class="tdright budget">
              </g:else>
              <g:formatNumber number="${currentSold}" format="0.##" /> / <g:formatNumber number="${budget.amount}" format="0.##" /> €</td>
              <td class="tdright fixedsize">
              <g:link title="Afficher le registre" controller="budget" action="operations" params="[budget:budget.id]"><img src="${resource(dir:'img', file:'operation.png')}"/></g:link>
              </td>
              <g:set var="budgetAmount" value="${budgetAmount + budget.amount}" />
              <g:set var="budgetUsedAmount" value="${budgetUsedAmount + currentSold}" />
              </tr>
            </g:each>
            <tr class="important">
              <td class="principal">&nbsp;</td>
              <td class="tdright">= <g:formatNumber number="${budgetUsedAmount}" format="0.##" /> / <g:formatNumber number="${budgetAmount}" format="0.##" /> €</td>
            <td class="tdright fixedsize">&nbsp;</td>
            </tr>
            </tbody>
          </table>
        </div>
      </g:if>

      <g:if test="${lates}">
        <div class="scheduled list">
          <h1 class="red">Paiements en retard</h1>
          <g:render template="scheduledtable" model="[cssClass:'red', scheduleds:lates]"/>
        </div>
      </g:if>

      <g:if test="${today}">
        <div class="scheduled list">
          <h1>Paiements du jour</h1>
          <div class="help">Les paiements gérés automatiquement sont marqués d'une horloge et n'ont pas besoin
            d'être validés manuellement: le système s'en charge.</div>
          <g:render template="scheduledtable" model="[cssClass:'green', scheduleds:today, filterAutomatic:false]"/>
        </div>
      </g:if>

      <g:if test="${future}">
        <div class="scheduled list">
          <h1>Paiements futurs</h1>
          <g:render template="scheduledtable" model="[cssClass:'blue', scheduleds:future]"/>
        </div>
      </g:if>
      <!--
      <div class="payments list">
        <h1>Recettes et dépenses du mois en cours</h1>
        <table class="simple">
          <tbody>
            <tr class="odd">
              <td class="principal">Dépense</td>
              <td class="tdright fixedsize"><g:formatNumber number="${depense}" format="0.##" /> €</td>
            </tr>
            <tr class="even">
              <td class="principal">Revenu</td>
              <td class="tdright fixedsize"><g:formatNumber number="${revenu}" format="0.##" /> €</td>
            </tr>
            <tr class="important">
              <td class="principal">&nbsp;</td>
              <td class="tdright fixedsize">= <g:formatNumber number="${revenu - depense}" format="0.##" /> €</td>
            </tr>
          </tbody>
        </table>
      </div>

      -->
      <g:if test="${accounts}">
        <div id="mobile-activation" class="help">
          <g:render template="mobile" model="[person:person]"/>
        </div>
      </g:if>
    </div>


  </body>
</html>
