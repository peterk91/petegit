<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="web_login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class ="login_form">
        <asp:DropDownList ID="DropDownList1" runat="server" 
            DataSourceID="SqlDataSource2" DataTextField="DepartmentID" 
            DataValueField="DepartmentID">
        </asp:DropDownList>
        <br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <br />
        <br />
    <br />

    
        <asp:Login ID="Login1" runat="server" onauthenticate="Login1_Authenticate" 
            DisplayRememberMe="True" DestinationPageUrl="~/Secure/home.aspx" 
            PasswordRequiredErrorMessage="Departmental Password is required." 
            UserNameRequiredErrorMessage="DepartmentalUser Name is required." 
            TitleText="Log In Required" Font-Bold="False" Font-Overline="False" 
            Width="228px">
            <LabelStyle Font-Overline="False" Font-Size="Medium" HorizontalAlign="Right" 
                VerticalAlign="Middle" Wrap="True" />
            <LayoutTemplate>
                <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                    <tr>
                        <td>
                            <table cellpadding="0">
                                <tr>
                                    <td align="center" colspan="2" style="font-weight:bold; font-size:large;">
                                        Log In Required</td>
                                </tr>
                                <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                <tr>
                                    <td align="right" style="font-size:Medium;text-decoration:none;" 
                                        valign="middle; width:150px;" width="150px">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:&nbsp;</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                            ControlToValidate="UserName" ErrorMessage="DepartmentalUser Name is required." 
                                            ToolTip="DepartmentalUser Name is required." ValidationGroup="Login1">Username Required</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr><td></td><td></td></tr>
                                <tr>
                                    <td align="right" style="font-size:Medium;text-decoration:none;" 
                                        valign="top">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password: &nbsp;</asp:Label>
                                    </td>
                                    
                                    <td valign="middle">
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                            ControlToValidate="Password" ErrorMessage="Departmental Password is required." 
                                            ToolTip="Departmental Password is required." ValidationGroup="Login1">Password Required</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me next time." />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color:Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" 
                                            ValidationGroup="Login1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <TitleTextStyle Font-Bold="True" />
        </asp:Login>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:LoginConnectionString %>" 
            SelectCommand="SELECT * FROM [User]"></asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" 
            SelectCommand="SELECT [DepartmentID] FROM [Department]"></asp:SqlDataSource>
        <br />
        <br />
    
    </div>
        
</asp:Content>

