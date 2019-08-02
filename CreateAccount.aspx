<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="WebAppTest4Siavash.CreateAccount" %>

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
          First name:<asp:TextBox id="myFirstname" name="firstname" runat="server"/> 
          Last name:<asp:TextBox id="myLastname" name="lastname" runat="server"/> 
          Username:<asp:TextBox id="myUsername" name="username" runat="server"/> 
          Password<asp:TextBox id="myPassword" name="password" runat="server"/>
          <asp:Button Text="Create" runat="server" onclick="CreateUserNamePassword" ID="buttonLogIn" />
          <p> already have an account: <asp:Button onclick="SendToLoginPage" id="SendToLoginPageButton" runat="server" Text="Log in" style="border:none;font-weight:800;color:blue" /></p>            
        </form>
      </div>
        <div id="myMessageArea" runat="server"></div>
    </div>
</body>
</html>
