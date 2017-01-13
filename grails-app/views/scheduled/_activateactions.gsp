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
<g:if test="${scheduled?.active}">
    <a href="#"
       onclick="ajaxPostLink('${createLink(controller:'scheduled', action:'deactivate', id:scheduled?.id)}', 'scheduled${scheduled?.id}-activation');">
        <img src="${assetPath(src:'online.png')}" alt="P" title="${message(code:'scheduled.deactivate')}"/>
    </a>
</g:if>
<g:else>
    <a href="#"
       onclick="ajaxPostLink('${createLink(controller:'scheduled', action:'activate', id:scheduled?.id)}', 'scheduled${scheduled?.id}-activation');">
        <img src="${assetPath(src:'offline.png')}" alt="_" title="${message(code:'scheduled.activate')}"/>
    </a>
</g:else>