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
    <title><g:layoutTitle default="Grails"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'epsilon.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'fileinput.css')}"/>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

    <r:require module="jquery"/>

    <style>
    body {
        padding-top: 60px;
        padding-bottom: 60px;
    }
    </style>

    <script src="${resource(dir: '/js', file: 'password.js')}"></script>
    <script src="${resource(dir: '/js', file: 'jscolor.min.js')}"></script>
    <r:require module="bootstrap"/>
    <r:require module="jquery-ui"/>
    <g:layoutHead/>
    <r:layoutResources/>

    <gvisualization:apiImport/>
    <script src="${resource(dir: '/js', file: 'fileinput.js')}"></script>
</head>

<body class="pig">

<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container-fluid">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${createLink(uri: '/')}"><img
                    src="${resource(dir: 'images', file: 'grails_logo.png')}"
                    alt="Epsilon" border="0"
                    style="height: 20px;"/></a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <g:render template="/generic/menu"/>
        </div>
    </div>
</nav>

<div class="container-fluid""><g:layoutBody/></div>

<footer>
    <nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
        <div class="navbar-inner">
            <div class="container-fluid">

                <p class="navbar-text pull-left">
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <g:link controller="admin" action="users"><g:message code="menu.administration"/></g:link> -
                    </sec:ifAllGranted>
                    <span style="-webkit-transform: rotate(180deg); -moz-transform: rotate(180deg); -o-transform: rotate(180deg); -khtml-transform: rotate(180deg); -ms-transform: rotate(180deg); transform: rotate(180deg); display: inline-block;" class="grand">&copy;</span> BROUILLARD Cyril - [2009-2017] - <g:message
                            code="app.name"/> - <g:message code="app.purpose"/></p>

                <div class="navbar-text pull-right">
                    <a class="label label-danger" href="https://github.com/cbrouillard/epsilon">Fork me on Github !</a>
                    <a class="label label-success">Proudly built with Grails <g:meta name="app.grails.version"/></a>
                </div>

            </div>
        </div>
    </nav>
</footer><a name="bottom"></a>

<r:layoutResources/>
</body>

<script src="${resource(dir: '/js/typeahead', file: 'typeahead.bundle.js')}"></script>
<script type="text/javascript">
    jQuery(function () {
        $('[data-toggle="tooltip"]').tooltip();

//        , showOn: 'both', buttonText: '<i class="icon-calendar"></i>'
        $(".datepicker, .datepicker-inner").datepicker({'dateFormat': 'dd/mm/yy'});
        $(".datepicker, .datepicker-inner").attr("autocomplete", "off");


        $('.typeahead-tiers').typeahead(null, {
            source: new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                remote: {
                    url: '${createLink(controller: 'tiers', action:'simpleautocomplete')}?query=%QUERY',
                    wildcard: '%QUERY'
                }
            })
        });


        $('.typeahead-category').typeahead(null, {
            source: new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                remote: {
                    url: '${createLink(controller: 'category', action:'simpleautocomplete')}?query=%QUERY',
                    wildcard: '%QUERY'
                }
            })
        });

        $('.typeahead-scheduled').typeahead(null, {
            source: new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                remote: {
                    url: '${createLink(controller: 'scheduled', action:'simpleautocomplete')}?query=%QUERY',
                    wildcard: '%QUERY'
                }
            })
        });

        $('.typeahead-budget').typeahead(null, {
            source: new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                remote: {
                    url: '${createLink(controller: 'budget', action:'simpleautocomplete')}?query=%QUERY',
                    wildcard: '%QUERY'
                }
            })
        });

        $('.typeahead-document').typeahead(null, {
            source: new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                remote: {
                    url: '${createLink(controller: 'document', action:'simpleautocomplete')}?query=%QUERY',
                    wildcard: '%QUERY'
                }
            })
        });

        $('.typeahead-categories-facture, .typeahead-categories-retrait').typeahead(null, {
            source: new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                remote: {
                    url: '${createLink(controller: 'category', action:'simpleautocomplete')}?type=facture&query=%QUERY',
                    wildcard: '%QUERY'
                }
            })
        });

        $('.typeahead-categories-depot').typeahead(null, {
            source: new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                remote: {
                    url: '${createLink(controller: 'category', action:'simpleautocomplete')}?type=depot&query=%QUERY',
                    wildcard: '%QUERY'
                }
            })
        });

        $('.typeahead-categories-virement').typeahead(null, {
            source: new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                remote: {
                    url: '${createLink(controller: 'category', action:'simpleautocomplete')}?type=virement&query=%QUERY',
                    wildcard: '%QUERY'
                }
            })
        });

        $('.tt-query').css('background-color', '#fff');
    });

    function goToCategory(catId) {
        window.location.href = '${createLink(controller:'category', action:'operations')}/' + catId
    }

    function goToTiers(tiersId) {
        window.location.href = '${createLink(controller:'tiers', action:'operations')}/' + tiersId
    }

    var showOrHide = function (showIt, divId){
        if (showIt){
            $('#'+divId).removeClass('hide');;
        } else {
            $('#'+divId).addClass('hide');
        }
    }

    var ajaxPostLink = function (url, updateId) {

        jQuery.ajax(
                {   type:'POST',
                    url:url,
                    success:
                            function(data,textStatus){
                                jQuery('#'+updateId).html(data);
                            },
                    error:
                            function(XMLHttpRequest,textStatus,errorThrown){

                            }
                });

        return false;
    }

</script>
</html>