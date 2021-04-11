<%@ Page Title="Konačni izvještaji" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="KonacniIzvjestaji.aspx.cs" Inherits="AplikacijaZaEvidencijuRadnihSati.KonacniIzvjestaji" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Label ID="Label1" runat="server" Text="Odabir klijenta za izvještaj"></asp:Label>
    <asp:DropDownList ID="DDLKlijentOdabir" runat="server" AutoPostBack="True" DataSourceID="SDSKlijent" DataTextField="Naziv" DataValueField="IDKlijent" OnSelectedIndexChanged="DDLKlijentOdabir_SelectedIndexChanged">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SDSKlijent" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" SelectCommand="SELECT * FROM [Klijent]"></asp:SqlDataSource>
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SDSUkupnoProjektSati">
        <Columns>
            <asp:BoundField DataField="Naziv projekta" HeaderText="Naziv projekta" SortExpression="Naziv projekta" />
            <asp:BoundField DataField="Ukupno vrijeme(HH:MM)" HeaderText="Ukupno vrijeme(HH:MM)" ReadOnly="True" SortExpression="Ukupno vrijeme(HH:MM)" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SDSUkupnoProjektSati" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" SelectCommand="DohvatiUkupnoSatiZaKlijenta" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLKlijentOdabir" Name="IDKlijent" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="LblExportUCSV" runat="server" Text="Export podataka u csv" Visible="False"></asp:Label>
    <asp:Button ID="BTNExportCSV" runat="server" OnClick="BTNExportCSV_Click" Text="Export CSV" Visible="False" />
    <br />
    <br />
    <br />
    Odabir tima za izvještaj<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SDSTimovi" DataTextField="Naziv" DataValueField="IDTim">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SDSTimovi" runat="server" ConnectionString="<%$ ConnectionStrings:Aplikacija_RWAConnectionString %>" SelectCommand="SELECT * FROM [Tim]"></asp:SqlDataSource>
    <br />

</asp:Content>
