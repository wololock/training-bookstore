package org.training

import java.util.Date;

class Book {
	
	String title
	String description
	String ISBN
	String cover
	Date dateCreated
	
	static searchable = {
		author(component: true)
	}
	
	static belongsTo = [author: Author, category: Category]
	
	static hasMany = [comments: Comment]
	
	static mapping = {
		comments(sort: "dateCreated", order: "desc")
	}

    static constraints = {
		title(blank: false, nullable: false)
		description(blank: true, nullable: true)
		ISBN(blank: false, nullable: false, unique: true)
		cover(blank: true, nullable: true)
    }
}
