<%@ page contentType="text/html" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mail" />
    <title><g:message code="app.name"/></title>

  </head>
  <body>
    <div class="body">
      <div class="in-body">

        <div id="mail">
          <ul>
          <g:each var="scheduled" in="${mail}">
              <li>${scheduled.type} de ${scheduled.amount} € à ${scheduled.tiers.name} (depuis ${scheduled.accountFrom.name})</li>
          </g:each>
          </ul>
          <br/>
          <g:link controller="summary" absolute="true">
            Se connecter sur Epsilon
          </g:link>
        </div>

      </div>
    </div>
  </body>
</html>
