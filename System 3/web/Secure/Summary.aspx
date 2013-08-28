<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Summary.aspx.cs" Inherits="Secure_Summary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style3
        {
            font-size: large;
        }
        .style4
        {
            text-align: center;
        }
        </style>
        



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    &nbsp;<strong><div class="style4">
        <div>
            <div class="style4">
                <em><span class="style3">My Requests </span></em>
    </div>

    <br />
    </strong>Here you can view the status of the requests you have made.</div>
    </div>
    <br />
    <br />
    <div align=center>
    <strong>Please select the Semester for which you wish to view requests:</strong>&nbsp;
        <asp:DropDownList ID="DropDownList1" runat="server" 
            DataSourceID="SqlDataSource6" DataTextField="Name" DataValueField="SemesterID" 
            onselectedindexchanged="DropDownList1_SelectedIndexChanged" 
            AutoPostBack="True">
        </asp:DropDownList>
        <br />
    <br />
    <strong>Choose the kind of view you want:</strong><asp:RadioButtonList 
        ID="RadioButtonList1" runat="server" AutoPostBack="True" 
        onselectedindexchanged="RadioButtonList1_SelectedIndexChanged" 
        RepeatDirection="Horizontal" RepeatLayout="Flow">
        <asp:ListItem Selected="True">List View</asp:ListItem>
        <asp:ListItem>Table View</asp:ListItem>
    </asp:RadioButtonList>
    </div>
    <br />
    <br />
    <div align=center>
    <asp:Panel ID="Panel1" runat="server" BorderStyle="Solid" BorderWidth="1px" 
        Width="65%" BackColor="#FFFFCC" HorizontalAlign="Left">
            <div style="padding: 30px;">

       
            <strong>
                <asp:Label ID="Label3" runat="server" Text="Denied Requests:"></asp:Label>
                <br /> </strong><br />
            <asp:GridView ID="GridView3" runat="server" AllowPaging="True" 
                AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
                BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="RequestID" 
                DataSourceID="SqlDataSource4" GridLines="Vertical" 
                style="text-align: center; margin-right: 1px" 
                AllowSorting="True">
                <AlternatingRowStyle BackColor="#ffffff" />
                <Columns>
                <asp:BoundField DataField="RequestID" HeaderText="Request ID" 
                SortExpression="RequestID" InsertVisible="False" ReadOnly="True">
                    <ItemStyle Width="70px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ModuleID" HeaderText="Module Code" 
                SortExpression="ModuleID" >
                    <ItemStyle Width="90px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Module Name" 
                        SortExpression="Name" >
                    <ItemStyle Width="400px" />
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="RequestID" 
                        DataNavigateUrlFormatString="rerequest.aspx?{0}" Text="Re Request" >
                    <ItemStyle Width="100px" />
                    </asp:HyperLinkField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#3F046F" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
            <br />
            <br />
            <strong>
                <asp:Label ID="Label2" runat="server" Text="Pending requests:"></asp:Label>
                <br /> </strong><br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" DataKeyNames="RequestID" 
        AllowPaging="True" BackColor="White" BorderColor="#999999" BorderStyle="None" 
        BorderWidth="1px" CellPadding="3" GridLines="Vertical" 
        style="text-align: center; margin-right: 1px" onrowdeleted="GridView1_RowDeleted" 
        onselectedindexchanged="GridView1_SelectedIndexChanged" 
            onrowediting="GridView1_RowEditing" AllowSorting="True">
                <AlternatingRowStyle BackColor="#ffffff" />
                <Columns>
                    <asp:BoundField DataField="RequestID" HeaderText="Request ID" 
                SortExpression="RequestID" InsertVisible="False" ReadOnly="True">
                    <ItemStyle Width="70px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ModuleID" HeaderText="Module Code" 
                SortExpression="ModuleID" >
                    <ItemStyle Width="90px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Module Name" 
                SortExpression="Name" >
                    <ItemStyle Width="400px" />
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="RequestID" 
                        DataNavigateUrlFormatString="edit.aspx?{0}" Text="Edit Request" >
                    <ItemStyle Width="100px" />
                    </asp:HyperLinkField>
                    <asp:HyperLinkField DataNavigateUrlFields="RequestID" 
                        DataNavigateUrlFormatString="view.aspx?{0}" Text="View Request" >
                    <ItemStyle Width="100px" />
                    </asp:HyperLinkField>
                    <asp:ButtonField CommandName="Delete" Text="Delete Request" >
                    <ItemStyle Width="100px" />
                    </asp:ButtonField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#3F046F" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
            <br />
            <br />
            <strong>
                <asp:Label ID="Label1" runat="server" Text="Allocated requests:"></asp:Label>
                <br /> </strong><br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource5" DataKeyNames="RequestID" 
        AllowPaging="True" BackColor="White" BorderColor="#999999" BorderStyle="None" 
        BorderWidth="1px" CellPadding="3" GridLines="Vertical" 
        style="text-align: center; margin-right: 1px" AllowSorting="True">
                <AlternatingRowStyle BackColor="#ffffff" />
                <Columns>
                    <asp:BoundField DataField="RequestID" HeaderText="Request ID" 
                        InsertVisible="False" ReadOnly="True" SortExpression="RequestID" >
                    <ItemStyle Width="70px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ModuleID" HeaderText="Module Code" 
                        SortExpression="ModuleID" >
                    <ItemStyle Width="90px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Module Name" >
                    <ItemStyle Width="400px" />
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="RequestID" 
                        DataNavigateUrlFormatString="view.aspx?{0}" Text="View Request" >
                    <ItemStyle Width="100px" />
                    </asp:HyperLinkField>
                    <asp:ButtonField CommandName="Update" Text="Release Request" >
                    <ItemStyle Width="100px" />
                    </asp:ButtonField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#3F046F" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
            <br />


            </div>

    </asp:Panel>

    </div>
    <div align=center>
    <asp:Panel ID="Panel2" runat="server" Visible="False" BackColor="#FFFFCC" 
        BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Width="90%">
        <br />
        <strong>Show in timetable: </strong>
        <asp:RadioButtonList ID="RadioButtonList2" runat="server" AutoPostBack="True" 
            onselectedindexchanged="RadioButtonList2_SelectedIndexChanged" 
            RepeatDirection="Horizontal" RepeatLayout="Flow">
            <asp:ListItem>Pending</asp:ListItem>
            <asp:ListItem>Allocated</asp:ListItem>
            <asp:ListItem Selected="True">Both</asp:ListItem>
        </asp:RadioButtonList>
        <br /><br />
        <strong>Weeks: </strong><asp:DropDownList ID="DropDownWeeks0" runat="server" 
            AutoPostBack="True" 
            onselectedindexchanged="DropDownWeeks0_SelectedIndexChanged">
            <asp:ListItem Selected="True" Value="All1">All (1 - 12)</asp:ListItem>
            <asp:ListItem Value="All2">All (1 - 15)</asp:ListItem>
            <asp:ListItem Value="1"></asp:ListItem>
            <asp:ListItem Value="2"></asp:ListItem>
            <asp:ListItem Value="3"></asp:ListItem>
            <asp:ListItem Value="4"></asp:ListItem>
            <asp:ListItem Value="5"></asp:ListItem>
            <asp:ListItem Value="6"></asp:ListItem>
            <asp:ListItem Value="7"></asp:ListItem>
            <asp:ListItem Value="8"></asp:ListItem>
            <asp:ListItem Value="9"></asp:ListItem>
            <asp:ListItem Value="10"></asp:ListItem>
            <asp:ListItem Value="11"></asp:ListItem>
            <asp:ListItem Value="12"></asp:ListItem>
            <asp:ListItem Value="13"></asp:ListItem>
            <asp:ListItem Value="14"></asp:ListItem>
            <asp:ListItem Value="15"></asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <div align=center style="width=75%; padding: 10px;">
        <asp:Table ID="Table2" runat="server" GridLines="Both" style="font-size: small">
            <asp:TableRow ID="TableRow5" runat="server" Height="30px">
                <asp:TableCell ID="TableCell37" runat="server" BackColor="#E1C4FF" Width="30px">Period:</asp:TableCell>
                <asp:TableCell ID="TableCell38" runat="server" BackColor="#E1C4FF" 
                    Width="340px">1</asp:TableCell>
                <asp:TableCell ID="TableCell39" runat="server" BackColor="#E1C4FF" 
                    Width="340px">2</asp:TableCell>
                <asp:TableCell ID="TableCell40" runat="server" BackColor="#E1C4FF" 
                    Width="340px">3</asp:TableCell>
                <asp:TableCell ID="TableCell41" runat="server" BackColor="#E1C4FF" 
                    Width="340px">4</asp:TableCell>
                <asp:TableCell ID="TableCell42" runat="server" BackColor="#E1C4FF" 
                    Width="340px">5</asp:TableCell>
                <asp:TableCell ID="TableCell43" runat="server" BackColor="#E1C4FF" 
                    Width="340px">6</asp:TableCell>
                <asp:TableCell ID="TableCell44" runat="server" BackColor="#E1C4FF" 
                    Width="340px">7</asp:TableCell>
                <asp:TableCell ID="TableCell45" runat="server" BackColor="#E1C4FF" 
                    Width="340px">8</asp:TableCell>
                <asp:TableCell runat="server" BackColor="#E1C4FF" Width="340px">9</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="TableRow6" runat="server" Height="30px">
                <asp:TableCell ID="TableCell46" runat="server" BackColor="#E1C4FF">Time:</asp:TableCell>
                <asp:TableCell ID="TableCell47" runat="server" BackColor="#E1C4FF">9am- 9.50am</asp:TableCell>
                <asp:TableCell ID="TableCell48" runat="server" BackColor="#E1C4FF">10am- 10.50am</asp:TableCell>
                <asp:TableCell ID="TableCell49" runat="server" BackColor="#E1C4FF">11am- 1.50am</asp:TableCell>
                <asp:TableCell ID="TableCell50" runat="server" BackColor="#E1C4FF">12pm- 12.50pm</asp:TableCell>
                <asp:TableCell ID="TableCell51" runat="server" BackColor="#E1C4FF">1pm- 1.50pm</asp:TableCell>
                <asp:TableCell ID="TableCell52" runat="server" BackColor="#E1C4FF">2pm- 2.50pm</asp:TableCell>
                <asp:TableCell ID="TableCell53" runat="server" BackColor="#E1C4FF">3pm- 3.50pm</asp:TableCell>
                <asp:TableCell ID="TableCell54" runat="server" BackColor="#E1C4FF">4pm- 4.50pm</asp:TableCell>
                <asp:TableCell runat="server" BackColor="#E1C4FF">5pm- 5.50pm</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="TableRow7" runat="server" Height="50px">
                <asp:TableCell ID="TableCell55" runat="server" BackColor="#E1C4FF">Mon</asp:TableCell>
                <asp:TableCell ID="TableCell56" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell57" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell58" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell59" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell60" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell61" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell62" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell63" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="TableRow8" runat="server" Height="50px">
                <asp:TableCell ID="TableCell64" runat="server" BackColor="#E1C4FF">Tue</asp:TableCell>
                <asp:TableCell ID="TableCell65" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell66" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell67" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell68" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell69" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell70" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell71" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell72" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server" Height="50px">
                <asp:TableCell runat="server" BackColor="#E1C4FF">Wed</asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server" Height="50px">
                <asp:TableCell runat="server" BackColor="#E1C4FF">Thurs</asp:TableCell>
                <asp:TableCell ID="TableCell1" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell2" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell3" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell4" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell5" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell6" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell7" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell8" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell9" runat="server" BackColor="White"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server" Height="50px">
                <asp:TableCell runat="server" BackColor="#E1C4FF">Friday</asp:TableCell>
                <asp:TableCell ID="TableCell10" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell11" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell12" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell13" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell14" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell15" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell16" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell17" runat="server" BackColor="White"></asp:TableCell>
                <asp:TableCell ID="TableCell18" runat="server" BackColor="White"></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        </div>
        <br />
        <br />
        <br />
    </asp:Panel>
    </div>
    <br />
            
    <asp:SqlDataSource ID="Sem" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT * FROM [Semester]">
    </asp:SqlDataSource>
            
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT Request.RequestID, Request.ModuleID, Module.Name, team17.ConcatRooms(Request.RequestID) AS Rooms FROM Module INNER JOIN Request ON Module.ModuleID = Request.ModuleID WHERE (Request.Status = 'Pending') AND (Request.UserID = @UserID) AND (Request.RoundID IN(Select RoundID FROM Round WHERE SemesterID = @Sem))" 
        
            
            DeleteCommand="DELETE FROM RequestRoom WHERE (RequestID = @RequestID); 
DELETE FROM RequestFacility WHERE (RequestID = @RequestID);
DELETE FROM RequestTime WHERE (RequestID = @RequestID);
DELETE FROM Request WHERE (RequestID = @RequestID);">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="login_name" Type="String" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Sem" 
                PropertyName="SelectedValue" />
        </SelectParameters>

        <DeleteParameters>
            <asp:Parameter Name="RequestID" />
        </DeleteParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT Request.RequestID,  Request.ModuleID, Module.Name FROM Module INNER JOIN Request ON Module.ModuleID = Request.ModuleID WHERE (Request.Status = 'Denied') AND (Request.UserID = @UserID) AND (Request.RoundID IN(Select RoundID FROM Round WHERE SemesterID =@Sem))" 
        
            
        
        DeleteCommand="DELETE FROM RequestRoom WHERE (RequestID = @RequestID); DELETE FROM RequestFacility WHERE (RequestID = @RequestID); DELETE FROM Request WHERE (RequestID = @RequestID)">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="login_name" Type="String" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Sem" 
                PropertyName="SelectedValue" />
        </SelectParameters>

        <DeleteParameters>
            <asp:Parameter Name="RequestID" />
        </DeleteParameters>

    </asp:SqlDataSource>
<br />
        <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
            ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
            SelectCommand="SELECT * FROM [Semester]"></asp:SqlDataSource>
    &nbsp;<asp:SqlDataSource ID="SqlDataSource5" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        
        SelectCommand="SELECT Request.RequestID, Request.ModuleID, Module.Name, team17.ConcatRooms(Request.RequestID) AS Rooms FROM Module INNER JOIN Request ON Module.ModuleID = Request.ModuleID WHERE (Request.Status = 'Allocated') AND (Request.UserID = @UserID) AND (Request.RoundID IN(Select RoundID FROM Round WHERE SemesterID = @Sem))" UpdateCommand="UPDATE Request
SET Status='Release Requested'
WHERE RequestID = @RequestID">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="login_name" Type="String" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Sem" 
                PropertyName="SelectedValue" />
        </SelectParameters>

        <UpdateParameters>
            <asp:Parameter Name="RequestID" />
        </UpdateParameters>

    </asp:SqlDataSource>
        </asp:Content>

