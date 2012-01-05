
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
    <h1>Opérations pour le budget "${budget.name}"</h1>

    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">

      <g:set var="operations" value="${budget.operations}"/>
      <table>
        <thead>
          <tr>
            <th>Date</th>
            <th>Tiers</th>
            <th>Catégorie</th>
            <th>Paiement</th>
            <th>Total</th>
          </tr>
        </thead>
        <tbody>
        <g:set var="total" value="${0D}" />
        <g:each in="${operations}" status="i" var="operation">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td><g:formatDate date="${operation.dateApplication}" /></td>
          <td>${operation.tiers.name}</td>
          <td>${operation.category.name}</td>
          <td class="tdright"><g:formatNumber number="${operation?.amount}" format="0.##" /> €
          <g:set var="total" value="${total + operation?.amount}" />
          </td>

          <td class="tdright"><g:formatNumber number="${total}" format="0.##" /> €</td>
          </tr>
        </g:each>
        </tbody>
      </table>

    </div>

  </div>
</body>
</html>
