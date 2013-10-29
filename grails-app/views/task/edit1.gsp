<g:form name="addForm" action="save" id="${task?.id}">
    Subject: <g:textField name="subject" value="${task?.subject}"/><br/>
    Due Date: <g:datePicker name="dueDate" value="${task?.dueDate?:(new Date())}"/><br/>
    Completed: <g:checkBox name="completed" value="${task?.completed}"/><br/>
    <g:submitButton name="save" value="Save" />
</g:form>