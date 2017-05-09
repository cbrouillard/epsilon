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
    <title><g:message code="category.merge"/></title>
</head>

<body>
<div class="col-sm-12">
    <h1><g:message code="category.merge"/> </h1>
    <hr/>

    <g:if test="${flash.message}">
        <div class="alert alert-info">${flash.message}</div>
    </g:if>
</div>

<g:form action="merge" method="post" class="form-horizontal">
          <div class="col-sm-6">
              <div class="around-border-red">

                <fieldset class="form">
                    <div id="formContainer">
                <h4><g:message code="category.merge.tomerge"/></h4><hr/>

                <div class="form-group">

                    <div class="col-sm-12">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-asterisk"></span></span>
                            <g:select name="catToMerge" from="${categories}"
                                      value="${leftCategory?.id}"
                                      class="form-control" optionValue="name" optionKey="id"/>
                        </div>

                        <div class="help-block with-errors"></div>
                    </div>
                </div>
                <div class="alert alert-danger"><g:message code="category.merge.tomerge.explanation"/></div>

              </div>
            </fieldset>
              </div>
          </div>

          <div class="col-sm-6">
              <div class="around-border-green">
                <fieldset class="form">
                    <div id="formContainer">
                  <h4><g:message code="category.merge.merge.in"/></h4><hr/>

                  <div class="form-group">

                      <div class="col-sm-12">
                          <div class="input-group">
                              <span class="input-group-addon"><span
                                      class="glyphicon glyphicon-asterisk"></span></span>
                              <g:select name="mergeIn" from="${categories}"
                                        value="${leftCategory?.id}"
                                        class="form-control" optionValue="name" optionKey="id"/>
                          </div>

                          <div class="help-block with-errors"></div>
                      </div>
                  </div>
                    <div class="alert alert-success"><g:message code="category.merge.merge.in.explanation"/></div>
                </div>
              </fieldset>

              <div class="form-group">
                  <div class="col-sm-offset-2 col-sm-10">
                      <button type="submit" class="btn btn-success pull-right">
                          <span class="glyphicon glyphicon-save"></span> ${message(code: 'category.merge.save', default: 'Save')}
                      </button>
                  </div>
              </div>

              </div>
          </div>
</g:form>

</body>
</html>
