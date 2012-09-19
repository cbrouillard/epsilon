
<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="popup">
  <g:set var="entityName" value="${message(code: 'wish.label', default: 'Wish')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
  <div id="show-wish" class="content scaffold-show" role="main">
    <h1>Détails d'un futur achat</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
      <table>
        <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="wish.id.label" default="Id" /></td>

        <td valign="top" class="value">${fieldValue(bean: wishInstance, field: "id")}</td>

        </tr>
        
        <tr class="prop">
            <td valign="top" class="name"><g:message code="wish.name.label" default="Name" /></td>

        <td valign="top" class="value">${fieldValue(bean: wishInstance, field: "name")}</td>

        </tr>
        
        </tbody>
      </table>
    </div>

    <div class="buttons">
      <g:form>
        <g:hiddenField name="id" value="${wishInstance?.id}" />
        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
      </g:form>
    </div>
  </div>
</body>
</html>
