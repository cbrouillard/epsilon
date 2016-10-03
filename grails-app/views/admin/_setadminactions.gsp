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
<g:set var="username" value="${sec.username().toString()}"/>
<g:if test="${!person?.username.equalsIgnoreCase(username)}">
    <g:if test="${person?.authorities*.authority.contains("ROLE_ADMIN")}">
        <a href="#" title="Désactiver"
           onclick="ajaxPostLink('${createLink(controller:'admin', action:'setadminuser', id:person?.id, params:[id: person?.id, role: false])}', 'person${person?.id}-admin');">
            <img src="${resource(dir: 'img', file: 'online.png')}" alt="D"/>
        </a>
    </g:if>
    <g:else>
        <a href="#" title="Activer"
           onclick="ajaxPostLink('${createLink(controller:'admin', action:'setadminuser', id:person?.id, params:[id: person?.id, role: true])}', 'person${person?.id}-admin');">
            <img src="${resource(dir: 'img', file: 'offline.png')}" alt="E"/>
        </a>
    </g:else>
</g:if>