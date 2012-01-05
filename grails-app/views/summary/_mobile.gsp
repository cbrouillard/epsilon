<g:if test="${person.mobileToken}">
<g:remoteLink  controller="person" action="deactivateMobile" update="mobile-activation" >
    <img src="${resource(dir:'img', file:'phone_on.png')}" alt="[]" title="Désactiver l'accès"/>
</g:remoteLink>
L'accès à Epsilon depuis votre mobile est <span class="plus">activé</span> !<br/>
Vous pouvez le désactiver en cliquant sur l'icône ci-contre.
</g:if>
<g:else>
<g:remoteLink  controller="person" action="activateMobile" update="mobile-activation" >
    <img src="${resource(dir:'img', file:'phone_off.png')}" alt="[X]" title="Activer l'accès"/>
</g:remoteLink>
  L'accès à Epsilon depuis votre mobile est <span class="plus">desactivé</span> !<br/>
Vous pouvez l'activer en cliquant sur l'icône ci-contre.
</g:else>