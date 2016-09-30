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
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title><g:message code="admin.crons.list.title"/> </title>
</head>

<body>
<div class="col-sm-12">
    <h1><g:message code="admin.crons.list.title"/> <small><g:message code="admin.crons.list.title.explanation"/> </small>
    </h1>
    <hr/>
</div>

<g:set var="crons" value="${com.headbangers.epsilon.CronExpression.list()}"/>



<div class="col-sm-7">
    <div class="tabbable">
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#newForm" data-toggle="tab"><g:message code="admin.crons.documentation.title"/></a>
            </li>
        </ul>

        <div class="tab-content">
            <div class="tab-pane active" id="newForm">
                <div class="around-border-within-tab">

                    <div class="alert alert-info">
                        <g:message code="admin.crons.documentation.body"/>
                    </div>

                    <h3><g:message code="cron.format"/></h3><hr/>
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th align="left"><g:message code="cron.fieldname"/></th>
                            <th align="left">&nbsp;</th>
                            <th align="left"><g:message code="cron.authorizedvalues"/></th>
                            <th align="left">&nbsp;</th>
                            <th align="left"><g:message code="cron.specialcars"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td align="left"><code>Seconds</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>0-59</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>, - * /</code></td>
                        </tr>
                        <tr>
                            <td align="left"><code>Minutes</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>0-59</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>, - * /</code></td>
                        </tr>
                        <tr>
                            <td align="left"><code>Hours</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>0-23</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>, - * /</code></td>
                        </tr>
                        <tr>
                            <td align="left"><code>Day-of-month</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>1-31</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>, - * ? / L W</code></td>
                        </tr>
                        <tr>
                            <td align="left"><code>Month</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>1-12 or JAN-DEC</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>, - * /</code></td>
                        </tr>
                        <tr>
                            <td align="left"><code>Day-of-Week</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>1-7 or SUN-SAT</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>, - * ? / L #</code></td>
                        </tr>
                        <tr>
                            <td align="left"><code>Year (Optional)</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>empty, 1970-2199</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>, - * /</code></td>
                        </tr>
                        <tr>
                            <td class="text-left" colspan="6">
                                <a href="http://www.quartz-scheduler.org/api/2.2.1/org/quartz/CronExpression.html"
                                   target="_blank">
                                    <g:message code="cron.complete.documentation"/>
                                </a>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="pull-right">
                        <span class="label label-success"><g:message code="cron.example"/></span>
                        <blockquote>
                            <b>"0 0 2 ? * 6L *"</b><br/><g:message code="cron.example.lastfriday"/>
                        </blockquote>
                    </div><div class="clearfix"></div>

                    <h3><g:message code="epsilon.format"/></h3><hr/>
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th align="left"><g:message code="cron.fieldname"/></th>
                            <th align="left">&nbsp;</th>
                            <th align="left"><g:message code="cron.authorizedvalues"/></th>
                            <th align="left">&nbsp;</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td align="left"><code>Starter</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>E</code></td>
                            <td align="left">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="left"><code>Selector</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>d m</code></td>
                            <td align="left">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="left"><code>Value</code></td>
                            <td align="left">&nbsp;
                            </td><td align="left"><code>0-365</code></td>
                            <td align="left">&nbsp;
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="pull-right">
                        <span class="label label-success"><g:message code="epsilon.example"/></span>
                        <blockquote>
                            <b>"E d 14"</b><br/><g:message code="epsilon.example.fourteendaysroll"/>
                        </blockquote>
                    </div><div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>

</div>

<div class="col-sm-5">
    <div class="around-border">
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th><g:message code="cron.name.label"/></th>
                <th><g:message code="cron.expression.label"/></th>
                <th><g:message code="cron.nextdate.label"/></th>
                <th class="text-right"><g:message code="actions"/></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${crons}" status="i" var="cron">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td>${cron.name}</td>
                    <td>${cron.expression}</td>
                    <td>${cron.nextDate}</td>
                    <td class="text-right">
                        <g:link title="Effacer" action="deletecron" id="${cron.id}"><img
                                src="${resource(dir: 'img', file: 'delete.png')}"/></g:link>
                        <g:link title="Editer" action="editcron" id="${cron.id}"><img
                                src="${resource(dir: 'img', file: 'edit.png')}"/></g:link>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>


        <g:set var="validationExpression" value="${newExpression?.validate()}"/>
        <g:set var="goodExpression"
               value="${newExpression && validationExpression.equals("Expression OK")}"/>


        <g:form method="post"
                class="form-horizontal">
            <g:hiddenField name="id" value="${newExpression?.id}"/>
            <div class="form-group">

                <label for="expression" class="col-sm-2 control-label mandatory"><g:message code="cron.expression.label"/></label>

                <div class="col-sm-10">
                    <div class="input-group">
                        <span class="input-group-addon"><span
                                class="glyphicon glyphicon-font"></span></span>
                        <g:textField name="expression" id="expression" required="true"
                                     class="form-control"
                                     value="${newExpression?.expression}"/>
                    </div>

                    <div class="help-block with-errors">
                        ${validationExpression}
                        <g:if test="${goodExpression}">
                            - <g:message code="cron.next.valid.dates"/>
                            <ul>
                                <g:each in="${newExpression.getNextDates(5)}" var="validDate">
                                    <li><g:formatDate date="${validDate}"/></li>
                                </g:each>
                            </ul>
                        </g:if>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <g:actionSubmit class="save btn btn-primary" action="validatecron"
                                    value="Valider"/>
                </div>
            </div>

            <g:if test="${goodExpression}">
                <div class="form-group">

                    <label for="name" class="col-sm-2 control-label mandatory"><g:message code="cron.name.more.label"/></label>

                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-font"></span></span>
                            <g:textField name="name" id="name" class="form-control"
                                         placeholder="CRON: ${newExpression.expression}"
                                         value="${newExpression?.name}"/>
                        </div>

                        <div class="help-block with-errors">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <g:actionSubmit class="save btn btn-success" action="savecron"
                                        value="${message(code:'default.button.save.label')}"/>
                    </div>
                </div>
            </g:if>

        </g:form>

    </div>
</div>

</body>
</html>