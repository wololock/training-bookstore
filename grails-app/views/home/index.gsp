
<%@ page import="org.training.Book" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
	</head>
	<body>
		
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(controller: 'book')}">Books</a></li>
				<li><a class="home" href="${createLink(controller: 'author')}">Authors</a></li>
				<li><a class="home" href="${createLink(controller: 'category')}">Categories</a></li>
			</ul>
		</div>
		
		<div id="list-book" class="content scaffold-list" role="main">
			<h1>Latest ${books.size()} books</h1>
			<table>
				<thead>
					<tr>					
						<g:sortableColumn property="title" title="${message(code: 'book.title.label', default: 'Title')}" />					
						<g:sortableColumn property="description" title="${message(code: 'book.description.label', default: 'Description')}" />					
						<g:sortableColumn property="ISBN" title="${message(code: 'book.ISBN.label', default: 'ISBN')}" />						
						<th><g:message code="book.comments.label" default="Comments" /></th>					
						<th><g:message code="book.author.label" default="Author" /></th>					
						<th><g:message code="book.category.label" default="Category" /></th>						
						<th><g:message code="book.cover.label" default="Cover" /></th>					
					</tr>
				</thead>
				<tbody>
				<g:each in="${books}" status="i" var="bookInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" controller="book" id="${bookInstance.id}">${fieldValue(bean: bookInstance, field: "title")}</g:link></td>
						<td>${fieldValue(bean: bookInstance, field: "description")}</td>
						<td>${fieldValue(bean: bookInstance, field: "ISBN")}</td>						
						<td>${bookInstance.comments.size()}</td>						
						<td>${fieldValue(bean: bookInstance, field: "author.realName")}</td>					
						<td>${fieldValue(bean: bookInstance, field: "category.name")}</td>						
						<td>
						<g:if test="${bookInstance?.cover}">
							<img src="${resource(dir:'upload', file: bookInstance.cover) }" width="50" />
						</g:if>
						</td>					
					</tr>
				</g:each>
				</tbody>
			</table>

		</div>
	</body>
</html>
