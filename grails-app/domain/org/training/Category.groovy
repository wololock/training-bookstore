package org.training

import java.util.Date;

class Category {
	
	String name
	Date dateCreated
	
	static hasMany = [books: Book]

    static constraints = {
		name(blank: false, nullable: false, unique: true)
    }
}
