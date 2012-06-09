package org.training

import grails.converters.JSON;

import org.apache.commons.fileupload.FileUploadException;
import org.springframework.dao.DataIntegrityViolationException

class BookController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST", upload: "POST"]
	
	def ajaxUploaderService

	def index() {
		redirect(action: "list", params: params)
	}

	def list() {

		def resultList, total = 0

		if (params.q != null) {
			def query = "*${params.q.encodeAsHTML()}*"
			def books = Book.search(query, [reload: true])

			println books

			resultList = books.results
			total = books.total
		} else {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			resultList = Book.list(params)
			total = Book.count()
		}

		[bookInstanceList: resultList, bookInstanceTotal: total]
	}

	def create() {
		[bookInstance: new Book(params)]
	}

	def save() {
		def bookInstance = new Book(params)
		if (!bookInstance.save(flush: true)) {
			render(view: "create", model: [bookInstance: bookInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [
			message(code: 'book.label', default: 'Book'),
			bookInstance.id
		])
		redirect(action: "show", id: bookInstance.id)
	}

	def show() {
		def bookInstance = Book.get(params.id)
		if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "list")
			return
		}

		[bookInstance: bookInstance]
	}

	def edit() {
		def bookInstance = Book.get(params.id)
		if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "list")
			return
		}

		[bookInstance: bookInstance]
	}

	def update() {
		def bookInstance = Book.get(params.id)
		if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (bookInstance.version > version) {
				bookInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[
							message(code: 'book.label', default: 'Book')]
						as Object[],
						"Another user has updated this Book while you were editing")
				render(view: "edit", model: [bookInstance: bookInstance])
				return
			}
		}

		bookInstance.properties = params

		if (!bookInstance.save(flush: true)) {
			render(view: "edit", model: [bookInstance: bookInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [
			message(code: 'book.label', default: 'Book'),
			bookInstance.id
		])
		redirect(action: "show", id: bookInstance.id)
	}

	def delete() {
		def bookInstance = Book.get(params.id)
		if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "list")
			return
		}

		try {
			bookInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "show", id: params.id)
		}
	}

	def upload() {

		if (request.method == "POST") {
			try {

				def file = new File("web-app/upload/" + params.qqfile)

				ajaxUploaderService.upload(request.inputStream, file)

				def book = Book.get(params.id)
				book.cover = file.getName()
				book.save(flush: true)

				def cover = g.resource(file: file.getName(), dir: 'upload').toString()

				return render(text: [success:true, cover: cover] as JSON, contentType: "application/json")
			} catch (FileUploadException e) {

				log.error("Failed to upload file.", e)

				return render(text: [success:false] as JSON, contentType: "application/json")
			}
		}
	}
}
