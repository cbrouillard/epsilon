<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="main">
  <g:set var="entityName" value="${message(code: 'wish.label', default: 'Wish')}" />
  <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des futurs achats</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau futur achat</g:link></span>
  </div>
  <div id="edit-wish" class="body" role="main">
    <h1>Editer un souhait d'achat</h1>
    <g:if test="${flash.message}">
      <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${wishInstance}">
      <ul class="errors" role="alert">
        <g:eachError bean="${wishInstance}" var="error">
          <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
        </g:eachError>
      </ul>
    </g:hasErrors>
    <div class="dialog">
      
    <g:form method="post" >
      <g:hiddenField name="id" value="${wishInstance?.id}" />
      <g:hiddenField name="version" value="${wishInstance?.version}" />
      
        <g:render template="form"/>
     
      <fieldset class="buttons">
        <g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
      </fieldset>
    </g:form>
      
    </div>
        
  </div>
</body>
</html>
