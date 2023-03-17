﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services.Description;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Diagnostics;
using ClubTraxUtilityPrograms.Utilities;
using System.Security.Policy;

namespace ClubTraxUtilityPrograms
{
    public partial class Menu : System.Web.UI.Page
    {
        protected static string JSONincidentEvents;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetPricingList();
        }

        // protected void filterit_Click(object sender, EventArgs e)
        //{
        //   string FilterExpression = string.Concat(DropDownList1.SelectedValue, " LIKE '%{0}%'");
        //   SqlDataSource1.FilterParameters.Clear();
        //   SqlDataSource1.FilterParameters.Add(new ControlParameter(DropDownList1.SelectedValue, "filter", "Text"));
        //   SqlDataSource1.FilterExpression = FilterExpression;
        // }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetPricingList()
        {
            JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
                      
                using (Database d = new Database("cn"))
                {
                    using (SqlCommand comm = new SqlCommand("SELECT * FROM tempChangePricing ORDER BY [nID]", d.Connection))
                    {

                        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(comm);
                        dt.TableName = "PricingList";
                        sqlDataAdapter.Fill(dt);
                    }


                }

                         

            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;

            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {

                    row.Add(col.ColumnName, dr[col]);

                }
                rows.Add(row);

            }

            JSONincidentEvents = serializer.Serialize(rows);
            return JSONincidentEvents;



        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string UpdatePricingList(string PLU, string amount, string priceName)
        {
            
            using (Database d = new Database("cn"))
            {
                using (SqlCommand comm = new SqlCommand("UpdatePriceList", d.Connection))
                {
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@PLU", PLU);
                    comm.Parameters.AddWithValue("@Amount", amount);
                    comm.Parameters.AddWithValue("@priceName", priceName);
                    comm.ExecuteNonQuery();
                    

                }


            }
            return "OK";
        }

    }
}