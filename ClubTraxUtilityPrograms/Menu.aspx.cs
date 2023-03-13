using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClubTraxUtilityPrograms
{
    public partial class Menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void filterit_Click(object sender, EventArgs e)
        {
            string FilterExpression = string.Concat(DropDownList1.SelectedValue, " LIKE '%{0}%'");
            SqlDataSource1.FilterParameters.Clear();
            SqlDataSource1.FilterParameters.Add(new ControlParameter(DropDownList1.SelectedValue, "filter", "Text"));
            SqlDataSource1.FilterExpression = FilterExpression;
        }
    }
}