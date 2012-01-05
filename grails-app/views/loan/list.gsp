
<%@ page import="com.headbangers.epsilon.Loan" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
  <title>Liste des prêts</title>
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des prêts</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau prêt</g:link></span>
  </div>
  <div class="body">
    <h1>Liste des prêts</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
      <table>
        <thead>
          <tr>

        <g:sortableColumn property="type" title="${message(code: 'loan.type.label', default: 'Type')}" />

        <th><g:message code="loan.tiers.label" default="Tiers" /></th>

        <th><g:message code="loan.owner.label" default="Owner" /></th>

        <g:sortableColumn property="amount" title="${message(code: 'loan.amount.label', default: 'Amount')}" />

        <th><g:message code="loan.scheduled.label" default="Scheduled" /></th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${loanInstanceList}" status="i" var="loanInstance">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td>${fieldValue(bean: loanInstance, field: "type")}</td>

          <td>${fieldValue(bean: loanInstance, field: "tiers")}</td>

          <td>${fieldValue(bean: loanInstance, field: "owner")}</td>

          <td>${fieldValue(bean: loanInstance, field: "amount")}</td>

          <td>${fieldValue(bean: loanInstance, field: "scheduled")}</td>

          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
    <div class="paginateButtons">
      <g:paginate total="${loanInstanceTotal}" />
    </div>
  </div>
</body>
</html>
