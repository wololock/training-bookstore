package org.training

class Comment {
	
	String message
	Date dateCreated
	
	static belongsTo = [author: AppUser, book: Book]

    static constraints = {
		message(blank: false, nullable: false)
    }
}
