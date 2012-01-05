<div id="search">
  <form action="search" method="post">
    <richui:autoComplete id="search${controllerName}" name="query" action="${createLinkTo('dir': controllerName+'/autocomplete')}" />
    <button>chercher</button>
  </form>
</div>