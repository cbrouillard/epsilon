<%@ page import="com.headbangers.epsilon.Account" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'threshold.label', default: 'Threshold')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="col-sm-12">
    <h1>Créer un nouveau seuil</h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:hasErrors bean="${threshold}">
            <div class="alert alert-danger">
                <g:renderErrors bean="${threshold}" as="list"/>
            </div>
        </g:hasErrors>


        <g:form action="save" method="post" class="form-horizontal">
            <fieldset class="form">
                <div id="formContainer">

                    <g:render template="form"/>

                </div>
            </fieldset>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">

                    <button type="submit" class="btn btn-success">
                        <span class="glyphicon glyphicon-save"></span> ${message(code: 'default.button.create.label', default: 'Save')}
                    </button>

                </div>
            </div>
        </g:form>
    </div>
</div>

</body>
</html>