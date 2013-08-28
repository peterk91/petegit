<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login1.aspx.cs" Inherits="web_login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 131px;
        }
        .style3
    {
        text-align: justify;
    }
    .style4
    {
        font-size: large;
    }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class ="login_form">
    <div>
    <div class="style3">
        <br />
        <span class="style4">
        <strong>Login Required:</strong></span><br />
        <br />

    </div>
        Department:&nbsp;
        <asp:DropDownList ID="DropList5" runat="server" DataSourceID="loginname" 
                                            DataTextField="DepartmentName" 
            DataValueField="DepartmentID" AutoPostBack="True">
        </asp:DropDownList>
    <br />
    
        <asp:Login ID="Login1" runat="server" onauthenticate="Login1_Authenticate" 
            DisplayRememberMe="True" DestinationPageUrl="~/Secure/home.aspx" 
            PasswordRequiredErrorMessage="Departmental Password is required." 
            UserNameRequiredErrorMessage="DepartmentalUser Name is required." 
            TitleText="Log In Required" Height="100px" Width="280px" 
            FailureText="Incorrect Password">
            <LayoutTemplate>
                <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                    <tr>
                        <td>
                            <table cellpadding="0">
                                     <tr>
                                    <td align="right">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password: &nbsp; &nbsp;</asp:Label>
                                    </td>
                                    <td class="style2">
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                        </td>
                                        <td>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                            ControlToValidate="Password" ErrorMessage="Departmental Password is required." 
                                            ToolTip="Departmental Password is required." ValidationGroup="Login1" Style="display:inline">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                <td>
                                
                                
                                    <asp:TextBox ID="UserName" runat="server" Visible="False"></asp:TextBox>
                                
                                
                                </td>
                                
                                
                                </tr>
                                <tr>
                                <td>
                                &nbsp;
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
        </asp:Login>
        
        </div>
        <br />


        <br />
        <br />
        <asp:SqlDataSource ID="loginname" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:InfoConnectionString %>" 
                                            
            SelectCommand="SELECT [DepartmentID], [DepartmentName] FROM [Department]">
        </asp:SqlDataSource>

    
    </div>
        
</asp:Content>

