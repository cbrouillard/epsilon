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
<g:if test="${tiers?.pinned}">
    <a href="#"
       onclick="ajaxPostLink('${createLink(controller:'tiers', action:'unpinne', id:tiers?.id)}', 'tiers${tiers?.id}-pinned');">
        <img src="${assetPath(src:'unpinne.png')}" alt="P" title="Stopper la surveillance"/>
    </a>
</g:if>
<g:else>
    <a href="#"
       onclick="ajaxPostLink('${createLink(controller:'tiers', action:'pinne', id:tiers?.id)}', 'tiers${tiers?.id}-pinned');">
        <img src="${assetPath(src:'pinne.png')}" alt="_" title="Surveiller ce tiers"/>
    </a>
</g:else>