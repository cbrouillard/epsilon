<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="main">
  <g:set var="entityName" value="${message(code: 'wish.label', default: 'souhait')}" />
  <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des futurs achats</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau futur achat</g:link></span>
  </div>
  <div class="body">
    <h1>Créer un nouveau futur achat</h1>
    <g:if test="${flash.message}">
      <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${wishInstance}">
      <div class="errors">
        <g:renderErrors bean="${wishInstance}" as="list" />
      </div>
      
    </g:hasErrors>
    <div class="dialog">
      <g:form action="save" >
        <g:render template="form"/>
        <fieldset class="buttons">
          <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
        </fieldset>
      </g:form>
    </div>
  </div>
</body>
</html>
