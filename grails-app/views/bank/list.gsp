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
<%@ page import="com.headbangers.epsilon.Bank" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'bank.label', default: 'Bank')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1><g:message code="bank.list"/> <small><g:message code="bank.list.explanation"/></small> <g:link controller="bank"
                                                                                                       action="create"
                                                                                                       class="btn btn-success"><img
                src="${assetPath(src: 'bank.png')}"
                alt=">"/> <g:message code="bank.create"/></g:link></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:if test="${!bankInstanceList}">
            <div class="alert alert-danger"><g:message code="no.banks.title"/></div>
        </g:if>
        <g:else>
            <g:if test="${flash.message}">
                <div class="alert alert-info">${flash.message}</div>
            </g:if>

            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>

                        <g:sortableColumn property="name" title="${message(code: 'bank.name.label', default: 'Name')}"/>

                        <g:sortableColumn property="description"
                                          title="${message(code: 'bank.description.label', default: 'Description')}"/>

                        <g:sortableColumn property="dateCreated"
                                          title="${message(code: 'bank.dateCreated.label', default: 'Date Created')}"/>

                        <g:sortableColumn property="lastUpdated"
                                          title="${message(code: 'bank.lastUpdated.label', default: 'Last Updated')}"/>

                        <th class="text-right">Actions</th>

                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${bankInstanceList}" status="i" var="bankInstance">
                        <tr>

                            <td>${fieldValue(bean: bankInstance, field: "name")}</td>

                            <td>${fieldValue(bean: bankInstance, field: "description")}</td>

                            <td><g:formatDate date="${bankInstance.dateCreated}"/></td>

                            <td><g:formatDate date="${bankInstance.lastUpdated}"/></td>

                            <td class="text-right">
                                <g:if test="${bankInstance.url}">
                                    <a href="${bankInstance.url}" target="_blank">
                                        <img src="${assetPath(src: 'external.png')}"
                                             data-toggle="tooltip" data-placement="left"
                                             title="${message(code: 'bank.website')}"/></a>
                                </g:if>
                                <g:link title="Editer" action="edit" id="${bankInstance.id}"><img
                                        src="${assetPath(src: 'edit.png')}"/></g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

            <div class="pagination pull-right">
                <g:paginate total="${bankInstanceTotal}"/>
            </div>

            <div class="clearfix">&nbsp;</div>
        </g:else>

    </div>
</div>

<div class="modal fade" id="modalWindow_show" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        </div>
    </div>
</div>

</body>
</html>
