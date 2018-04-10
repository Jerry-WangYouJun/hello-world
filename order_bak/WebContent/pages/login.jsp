<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="<%=path%>/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=path%>/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
	<link href="<%=path%>/vendor/dist/css/sb-admin-2.css" rel="stylesheet">
	<link href="<%=path%>/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<script src="<%=path%>/vendor/jquery/jquery.min.js"></script>
	<script src="<%=path%>/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=path%>/vendor/metisMenu/metisMenu.min.js"></script>
	<script src="<%=path%>/vendor/dist/js/sb-admin-2.js"></script>
  </head>
  
  <body>
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" id="log_form">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="userName" name="userName" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="userPwd" type="password" value="">
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <a class="btn btn-lg btn-success btn-block" onclick="submitForm()">Login</a>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
function submitForm(){
	$.ajax({ 
    	url: '${pageContext.request.contextPath}/userAction!login.action',
    	data : $('#log_form').serialize(),
    	dataType : 'json',
    	success : function(obj){
    		if(obj.success){
				location.replace('<%=path%>' + '/index.jsp');
			}else{
				alert(obj.msg);
			}
    	}
    });
}
</script>
  </body>
</html>
