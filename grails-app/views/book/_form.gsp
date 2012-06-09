<%@ page import="org.training.Book" %>

<r:require module="fileuploader"/>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="book.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${bookInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="book.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${bookInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'ISBN', 'error')} required">
	<label for="ISBN">
		<g:message code="book.ISBN.label" default="ISBN" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="ISBN" required="" value="${bookInstance?.ISBN}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'author', 'error')} required">
	<label for="author">
		<g:message code="book.author.label" default="Author" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="author" name="author.id" from="${org.training.Author.list()}" optionKey="id" optionValue="realName" required="" value="${bookInstance?.author?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'category', 'error')} required">
	<label for="category">
		<g:message code="book.category.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="category" name="category.id" from="${org.training.Category.list()}" optionKey="id" optionValue="name" required="" value="${bookInstance?.category?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'cover', 'error')} ">
	<label for="cover">
		<g:message code="book.cover.label" default="Cover" />		
	</label>
	
	<span id="cover-thumbnail">
	<g:if test="${bookInstance?.cover}">
		<img src="${resource(dir:'upload', file:bookInstance.cover)}" width="100" />
	</g:if>
	</span>
	
	<uploader:uploader id="bookCoverUpload" url="[controller:'book', action:'upload', id: bookInstance.id]">
		<uploader:onComplete>
		jQuery("#cover-thumbnail").html(jQuery("<img>").attr("src", responseJSON.cover).attr("width", 100));
		</uploader:onComplete>
	</uploader:uploader>
</div>
