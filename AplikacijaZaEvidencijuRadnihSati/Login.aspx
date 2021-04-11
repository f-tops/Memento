<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AplikacijaZaEvidencijuRadnihSati.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style type="text/css">
        .container {
            text-align: center;
        }

        .login-container {
            margin-top: 5%;
            margin-bottom: 5%;
        }

        .row {
            justify-content: center;
        }

        .form-control {
            text-align: center;
        }

        .form-group {
            text-align: center !important;
        }

        .login-form-1 {
            padding: 5%;
            box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);
        }

            .login-form-1 h3 {
                text-align: center;
                color: #333;
            }

        .btnSubmit {
            width: 50%;
            border-radius: 1rem;
            padding: 1.5%;
            border: none;
            cursor: pointer;
        }

        .login-form-1 .btnSubmit {
            font-weight: 600;
            color: #fff;
            background-color: #0062cc;
        }

        .auto-style1 {
            color: #FF0000;
        }
    </style>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.js"></script>
    <script src="Scripts/jquery-3.0.0-vsdoc.js"></script>
    <link runat="server" rel="shortcut icon" href="Slike/favicon.ico" type="image/x-icon" />
    <link runat="server" rel="icon" href="Slike/favicon.ico" type="image/ico" />

</head>
<body>

    <form id="form1" runat="server">
        <div class="container login-container">
            <div class="row">
                <div class="col-lg-4 login-form-1">
                    <asp:Image ID="Image1" runat="server" Height="205px" ImageUrl="~/Slike/logo.png" Width="285px" />
                    <h3>Dobrodošli!</h3>
                    <h5>Unesite Vaše login podatke.</h5>
                    <asp:Label ID="LblPoruka" runat="server" CssClass="auto-style1"></asp:Label>

                    <div class="form-group">
                        <br />
                        <asp:TextBox ID="TbEmail" TextMode="Email" runat="server" CssClass="form-control" placeholder="Email*"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TbEmail" ErrorMessage="E-mail je obavezan!" CssClass="auto-style1"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <asp:TextBox ID="TbPassword" TextMode="Password" runat="server" CssClass="form-control" placeholder="Password*"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TbPassword" ErrorMessage="Password je obavezan!" CssClass="auto-style1"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                            <asp:ListItem Value="0">Evidencija radnih sati</asp:ListItem>
                            <asp:ListItem Value="1">Administracija</asp:ListItem>
                        </asp:DropDownList>

                        <br />
                    </div>

                    <div class="form-group">
                        <asp:Button ID="BtnLogin" runat="server" OnClick="BtnLogin_Click" Text="Login" Width="100px" CssClass="btnSubmit" />
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center py-3">© 2021 Franjo Topić</div>
    </form>

</body>
</html>
