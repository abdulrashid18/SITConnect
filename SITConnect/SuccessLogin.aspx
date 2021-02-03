<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuccessLogin.aspx.cs" Inherits="SITConnect.SuccessLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lb_msg" runat="server" EnableViewState="false"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btn_password" runat="server" OnClick="btn_password_Click" Text="Change Password" />
            <br />
            <br />
            <asp:Button ID="btn_logout" runat="server" OnClick="btn_logout_Click" Text="Log Out" Visible="false"/>
        </div>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
