<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="RoomBook.aspx.cs" Inherits="Secure_RoomBook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">

<script type="text/javascript">

    function TimePeriodValidate(source, args) {
        var findBox = document.getElementById('<%= CheckBoxList2.ClientID %>');
        var checkList = findBox.getElementsByTagName("input");
        for (var i = 0; i < checkList.length; i++) {
            if (checkList[i].checked) {
                args.IsValid = true; return;
            }
        }
        args.IsValid = false;
    }

    function WeekValidate(source, args) {
        var findBox = document.getElementById('<%= CheckBoxList1.ClientID %>');
        var checkList = findBox.getElementsByTagName("input");
        for (var i = 0; i < checkList.length; i++) {
            if (checkList[i].checked) {
                args.IsValid = true; return;
            }
        }
        args.IsValid = false;
    }  
</script>

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
        </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <strong>
    <div class="style4">
        <strong><em><span class="style3">Request Form</span></em></strong>
    </div>
    </strong>

    <div class="style5">
        If you need help with this page click <a href="Help.aspx">here</a>
    </div>

    <div align=center>
    <asp:ValidationSummary id="valSum" 
        DisplayMode="BulletList"
        EnableClientScript="true"
        ValidationGroup="CheckBookingForm"
        Style="color: Red;"
        HeaderText="Sorry, you are unable to continue due to the following errors:"
        runat="server"/>
    </div>
    
    <br />

    <table 
        align="center" 
        style="border-style: solid; border-width: 1px; border-collapse: collapse; table-layout: auto; border-spacing: inherit; empty-cells: show; background-color: #FFFFCC;" 
        width="95%">
        <tr>
            <td align="center"
                style="padding: 10px; border-right-style: solid; border-right-width: 1px; border-bottom-style: solid; border-bottom-width: 1px; text-align: center;" colspan="2">
                <strong>
                <div style="text-decoration: underline">
                    ROUND SELECTION
                </div>
                </strong>
                <br />
                <div align=center>
                Please select which round you'd like to make a booking for:
                <asp:DropDownList ID="DropDownList3" runat="server" 
                    DataSourceID="RoundDropDownDataSource" DataTextField="Column1" 
                    DataValueField="RoundID" 
                        onselectedindexchanged="DropDownList3_SelectedIndexChanged" 
                        ToolTip="Please select a round from the drop down list." 
                        AutoPostBack="True" ondatabound="DropDownList3_DataBound">
                </asp:DropDownList>
                    <br />
                    <br />
                    <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
                </div>
            </td>
        </tr>
        <tr>
            <td class="style6"
                style="padding: 10px; border-right-style: solid; border-right-width: 1px;" 
                width="50%">
                <div align=center>
                <strong>
                <div style="text-decoration: underline">
                    MODULE INFORMATION
                </div>
                </div>
                <div class="style7">
                <br />
                <div align=center>
                Module Part:
                </strong> 
                <span class="style2">
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SQLPart" DataTextField="Part" DataValueField="Part" 
                        AutoPostBack="True" 
                        ToolTip="Pick a Part you would like to filter the modules by" 
                        onselectedindexchanged="DropDownList1_SelectedIndexChanged" 
                        ondatabound="DropDownList1_DataBound">
                    </asp:DropDownList>
                    </div>
                    <br />
                    <br />
                </span>
                <div align=center>
                <div class="style7" align=center 
                        style="border: 1px solid #808080; width: 430px; background-color: #FFFFFF;">
                <div style="padding: 10px;">
                <strong>Module Code&nbsp;&nbsp;&nbsp;&nbsp; Module Name</strong>

                <span class="style2">
                <br />

                <asp:ListBox ID="ListBoxModCodes" runat="server" 
                    DataSourceID="SQLModCodes" DataTextField="ModuleID" 
                    DataValueField="Name" AutoPostBack="True" 
                    onselectedindexchanged="ListBox1_SelectedIndexChanged1" Width="100px" 
                        Rows="12" 
                        ToolTip="Please ensure you have selected a module code from the list."></asp:ListBox>
                <asp:ListBox ID="ListBoxModNames" runat="server" 
                    DataSourceID="SQLModNames" DataTextField="Name" DataValueField="Name" 
                    AutoPostBack="True" 
                    onselectedindexchanged="ListBox2_SelectedIndexChanged" Width="305px" Rows="12" 
                        ToolTip="Please ensure you have selected a module name from the list.">
                </asp:ListBox>
                </div>

                </div>
                </div>

                <asp:RequiredFieldValidator
                    id="ModuleCodeValidator"
                    ControlToValidate="ListBoxModCodes" 
                    ErrorMessage="You must select a module code."
                    Display="Static"
                    Style="color: White; display: inline;"
                    Width="100%"
                    Text="*"
                    ValidationGroup="CheckBookingForm" 
                    runat=server/>

                <asp:RequiredFieldValidator
                    id="ModuleNameValidator"
                    ControlToValidate="ListBoxModNames" 
                    ErrorMessage="You must select a module name."
                    Display="Static"
                    Style="color: White; display: inline;"
                    Width="100%"
                    Text="*"
                    ValidationGroup="CheckBookingForm" 
                    runat=server/>

                <div class="style8">
                    <i>
                    <br />
                    Note: If a module is repeated it means there are mutiple entries of the same 
                    name, so ensure the module code auto-selected is correct</i>
                </div>
                <br />
                <br />

                <div align=center>
                </span><strong>Number of Students: </strong>
                <span class="style2">
                <strong style="text-decoration: underline">
                    <asp:TextBox ID="TextBoxStudents" runat="server" Width="50px" 
                        AutoPostBack="True" ontextchanged="TextBoxStudents_TextChanged" 
                        ValidationGroup="CheckBookingForm" 
                        ToolTip="Input the number of students you wish to request a room for."></asp:TextBox>

                    
                </strong>
                </span>
                <span class="style4">
                &nbsp;(Max
    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                    )</span><strong style="text-decoration: underline"><span class="style2"><br />
                </span>
                </strong>
                </div>
                </div>
                    <asp:RegularExpressionValidator 
                        ID="NoStudentsNumberValidator" 
                        runat="server" 
                        ControlToValidate="TextBoxStudents"
                        ErrorMessage="Number of Students can only contain numbers." 
                        Style="color: White; display: inline;"
                        Width="100%"
                        Text="*" 
                        ValidationExpression="^\d+$" 
                        ValidationGroup="CheckBookingForm" 
                        />
                
                    <asp:RangeValidator 
                         id="NoStudentsValidation" 
                         ControlToValidate="TextBoxStudents" 
                         MinimumValue="1"
                         MaximumValue="415" 
                         Type="Integer" 
                         Style="color: White; display: inline;"
                         Text="*"
                         runat="server" 
                         ValidationGroup="CheckBookingForm">
                    </asp:RangeValidator>

                    <asp:RequiredFieldValidator
                        id="NoStudentsRequiredValidator"
                        ControlToValidate="TextBoxStudents" 
                        ErrorMessage="Number of Students cannot be empty."
                        Display="Static"
                        Style="color: White; display: inline;"
                        Width="100%"
                        Text="*"
                        ValidationGroup="CheckBookingForm" 
                        runat=server/>
    

            </td>
            <td class="style6" style="padding: 10px; margin-top:0px;" width="50%">
                <strong>
                <div style="text-decoration: underline;">
                    TIME INFORMATION</div>
                <div class="style7">
                    </strong>
                    <span class="style2">
                    <br />
                    <br />
                    <div class="style4">
                        <i>
    <span class="style2">
                        To select a time please check the appropiate box</span></i></div>
                        <br />
                    <br />
                <table style="border-color: black; border-width: 1px; border-style: solid; width: 300px; height: 260px; border-collapse: collapse; border-spacing: inherit; empty-cells: show; table-layout: auto;" 
                        align="center">
                    <tr>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            Period:</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF;">
                            1</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            2</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF;">
                            3</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            4</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            5</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            6</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            7</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            8</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF;">
                            9</td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            Times:</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            9am -
                            <br />
                            9.50am</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            10am -
                            <br />
                            10.50am</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            11am -
                            <br />
                            11.50am</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            12pm -
                            <br />
                            12.50pm</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            1pm -<br />
                            1.50pm</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            2pm -<br />
                            2.50pm</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            3pm -
                            <br />
                            3.50pm</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            4pm -<br />
                            4.50pm</td>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            5pm -<br />
                            5.50pm</td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            Mon</td>
                        <td style="border-right-style: solid; border-right-width: 1px;" colspan="9" 
                            rowspan="5">
                            <asp:CheckBoxList ID="CheckBoxList2" runat="server" 
                                Height="196px" 
                                RepeatColumns="9" RepeatDirection="Horizontal" style="text-align: center" 
                                Width="437px" BackColor="White" AutoPostBack="True" 
                                onselectedindexchanged="CheckBoxList2_SelectedIndexChanged" 
                                ToolTip="Please ensure you have selected at least one time period." 
                                onunload="CheckBoxList2_Unload">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem></asp:ListItem>
                            </asp:CheckBoxList>

                            <asp:CustomValidator 
                                ID="cv1" 
                                runat="server" 
                                ErrorMessage="Please select at least one time period."
                                Style="color: White; display:none;"
                                Text="*" 
                                ClientValidationFunction="TimePeriodValidate" 
                                ValidationGroup="CheckBookingForm">
                            </asp:CustomValidator>

                        </td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            Tue</td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            Wed</td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            Thurs</td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid black; background-color: #E1C4FF; ">
                            Fri</td>
                    </tr>
                </table>

                    <i>
                    <br />
                    <br />
                    </i></span><strong>Weeks In Semester:</strong><asp:RadioButtonList 
                    ID="RadioButtonList2" runat="server" AutoPostBack="True" 
                    onselectedindexchanged="RadioButtonList2_SelectedIndexChanged" 
                    RepeatDirection="Horizontal" RepeatLayout="Flow">
                    <asp:ListItem Selected="True">All</asp:ListItem>
                    <asp:ListItem Value="Me">Let Me Choose</asp:ListItem>
                </asp:RadioButtonList>
    <span class="style2">
                    <asp:CheckBoxList ID="CheckBoxList1" runat="server" Enabled="False" 
                    RepeatDirection="Horizontal" AutoPostBack="True" 
                        onselectedindexchanged="CheckBoxList1_SelectedIndexChanged" 
                        ToolTip="Tick the boxes of the weeks you wish to make a room request for.">
                    <asp:ListItem Selected="True">1</asp:ListItem>
                    <asp:ListItem Selected="True">2</asp:ListItem>
                    <asp:ListItem Selected="True">3</asp:ListItem>
                    <asp:ListItem Selected="True">4</asp:ListItem>
                    <asp:ListItem Selected="True">5</asp:ListItem>
                    <asp:ListItem Selected="True">6</asp:ListItem>
                    <asp:ListItem Selected="True">7</asp:ListItem>
                    <asp:ListItem Selected="True">8</asp:ListItem>
                    <asp:ListItem Selected="True">9</asp:ListItem>
                    <asp:ListItem Selected="True" Value="10">10</asp:ListItem>
                    <asp:ListItem Selected="True">11</asp:ListItem>
                    <asp:ListItem Selected="True">12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                </asp:CheckBoxList>

                <asp:CustomValidator 
                    ID="CustomValidator1" 
                    runat="server" 
                    ErrorMessage="Please select at least one week."
                    Style="color: White; display:none;"
                    Text="*" 
                    ClientValidationFunction="WeekValidate" 
                    ValidationGroup="CheckBookingForm">
                </asp:CustomValidator>


                    <br />
                    </span>
                </div>
            </td>
        </tr>
        <tr>
            <td 
                
                
                style="padding: 10px; border-top-style: solid; border-top-width: 1px; border-right-style: solid; border-right-width: 1px;" 
                colspan="2">
                
                <div style="text-decoration: underline; height: 8%; text-align: center">
                    <strong style="text-align: center">ROOM SELECTION<br />
                    <br />
                    <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
                        Text="Back to Regular Booking" />
                    </strong>
                    
                </div>
                <br />
                    <strong style="text-align: center">
                <div align=center>
                <div style="border: 1px solid #808080; text-align: center; background-color: #FFFFFF; width: 450px; padding: 10px;">
                    
                    <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                </div>
                </div>
                </strong>
                </strong>

            </td>
        </tr>
        <tr>
            <td colspan="2" style="border-top-style: solid; border-width: 1px">
                <div style="margin: 7px 0px 3px 7px; text-align: center">



    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Submit Request" style="text-align: center" ValidationGroup="CheckBookingForm" />
                </div>
            </td>
        </tr>
    </table>
    <br />
    <strong>
                <strong style="text-align: center">
    <br />
    <br />
    <asp:SqlDataSource ID="RoundDropDownDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" SelectCommand="SELECT Round.Round + ' - ' + Semester.Name, Round.RoundID

FROM Round 

INNER JOIN Semester ON Round.SemesterID = Semester.SemesterID

WHERE Round.[Open] &lt;= GETDATE() AND Round.[Close] &gt;= GETDATE()">
    </asp:SqlDataSource>
    </strong>
                </strong>
    <br />



    <asp:SqlDataSource ID="SQLPart" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT DISTINCT [Part] FROM [Module]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlBuildings" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT * FROM [Building]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="InsertNewBooking" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" >
        <InsertParameters>
            <asp:SessionParameter Name="UserID" SessionField="login_name" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLModNames" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        
        SelectCommand="SELECT * FROM [Module] WHERE ([DepartmentID] = @DepartmentID) ORDER BY [Name]">
        <SelectParameters>
            <asp:SessionParameter Name="DepartmentID" SessionField="login_name" 
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLModCodes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        
        SelectCommand="SELECT * FROM [Module] WHERE ([DepartmentID] = @DepartmentID) ORDER BY [ModuleID]">
        <SelectParameters>
            <asp:SessionParameter Name="DepartmentID" SessionField="login_name" 
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLRoomType" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        
        SelectCommand="SELECT * FROM [Facility] WHERE ([FacilityID] = 0) OR ([FacilityID] =1) OR ([FacilityID] = 2)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLPark" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT DISTINCT [Park] FROM [Building]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLRoomStyle" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        
        SelectCommand="SELECT * FROM [Facility] WHERE ([FacilityID] = 3) OR ([FacilityID] = 4)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLFacilities" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        
        
        SelectCommand="SELECT * FROM [Facility] WHERE ([FacilityID] &gt; @FacilityID)">
        <SelectParameters>
            <asp:Parameter DefaultValue="4" Name="FacilityID" Type="Double" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLRooms" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT [RoomID] FROM [Room]"></asp:SqlDataSource>
    <br />






</asp:Content>


