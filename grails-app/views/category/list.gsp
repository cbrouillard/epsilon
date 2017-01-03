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
<%@ page import="com.headbangers.epsilon.Category" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1><g:message code="category.list"/> <small><g:message code="category.list.explanation"/></small> <g:link controller="category" action="create"
                                                                                class="btn btn-success"><img
                src="${resource(dir: 'img', file: 'category.png')}"
                alt=">"/> <g:message code="category.create"/></g:link></h1>

    <div class="alert alert-info">
        <g:message code="category.super.explanation"/>
    </div>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">


        <div class="text-right pull-right">
            <g:render template="/generic/search"/>
        </div>

        <g:render template="/generic/listsize"/>
        <div class="clearfix"></div>
        <hr/>

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <g:sortableColumn property="name" title="${message(code: 'category.name.label', default: 'Name')}"/>

                    <g:sortableColumn property="type" title="${message(code: 'category.type.label', default: 'Type')}"/>

                    <g:sortableColumn property="description"
                                      title="${message(code: 'category.description.label', default: 'Description')}"/>

                    <g:sortableColumn property="dateCreated"
                                      title="${message(code: 'category.dateCreated.label', default: 'Date Created')}"/>

                    <g:sortableColumn property="lastUpdated"
                                      title="${message(code: 'category.lastUpdated.label', default: 'Last Updated')}"/>

                    <th class="text-right"><g:message code="total"/></th>

                    <th class="text-center"><g:message code="watching"/></th>
                    <th class="text-right"><g:message code="actions"/></th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${categoryInstanceList}" status="i" var="categoryInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                        <td><span class="label" style="background-color: ${categoryInstance.color};">&nbsp;</span> ${fieldValue(bean: categoryInstance, field: "name")}</td>

                        <td>${fieldValue(bean: categoryInstance, field: "type")}</td>

                        <td>${fieldValue(bean: categoryInstance, field: "description")}</td>

                        <td><g:formatDate date="${categoryInstance.dateCreated}"/></td>

                        <td><g:formatDate date="${categoryInstance.lastUpdated}"/></td>
                        <td class="tdright"><b><g:formatNumber number="${categoryInstance?.sold}" format="###,###.##"/> €</b>
                        </td>
                        <td class="text-center">
                            <div id="category${categoryInstance.id}-pinned">
                                <g:render template="pinnedactions" model="[category: categoryInstance]"/>
                            </div>
                        </td>
                        <td class="text-right">
                            <g:link title="Afficher les détails" data-toggle="modal" data-target="#modalWindow_show"
                                    action="show" id="${categoryInstance.id}"><img
                                    src="${resource(dir: 'img', file: 'details.png')}"/></g:link>
                            <g:link title="Editer" action="edit" id="${categoryInstance.id}"><img
                                    src="${resource(dir: 'img', file: 'edit.png')}"/></g:link>
                            <g:link title="Opérations pour cette catégorie" action="operations"
                                    id="${categoryInstance.id}"><img
                                    src="${resource(dir: 'img', file: 'stats.png')}"/></g:link>
                        </td>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="pagination pull-right">

            <g:paginate total="${categoryInstanceTotal}"/>
        </div>

        <div class="clearfix">&nbsp;</div>

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
