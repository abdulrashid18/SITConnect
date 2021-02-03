<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuccessRegister.aspx.cs" Inherits="SITConnect.SuccessRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lb_msg1" runat="server">Your account have been suceessfully registered!</asp:Label>
        </div>
        <asp:Button ID="lb_loginpage" runat="server" OnClick="lb_loginpage_Click" Text="Login Page" />
    </form>
</body>
</html>
