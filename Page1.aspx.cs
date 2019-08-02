using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace WebAppTest4Siavash
{
    public partial class Page1 : System.Web.UI.Page
    {
        static string RefineText = "";
        static string strUserID = "";
        protected static string data4Graph = "";
        protected void CreateTableOfContent()
        {
            if(strUserID == null)
            {
                return;
            }
            ConnectSQLServerObject mySqlConnObj = new ConnectSQLServerObject();
            SqlConnection mySqlConn = mySqlConnObj.getSQLConnectionObject();
            mySqlConn.Open();
            if (mySqlConn.State == System.Data.ConnectionState.Open)
            {
                string query = "";
                if (RefineText.Length == 0)
                {
                    query = "Select * From SampleData where fkUserId =" + strUserID;
                }
                else
                {
                    query = "Select * From SampleData where fkUserId =" + strUserID + " and Type Like '%" + RefineText + "%'";
                }                
                SqlCommand cmd = new SqlCommand(query, mySqlConn);
                SqlDataReader reader = cmd.ExecuteReader();
                string innerHTMLStr = "";
                int counter = 0;
                data4Graph = "";
                while (reader.Read())
                {
                    innerHTMLStr += "<tr>";
                    innerHTMLStr += "<th scope=\"row\">" + (counter+1).ToString() + "</th>";
                    innerHTMLStr += "<td>" + reader["Type"].ToString() + "</td>";
                    innerHTMLStr += "<td>" + reader["Value"].ToString() + "</td>";
                    innerHTMLStr += "</tr>";
                    ++counter;
                    if(counter>1)
                    {
                        data4Graph += ",";
                    }
                    data4Graph += "{ order:" + counter.ToString() + ", value:" + reader["Value"].ToString() + "}";
                }
                NumOfRecords_DIV.InnerHtml = counter.ToString();
                TableBodyContent.InnerHtml = innerHTMLStr;
            }
            mySqlConn.Close();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["UserId"] == null)
            {
                Response.Redirect("default.aspx?msg=FalseAttemptToApproach");
            }
            strUserID = Request.Cookies["UserId"].Value.ToString();
            CreateTableOfContent();            
        }

        protected void SubmitBtn_Click(object sender, EventArgs e)
        {
            RefineText = FilterType_TextBox.Text;
            CreateTableOfContent();
        }

        
    }
}