<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SITConnect.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <script src="https://www.google.com/recaptcha/api.js?render=6LdjaUgaAAAAAAynCU-bEjg0U_QDhQq7dm28HGjI"></script>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <strong>
            <asp:Label ID="Label1" runat="server" Text="Login"></asp:Label>
            </strong>
        </div>
    <table class="auto-style1">
        <tr>
            <td>
                <asp:Label ID="lb_email" runat="server" Text="Email Address"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tb_email" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lb_password" runat="server" Text="Password"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tb_password" runat="server" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
    </table>
        <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response" />
        <asp:Button ID="btn_login" runat="server" OnClick="btn_login_Click" Text="Login" />
        <p>
        <asp:Label ID="lb_error" runat="server" ForeColor="Red"></asp:Label>
        </p>
    </form>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6LdjaUgaAAAAAAynCU-bEjg0U_QDhQq7dm28HGjI', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
    </body>
</html>
