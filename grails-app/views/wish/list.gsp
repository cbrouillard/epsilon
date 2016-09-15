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
<%@ page import="com.headbangers.epsilon.Wish" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'wish.label', default: 'Wish')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1>Liste des futurs achats <small>Ce que vous désirez !</small> <g:link controller="wish" action="create"
                                                                             class="btn btn-success"><img
                src="${resource(dir: 'img', file: 'gift.png')}"
                alt=">"/> Créer un nouveau souhait</g:link></h1>

    <div class="row">
        <div class="col-sm-8">
            <div class="alert alert-info">
                Voici la liste de vos futurs achats. Saisissez vos projets : Epsilon se charge de vous dire si toutes vos
                envies rentrent dans votre budget !
            </div>
        </div>

        <div class="col-sm-4">
            <div class="around-border">
                <div class="row">

                    <div class="counter-shower col-xs-12 col-sm-12">

                        <div class="number">
                            <span class="label label-default">
                                <g:formatNumber number="${wishInstanceList*.price.sum()}"
                                                format="###,###.##"/> €
                            </span>
                        </div>

                        <div class="lbl">
                            Total des achats prévus
                        </div>

                    </div>

                </div>
            </div>
        </div>


    </div>

    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">

        <g:render template="/generic/listsize"/>
        <div class="clearfix">&nbsp;</div>

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>
        <div class="row">
            <g:each in="${wishInstanceList}" status="i" var="wishInstance">
                <div class="col-lg-3 col-md-5 col-sm-5" id="refreshWish${wishInstance.id}">
                    <g:render template="onewish" model="[wishInstance: wishInstance]"/>
                </div>
            </g:each>
            <div class="clearfix"></div>
        </div>

        <div class="pagination pull-right">
            <g:paginate total="${wishInstanceTotal}"/>
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
