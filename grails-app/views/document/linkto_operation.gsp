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
<%@ page import="com.headbangers.epsilon.AccountType" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}"/>
    <title><g:message code="document.${document.type.toString().toLowerCase()}.linkto"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1><g:message code="document.${document.type.toString().toLowerCase()}.linkto"/>
        <small><g:message code="document.${document.type.toString().toLowerCase()}.linkto.explanation"/></small></h1>
    <hr/>
</div>

<div class="col-md-6 col-sm-12">
    <div class="around-border">

        <h4>Dernières opérations sur l'ensemble de vos comptes</h4>
        <hr/>

        <g:set var="operations" value="${accounts*.lastOperations.flatten()}"/>
        <g:render template="/operation/simplelist"
                  model="[operations    : operations,
                          actions       : [
                                  [ctrl: 'operation', act: 'linkdocument', icon: 'enter.png', params: [docId: document.id]]
                          ], showAccount: true]"/>
    </div>
</div>

<div class="col-md-6 col-sm-12">
    <div class="around-border">

        <h4>Filtre de recherche</h4>
        <hr/>

        <g:if test="${flash.message}">
            <div class="alert alert-info">${flash.message}</div>
        </g:if>

        <g:form action="searchoperation">
            <div class="form-group">
                <g:hiddenField name="id" value="${document.id}"/>

                <label for="tiers" class="col-sm-2 control-label"><g:message
                        code="operation.tiers.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-user"></span></span>

                        <g:textField id="tiers" name="tiers"
                                     class="form-control typeahead-tiers"
                                     autocomplete="off" value="${search?.tiers}"/>

                    </div>

                    <div class="help-block with-errors"></div>
                </div>
            </div>

            <div class="form-group">

                <label for="category" class="col-sm-2 control-label"><g:message
                        code="operation.category.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-tag"></span></span>

                        <g:textField id="category" name="category"
                                     class="form-control typeahead-categories-facture"
                                     autocomplete="off" value="${search?.category}"/>

                    </div>

                    <div class="help-block with-errors"></div>
                </div>

            </div>

            <div class="form-group">

                <label for="afterDate" class="col-sm-2 control-label"><g:message
                        code="after.date"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-calendar"></span></span>
                        <input type="text"
                               name="afterDate"
                               value="${formatDate(format: 'dd/MM/yyyy', date: search?.afterDate)}"
                               id="afterDate" class="datePicker form-control"/>

                    </div>

                    <div class="help-block with-errors"></div>
                </div>
            </div>

            <div class="form-group">

                <label for="beforeDate" class="col-sm-2 control-label"><g:message
                        code="before.date"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-calendar"></span></span>
                        <input type="text"
                               name="beforeDate"
                               value="${formatDate(format: 'dd/MM/yyyy', date: search?.beforeDate)}"
                               id="beforeDate" class="datePicker form-control"/>

                    </div>

                    <div class="help-block with-errors"></div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-success">
                        <span class="glyphicon glyphicon-search"></span> ${message(code: 'default.button.search.label', default: 'Search')}
                    </button>
                    <g:if test="${search}">
                        <g:link class="btn btn-default" controller="document" action="linkto" id="${document.id}">
                            <g:message code="reset"/>
                        </g:link>
                    </g:if>
                </div>
            </div>

        </g:form>
        <div class="clearfix">&nbsp;</div>

        <g:if test="${searchedOperations}">

            <hr/>

            <g:render template="/operation/simplelist"
                      model="[operations: searchedOperations,
                              actions   : [
                                      [ctrl: 'operation', act: 'linkdocument', icon: 'enter.png', params: [docId: document.id]]
                              ], showAccount: true]"/>
        </g:if>
        <g:else>
            <g:if test="${search}">
                <div class="alert alert-warning">Aucun résultat</div>
            </g:if>
        </g:else>

    </div>
</div>

</body>
</html>