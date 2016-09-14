<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'wish.label', default: 'souhait')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="col-sm-12">
    <h1>Créer un nouveau souhait <small>Génie ? Es-tu là ?</small></h1>
    <hr/>
</div>

<div class="col-sm-12">

    <g:if test="${flash.message}">
        <div class="alert alert-info">${flash.message}</div>
    </g:if>

    <g:hasErrors bean="${wishInstance}">
        <div class="alert alert-danger">
            <g:renderErrors bean="${wishInstance}" as="list"/>
        </div>
    </g:hasErrors>

    <div class="tabbable"><!-- Only required for left/right tabs -->
        <ul class="nav nav-tabs">
            <li class="${!tabToDisplay || tabToDisplay == 'simple' ? 'active' : ''}">
                <a href="#simple" data-toggle="tab">Création simple</a>
            </li>
            <li class="${tabToDisplay == 'bulk' ? 'active' : ''}">
                <a href="#bulk" data-toggle="tab">Import massif</a>
            </li>
        </ul>

        <div class="tab-content">

            <div class="tab-pane ${!tabToDisplay || tabToDisplay == 'simple' ? 'active' : ''}" id="simple">
                <div class="around-border-within-tab"><div class="clearfix">&nbsp;</div>
                    <g:form action="guess" class="form-horizontal">
                        <div class="form-group ${hasErrors(bean: wishInstance, field: 'webShopUrl', 'has-error')}">

                            <label for="url" class="col-sm-2 control-label">Lien à parcourir</label>

                            <div class="col-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-link"></span></span>
                                    <g:textField name="url" value="${wishInstance?.webShopUrl}"
                                                 class="form-control"/>
                                </div>

                                <div class="help-block with-errors"></div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-primary">
                                    <span class="glyphicon glyphicon-cog"></span> ${message(code: 'default.button.guess.label', default: 'Guess')}
                                </button>
                            </div>
                        </div>

                    </g:form>

                    <hr/>

                    <g:form action="save" class="form-horizontal">
                        <g:render template="form"/>

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

            <div class="tab-pane ${tabToDisplay == 'bulk' ? 'active' : ''}" id="bulk">
                <div class="around-border-within-tab"><div class="clearfix">&nbsp;</div>

                    <div class="alert alert-info">
                        Un import massif est constitué d'une série de lien. Chaque lien :
                        <ul>
                            <li>doit être un lien valide</li>
                            <li>être séparé par un retour à la ligne</li>
                        </ul><br/>
                        Epsilon va tenter de deviner les données utiles pour chacun des liens.
                    </div>

                    <g:form action="bulksave" class="form-horizontal">

                        <div class="form-group">

                            <label for="account" class="col-sm-2 control-label mandatory"><g:message
                                    code="wish.account.label"/></label>

                            <div class="col-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-piggy-bank"></span></span>
                                    <g:select id="account" name="account.id" from="${accounts}" optionKey="id" value="${wishInstance?.account?.id}" class="many-to-one form-control"
                                              required="required"/>
                                </div>

                                <div class="help-block with-errors"></div>
                            </div>
                        </div>


                        <div class="form-group">

                            <label for="bulkData" class="col-sm-2 control-label"><g:message
                                    code="wish.bulkData.label"/></label>

                            <div class="col-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-link"></span></span>
                                    <g:textArea name="bulkData" cols="40" rows="5"
                                                class="form-control editor"/>
                                </div>

                                <div class="help-block with-errors"></div>
                            </div>
                        </div>

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

        </div>
    </div>
</div>
</body>
</html>
