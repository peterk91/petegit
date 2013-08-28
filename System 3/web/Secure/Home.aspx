<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Secure_Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">





    <div id ="mainInfo" style="width:65%;">
        <div>
            <strong><u>General Information</u><br />
            <br />
             - Make a Request: </strong>This is where you can submit all your requests for whichever round is currently 
            open.<br />
        <strong> - Module Management: </strong>This is where you can add a new module.<br />
        <strong> - Room Information:</strong>
            Here you can look up information about any room on campus.<strong><br />
         - My Request:</strong>
            Here is where you can find a list of all your submitted requests and the status 
            of them.<strong><br />
         - Help / Contact: </strong>Here is where you can find extra information on how the system works and also 
            contact details for if you need any further assistance.
            </div>
            </div>
            <div id = "currentRounds" style="width:65%;">
                <br />
                <strong><u>Round Information</u></strong><br />
                <br />
                <strong>Current Rounds<br />
                </strong>&nbsp;<asp:GridView 
            ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource7" BackColor="White" BorderColor="#999999" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#ffffff" />
            <Columns>
                <asp:BoundField DataField="Round" HeaderText="Round" SortExpression="Round" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                <ItemStyle Width="100px" />

                </asp:BoundField>
                <asp:BoundField DataField="Round Opening Date" HeaderText="Round Opening Date" 
                    SortExpression="Round Opening Date">
                                                                    <ItemStyle Width="150px" />
                            </asp:BoundField>
                <asp:BoundField DataField="Round Closing Date" HeaderText="Round Closing Date" 
                    SortExpression="Round Closing Date">
                                                                    <ItemStyle Width="150px" />
                            </asp:BoundField>
                <asp:BoundField DataField="Semester" HeaderText="Semester" 
                    SortExpression="Semester">
                                                <ItemStyle Width="150px" />
                            </asp:BoundField>
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
                <strong>Upcoming Rounds</strong><br />
                <br />
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource8" BackColor="White" BorderColor="#999999" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#ffffff" />
                    <Columns>
                        <asp:BoundField DataField="Round" HeaderText="Round" SortExpression="Round">
                                                    <ItemStyle Width="100px" />
                            </asp:BoundField>
                        <asp:BoundField DataField="Round Opening Date" HeaderText="Round Opening Date" 
                            SortExpression="Round Opening Date">
                                                        <ItemStyle Width="150px" />
                            </asp:BoundField>
                        <asp:BoundField DataField="Semester" HeaderText="Semester" 
                            SortExpression="Semester" >
                                                        <ItemStyle Width="150px" />
                            </asp:BoundField>
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
                <strong>Closed Rounds</strong><br />
                <br />
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource9" BackColor="White" BorderColor="#999999" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#ffffff" />
                    <Columns>
                        <asp:BoundField DataField="Round" HeaderText="Round" SortExpression="Round">
                        <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Round Closing Date" HeaderText="Round Closing Date" 
                            SortExpression="Round Closing Date">
                            <ItemStyle Width="150px" />
                            </asp:BoundField>
                        <asp:BoundField DataField="Semester" HeaderText="Semester" 
                            SortExpression="Semester">
                            <ItemStyle Width="150px" />
                            </asp:BoundField>
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
       
        </div>


    <div id ="homeUpdate" style="border-style: solid; border-width: 1px; border-collapse: collapse; 
        border-spacing: inherit; background-color: #FFFFCC; width: 30%; float: auto;" align=center>
            <strong><u>Login Status</u><br /><br />
        <u>You are currently logged in as: </u></strong>
        <br />
        <br />
        <asp:DataList ID="DataList2" runat="server" DataKeyField="DepartmentID" 
            DataSourceID="SqlDataSource2">
            <ItemTemplate>
                <strong>Department ID:</strong>
                <asp:Label ID="DepartmentIDLabel" runat="server" 
                    Text='<%# Eval("DepartmentID") %>' />
                <br />
<br />
            </ItemTemplate>
        </asp:DataList>

        
        
        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource3">
            <ItemTemplate>
                <strong>Department Name:</strong>
                <asp:Label ID="DepartmentNameLabel" runat="server" 
                    Text='<%# Eval("DepartmentName") %>' />
                <br />

            </ItemTemplate>
        </asp:DataList>
        <br />
        <strong><u>Current Status:</u><br />
        </strong>
        <br />
        <asp:DataList ID="DataList3" runat="server" DataSourceID="SqlDataSource4">
            <ItemTemplate>
                <strong>Pending Requests:</strong>
                <asp:Label ID="Column1Label" runat="server" Text='<%# Eval("Column1") %>' />
                <br />
<br />
            </ItemTemplate>
        </asp:DataList>
        <asp:DataList ID="DataList4" runat="server" DataSourceID="SqlDataSource5">
            <ItemTemplate>
                <strong>Denied Requests:</strong>
                <asp:Label ID="Column1Label" runat="server" Text='<%# Eval("Column1") %>' />
                <br />
<br />
            </ItemTemplate>
        </asp:DataList>
        <asp:DataList ID="DataList5" runat="server" DataSourceID="SqlDataSource6">
            <ItemTemplate>
                <strong>Allocated Requests:</strong>
                <asp:Label ID="Column1Label" runat="server" Text='<%# Eval("Column1") %>' />
                <br />
<br />
            </ItemTemplate>
        </asp:DataList>
        <br />
        <br />
        
        <strong>Updates</strong>
            <br />
        <br />
        
        <asp:FormView ID="FormView1" runat="server" AllowPaging="True" 
            BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" 
            CellPadding="4" CellSpacing="2" DataSourceID="SqlDataSource1" ForeColor="Black" 
            GridLines="Both" Height="100%" 
            onpageindexchanging="FormView1_PageIndexChanging" Width="75%">
            <EditItemTemplate>
                UpdateID:
                <asp:TextBox ID="UpdateIDTextBox" runat="server" 
                    Text='<%# Bind("UpdateID") %>' />
                <br />
                Comment:
                <asp:TextBox ID="CommentTextBox" runat="server" Text='<%# Bind("Comment") %>' />
                <br />
                Date:
                <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                    CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                    CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <FooterStyle BackColor="#F2F2F2" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <InsertItemTemplate>
                UpdateID:
                <asp:TextBox ID="UpdateIDTextBox" runat="server" 
                    Text='<%# Bind("UpdateID") %>' />
                <br />
                Comment:
                <asp:TextBox ID="CommentTextBox" runat="server" Text='<%# Bind("Comment") %>' />
                <br />
                Date:
                <asp:TextBox ID="DateTextBox" runat="server" Text='<%# Bind("Date") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                    CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                    CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="CommentLabel" runat="server" Text='<%# Bind("Comment") %>' />
                <br />
                Date:
                <asp:Label ID="DateLabel" runat="server" Text='<%# Bind("Date") %>' />
                <br />
            </ItemTemplate>
            <PagerSettings Mode="NumericFirstLast" />
            <PagerStyle ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
        </asp:FormView>
        <br />

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" 
            SelectCommand="SELECT [DepartmentID] FROM [Department] WHERE ([DepartmentID] = @DepartmentID)">
            <SelectParameters>
                <asp:SessionParameter Name="DepartmentID" SessionField="login_name" 
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
            ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" SelectCommand="SELECT COUNT(RequestID) FROM Request
WHERE Status = 'Allocated' AND ([UserID] = @UserID)">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="login_name" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
            ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" SelectCommand="SELECT COUNT(RequestID) FROM Request
WHERE Status = 'Denied' AND ([UserID] = @UserID)">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" 
                    SessionField="login_name" Type="String" />
            </SelectParameters>
            </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
            ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" SelectCommand="SELECT COUNT(RequestID) FROM Request
WHERE Status = 'Pending' AND ([UserID] = @UserID)">
<SelectParameters>
                <asp:SessionParameter Name="UserID" 
                    SessionField="login_name" Type="String" />
            </SelectParameters>

</asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" 
            
            
            
            SelectCommand="SELECT [DepartmentName] FROM [Department] WHERE ([DepartmentID] = @DepartmentID)">
            <SelectParameters>
                <asp:SessionParameter Name="DepartmentID" 
                    SessionField="login_name" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" 
            SelectCommand="SELECT * FROM [Updates] ORDER BY [Date]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
            ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" SelectCommand="SELECT Round.Round AS 'Round', Round.[Open] AS 'Round Opening Date', Round.[Close] AS 'Round Closing Date', Semester.Name AS 'Semester' 

FROM Round 

INNER JOIN Semester ON Round.SemesterID = Semester.SemesterID

WHERE Round.[Open] &lt;= GETDATE() AND Round.[Close] &gt;= GETDATE()">
        </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource8" runat="server" 
                ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" SelectCommand="SELECT Round.Round AS 'Round', Round.[Open] AS 'Round Opening Date', Semester.Name AS 'Semester' 

FROM Round 

INNER JOIN Semester ON Round.SemesterID = Semester.SemesterID

WHERE Round.[Open] &gt; GETDATE()"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource9" runat="server" 
                ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" SelectCommand="SELECT Round.Round AS 'Round', Round.[Close] AS 'Round Closing Date', Semester.Name AS 'Semester'

FROM Round 

INNER JOIN Semester ON Round.SemesterID = Semester.SemesterID

WHERE Round.[Close] &lt; GETDATE()"></asp:SqlDataSource>
        <br />


    </div>



</asp:Content>

