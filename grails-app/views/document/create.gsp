<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'document.label', default: 'document')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1><g:message code="document.${document.type.toString().toLowerCase()}.create"/></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <g:if test="${flash.message}">
        <div class="alert alert-info">${flash.message}</div>
    </g:if>

    <g:hasErrors bean="${document}">
        <div class="alert alert-danger">
            <g:renderErrors bean="${document}" as="list"/>
        </div>
    </g:hasErrors>

    <div class="around-border"><div class="clearfix">&nbsp;</div>
        <g:uploadForm action="save" class="form-horizontal">
            <g:hiddenField name="type" value="${document.type}"/>

            <div class="form-group">

                <label for="name" class="col-sm-2 control-label mandatory"><g:message
                        code="document.data.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-barcode"></span></span>
                        <input id="data" type="file" class="file form-control" name="data" data-show-preview="false"
                               data-show-upload="false" data-show-caption="true"
                               data-initial-caption="${message(code: 'document.choose.file')}"
                               data-allowed-file-extensions='${document.type.allowed}'>
                    </div>

                    <div class="help-block with-errors">
                        ${document.type.allowed}
                    </div>
                </div>
            </div>

            <div class="form-group ${hasErrors(bean: document, field: 'name', 'has-error')}">

                <label for="name" class="col-sm-2 control-label"><g:message
                        code="name"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-font"></span></span>
                        <g:textField name="name" value="${document.name}"
                                     class="form-control" autofocus=""/>
                    </div>

                    <div class="help-block with-errors">
                        <g:message code="document.name.help"/>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-success">
                        <span class="glyphicon glyphicon-save"></span> ${message(code: 'default.button.create.label', default: 'Save')}
                    </button>
                </div>
            </div>

        </g:uploadForm>
    </div>

</div>
</body>
</html>