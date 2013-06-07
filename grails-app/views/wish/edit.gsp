<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'wish.label', default: 'Wish')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>

<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Editer un souhait d'achat</h1>
                <hr/>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="span12">
            <div class="around-border">

                <g:if test="${flash.message}">
                    <div class="alert alert-info">${flash.message}</div>
                </g:if>

                <g:hasErrors bean="${wishInstance}">
                    <ul class="alert alert-error" role="alert">
                        <g:eachError bean="${wishInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                    error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>

                <g:form method="post" class="form-horizontal">
                    <g:hiddenField name="id" value="${wishInstance?.id}"/>
                    <g:hiddenField name="version" value="${wishInstance?.version}"/>

                    <g:render template="form"/>

                    <div class="control-group">
                        <div class="controls">
                            <g:actionSubmit class="save btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default:
                                    'Update')}"/>
                            <g:actionSubmit class="delete btn btn-danger" action="delete"
                                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                            formnovalidate=""
                                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                        </div>
                    </div>
                </g:form>

            </div>
        </div>
    </div>

</div>

<div id="edit-wish" class="body" role="main">
    <h1></h1>


    <div class="dialog">

    </div>

</div>
</body>
</html>
