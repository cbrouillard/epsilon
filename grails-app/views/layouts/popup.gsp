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
<html>
<head>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'epsilon.css')}"/>

    <r:require module="jquery"/>
    <r:require module="bootstrap"/>
    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body>
<div id="grailsLogo" class="logo"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Epsilon" border="0" style="height:20px;"/></div>

<g:layoutBody/>
<r:layoutResources/>
</body>

</html>