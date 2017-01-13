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
<g:if test="${operation?.pointed}">
    <a class="ajax-link"
       onclick="ajaxPostLink('${createLink(controller:'operation', action:'unpoint', id:operation?.id)}', 'operation${operation?.id}-point');">
        <img src="${assetPath(src: 'online.png')}" alt="P" title="${message(code: 'operation.unpoint')}"/>
    </a>
</g:if>
<g:else>
    <a class="ajax-link"
       onclick="ajaxPostLink('${createLink(controller:'operation', action:'point', id:operation?.id)}', 'operation${operation?.id}-point');">
        <img src="${assetPath(src: 'offline.png')}" alt="_" title="${message(code: 'operation.point')}"/>
    </a>
</g:else>