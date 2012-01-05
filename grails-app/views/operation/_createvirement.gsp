<g:hasErrors bean="${operationInstance}">
  <div class="errors">
    <g:renderErrors bean="${operationInstance}" as="list" />
  </div>
</g:hasErrors>
<g:form action="savevirement" method="post" >
  <div class="dialog">
    <table>
      <tbody>

      <input name="account.id" type="hidden" value="${selected?.id}"/>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="account.to">Virement vers</label>
        </td>
        <td valign="top" class="value mandatory ">

        <g:select optionValue="name" name="account.to" from="${accounts}" optionKey="id"/>

      </td>

      <td valign="top" class="name">
        <label for="dateApplication"><g:message code="operation.dateApplication.label" default="Date Application" /></label>
      </td>
      <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'dateApplication', 'errors')}">
        <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:operationInstance?.dateApplication)}" name="dateApplication" id="dateApplicationvirement"/>
      </td>

      <jq:jquery>
        jQuery("#dateApplicationvirement").datePicker({clickInput:true, startDate:'01/01/1996'})
        .val(new Date().asString()).trigger('change');
      </jq:jquery>

      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="category"><g:message code="operation.category.label" default="Category" /></label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'category', 'errors')}">
      <richui:autoComplete id="categoryvirement" name="category.name" action="${createLinkTo('dir': 'category/autocomplete/'+type)}"  value="${operationInstance?.category?.name}"/>
      </td>

      <td valign="top" class="name">
        <label for="amount"><g:message code="operation.amount.label" default="Amount" /></label>
      </td>
      <td valign="top" class="mandatory value ${hasErrors(bean: operationInstance, field: 'amount', 'errors')}">
      <g:textField name="amount" value="${fieldValue(bean: operationInstance, field: 'amount')}" />
      </td>
      </tr>


      <tr class="prop">
        <td valign="top" class="name">
          <label for="note"><g:message code="operation.note.label" default="Note" /></label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: operationInstance, field: 'note', 'errors')}">
          <g:textArea name="note" cols="40" rows="50" value="${operationInstance?.note}"/>
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
