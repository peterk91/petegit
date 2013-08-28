using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_updated : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Secure/Summary.aspx");
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Secure/Booking.aspx");
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        string mod = Request.Url.Query.ToString().Substring(1);
        Response.Redirect("~/Secure/ModuleBooking.aspx?" + mod);
    }
}