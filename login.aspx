<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="score_m.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" href="resource/css/base.css"/>
    <style>
           body {
                background: var(--half_background);
        }
        .cont {
            background-color: #FFF;
            width: 400px;
            height: 300px;
            margin: 200px auto;
            box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
            border-radius: 10px;
            display: flex;
            flex-flow: column;
            justify-content: space-around;
            align-items: center;
        }


        .myTextboxStyle {
           background-color: #fff;
            background-image: none;
            border-radius: 4px;
            border: 1px solid #dcdfe6;
            box-sizing: border-box;
            color: #606266;
            display: inline-block;
            font-size: inherit;
            height: 40px;
            line-height: 40px;
            outline: none;
            padding: 0 15px;
            transition: border-color .2s cubic-bezier(.645,.045,.355,1);
            min-width: 140px;
        }


    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cont"">
            <div>
                <asp:Label ID="Label1" runat="server" Text="User Role:  "></asp:Label>
                <asp:DropDownList ID="roleInput" runat="server">
                    <asp:ListItem Value="student">Student</asp:ListItem>
                    <asp:ListItem Value="admin">Administrator</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div>
                <asp:Label ID="Label2" runat="server" Text="Username:  "></asp:Label>
                <asp:TextBox ID="idInput" runat="server" placeholder="Please enter username"></asp:TextBox>
            </div>
            <div>
                <asp:Label ID="Label3" runat="server" Text="Password:  "></asp:Label>
                <asp:TextBox ID="passwordInput" runat="server" TextMode="Password" placeholder="Please enter password" CssClass="myTextboxStyle"></asp:TextBox>
            </div>
            <div>
                <asp:Button ID="Button1" runat="server" Text=" Login " OnClick="Button1_Click" />
            </div>
        </div>
    </form>
</body>
</html>
