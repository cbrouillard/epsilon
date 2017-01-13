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
<g:if test="${person?.enabled}">
    <a href="#"
       onclick="ajaxPostLink('${createLink(controller:'admin', action:'disableuser', id:person?.id)}', 'person${person?.id}-enable');">
        <img src="${assetPath(src: 'online.png')}" alt="D"/>
    </a>
</g:if>
<g:else>
    <a href="#"
       onclick="ajaxPostLink('${createLink(controller:'admin', action:'enableuser', id:person?.id)}', 'person${person?.id}-enable');">
        <img src="${assetPath(src: 'offline.png')}" alt="E"/>
    </a>
</g:else>