<!--
/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1><g:message code="document.${type.toString().toLowerCase()}.list"/> <small><g:message
            code="document.${type.toString().toLowerCase()}.list.explanation"/></small>
        <g:if test="${type != 'mixed'}">
            <g:link controller="document" action="create" params="[type: type]" class="btn btn-success"><img
                    src="${resource(dir: 'img', file: 'invoice.png')}"
                    alt=">"/> <g:message code="document.${type.toString().toLowerCase()}.create"/></g:link>
        </g:if>
    </h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <div class="text-right pull-right">
            <g:render template="/generic/search" model="[action: 'invoices']"/>
        </div>

        <g:render template="/generic/listsize" model="[wantedSizes: [8, 20, 40, 80], action: 'invoices']"/>
        <div class="clearfix"></div>
        <hr/>

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:if test="${!documents}">
            <div class="alert alert-warning"><g:message code="no.documents.title"/></div>
        </g:if>
        <g:else>
            <g:each in="${documents}" var="document">
                <div class="col-lg-3 col-md-5 col-sm-5">
                    <g:render template="onedocument" model="[document: document, accounts: accounts]"/>
                </div>
            </g:each>

            <div class="clearfix">&nbsp;</div>
        </g:else>

    </div>

</div>

</body>
</html>