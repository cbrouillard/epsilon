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
<form action="search" method="post" >

    <div class="input-append">
        <input type="text" class="input-medium" name="query">
        <button type="submit" class="btn" type="button">chercher</button>
    </div>
    %{--<richui:autoComplete class="input-medium search-query" id="search${controllerName}" name="query" action="${createLinkTo('dir': controllerName + '/autocomplete')}"/>--}%
</form>