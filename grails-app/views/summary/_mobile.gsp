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
    <a href="#" class="btn btn-default"
       onclick="ajaxPostLink('${createLink(controller:'person', action:'deactivateMobile', id:person?.id)}', 'mobile-activation');">
        <img src="${resource(dir: 'img', file: 'phone_on.png')}" alt="[]"/>
    </a>
</g:if>
<g:else>
    <a href="#" class="btn btn-default"
       onclick="ajaxPostLink('${createLink(controller:'person', action:'activateMobile', id:person?.id)}', 'mobile-activation');">
        <img src="${resource(dir: 'img', file: 'phone_off.png')}" alt="[X]"/>
    </a>
</g:else>