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
<form action="search" method="get" class="form-inline">

    <div class="form-group">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-search"></span></span>
            <input type="text" class="form-control typeahead-${controllerName}" name="query" autocomplete="off"
                   value="${query ?: ""}">
        </div>
        <g:if test="${params.query}">
            <g:link class="btn btn-danger" action="${action ?: 'list'}">&nbsp;<span
                    class="glyphicon glyphicon-remove"></span>&nbsp;</g:link>
        </g:if>
        <button type="submit" class="btn btn-default" style="display: none;"><g:message code="search"/></button>

    </div>
</form>