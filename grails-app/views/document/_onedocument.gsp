<div>
    <div class="caption text-center">

        <ul class="list-group">
            <li class="list-group-item " style="word-wrap: break-word;">
                <strong>${fieldValue(bean: document, field: "name")}</strong>
            </li>

            <li class="list-group-item ">
                <g:message code="document.type.${document.type.toString().toLowerCase()}"/>
            </li>

            <li class="list-group-item ">
                Créé le : <g:formatDate date="${document.dateCreated}"/>
            </li>

            <li class="list-group-item">
                <div class="btn-group btn-group-xs" role="group" aria-label="...">
                    <g:link controller="document" action="download" id="${document.id}" class="btn">
                        <img src="${resource(dir: 'img', file: 'invoice.png')}"/> <g:message code="document.download"/>
                    </g:link>
                </div>
            </li>

        </ul>

    </div>
</div>