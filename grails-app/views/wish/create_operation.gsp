
<%@ page import="com.headbangers.epsilon.Wish" %>
<!doctype html>
<html>
  <head>
    <meta name="layout" content="main">
  <g:set var="entityName" value="${message(code: 'wish.label', default: 'Wish')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>

  <resource:autoComplete skin="default" />
</head>
<body>
  <div class="undernav">
    <span class="menuButton"><g:link class="list" action="list">Liste des futurs achats</g:link></span>
    <span class="menuButton"><g:link class="create" action="create">Nouveau futur achat</g:link></span>
  </div>

  <div class="body" role="main">
    <h1>J'achète ! Gaffe au budget !</h1>

    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>

    <g:set var="type" value="DEPENSE" />

    <g:form action="save_operation" method="post" >
      <div class="dialog">
        <table>
          <tbody>

          <input name="account.id" type="hidden" value="${selected?.id}"/>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="tiers"><g:message code="operation.tiers.label" default="Tiers" /></label>
            </td>
            <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'tiers', 'errors')}">

          <richui:autoComplete id="tiers${type}" name="tiers.name" action="${createLinkTo('dir': 'tiers/autocomplete')}" value="${operationInstance?.tiers?.name}" />
          <g:if test="${parameterBayesianFilter.equals("true")}" >
            <jq:jquery>
              jQuery('#tiers${type}').focusout (function(){
              tryToGuessCategoryWithTiersId(jQuery('#tiers${type}').val(), 'category${type}');        
              });
            </jq:jquery>
          </g:if>
          </td>

          <td valign="top" class="name">
            <label for="dateApplication"><g:message code="operation.dateApplication.label" default="Date Application" /></label>
          </td>
          <td valign="top" class="mandatory  value ${hasErrors(bean: operationInstance, field: 'dateApplication', 'errors')}">
            <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:operationInstance?.dateApplication)}" name="dateApplication" id="dateApplication${type}"/>
          </td>

          <jq:jquery>
            jQuery("#dateApplication${type}").datePicker({clickInput:true, startDate:'01/01/1996'})
            .val(new Date().asString()).trigger('change');
          </jq:jquery>

          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="category"><g:message code="operation.category.label" default="Category" /></label>
            </td>
            <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'category', 'errors')}">
          <richui:autoComplete id="category${type}" name="category.name" action="${createLinkTo('dir': 'category/autocomplete/'+type)}"  value="${operationInstance?.category?.name}"/>
          </td>

          <td valign="top" class="name">
            <label for="amount"><g:message code="operation.amount.label" default="Amount" /></label>
          </td>
          <td valign="top" class="mandatory  value ${hasErrors(bean: operationInstance, field: 'amount', 'errors')}">
          <g:textField name="amount" value="${fieldValue(bean: wishInstance, field: 'price')}" />
          </td>
          </tr>


          <tr class="prop">
            <td valign="top" class="name">
              <label for="note"><g:message code="operation.note.label" default="Note" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">
          <g:textArea name="note" cols="40" rows="50" value="${wishInstance?.description}"/>
          </td>

          <td valign="top" class="name">
            <label for="pointed"><g:message code="operation.pointed.label" default="Pointed" /></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: operationInstance, field: 'pointed', 'errors')}">
          <g:checkBox name="pointed" value="${operationInstance?.pointed}" />
          </td>
          </tr>

          </tbody>
        </table>


      </div>
      <div class="buttons">
        <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
      </div>
    </g:form>


  </div>

</body>
</html>
