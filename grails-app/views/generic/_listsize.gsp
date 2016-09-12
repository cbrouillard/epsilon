<small>Nombre d'éléments affichés</small>
<div class="btn-group" role="group" aria-label="...">
    <g:link  action="list" params="${params + [max:10]}" class="btn btn-xs btn-${params.max == 10 ? "success" : "default"}">10</g:link>
    <g:link  action="list" params="${params + [max:20]}" class="btn btn-xs btn-${params.max == 20 || !params.max ? "success" : "default"}">20</g:link>
    <g:link  action="list" params="${params + [max:50]}" class="btn btn-xs btn-${params.max == 50 ? "success" : "default"}">50</g:link>
    <g:link  action="list" params="${params + [max:100]}" class="btn btn-xs btn-${params.max == 100 ? "success" : "default"}">100</g:link>
</div>