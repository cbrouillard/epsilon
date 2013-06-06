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
<g:if test="${person.mobileToken}">
    <g:remoteLink controller="person" action="deactivateMobile" update="mobile-activation">
        <img src="${resource(dir: 'img', file: 'phone_on.png')}" alt="[]" title="Désactiver l'accès"/>
    </g:remoteLink>
    L'accès à Epsilon depuis votre mobile est <span class="plus">activé</span> !
Vous pouvez le désactiver en cliquant sur l'icône ci-contre.
</g:if>
<g:else>
    <g:remoteLink controller="person" action="activateMobile" update="mobile-activation">
        <img src="${resource(dir: 'img', file: 'phone_off.png')}" alt="[X]" title="Activer l'accès"/>
    </g:remoteLink>
    L'accès à Epsilon depuis votre mobile est <span class="plus">desactivé</span> !
    Vous pouvez l'activer en cliquant sur l'icône ci-contre.
</g:else>