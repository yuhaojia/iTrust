<%--
  Created by IntelliJ IDEA.
  User: jeehaengyoo
  Date: 11/4/17
  Time: 2:21 PM
  To change this template use File | Settings | File Templates.
--%>
<form method="post" action="/iTrust/login.jsp">
    MID<br />
    <input type="text" maxlength="10" id="j_username" name="j_username" style="width: 97%;"><br />
    Password<br />
    <input type="password" maxlength="20" id="j_password" name="j_password" style="width: 97%;"><br /><br />
    <input type="submit" value="Login"><br /><br />
</form>

<form method="post" action="/iTrust/logout.jsp">
    <input type="submit" value="Back to Main"><br />
</form>
