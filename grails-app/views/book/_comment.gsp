<div id="comment-${comment.id}" style="padding: 0 0 10px 5px;">
	<p><g:formatDate date="${comment.dateCreated}" /> <b>${comment.author.username}</b> said:</p>
	<p>${comment.message.encodeAsHTML()}</p>
</div>