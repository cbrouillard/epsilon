<div id="deco-border-left">&nbsp;</div>
<div id="menu-principal">

  <div id="grailsLogo" >
    <a href="${createLink(uri: '/')}">
    <img src="${resource(dir:'images',file:'grails_logo.png')}" alt="Epsilon" border="0" />
    </a>
    <sec:ifLoggedIn>
      <div id="welcome">
        Bienvenue <sec:username/> !
      </div>

    </sec:ifLoggedIn>
  </div>

  <g:if test="${controllerName == 'summary'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><a class="home" href="${createLink(uri: '/')}">Accueil</a></div>
<g:if test="${controllerName == 'bank'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><g:link class="bank" controller="bank">Etablissements</g:link></div>
<g:if test="${controllerName == 'account'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><g:link class="account" controller="account">Comptes</g:link></div>
<g:if test="${controllerName == 'scheduled'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><g:link class="echeancy" controller="scheduled">Echéances</g:link></div>
<g:if test="${controllerName == 'budget'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><g:link class="budget" controller="budget">Budgets</g:link></div>
<g:if test="${controllerName == 'loan'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><g:link class="loan" controller="loan">Prêts</g:link></div>
<g:if test="${controllerName == 'category'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><g:link class="category" controller="category">Catégories</g:link></div>
<g:if test="${controllerName == 'tiers'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><g:link class="tiers" controller="tiers">Tiers</g:link></div>
<g:if test="${controllerName == 'operation'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><g:link class="operation" controller="operation">Registres</g:link></div>
<g:if test="${controllerName == 'stats'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><g:link class="stats" controller="stats">Statistiques</g:link></div>

<g:if test="${controllerName == 'person'}"><div class="menuButton selected"></g:if><g:else><div class="menuButton"></g:else><g:link class="personal" controller="person" action="infos">Vos informations</g:link></div>

<div class="menuButton" id="logout-button">
  <sec:ifLoggedIn>
    <g:link controller="logout" class="logout">
      Se déconnecter
    </g:link>
  </sec:ifLoggedIn>
</div>
</div>


