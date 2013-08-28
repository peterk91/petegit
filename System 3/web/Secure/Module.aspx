<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Module.aspx.cs" Inherits="Secure_Module" %>

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
    <div align=center>
    <strong>
    <div class="style4">
    <strong><em><span class="style3">Module Management</span></em></strong>
    </div>
    </strong>
    <br />
        
    <asp:ValidationSummary id="valSum" 
        DisplayMode="BulletList"
        EnableClientScript="true"
        ValidationGroup="CheckModuleForm"
        Style="color: Red;"
        HeaderText="Sorry, you are unable to continue due to the following errors:"
        runat="server"/>

    <br />

    <div style="border-style: solid; border-width: 1px; border-collapse: collapse; 
        border-spacing: inherit; background-color: #FFFFCC; width:60%;">

    <div style="padding-top:10px;">
    <span><i><u>
    You may use the following form to submit a new module. Please ensure the module code is in the format "COA123".<br />
        Where &#39;CO&#39; is the Department Code, &#39;A&#39; is the Part and &#39;123&#39; is a unique number.<br />
        <br />
        Please note you can only add modules to your own department.</span></u></i></div>

    <br />

    Module Code:
    <asp:ListBox ID="DepCode" runat="server" DataSourceID="DepartmentDataSource" 
        DataTextField="DepartmentID" DataValueField="DepartmentID" Rows="1">
    </asp:ListBox>
    
    <asp:DropDownList ID="ModulePart" runat="server" 
        DataSourceID="ModulePartDropDownDataSource" DataTextField="Part" 
        DataValueField="Part">
    </asp:DropDownList>
    
    <asp:TextBox ID="ModuleCode" Width="50px" runat="server" MaxLength="3" ValidationGroup="check">
    </asp:TextBox>

    <asp:RegularExpressionValidator 
        ID="ModuleCodeNumberValidator" 
        runat="server" 
        ControlToValidate="ModuleCode"
        ErrorMessage="Module Code can only contain numbers." 
        Style="color: White; display: inline;"
        Width="100%"
        Text="*" 
        ValidationExpression="^\d+$" 
        ValidationGroup="CheckModuleForm" 
        />
    
    <asp:RequiredFieldValidator
        id="ModuleCodeRequiredValidator"
        ControlToValidate="ModuleCode" 
        ErrorMessage="Module Code cannot be blank."
        Display="Static"
        Style="color: White; display: inline;"
        Width="100%"
        Text="*"
        ValidationGroup="CheckModuleForm" 
        runat=server/>
    
    <asp:SqlDataSource ID="DepartmentDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT [DepartmentID] FROM [Department] WHERE ([DepartmentID] = @DepartmentID)">
        <SelectParameters>
            <asp:SessionParameter Name="DepartmentID" SessionField="login_name" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="ModulePartDropDownDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:team17ConnectionString %>" 
        SelectCommand="SELECT DISTINCT [Part] FROM [Module]">
    </asp:SqlDataSource>
    
        <br />
    <br />
    
    Module Name:
    <asp:TextBox ID="ModuleName" runat="server"></asp:TextBox>

    <asp:RequiredFieldValidator
        id="ModuleNameValidator"
        ControlToValidate="ModuleName" 
        ErrorMessage="Module Name cannot be blank."
        Display="Static"
        Style="color: White; display: inline;"
        Width="100%"
        Text="*"
        ValidationGroup="CheckModuleForm" 
        runat=server/>

    <br />
    <br />

    <asp:Button ID="SubmitButton" runat="server" onclick="Button1_Click" 
        Text="Submit" ValidationGroup="CheckModuleForm"/>
    
    <br />
    <br />

    </div>

    </div>
</asp:Content>

