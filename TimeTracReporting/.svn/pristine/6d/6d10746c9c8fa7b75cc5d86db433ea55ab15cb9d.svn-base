<%@ include file="header.jsp" %>

<body>
	<div class="header">
		<div class="login-logo">
			<img src="images/logo2.png" alt="Stewart &amp; Stevenson" />
		</div>
		<div class="login-logo-center-text">Stewart &amp; Stevenson</div>
	</div>
	<div class="header-bar">
		<div class="text">TRAC / TIME TRAC REPORT</div>
	</div>
	<div class="login-bar-spacer"></div>
	<div class="content">
	<p class="instruction-login">
		<b>Use your JDE username and password to run a report on time worked and time off.  
	</p>
		<form class="login-form-auth login-form"
			method="post" action="authenticate.action">
			<label for="abn">Login Id</label> <input type="text" id="abn"
				name="abn" value="" autofocus/>
			<div class="clear"></div>
			<label for="password">Password</label>
			<input type="password" id="password" name="password" value="" />								
			<div class="clear"></div>
			<label></label> <input type="submit" id="loginBtn" value="Log in" />					
			<c:if test="${not empty invalidLogin}">
			   <p class="invalid-login">
   				<c:out value="**********Invalid Login**********"/>
   			   </p>
			</c:if>						
		</form>
		
	</div>	
<%@ include file="footer.jsp" %>