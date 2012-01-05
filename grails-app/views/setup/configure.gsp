
<%@ page import="com.headbangers.epsilon.SetupObjectCommand" %>
<html>
  <head>
    <meta name='layout' content='login' />
    <title>Configurer Epsilon sur votre serveur</title>
    </style>
  </head>

  <body>
    <div class="setup">
      <h1>Configuration d'Epsilon</h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${setup}">
        <div class="errors">
          <g:renderErrors bean="${setup}" as="list" />
        </div>
      </g:hasErrors>

      <g:form action="install" method="post" >

        <div class="dialog">
          <h3>Configuration du mot de passe administrateur</h3>

          <div class="help">
            Le mot de passe de l'administrateur est important ! Avec ce compte
            vous pouvez accéder à la configuration des utilisateurs d'Epsilon.
            Pour vous connecter en tant qu'administrateur, utilisez le login 'admin'.
          </div>

          <table>
            <tbody>

              <tr class="prop">
                <td valign="top" class="name">
                  <label for="adminpass"><g:message code="setup.adminpass.label" default="Admin password" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: setup, field: 'adminpassword', 'errors')}">
            <g:textField name="adminpassword" value="${setup?.adminpassword}" />
            </td>
            </tr>
            </tbody>
          </table>
        </div>

        <div class="dialog">
          <h3>Configuration du premier utilisateur</h3>

          <div class="help">
            Vous pouvez vous servir de ce formulaire afin de créer votre premier 
            utilisateur pour Epsilon. Notez que l'administrateur peut créer
            autant d'utilisateurs que souhaité.
          </div>

          <table>
            <tbody>

              <tr class="prop">
                <td valign="top" class="name">
                  <label for="username"><g:message code="person.username.label" default="Username" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: setup, field: 'username', 'errors')}">
            <g:textField name="username" value="${setup?.username}" />
            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="UserRealName"><g:message code="person.userRealName.label" default="UserRealName" />:</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: setup, field: 'userRealName', 'errors')}">
            <g:textField name="userRealName" value="${setup?.userRealName}" />
            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="pass"><g:message code="person.pass.label" default="Pass" />:</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: setup, field: 'passwd', 'errors')}">
            <g:textField name="passwd" value="${setup?.passwd}" />
            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="email"><g:message code="person.email.label" default="Email" />:</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: setup, field: 'email', 'errors')}">
            <g:textField name="email" value="${setup?.email}" />
            </td>
            </tr>

            </tbody>
          </table>
        </div>

        <div class="buttons">
          <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'setup.button.install.label', default: 'Install')}" /></span>
        </div>

      </g:form>

    </div>
  </body>
</html>