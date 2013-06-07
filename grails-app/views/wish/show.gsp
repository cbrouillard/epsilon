<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="popup">
</head>

<body>
<g:if test="${flash.message}">
    <div class="alert alert-info">${flash.message}</div>
</g:if>

<dl class="dl-horizontal">
    <dt><g:message code="wish.id.label" default="Id"/></dt>
    <dd>${fieldValue(bean: wishInstance, field: "id")}</dd>

    <dt><g:message code="wish.name.label" default="Name"/></dt>
    <dd>${fieldValue(bean: wishInstance, field: "name")}</dd>

</dl>


<div class="modal-footer">
    <g:form>
        <g:hiddenField name="id" value="${wishInstance?.id}"/>
        <span
                class="button"><g:actionSubmit class="edit btn btn-primary" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
        <span class="button"><g:actionSubmit class="delete btn btn-danger" action="delete"
                                             value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                             onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
    </g:form>
</div>
</body>
</html>
