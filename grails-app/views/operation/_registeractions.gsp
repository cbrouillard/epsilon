<div class="tabbable">
<ul class="nav nav-tabs">
<li class="${tabToDisplay == 'depot' ? 'active' : ''}">
<a href="#depot" data-toggle="tab">Dépôt</a>
</li>
<li class="${tabToDisplay == 'virement' ? 'active' : ''}">
    <a href="#virement" data-toggle="tab">Virement</a>
</li>
<li class="${!tabToDisplay || tabToDisplay == 'facture' ? 'active' : ''}">
    <a href="#facture" data-toggle="tab">Facture</a>
</li>
</ul>

<div class="tab-content">

    <div class="tab-pane ${tabToDisplay == 'depot' ? 'active' : ''}" id="depot">

        <g:render template="createform" model="[type: 'depot', selected: selected]"/>

    </div>


    <div class="tab-pane ${tabToDisplay == 'virement' ? 'active' : ''}" id="virement">

        <g:render template="createvirement" model="[selected: selected]"/>

    </div>

    <div class="tab-pane ${!tabToDisplay || tabToDisplay == 'facture' ? 'active' : ''}" id="facture">

        <g:render template="createform" model="[type: 'retrait', selected: selected]"/>

    </div>

</div>