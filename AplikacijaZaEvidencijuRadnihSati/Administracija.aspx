<%@ Page Title="Administracija" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Administracija.aspx.cs" Inherits="AplikacijaZaEvidencijuRadnihSati.Administracija" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>

        .table {
            padding-left:20px;
            padding-right:20px;
            box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);
        }

        .tablica1{
            padding-bottom:20px;
        }
        .label{
            padding-top:20px;
            padding-bottom:20px;
        }
    </style>
    <div class="card">
        <div class="tablica1 table text-center table-striped">
            <div class="label">
            <asp:Label ID="Label1" runat="server" Text="Administracija djelatnika" Font-Size="Large" Font-Bold="True"></asp:Label>
            </div>
            <asp:GridView ID="GVDjelatnici" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IDDjelatnik" DataSourceID="SDSDjelatnici" CssClass="table" Font-Size="Small">
                <Columns>
                    <asp:BoundField DataField="IDDjelatnik" HeaderText="IDDjelatnik" ReadOnly="True" SortExpression="IDDjelatnik" />
                    <asp:BoundField DataField="Djelatnik" HeaderText="Djelatnik" ReadOnly="True" SortExpression="Djelatnik" />
                    <asp:BoundField DataField="DatumZaposlenja" HeaderText="Datum zaposlenja" SortExpression="DatumZaposlenja" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="Zaporka" HeaderText="Zaporka" SortExpression="Zaporka" />
                    <asp:BoundField DataField="Naziv" HeaderText="Tip djelatnika" SortExpression="Naziv" />
                    <asp:BoundField DataField="Naziv1" HeaderText="Naziv tima" SortExpression="Naziv1" />
                    <asp:CommandField ShowEditButton="True" />
                </Columns>
            </asp:GridView>

        <asp:SqlDataSource ID="SDSDjelatnici" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" DeleteCommand="DELETE FROM [Djelatnik] WHERE [IDDjelatnik] = @IDDjelatnik" InsertCommand="INSERT INTO [Djelatnik] ([IDDjelatnik], [Ime], [Prezime], [Email], [DatumZaposlenja], [Zaporka], [TipDjelatnikaID], [TimID]) VALUES (@IDDjelatnik, @Ime, @Prezime, @Email, @DatumZaposlenja, @Zaporka, @TipDjelatnikaID, @TimID)" SelectCommand="GetDjelatnici" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE [Djelatnik] SET [Ime] = @Ime, [Prezime] = @Prezime, [Email] = @Email, [DatumZaposlenja] = @DatumZaposlenja, [Zaporka] = @Zaporka, [TipDjelatnikaID] = @TipDjelatnikaID, [TimID] = @TimID WHERE [IDDjelatnik] = @IDDjelatnik">
            <DeleteParameters>
                <asp:Parameter Name="IDDjelatnik" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="IDDjelatnik" Type="Int32" />
                <asp:Parameter Name="Ime" Type="String" />
                <asp:Parameter Name="Prezime" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="DatumZaposlenja" />
                <asp:Parameter Name="Zaporka" Type="String" />
                <asp:Parameter Name="TipDjelatnikaID" Type="Int32" />
                <asp:Parameter Name="TimID" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter Name="TimID" SessionField="TimID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Ime" Type="String" />
                <asp:Parameter Name="Prezime" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter DbType="DateTime2" Name="DatumZaposlenja" />
                <asp:Parameter Name="Zaporka" Type="String" />
                <asp:Parameter Name="TipDjelatnikaID" Type="Int32" />
                <asp:Parameter Name="TimID" Type="Int32" />
                <asp:Parameter Name="IDDjelatnik" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <div class="btn">
            Dodaj djelatnika u tim<br />
            <asp:DropDownList ID="DDLDjelatnici" runat="server" DataSourceID="SDSDjelatnici2" DataTextField="Column1" DataValueField="IDDjelatnik" CssClass="dropdown">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SDSDjelatnici2" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" SelectCommand="SELECT [Ime] +' '+[Prezime], [IDDjelatnik] FROM [Djelatnik] WHERE ([TimID] &lt;&gt; @TimID) ORDER BY [Prezime] ASC">
                <SelectParameters>
                    <asp:SessionParameter Name="TimID" SessionField="TimID" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:Button ID="BtnDodaj" runat="server" OnClick="BtnDodaj_Click" Text="Dodaj" CssClass="btn-info" />

                    </div>
        </div>

        <div class="tablica2 table text-center table-striped">
            <div class="label">
            <asp:Label ID="LabelAdminProjekt" runat="server" Text="Administracija djelatnika" Font-Size="Large" Font-Bold="True"></asp:Label>
            </div>
            <asp:GridView ID="GVProjekt" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IDProjekt" DataSourceID="SDSProjekt" Font-Size="Small" OnSelectedIndexChanged="GVProjekt_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="Naziv" HeaderText="Projekt" SortExpression="Naziv" />
                    <asp:BoundField DataField="Naziv1" HeaderText="Klijent" SortExpression="Naziv1" />
                    <asp:BoundField DataField="DatumOtvaranja" HeaderText="DatumOtvaranja" SortExpression="DatumOtvaranja" />
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SDSProjekt" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" SelectCommand="select Projekt.IDProjekt, Projekt.Naziv, Klijent.Naziv, Projekt.DatumOtvaranja from Projekt
inner join Klijent on Klijent.IDKlijent = Projekt.KlijentID
where Projekt.VoditeljProjektaID = @UserID">
                <SelectParameters>
                    <asp:SessionParameter Name="UserID" SessionField="UserID2" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Djelatnici koji rade na projektu" Visible="False"></asp:Label>
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IDDjelatnik" DataSourceID="SDSProjektDjelatnik">
                <Columns>
                    <asp:BoundField DataField="IDDjelatnik" HeaderText="IDDjelatnik" ReadOnly="True" SortExpression="IDDjelatnik" />
                    <asp:BoundField DataField="Djelatnik" HeaderText="Djelatnik" ReadOnly="True" SortExpression="Djelatnik" />
                </Columns>
            </asp:GridView>
            <br />
            <asp:SqlDataSource ID="SDSProjektDjelatnik" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" SelectCommand="select Djelatnik.IDDjelatnik, Djelatnik.Ime +' '+Djelatnik.Prezime as 'Djelatnik' from ProjektDjelatnik
inner join Djelatnik on Djelatnik.IDDjelatnik = ProjektDjelatnik.DjelatnikID
where ProjektDjelatnik.ProjektID = @IDProjekt">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GVProjekt" Name="IDProjekt" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Djelatnici koji ne rade na projektu" Visible="False"></asp:Label>
            <asp:DropDownList ID="DDLDjelatniciKojiNisuNaProjektu" runat="server" DataSourceID="SDSProjektBezDjelatnika" DataTextField="Djelatnik" DataValueField="IDDjelatnik" Visible="False">
            </asp:DropDownList>
            <br />
            <asp:SqlDataSource ID="SDSProjektBezDjelatnika" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" SelectCommand="SelectDostupnihDjelatnika" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GVProjekt" Name="ProjektID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="BtnDodaj2" runat="server" OnClick="BtnDodaj2_Click" Text="Dodaj" Visible="False" />
            <br />
        </div>
    </div>
</asp:Content>
