<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="view.aspx.cs" Inherits="Secure_view" %>

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
        .style5
        {
            text-align: right;
        }
        </style>

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
        <strong>
    <div class="style4">
        <strong><em><span class="style3">View Request, </span></em></strong>
        <span class="style3"><em>ID = <font color="red"><asp:Label ID="Label11" runat="server" Text="Label"></asp:Label></font></em></span>
    </div>
    </strong>

    <div class="style5">
        If you need help with this page click <a href="Help.aspx">here</a>
    </div>
    <br />

    <table 
        align="center" 
        style="border-style: solid; border-width: 1px; border-collapse: collapse; table-layout: auto; border-spacing: inherit; empty-cells: show; background-color: #FFFFCC;" 
        width="65%">
    <tr>
        <td align=center style="border-style: solid; border-top-width: 0px; border-left-width: 0px; border-right-width: 1px; border-bottom-width: 0px;">
            <p style=" font-size: medium;"><b>Details</b></p>
        </td>
        <td align=center style="border-style: solid; border-top-width: 0px; border-left-width: 0px; border-right-width: 0px; border-bottom-width: 1px;">
            <p style=" font-size: medium;"><b>Timetable View</b></p>
        </td>
    </tr>
    <tr>
        <td align=center style="padding:10px; background-color: #FAFAFA; border-style: solid; border-top-width: 1px; border-left-width: 0px; border-right-width: 1px; border-bottom-width: 0px;">        
                <strong>Status:</strong>
                <asp:Label ID="Label10" runat="server" Text="Label"></asp:Label>
            <p>
                <strong>Module Name:</strong>
                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
            </p>
            <p>
                <strong>Module Code:</strong>
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            </p>
            <p>
                <strong>Number of Students: </strong>
                <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>
            </p>
            <p>
                <strong>Room(s) Requested:</strong>
                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
            </p>
                <p>
                    <strong>Room Type: </strong>
                <asp:Label ID="Label12" runat="server" Text="Label"></asp:Label>
            </p>
                <p>
                    <strong>Room Style: </strong>
                <asp:Label ID="Label13" runat="server" Text="Label"></asp:Label>
            </p>
            <p>
                <strong>Facilities Requested:</strong>
                <asp:Label ID="Label4" runat="server"></asp:Label>
            </p>
            <p>
                <strong>Park Requested: </strong>
                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
            </p>
            <p>
                <strong>Building Requested:</strong>
                <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>
            </p>
            <p>
                <strong>Weeks Requested:</strong>
                <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>
            </p>
            <p>
                <strong>Times Requested:</strong>
                <asp:Label ID="Label7" runat="server"></asp:Label>
            </p>
        </td>
        <td align=center style="padding:10px;">
            <i><u>Red boxes indicate which periods have been requested/allocated.</u></i>
            <br /><br />
            <asp:Table ID="Table1" runat="server" GridLines="Both" Height="271px" 
                                Width="100%">
                                <asp:TableRow ID="TableRow1" runat="server">
                                    <asp:TableCell ID="TableCell1" runat="server" BackColor="#E1C4FF" Width="60px">Period:</asp:TableCell>
                                    <asp:TableCell ID="TableCell2" runat="server" BackColor="#E1C4FF" Width="60px">1</asp:TableCell>
                                    <asp:TableCell ID="TableCell3" runat="server" BackColor="#E1C4FF" Width="60px">2</asp:TableCell>
                                    <asp:TableCell ID="TableCell4" runat="server" BackColor="#E1C4FF" Width="60px">3</asp:TableCell>
                                    <asp:TableCell ID="TableCell5" runat="server" BackColor="#E1C4FF" Width="60px">4</asp:TableCell>
                                    <asp:TableCell ID="TableCell6" runat="server" BackColor="#E1C4FF" Width="60px">5</asp:TableCell>
                                    <asp:TableCell ID="TableCell7" runat="server" BackColor="#E1C4FF" Width="60px">6</asp:TableCell>
                                    <asp:TableCell ID="TableCell8" runat="server" BackColor="#E1C4FF" Width="60px">7</asp:TableCell>
                                    <asp:TableCell ID="TableCell9" runat="server" BackColor="#E1C4FF" Width="60px">8</asp:TableCell>
                                    <asp:TableCell runat="server" BackColor="#E1C4FF" Width="60px">9</asp:TableCell>
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
                                    <asp:TableCell ID="TableCell20" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell21" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell22" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell23" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell24" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell25" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell26" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell27" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow4" runat="server">
                                    <asp:TableCell ID="TableCell28" runat="server" BackColor="#E1C4FF">Tue</asp:TableCell>
                                    <asp:TableCell ID="TableCell29" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell30" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell31" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell32" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell33" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell34" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell35" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell ID="TableCell36" runat="server" BackColor="White"></asp:TableCell>
                                    <asp:TableCell runat="server" BackColor="White"></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server">
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
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" BackColor="#E1C4FF">Thurs</asp:TableCell>
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
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" BackColor="#E1C4FF">Friday</asp:TableCell>
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
                            </asp:Table>
        </td>
    </tr>
    </table>
    <br />

</asp:Content>

