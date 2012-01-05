<g:form method="post" action="savevirement">
  <div class="dialog">

    <table>
      <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="name"><g:message code="scheduled.name.label" default="Name" />:</label>
          </td>
          <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'name', 'errors')}">
      <g:textField name="name" value="${fieldValue(bean: scheduledInstance, field: 'name')}" />
      </td>
      <td valign="top" class="name">
        <label for="dateApplication"><g:message code="scheduled.dateApplication.label" default="Date Application" /></label>
      </td>
      <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'dateApplication', 'errors')}">
        <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:scheduledInstance?.dateApplication)}" name="dateApplication" id="dateApplicationvirement"/>
      </td>
      </tr>

      <tr class="prop">
      <td valign="top" class="name">
        <label for="category"><g:message code="scheduled.category.label" default="Category" /></label>
      </td>
      <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'category', 'errors')}">
      <richui:autoComplete id="categoryvirement" name="category.name" action="${createLinkTo('dir': 'category/autocomplete/'+type)}"  value="${scheduledInstance?.category?.name}"/>
      </td>
      <td valign="top" class="name">
        <label for="dateLastApplication"><g:message code="scheduled.dateLastApplication.label" default="Date Last Application" /></label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: scheduledInstance, field: 'dateLasApplication', 'errors')}">
        <input type="text" value="${formatDate(format:'dd/MM/yyyy', date:scheduledInstance?.dateLastApplication)}" name="dateLastApplication" id="dateLastApplicationvirement"/>
      </td>
      </tr>

      <tr class="prop">

      
      <td valign="top" class="name">
          <label for="amount"><g:message code="scheduled.amount.label" default="Amount" /></label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'amount', 'errors')}">
      <g:textField name="amount" value="${fieldValue(bean: scheduledInstance, field: 'amount')}" />
      </td>
      <td valign="top" class="name">
          <label for="accountFrom"><g:message code="scheduled.accountFrom.label" default="Account" />:</label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'accountFrom', 'errors')}">
      <g:select optionValue="name" name="accountFrom.id" from="${accounts}" optionKey="id" value="${scheduledInstance?.accountFrom?.id}"  />
      </td>

      </tr>

      <tr class="prop">
      <td valign="top" class="name">
          <label for="note"><g:message code="scheduled.note.label" default="Note" /></label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: scheduledInstance, field: 'note', 'errors')}">
      <g:textArea name="note" cols="40" rows="5" value="${scheduledInstance?.note}" />
      </td>
      <td valign="top" class="name">
          <label for="accountTo"><g:message code="scheduled.accountTo.label" default="Account" />:</label>
        </td>
        <td valign="top" class="mandatory value ${hasErrors(bean: scheduledInstance, field: 'accountTo', 'errors')}">
      <g:select optionValue="name" name="accountTo.id" from="${accounts}" optionKey="id" value="${scheduledInstance?.accountTo?.id}"  />
      </td>

      </tr>

      <tr class="prop">       
      
      <td valign="top" class="name">
          <label for="automatic"><g:message code="scheduled.automatic.label" default="Automatic" /></label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: scheduledInstance, field: 'automatic', 'errors')}">
      <g:checkBox name="automatic" value="${scheduledInstance?.automatic}" />
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      </tr>

      </tbody>
    </table>

    <jq:jquery>
      jQuery("#dateApplicationvirement").datePicker({clickInput:true, startDate:'01/01/1996'});
      jQuery("#dateLastApplicationvirement").datePicker({clickInput:true, startDate:'01/01/1996'});
    </jq:jquery>
  </div>
  <div class="buttons">
    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
  </div>



</g:form>
