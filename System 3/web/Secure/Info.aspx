<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Info.aspx.cs" Inherits="Secure_Info" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<style type="text/css">
    .style1
    {
    text-align: right;
    }
    .style3
    {
    font-size: large;
    }
    .style4
    {        text-align: center;
    }
    .style2
    {
        border-style: solid;
        border-width: thin;
        width: 497px;
        height: 388px;
        margin-top: 0px;
    }
    .style8
    {
    text-align: right;
    }
    .style9
    {
    text-align: right;
    width: 50px;
    }
    .style10
    {
    width: 107px;
    }
    .style14
    {
        text-align: center;
        height: 36px;
    }
    .style15
    {
        text-align: left;
        width: 0;
    }
    .style7
    {
    width: 81px;
    }
    .style11
    {
        width: 250px;
        text-align: left;
    }
    .style13
    {
        width: 339px;
        text-align: center;
    }
    .style12
    {
    }
    .style17
    {
        text-align: center;
        width: 470px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <strong>
    <div class="style4">
        <strong><em><span class="style3">Room Information</span></em></strong>
    </div>
    </strong>

    <div class="style1">
        If you need help with this page click <a href="Help.aspx">here</a>
    </div>

    <br />
    <br />

    <table align="center" width="85%">
    <tr>
        <td>
            <table align=center width="85%" 
            style="border-style: solid; border-width: 1px; border-collapse: collapse; table-layout: auto; border-spacing: inherit; empty-cells: show; background-color: #FFFFCC;">
            <tr>
                <td><div style="padding-top: 10px; padding-left: 30px;" align=center><b>Park</b></div></td>
                <td><div style="padding-top: 10px;" align=center><b>Building ID</b></div></td>
                <td><div style="padding-top: 10px;" align=center><b>Building Name</b></div></td>
                <td><div style="padding-top: 10px;" align=center><b>Room</b></div></td>
            </tr>
            <tr>
                <td valign=top align=center>
                    <div style="padding-left: 30px;" align=center>
                    <asp:ListBox ID="ListBoxPark" runat="server" DataSourceID="ParkCodes" 
                    DataTextField="Park" DataValueField="Park" Rows="15" Width="50px" 
                        onselectedindexchanged="ListBox1_SelectedIndexChanged" AutoPostBack="True" 
                        ondatabound="ListBox1_DataBound" CausesValidation="True"></asp:ListBox>
                    </div>
                </td>
                <td valign=top align=center>
                    <div align=center>
                    <asp:ListBox ID="ListBoxBuildID" runat="server" DataSourceID="BuildingCodes" 
                    DataTextField="BuildingID" DataValueField="BuildingID" Rows="15" Width="80px" 
                        onselectedindexchanged="ListBox2_SelectedIndexChanged" AutoPostBack="True"></asp:ListBox>
                    </div>
                </td>
                <td valign=top>
                    <div align=center>
                    <asp:ListBox ID="ListBoxBuildNames" runat="server" DataSourceID="BuildingNames" 
                    DataTextField="Name" DataValueField="BuildingID" Rows="15" Width="230px" AutoPostBack="True" 
                        onselectedindexchanged="ListBox3_SelectedIndexChanged"></asp:ListBox>
                    </div>
                </td>
                <td valign=top>
                    <div align=center>
                    <asp:ListBox ID="ListBoxRooms" runat="server" DataSourceID="RoomCodes" 
                    DataTextField="RoomID" DataValueField="RoomID" Rows="15" Width="80px" 
                        onselectedindexchanged="ListBox4_SelectedIndexChanged" AutoPostBack="True"></asp:ListBox>
                    </div>
                </td>
                <td colspan="3">
                    <div style="padding-right: 5px; padding-bottom: 30px;" align=center>
                    <div class="style2">
                    <em>Choose Advance Fliter Options:<asp:RadioButtonList ID="RadioButtonFilter" 
                    runat="server" Height="16px" RepeatDirection="Horizontal" Width="108px" 
                    RepeatLayout="Flow" AutoPostBack="True" 
                    onselectedindexchanged="RadioButtonList1_SelectedIndexChanged1">
                    <asp:ListItem>On</asp:ListItem>
                    <asp:ListItem Selected="True">Off</asp:ListItem>
                    </asp:RadioButtonList>
                    </em>
                    <table>
                    <tr>
                    <td class="style9">Room Type:</td>
                    <td>
                    &nbsp;
                    <asp:DropDownList ID="DropDownListType" runat="server" 
                    DataSourceID="RoomType" DataTextField="Name" DataValueField="FacilityID" 
                    Enabled="False" AutoPostBack="True" 
                    ondatabound="DropDownListType_DataBound" 
                    onselectedindexchanged="DropDownListType_SelectedIndexChanged">
                    </asp:DropDownList>
                    </td>
                    <td class="style9">Room Style:</td>
                    <td class="style10">
                    &nbsp;
                    <asp:DropDownList ID="DropDownListStyle" runat="server" 
                    DataSourceID="RoomStyle" DataTextField="Name" DataValueField="FacilityID" 
                    Enabled="False" 
                    onselectedindexchanged="DropDownList2_SelectedIndexChanged" 
                    AutoPostBack="True" ondatabound="DropDownListStyle_DataBound">
                    </asp:DropDownList>
                    </td>
                    <td class="style8">Capacity Required:</td>
                    <td>
                    <asp:TextBox ID="TextBoxCapacity" runat="server" Width="58px" Enabled="False" 
                    ontextchanged="TextBox1_TextChanged" AutoPostBack="True"></asp:TextBox>
                    </td>
                    </tr>
                    </table>
                    <p><b>Room Facilities:</b></p>
                    <asp:CheckBoxList ID="CheckBoxListFacilities" runat="server" DataSourceID="Facilities" 
                    DataTextField="Name" DataValueField="FacilityID" RepeatColumns="3" Enabled="False" 
                    onselectedindexchanged="CheckBoxList1_SelectedIndexChanged" 
                    AutoPostBack="True" style="font-size: x-small">
                    </asp:CheckBoxList>
                    <br />
                    </div>
                    </div>
                </td>
            </tr>
            </table>   
        </td>
    </tr>
    </table>
     
    <br />
    <div align=center>

           <asp:Panel ID="InfoPanel" runat="server" BorderWidth="0px" Visible="False" 
            Width="95%" style="text-align: left" Height="100%" 
        EnableTheming="False" CssClass="style7">
            
            <br />
            <div style="padding-left: 10%; padding-right:10%;">
                <table align=center width="95%" 
                        style="border-style: solid; border-width: 1px; border-collapse: collapse; table-layout: auto; 
                        border-spacing: inherit; empty-cells: show; background-color: #FFFFCC;">
                    <tr>
                        <td class="style14" colspan="3">
                            <asp:Label ID="Label1" runat="server" 
                                style="font-weight: 700; text-decoration: underline" Text="Room Profile"></asp:Label>
                        </td>
                        
                        <td class="style15" rowspan="2" 
                            style="border-left-style: solid; border-left-width: 1px; padding-left: 20px; padding-right: 10px;">
                            <strong>Semester:</strong></td>
                        <td class="style20" rowspan="2" 
                            style="border-left-style: solid; border-left-width: 1px; padding: 10px;">
                            <strong>
                            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                                DataSourceID="SqlDataSource6" DataTextField="Name" DataValueField="SemesterID" 
                                onselectedindexchanged="DropDownList1_SelectedIndexChanged">
                            </asp:DropDownList>
                            </strong>
                        </td>
                        
                    </tr>
                    <tr style="padding-left: 10px;">
                        <td class="style7">
                            <asp:Label ID="Label2" runat="server" style="font-weight: 700; padding-left: 20px;" Text="Room:"></asp:Label>
                        </td>
     
                        <td class="style11">
                            <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>
                        </td>
                        <td class="style13" rowspan="6">
                            <asp:Image ID="ImageRoom" runat="server" BorderColor="Black" 
                                BorderStyle="Solid" BorderWidth="1px" Height="200px" ImageAlign="Left" 
                                Width="300px" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style7">
                            <asp:Label ID="Label3" runat="server" style="font-weight: 700; padding-left: 20px;" Text="Building:"></asp:Label>
                        </td>
                        <td class="style11">
                            <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>
                        </td>
                        <td class="style15" rowspan="2" 
                            style="border-left-style: solid; border-left-width: 1px; padding-left: 20px;">
                            <strong>Weeks:</strong></td>
                        <td class="style20" rowspan="2" 
                            style="border-left-style: solid; border-left-width: 1px; padding: 10px;">
                            <asp:DropDownList ID="DropDownWeeks0" runat="server" AutoPostBack="True" 
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
                        </td>
                    </tr>
                    <tr>
                        <td class="style7">
                            <asp:Label ID="Label4" runat="server" style="font-weight: 700; padding-left: 20px;" Text="Park:"></asp:Label>
                        </td>
                        <td class="style11">
                            <asp:Label ID="Label10" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style7">
                            <asp:Label ID="Label5" runat="server" style="font-weight: 700; padding-left: 20px;" Text="Capacity:"></asp:Label>
                        </td>
                        <td class="style11">
                            <asp:Label ID="Label11" runat="server" Text="Label"></asp:Label>
                        </td>
                        <td class="style17" colspan="2" rowspan="4" 
                            style="border-style: solid; border-width: 1px; padding: 20px;">
                            <i><u>Red cells indicate that the room is booked at the chosen time:</u></i>
                            <br />
                            <br />
                            <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
                                Text="Request This Room" />
                            <br /><br />
                            <asp:Table ID="Table1" runat="server" GridLines="Both" Height="271px" 
                                Width="100%">
                                <asp:TableRow ID="TableRow1" runat="server">
                                    <asp:TableCell ID="TableCell1" runat="server" BackColor="#E1C4FF">Period:</asp:TableCell>
                                    <asp:TableCell ID="TableCell2" runat="server" BackColor="#E1C4FF">1</asp:TableCell>
                                    <asp:TableCell ID="TableCell3" runat="server" BackColor="#E1C4FF">2</asp:TableCell>
                                    <asp:TableCell ID="TableCell4" runat="server" BackColor="#E1C4FF">3</asp:TableCell>
                                    <asp:TableCell ID="TableCell5" runat="server" BackColor="#E1C4FF">4</asp:TableCell>
                                    <asp:TableCell ID="TableCell6" runat="server" BackColor="#E1C4FF">5</asp:TableCell>
                                    <asp:TableCell ID="TableCell7" runat="server" BackColor="#E1C4FF">6</asp:TableCell>
                                    <asp:TableCell ID="TableCell8" runat="server" BackColor="#E1C4FF">7</asp:TableCell>
                                    <asp:TableCell ID="TableCell9" runat="server" BackColor="#E1C4FF">8</asp:TableCell>
                                    <asp:TableCell runat="server" BackColor="#E1C4FF">9</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow2" runat="server">
                                    <asp:TableCell ID="TableCell10" runat="server" BackColor="#E1C4FF">Time:</asp:TableCell>
                                    <asp:TableCell ID="TableCell11" runat="server" BackColor="#E1C4FF">9am- 9.50am</asp:TableCell>
                                    <asp:TableCell ID="TableCell12" runat="server" BackColor="#E1C4FF">10am- 10.50am</asp:TableCell>
                                    <asp:TableCell ID="TableCell13" runat="server" BackColor="#E1C4FF">11am- 1.50am</asp:TableCell>
                                    <asp:TableCell ID="TableCell14" runat="server" BackColor="#E1C4FF">12pm- 12.50pm</asp:TableCell>
                                    <asp:TableCell ID="TableCell15" runat="server" BackColor="#E1C4FF">1pm- 1.50pm</asp:TableCell>
                                    <asp:TableCell ID="TableCell16" runat="server" BackColor="#E1C4FF">2pm- 2.50pm</asp:TableCell>
                                    <asp:TableCell ID="TableCell17" runat="server" BackColor="#E1C4FF">3pm- 3.50pm</asp:TableCell>
                                    <asp:TableCell ID="TableCell18" runat="server" BackColor="#E1C4FF">4pm- 4.50pm</asp:TableCell>
                                    <asp:TableCell runat="server" BackColor="#E1C4FF">5pm- 5.50pm</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow3" runat="server">
                                    <asp:TableCell ID="TableCell19" runat="server" BackColor="#E1C4FF">Mon</asp:TableCell>
                                    <asp:TableCell ID="TableCell20" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell21" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell22" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell23" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell24" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell25" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell26" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell27" runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow4" runat="server">
                                    <asp:TableCell ID="TableCell28" runat="server" BackColor="#E1C4FF">Tue</asp:TableCell>
                                    <asp:TableCell ID="TableCell29" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell30" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell31" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell32" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell33" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell34" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell35" runat="server"></asp:TableCell>
                                    <asp:TableCell ID="TableCell36" runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" BackColor="#E1C4FF">Wed</asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" BackColor="#E1C4FF">Thurs</asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" BackColor="#E1C4FF">Friday</asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                    <asp:TableCell runat="server"></asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </td>
                    </tr>
                    <tr>
                        <td class="style7">
                            <asp:Label ID="Label6" runat="server" style="font-weight: 700; padding-left: 20px;" Text="Type:"></asp:Label>
                        </td>
                        <td class="style11">
                            <asp:Label ID="Label12" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style7">
                            <asp:Label ID="Label7" runat="server" style="font-weight: 700; padding-left: 20px;" Text="Style:"></asp:Label>
                        </td>
                        <td class="style11">
                            <asp:Label ID="Label13" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style7" valign="top">
                            <asp:Label ID="Label14" runat="server" style="font-weight: 700; padding-left: 20px;" 
                                Text="Facilities:"></asp:Label>
                        </td>
                        <td class="style12" align="left" valign="top" colspan="2">
                            <asp:BulletedList ID="BulletedListFacilities" runat="server" 
                                BulletStyle="Square">
                            </asp:BulletedList>
                        </td>
                    </tr>
                </table> 
                </div>       
            </asp:Panel>
    </div>
    <br />
            
        <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
            ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
            SelectCommand="SELECT * FROM [Semester]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="ParkCodes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT DISTINCT [Park] FROM [Building] ORDER BY [Park]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="BuildingCodes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT [Park], [BuildingID] FROM [Building]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="BuildingNames" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT * FROM [Building] ORDER BY [Name]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="RoomCodes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        
        SelectCommand="SELECT [Name] FROM [Building] WHERE ([BuildingID] = @BuildingID)">
        <SelectParameters>
            <asp:Parameter DefaultValue="Nothing" Name="BuildingID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="RoomType" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT * FROM [Facility] WHERE ([FacilityID] = 0) OR ([FacilityID] = 1) OR ([FacilityID] = 2)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="RoomStyle" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT * FROM [Facility] WHERE ([FacilityID] = 3) OR ([FacilityID] = 4)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Facilities" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        
        SelectCommand="SELECT * FROM [Facility] WHERE ([FacilityID] &gt; @FacilityID)">
        <SelectParameters>
            <asp:Parameter DefaultValue="4" Name="FacilityID" Type="Double" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>