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
<g:form class="form-inline pull-right"  action="${action}" controller="${controller}" method="get" style="${css}">
    <g:hiddenField name="id" value="${id}" />
    <g:message code="Between"/> <g:select name="fromYear" from="${yearRange}" value="${fromYear}" class="form-control"/>
    <g:message code="and"/> <g:select name="toYear" from="${yearRange}" value="${toYear}" class="form-control"/>
    <input type="submit" value="Ok" class="btn btn-default"/>
</g:form>