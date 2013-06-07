<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'wish.label', default: 'souhait')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="container">
    <div class="row">
        <div class="span12">
            <div>
                <h1>Créer un nouveau souhait</h1>
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
                    <div class="alert alert-error">
                        <g:renderErrors bean="${wishInstance}" as="list"/>
                    </div>
                </g:hasErrors>

                <g:form action="save" class="form-horizontal">
                    <g:render template="form"/>

                    <div class="control-group">
                        <div class="controls">
                            <g:submitButton name="create" class="save btn btn-primary"
                                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                        </div>
                    </div>
                </g:form>

            </div>
        </div>
    </div>

</div>

</body>
</html>
