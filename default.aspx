<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="WebAppTest4Siavash._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="LoginPage.css">
    <title>First Try to dev wep app</title>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>  
    <script> 
        $('.message a').click(function(){
           $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
        });        
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="login-page">
      <div class="form">                  
        <form class="login-form" runat="server">
          <asp:TextBox id="myUsername" name="username" runat="server"/> 
          <asp:TextBox id="myPassword" name="password" runat="server"/>
          <asp:Button Text="Log In" runat="server" onclick="CheckUserNamePassword" ID="buttonLogIn" />
          <p> Register a new user: <asp:button onclick="SendToSignUpPage" id="SendToSignUpPageButton" runat="server" Text="Create" style="border:none;font-weight:800;color:blue"/>  </p>            
        </form>
      </div>
        <div id="myMessageArea" runat="server"></div>
</div>


</div>
</body>
</html>
