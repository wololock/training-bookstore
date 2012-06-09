package org.training

import java.util.Date;

class Author {
	
	String realName
	Date dateCreated
	
	static searchable = true
	
	static hasMany = [books: Book]

    static constraints = {
		realName(blank: false, nullable: false)
    }
}
