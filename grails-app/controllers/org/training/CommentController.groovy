package org.training

class CommentController {

	def add = {

		if (request.method == "POST") {

			def book = Book.get(params.id)

			if (book != null) {

				def comment = new Comment(message: params.message, book: book, author: getAuthenticatedUser()).save(flush: true)

				def messages = Comment.withCriteria {
					eq("book", book)
					order("dateCreated", "desc")
				}

				render template: "/book/comment", collection: messages, var: "comment"
			}
		}
	}
}
