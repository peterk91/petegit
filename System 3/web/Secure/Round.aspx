<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Round.aspx.cs" Inherits="Secure_Round" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
 <style type="text/css">
        .style2
        {
            text-decoration: underline;
            text-align: center;
        }
        .style3
        {
            font-size: large;
        }
        .style4
        {
            text-align: center;
        }
        .style5
        {
            text-align: right;
        }
        .style6
        {
            text-align: center;
        }
        .style7
        {
            text-align: left;
        }
        .style8
        {
            text-align: center;
            text-decoration: underline;
        }
        .style9
        {
            text-align: left;
            height: 362px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <div align=center>
    <strong>
    <div class="style4">
    <strong><em><span class="style3">Round Information</span></em></strong>
    </div>
    </strong>

    <br />
    <br />

    Current Rounds:<br /><br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="CurrentRoundsDataSource" BackColor="White" BorderColor="#999999" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
        <AlternatingRowStyle BackColor="#DCDCDC" />
        <Columns>
            <asp:BoundField DataField="Round" HeaderText="Round" SortExpression="Round" 
                ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" >
<ItemStyle HorizontalAlign="Center" Width="150px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Round Opening Date" HeaderText="Round Opening Date" 
                SortExpression="Round Opening Date" ItemStyle-Width="200px" 
                ItemStyle-HorizontalAlign="Center" >
<ItemStyle HorizontalAlign="Center" Width="200px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Round Closing Date" HeaderText="Round Closing Date" 
                SortExpression="Round Closing Date" ItemStyle-Width="200px" 
                ItemStyle-HorizontalAlign="Center" >
<ItemStyle HorizontalAlign="Center" Width="200px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Semester" HeaderText="Semester" 
                SortExpression="Semester" ItemStyle-Width="150px" 
                ItemStyle-HorizontalAlign="Center" >
<ItemStyle HorizontalAlign="Center" Width="150px"></ItemStyle>
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#0000A9" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#000065" />
    </asp:GridView>
    <asp:SqlDataSource ID="CurrentRoundsDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" SelectCommand="SELECT Round.Round AS 'Round', Round.[Open] AS 'Round Opening Date', Round.[Close] AS 'Round Closing Date', Semester.Name AS 'Semester' 

FROM Round 

INNER JOIN Semester ON Round.SemesterID = Semester.SemesterID

WHERE Round.[Open] &lt;= GETDATE() AND Round.[Close] &gt;= GETDATE()">
    </asp:SqlDataSource>
    <br /><br />
    Upcoming Rounds:<br /><br />
    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
        DataSourceID="UpcomingRoundsDataSource" BackColor="White" 
            BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
            GridLines="Vertical">
        <AlternatingRowStyle BackColor="#DCDCDC" />
        <Columns>
            <asp:BoundField DataField="Round" HeaderText="Round" SortExpression="Round" 
                ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" >
<ItemStyle HorizontalAlign="Center" Width="150px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Round Opening Date" HeaderText="Round Opening Date" 
                SortExpression="Round Opening Date" ItemStyle-Width="200px" 
                ItemStyle-HorizontalAlign="Center" >
<ItemStyle HorizontalAlign="Center" Width="200px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Semester" HeaderText="Semester" 
                SortExpression="Semester" ItemStyle-Width="150px" 
                ItemStyle-HorizontalAlign="Center" >
<ItemStyle HorizontalAlign="Center" Width="150px"></ItemStyle>
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#0000A9" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#000065" />
    </asp:GridView>
    <asp:SqlDataSource ID="UpcomingRoundsDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" SelectCommand="SELECT Round.Round AS 'Round', Round.[Open] AS 'Round Opening Date', Semester.Name AS 'Semester' 

FROM Round 

INNER JOIN Semester ON Round.SemesterID = Semester.SemesterID

WHERE Round.[Open] &gt; GETDATE()"></asp:SqlDataSource>
    <br /><br />
    Closed Rounds:<br /><br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
        DataSourceID="ClosedRoundsDataSource" BackColor="White" BorderColor="#999999" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
        <AlternatingRowStyle BackColor="#DCDCDC" />
        <Columns>
            <asp:BoundField DataField="Round" HeaderText="Round" SortExpression="Round" 
                ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" >
<ItemStyle HorizontalAlign="Center" Width="150px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Round Closing Date" HeaderText="Round Closing Date" 
                SortExpression="Round Closing Date" ItemStyle-Width="200px" 
                ItemStyle-HorizontalAlign="Center" >
<ItemStyle HorizontalAlign="Center" Width="200px"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Semester" HeaderText="Semester" 
                SortExpression="Semester" ItemStyle-Width="150px" 
                ItemStyle-HorizontalAlign="Center" >
<ItemStyle HorizontalAlign="Center" Width="150px"></ItemStyle>
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#0000A9" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#000065" />
    </asp:GridView>
    <asp:SqlDataSource ID="ClosedRoundsDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" SelectCommand="SELECT Round.Round AS 'Round', Round.[Close] AS 'Round Closing Date', Semester.Name AS 'Semester'

FROM Round 

INNER JOIN Semester ON Round.SemesterID = Semester.SemesterID

WHERE Round.[Close] &lt; GETDATE()"></asp:SqlDataSource>
    <br />
&nbsp;

</div>

</asp:Content>
