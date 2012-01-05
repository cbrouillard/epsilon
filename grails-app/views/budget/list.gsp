
<%@ page import="com.headbangers.epsilon.Budget" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'budget.label', default: 'Budget')}" />
  <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des budgets</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau budget</g:link></span>
  </div>
  <div class="body">
    <h1>Liste des budgets</h1>
    
    <div class="help">
      Les budgets permettent de gérer des plafonds de dépenses sur certaines catégories.<br/><br/>
      Chaque "budget" est "branché" sur une ou plusieurs catégories de dépenses.<br/>Lorsqu'un retrait
      est enregistré avec l'une des catégories affectée à un budget, ce dernier voit son "montant
      utilisé" augmenter.<br/><br/>
      Tant que le budget est respecté, la valeur du "montant utilisé" s'affichera en <font style="color:green;">VERT</font><br/>
      Si vous flirtez avec la valeur maximale, alors l'affichage se notera en <font style="color:orange;">ORANGE</font><br/>
      Enfin, en cas de non respect de votre budget, l'affichage sera sévèrement colorié en <font style="color:red; background-color: #000;">ROUGE SUR FOND NOIR</font>
    </div>
    
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
      <table>
        <thead>
          <tr>
        <g:sortableColumn property="name" title="${message(code: 'budget.name.label', default: 'Name')}" />
        <th>Montant utilisé</th>
        <g:sortableColumn property="amount" title="${message(code: 'budget.amount.label', default: 'Amount')}" />
        <th><g:message code="budget.categories.label" default="Categories" /></th>                        
        <g:sortableColumn property="note" title="${message(code: 'budget.note.label', default: 'Note')}" />
        <g:sortableColumn property="lastUpdated" title="${message(code: 'budget.lastUpdated.label', default: 'Last Updated')}" />
        <th>Actions</th>
        <g:sortableColumn property="active" title="${message(code: 'budget.active.label', default: 'Active')}" />
        </tr>
        </thead>
        <tbody>
        <g:each in="${budgetInstanceList}" status="i" var="budgetInstance">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

            <td>${fieldValue(bean: budgetInstance, field: "name")}</td>

          <g:set var="currentSold" value="${budgetInstance.currentMonthOperationsSum}" />
          
          <g:if test="${currentSold < budgetInstance.amount}">
            <td class="budget-OK">
          </g:if>
          <g:elseif test="${currentSold >= budgetInstance.amount - 1 && currentSold <= budgetInstance.amount + 1}">
            <td class="budget-REACHED">
          </g:elseif>
          <g:elseif test="${currentSold > budgetInstance.amount}">
            <td class="budget-KO">
          </g:elseif>
          <g:else>
            <td class="budget">
          </g:else>
           <g:formatNumber number="${currentSold}" format="0.##" /> €</td>
          
          <td>${fieldValue(bean: budgetInstance, field: "amount")} €</td>
          <td>
            <ul>
              <g:each in="${budgetInstance.attachedCategories}" status="c" var="category">
                <li>${category.name}</li>
              </g:each>                
            </ul>
          </td>
          <td class="limitedSize">${fieldValue(bean: budgetInstance, field: "note")}</td>
          <td><g:formatDate date="${budgetInstance.lastUpdated}" /></td>
          <td class="center">
          <g:link title="Afficher les détails" action="show" id="${budgetInstance.id}" class="popup" rel="popup"><img src="${resource(dir:'img', file:'details.png')}" alt="Détails"/></g:link>
          <g:link title="Editer" action="edit" id="${budgetInstance.id}"><img src="${resource(dir:'img', file:'edit.png')}" alt="Editer"/></g:link>
          <g:link title="Afficher le registre" controller="budget" action="operations" params="[budget:budgetInstance.id]"><img src="${resource(dir:'img', file:'operation.png')}"/></g:link>
          </td>
          <td class="center">
            <div id="budget${budgetInstance.id}-activation">
              <g:render template="activateactions" model="[budget:budgetInstance]"/>
            </div>
          </td>
          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
    <div class="paginateButtons">
      <g:paginate total="${budgetInstanceTotal}" />
    </div>
  </div>
</body>
</html>
