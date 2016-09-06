<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Liste des expressions cron</title>
</head>

<body>
<div class="col-sm-12">
    <h1>Liste des expressions cron <small>Elles sont pas bêtes ces expressions.</small>
    </h1>
    <hr/>
</div>

<g:set var="crons" value="${com.headbangers.epsilon.CronExpression.list()}"/>



<div class="col-sm-7">
    <div class="tabbable">
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#newForm" data-toggle="tab">Documentation</a>
            </li>
        </ul>

        <div class="tab-content">
            <div class="tab-pane active" id="newForm">
                <div class="around-border-within-tab">

                    <div class="alert alert-info">
                        Les expressions sont écrites selon deux formats:
                        <ul>
                            <li>le format cron standard</li>
                            <li>le format epsilon</li>
                        </ul>
                    </div>

                    <h3>Format cron :</h3><hr/>
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th align="left">Nom du champ</th>
                            <th align="left">&nbsp;</th>
                            <th align="left">Valeurs autorisées</th>
                            <th align="left">&nbsp;</th>
                            <th align="left">Caractères spéciaux</th>
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
                                    Documentation complète
                                </a>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="pull-right">
                        <span class="label label-success">Exemple cron :</span>
                        <blockquote>
                            <b>"0 0 2 ? * 6L *"</b><br/>Le dernier vendredi du mois, à 2h du matin
                        </blockquote>
                    </div><div class="clearfix"></div>

                    <h3>Format epsilon :</h3><hr/>
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th align="left">Nom du champ</th>
                            <th align="left">&nbsp;</th>
                            <th align="left">Valeurs autorisées</th>
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
                        <span class="label label-success">Exemple epsilon :</span>
                        <blockquote>
                            <b>"E d 14"</b><br/>Roulement sur 14 jours
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
                <th>Nom</th>
                <th>Expression</th>
                <th>Prochaine date</th>
                <th class="text-right">Actions</th>
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

                <label for="expression" class="col-sm-2 control-label mandatory">Expression</label>

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
                            - Prochaines dates valides :
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

                    <label for="name" class="col-sm-2 control-label mandatory">Nom de l'expression</label>

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
                                        value="Enregistrer"/>
                    </div>
                </div>
            </g:if>

        </g:form>

    </div>
</div>

</body>
</html>