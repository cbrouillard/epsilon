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
<small><g:message code="nb.elements"/></small>
<div class="btn-group" role="group" aria-label="...">
    <g:link  action="list" params="${params + [max:10]}" class="btn btn-xs btn-${params.max == 10 ? "success" : "default"}">10</g:link>
    <g:link  action="list" params="${params + [max:20]}" class="btn btn-xs btn-${params.max == 20 || !params.max ? "success" : "default"}">20</g:link>
    <g:link  action="list" params="${params + [max:50]}" class="btn btn-xs btn-${params.max == 50 ? "success" : "default"}">50</g:link>
    <g:link  action="list" params="${params + [max:100]}" class="btn btn-xs btn-${params.max == 100 ? "success" : "default"}">100</g:link>
</div>