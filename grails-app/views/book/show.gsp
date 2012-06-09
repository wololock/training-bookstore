
<%@ page import="org.training.Book" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-book" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<sec:access url="/book/create">
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</sec:access>
			</ul>
		</div>
		<div id="show-book" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list book">
			
				<g:if test="${bookInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="book.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${bookInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="book.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${bookInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookInstance?.ISBN}">
				<li class="fieldcontain">
					<span id="ISBN-label" class="property-label"><g:message code="book.ISBN.label" default="ISBN" /></span>
					
						<span class="property-value" aria-labelledby="ISBN-label"><g:fieldValue bean="${bookInstance}" field="ISBN"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookInstance?.author}">
				<li class="fieldcontain">
					<span id="author-label" class="property-label"><g:message code="book.author.label" default="Author" /></span>
					
						<span class="property-value" aria-labelledby="author-label"><g:link controller="author" action="show" id="${bookInstance?.author?.id}">${bookInstance?.author?.realName?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="book.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label"><g:link controller="category" action="show" id="${bookInstance?.category?.id}">${bookInstance?.category?.name?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				
				<g:if test="${bookInstance?.cover}">
				<li class="fieldcontain">
					<span id="cover-label" class="property-label"><g:message code="book.cover.label" default="Cover" /></span>
					<span class="property-value" aria-labelledby="cover-label">
						<img src="${resource(dir:'upload', file: bookInstance.cover) }" width="100" />
					</span>					
				</li>
				</g:if>
				
				<li class="fieldcontain">
					<span id="qrcode-label" class="property-label"><g:message code="book.qrcode.label" default="QR code" /></span>
					<span class="property-value" aria-labelledby="qrcode-label">
						<p>URL: ${createLink(absolute: true, controller: 'book', action: 'show', id: bookInstance.id)}</p>
						<p><qrcode:image text="${createLink(absolute: true, controller: 'book', action: 'show', id: bookInstance.id)}" width="140" height="140" /></p>
					</span>					
				</li>
			
			</ol>
			
			<h1>Comments</h1>
			<div style="padding:10px 20px" id="comments-container">
			<g:if test="${bookInstance.comments.size() > 0}">
				<g:render template="comment" collection="${bookInstance.comments}" var="comment" />
			</g:if>
			<g:else>
				No comments added yet
			</g:else>
			</div>
			
			<h1>Add comment</h1>
			<div style="padding:10px 20px">
			<sec:ifLoggedIn>
				<g:formRemote name="postCommentForm" url="[controller: 'comment', action: 'add', id: bookInstance.id]" method="post" update="comments-container">
					<p><g:textArea name="message"></g:textArea></p>
					<p><g:submitButton name="Post comment"/></p>
				</g:formRemote>
			</sec:ifLoggedIn>
			<sec:ifNotLoggedIn>You must be logged in to post comments</sec:ifNotLoggedIn>
			</div>
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${bookInstance?.id}" />
					<sec:access url="/book/edit">
					<g:link class="edit" action="edit" id="${bookInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					</sec:access>
					<sec:access url="/book/delete">
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</sec:access>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
