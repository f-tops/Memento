<%@ Page Title="Kontrola" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Kontrola.aspx.cs" Inherits="AplikacijaZaEvidencijuRadnihSati.Kontrola" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:SqlDataSource ID="KontrolaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" SelectCommand="PrikazDnevnihIzvjestajaZaTim" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="TimID" SessionField="TimID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GVKontrola" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IDDnevniIzvjestaj" DataSourceID="KontrolaDataSource" OnSelectedIndexChanged="GVKontrola_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="IDDnevniIzvjestaj" HeaderText="IDDnevniIzvjestaj" InsertVisible="False" ReadOnly="True" SortExpression="IDDnevniIzvjestaj" />
            <asp:BoundField DataField="Naziv" HeaderText="Naziv" SortExpression="Naziv" />
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Djelatnik" HeaderText="Djelatnik" ReadOnly="True" SortExpression="Djelatnik" />
            <asp:BoundField DataField="Status izvještaja" HeaderText="Status izvještaja" SortExpression="Status izvještaja" />
            <asp:CommandField ShowSelectButton="True" />
        </Columns>
    </asp:GridView>
    <br />
    <asp:Label ID="LblDetalji" runat="server" Text="Detalji" Visible="False"></asp:Label>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IDProjektUpisanoVrijeme" DataSourceID="DetaljDataSource">
        <Columns>
            <asp:BoundField DataField="Projekt" HeaderText="Projekt" SortExpression="Projekt" />
            <asp:BoundField DataField="RadniSati" HeaderText="Radni Sati" SortExpression="RadniSati" />
            <asp:BoundField DataField="PrekovremeniSati" HeaderText="Prekovremeni Sati" SortExpression="PrekovremeniSati" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="DetaljDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" SelectCommand="PrikazDetalja" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="GVKontrola" Name="Id" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="LblKomentarIOdobravanje" runat="server" Text="Komentar i odobravanje" Visible="False"></asp:Label>
    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="IDDnevniIzvjestaj" DataSourceID="KomentarOdobravanjeDataSource">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="Komentar" HeaderText="Komentar" SortExpression="Komentar" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="KomentarOdobravanjeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" DeleteCommand="DELETE FROM [DnevniIzvjestaj] WHERE [IDDnevniIzvjestaj] = @IDDnevniIzvjestaj" InsertCommand="INSERT INTO [DnevniIzvjestaj] ([Datum], [DjelatnikID], [Naziv], [Komentar], [IzvjestajStatus]) VALUES (@Datum, @DjelatnikID, @Naziv, @Komentar, @IzvjestajStatus)" SelectCommand="SELECT * FROM [DnevniIzvjestaj] WHERE ([IDDnevniIzvjestaj] = @IDDnevniIzvjestaj)" UpdateCommand="UPDATE [DnevniIzvjestaj] SET [Komentar] = @Komentar WHERE [IDDnevniIzvjestaj] = @IDDnevniIzvjestaj">
        <DeleteParameters>
            <asp:Parameter Name="IDDnevniIzvjestaj" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter DbType="Date" Name="Datum" />
            <asp:Parameter Name="DjelatnikID" Type="Int32" />
            <asp:Parameter Name="Naziv" Type="String" />
            <asp:Parameter Name="Komentar" Type="String" />
            <asp:Parameter Name="IzvjestajStatus" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="GVKontrola" Name="IDDnevniIzvjestaj" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter DbType="Date" Name="Datum" />
            <asp:Parameter Name="DjelatnikID" Type="Int32" />
            <asp:Parameter Name="Naziv" Type="String" />
            <asp:Parameter Name="Komentar" Type="String" />
            <asp:Parameter Name="IzvjestajStatus" Type="Int32" />
            <asp:Parameter Name="IDDnevniIzvjestaj" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:Button ID="BtnVratiNaDoradu" runat="server" OnClick="BtnVratiNaDoradu_Click" Text="Vrati na doradu" Visible="False" />
    <asp:Button ID="BtnOdobri" runat="server" OnClick="BtnOdobri_Click" Text="Odobri" Visible="False" />
    <br />
    </asp:Content>
