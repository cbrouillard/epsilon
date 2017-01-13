<div class="thumbnail">
    <div style="height: 200px;" class="wish-img">
        <g:if test="${wishInstance.thumbnailUrl}">
            <a href="${wishInstance.webShopUrl}" target="_blank">
                <img style="max-height: 200px;" src="${wishInstance.thumbnailUrl}" class="img-rounded"/>
            </a>
        </g:if>
        <g:else>
            <g:link title="Editer" action="edit" id="${wishInstance.id}">
                <img style="max-height: 200px;max-width: 200px;"
                     src="${assetPath(src: 'no-image.png')}"/>
            </g:link>
        </g:else>
    </div>

    <div class="caption text-center">
        <ul class="list-group">
            <li class="list-group-item list-group-item-success"
                style=" word-wrap: break-word;height: 95px;">
                <strong>${fieldValue(bean: wishInstance, field: "name")}</strong>
            </li>
            <li class="list-group-item">
                <strong>${fieldValue(bean: wishInstance, field: "price")} €</strong>
            </li>
            <g:if test="${wishInstance.webShopUrl}">
                <li class="list-group-item">
                    <a href="${wishInstance.webShopUrl}" target="_blank">Lien boutique</a>
                </li>
            </g:if>
            <li class="list-group-item">
                <g:if test="${wishInstance.previsionBuy}">
                    Date prévue pour l'achat : <g:formatDate date="${wishInstance.previsionBuy}"/>
                </g:if>
                <g:else>
                    Pas de date prévue pour l'achat
                </g:else>
            </li>
            <g:if test="${wishInstance.boughtDate}">
                <li class="list-group-item">
                    Date d'achat : <g:formatDate date="${wishInstance.boughtDate}"/>
                </li>
            </g:if>
            <g:if test="${wishInstance.description}">
                <li class="list-group-item">
                    ${fieldValue(bean: wishInstance, field: "description")}
                </li>
            </g:if>
            <li class="list-group-item">
                <div class="btn-group btn-group-xs" role="group" aria-label="...">

                    <g:if test="${!refreshed}">
                        <a href="#" class="btn"
                           onclick="ajaxPostLink('${createLink(controller:'wish', action:'refresh', id:wishInstance?.id)}', 'refreshWish${wishInstance?.id}');">
                            <img src="${assetPath(src: 'refresh.png')}" alt="_"
                                 title="Rafraichir les données"/>
                        </a>
                    </g:if>
                    <g:else>
                        <a href="#" class="btn"><small>&#10003;</small></a>
                    </g:else>

                    <g:link title="Editer" action="edit" id="${wishInstance.id}" class="btn"><img
                            src="${assetPath(src: 'edit.png')}" alt="Editer"/></g:link>
                    <g:link title="Acheter!" action="create_operation" id="${wishInstance.id}"
                            class="btn"><img
                            src="${assetPath(src: 'buy.png')}" alt="Acheter!"/></g:link>
                </div>
            </li>
        </ul>
    </div>
</div>