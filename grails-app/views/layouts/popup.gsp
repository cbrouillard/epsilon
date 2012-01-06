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
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'epsilon.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'datePicker.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        
        <g:javascript library="jquery" />
        <g:javascript library="date"/>
        <g:javascript library="jquery.datePicker"/>
        <g:javascript library="qtip/jquery.qtip-1.0.0-rc3.min"/>

        <g:javascript library="fancybox/jquery.fancybox-1.3.1"/>
        <link rel="stylesheet" href="${resource(dir:'/js/fancybox',file:'jquery.fancybox-1.3.1.css')}" />
        
        <script>
          jQuery.noConflict();
        </script>

        <g:javascript library="prototype" />
        <g:javascript library="application" />

        <g:layoutHead />
    </head>
    <body>

        <jq:jquery>
          jQuery("a.popup").fancybox(
            {showNavArrows:false, 'zoomSpeedIn' : 300,
            'zoomSpeedOut': 300,
            'overlayShow': true,
            'hideOnContentClick': false,
            'callbackOnShow': function() {
              jQuery("#fancy_right").hide();
              jQuery("#fancy_left").hide();
              }
            }
          );
          jQuery("a[title]").qtip({ style: { name: 'dark', tip: true }, position : {corner:{target:'topRight', tooltip:'bottomLeft'}} });
        </jq:jquery>

        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>
        <div id="grailsLogo" class="logo"><img src="${resource(dir:'images',file:'grails_logo.png')}" alt="Epsilon" border="0" /></div>

        <g:layoutBody />

    </body>

    
</html>