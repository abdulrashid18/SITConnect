<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="SITConnect.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 31px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <strong>
            <asp:Label ID="Label1" runat="server" Text="Registration"></asp:Label>
            </strong>
        </div>
    <table style="width:100%;">
        <tr>
            <td>
                <asp:Label ID="lb_firstname" runat="server" Text="First Name"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tb_firstname" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lb_lastname" runat="server" Text="Last Name"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tb_lastname" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lb_credit" runat="server" Text="Credit Card Number"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tb_credit" runat="server" TextMode="Number"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                <asp:Label ID="lb_expiry" runat="server" Text="Expire Date"></asp:Label>
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="tb_expiry" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lb_cvv" runat="server" Text="CVV"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tb_cvv" runat="server" TextMode="Number"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lb_email" runat="server" Text="Email Address"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tb_email" runat="server" TextMode="Email"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                <asp:Label ID="lb_password" runat="server" Text="Password"></asp:Label>
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="tb_password" runat="server" onkeyup="javascript:validate()" TextMode="Password"></asp:TextBox>
                <asp:Label ID="lb_errpass" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lb_dob" runat="server" Text="Date of Birth"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tb_dob" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
                <br />
        <asp:Label ID="lb_msg" runat="server" ForeColor="Red"></asp:Label>
        <br />
                <asp:Label ID="lb_errpassword" runat="server" ForeColor="Red"></asp:Label>
    </form>
    </body>
    <script type="text/javascript">
        function validate() {
            var str = document.getElementById('<%=tb_password.ClientID %>').value;
            if (str.length < 8) {
                document.getElementById("lb_errpass").innerHTML = "Password length must be at least 8 characters";
                document.getElementById("lb_errpass").style.color = "Red";
                return ("too_short");
            }
            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("lb_errpass").innerHTML = "Password requires at least 1 number";
                document.getElementById("lb_errpass").style.color = "Red";
                return ("no_number");
            }
            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById("lb_errpass").innerHTML = "Password requires at least 1 uppercase letter";
                document.getElementById("lb_errpass").style.color = "Red";
                return ("no_upper");
            }
            else if (str.search(/[a-z]/) == -1) {
                document.getElementById("lb_errpass").innerHTML = "Password requires at least 1 lowercase letter";
                document.getElementById("lb_errpass").style.color = "Red";
                return ("no_lower");
            }
            else if (str.search(/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?*$]/) == -1) {
                /*alternative str.search(/[^A-Za-z0-9]/) */
                document.getElementById("lb_errpass").innerHTML = "Password requires at least 1 special character";
                document.getElementById("lb_errpass").style.color = "Red";
                return ("no_special");
            }

            document.getElementById("lb_errpass").innerHTML = "Excellent!";
            document.getElementById("lb_errpass").style.color = "Blue";
        }
    </script>
</html>
