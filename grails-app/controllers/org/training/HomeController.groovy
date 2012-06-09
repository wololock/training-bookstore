package org.training

class HomeController {

    def index() {
	
		def books = Book.withCriteria {
			order("dateCreated", "desc")
			maxResults(5)
		}
		
		def comments = Comment.withCriteria {
			order("dateCreated", "desc")
			maxResults(5)
		}
		
		[books: books, comments: comments]
	}
}
