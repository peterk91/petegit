<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="updated.aspx.cs" Inherits="Secure_updated" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <p>
        <strong>Your request has been updated successfully!</strong></p>
<p>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="Go to My Requests" />
    </p>
<p>
        <asp:Button ID="Button2" runat="server" 
            Text="Make a similar request" onclick="Button2_Click" /> (Same Module and Round)
    </p>
    <p>
        <asp:Button ID="Button3" runat="server" onclick="Button3_Click" 
            Text="Make a new request" />
    </p>



</asp:Content>

