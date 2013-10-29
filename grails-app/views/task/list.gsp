<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>ToDo List</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: "css", file: "list.css")}"/>
    <g:javascript src="jquery-2.0.3.min.js"/>
    <g:javascript src="site.js"/>
</head>
<body id="body" class="body">

<div class="container" id="main">
    <div id="head">
        <h1><label>ToDo List</label></h1>
    </div>

    <table>
        <tr>
            <g:formRemote id="add_form" name="add_form" update="body" url="[controller: 'task', action: 'save']">
                <td>
                    <g:textField size="50" name="subject" autofocus="true" class="field"
                                 placeholder="Start typing for create new task..." />
                </td>
                <td>
                    <span id="add_button" class="add"><label>Add Task</label></span>
                </td>
            </g:formRemote>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <g:remoteLink update="body" action="checkAll" style="text-decoration: none">
                    <label class="change">Change All</label>
                </g:remoteLink>
            </td>
        </tr>
    </table>
    <table>
    <!--start g:each-->
        <g:each in="${tasks}" var="task">
            <tr>
                <td>
                    <g:remoteLink update="body" style="text-decoration: none"
                                  class="checkAll" action="check" id="${task.id}">
                        <img src="${createLinkTo(dir: 'images/app', file: 'change.png')}"/>
                    </g:remoteLink>
                </td>
                <g:if test="${task.completed}">
                    <td class="subject"><label style="text-decoration: line-through">${task.subject}</label></td>
                </g:if>
                <g:else>
                    <td class="subject"><label>${task.subject}</label></td>
                </g:else>
                <td>
                    <g:remoteLink update="body" action="upPriority"
                                  id="${task.id}" style="text-decoration: none">
                        <img src="${createLinkTo(dir: 'images/app', file: 'up.png')}"/>
                    </g:remoteLink>
                </td>
                <td>
                    <g:remoteLink update="body" action="downPriority"
                                  id="${task.id}" style="text-decoration: none">
                        <img src="${createLinkTo(dir: 'images/app', file: 'down.png')}"/>
                    </g:remoteLink>
                </td>
                <td>
                    <g:remoteLink update="body" action="delete"
                                  style="text-decoration: none" id="${task.id}">
                        <img src="${createLinkTo(dir: 'images/app', file: 'delete.png')}"/>
                    </g:remoteLink>
                </td>
            </tr>
        </g:each>
    </table>

    <table>
        <tr>
            <td>
                <g:if test="${tasks?.size() == completedTasks?.size()}">
                    <label>All tasks are completed!</label>
                </g:if>
                <g:else>
                    <label>${completedTasks?.size()}: completed tasks</label><br/>
                    <g:if test="${(tasks?.size() - completedTasks?.size()) == 1}">
                        <label>${tasks?.size() - completedTasks?.size()}: open task</label>
                    </g:if>
                    <g:else>
                        <label>${tasks?.size() - completedTasks?.size()}: open tasks</label>
                    </g:else>
                </g:else>
            </td>
        </tr>
    </table>
</div>

</body>
</html>