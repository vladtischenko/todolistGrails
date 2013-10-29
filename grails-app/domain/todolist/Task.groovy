package todolist

class Task {

	String subject
	boolean completed = false
    int priority = 0

    static constraints = {
		subject (blank: false)
    }

    static mapping = {
        version false
        sort priority: "desc"
    }
}
