package todolist

class TaskController {

    def index() {
        redirect(action: list)
    }

    def list = {
        [tasks: Task.findAll().sort {it.priority}.reverse(), completedTasks: Task.findAllByCompleted(true)]
    }

    def checkAll = {
        def tasks = Task.findAll()
        def compTasks = Task.findAllByCompleted(true)
        if (tasks.size() == compTasks.size())
            tasks.each {task -> task.completed = !task.completed}
        else
            tasks.each {task -> task.completed = true}
        redirect(action: "list")
    }

    def save = {
        def tasks = Task.findAll()
        tasks?.each {it.priority += 1}
        new Task(params).save()
        redirect(action: "list")
    }

    def delete = {
        def task = Task.findById(params.id)
        def taskPriority = task.priority
        task?.delete()
        def tasks = Task.findAll("from Task as t where t.priority > :pr", [pr: taskPriority])
        tasks?.each {it.priority -=1}
        redirect(action: "list")
    }

    def check = {
        def task = Task.findById(params.id)
        task.completed = !task.completed
        redirect(action: "list")
    }

    def edit = {
        def task = Task.findById(params.id)
        task?.subject = params?.subject
        redirect(action: "list")
    }

    def upPriority = {
        def changedTask = Task.findById(params.id)
        def changedPriority = changedTask?.priority
        def task = Task.find("from Task as t where t.priority = :pr", [pr: (changedPriority + 1)])
        if(task) {
            changedTask?.priority = task?.priority
            task?.priority = changedPriority
        }
        redirect(action: "list")
    }

    def downPriority = {
        def changeTask = Task.findById(params.id)
        def changePriority = changeTask.priority
        def task = Task.find("from Task as t where  t.priority = :pr", [pr: (changePriority - 1)])
        if (task) {
            changeTask?.priority = task?.priority
            task?.priority = changePriority
        }
        redirect(action: "list")
    }
}
