<%--
  Created by IntelliJ IDEA.
  User: cyril
  Date: 13/06/13
  Time: 16:05
  To change this template use File | Settings | File Templates.
--%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Statistiques</title>
</head>

<body>
<div class="col-sm-12">
    <h1>Statistiques <small>De jolis graphiques.</small></h1>
    <hr/>
</div>

<div class="col-sm-6">
    <div class="around-border">
        <div class="alert alert-info">
            Dépenses par catégories
        </div>
        <g:render template="/generic/chart"
                  model="[name: 'OpChart-depenses', controller: 'stats', action: 'categoryChart']"/>

    </div>
</div>

<div class="col-sm-6">
    <div class="around-border">
        <div class="alert alert-info">
            Revenus par catégories
        </div>
        <g:render template="/generic/chart"
                  model="[name: 'OpChart-revenus', controller: 'stats', action: 'revenuesChart']"/>
    </div>
</div>

</body>
</html>