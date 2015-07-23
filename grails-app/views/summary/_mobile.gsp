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
    <g:remoteLink controller="person" action="deactivateMobile" update="mobile-activation" class="btn btn-default">
        <img src="${resource(dir: 'img', file: 'phone_on.png')}" alt="[]"/>
    </g:remoteLink>
</g:if>
<g:else>
    <g:remoteLink controller="person" action="activateMobile" update="mobile-activation" class="btn btn-default">
        <img src="${resource(dir: 'img', file: 'phone_off.png')}" alt="[X]"/>
    </g:remoteLink>
</g:else>