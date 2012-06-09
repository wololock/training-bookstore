
<%@ page import="org.training.Book" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-book" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<sec:access url="/book/create">
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</sec:access>
			</ul>
		</div>
		
		<div id="searchable" style="padding:10px">
			<h1>Search</h1>			
			<g:form method="get">
				<g:textField name="q" value="${params?.q?.encodeAsHTML()}" />
				<g:submitButton name="Search" />
			</g:form>
		</div>
		
		<div id="list-book" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
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
				<g:each in="${bookInstanceList}" status="i" var="bookInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${bookInstance.id}">${fieldValue(bean: bookInstance, field: "title")}</g:link></td>
					
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
			<div class="pagination">
				<g:paginate total="${bookInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
