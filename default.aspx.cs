using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace WebAppTest4Siavash
{
    public partial class ConnectSQLServerObject
    {
        public SqlConnection getSQLConnectionObject()
        {
            SqlConnection mySqlConn = new SqlConnection();
            String cSqlServerUsername = "";
            String cSqlServerPassword = "";
            String cSqlServerName = "";
            String cSqlServerPort = "1433";
            String cSqlServerDatabaseName = "WebAppTest4Siavash";
            String mConnectionString = "Server=" + cSqlServerName + "," + cSqlServerPort + ";Database=" + cSqlServerDatabaseName + ";Uid=" + cSqlServerUsername + ";Pwd=" + cSqlServerPassword + ";Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;";
            mySqlConn.ConnectionString = mConnectionString;
            return mySqlConn;
        }
    }

    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string msg = Request.QueryString["msg"];
            if(msg != null)
            {
                if (msg == "SuccessfulCreateAccount")
                {
                    myMessageArea.InnerHtml = "<p style=\"color:green;font-weight:800\">User Account Successfully Created!</p>";
                }
                else if(msg == "FalseAttemptToApproach")
                {
                    myMessageArea.InnerHtml = "<p style=\"color:red;font-weight:800\">You tried to hack my website!</p>";
                }
            }
        }

        protected void CreateUserNamePassword(object sender, EventArgs e)
        {

        }

        protected void SendToSignUpPage(object sender, EventArgs e)
        {
            Response.Redirect("CreateAccount.aspx");
        }

        protected void CheckUserNamePassword(object sender, EventArgs e)
        {
            ConnectSQLServerObject mySqlConnObj = new ConnectSQLServerObject();
            SqlConnection mySqlConn = mySqlConnObj.getSQLConnectionObject();
            mySqlConn.Open();
            if (mySqlConn.State == System.Data.ConnectionState.Open)
            {
                myMessageArea.InnerHtml = "<p>Database connected successfully!</p>";
                string usernameTxt = myUsername.Text;
                string passwordTxt = myPassword.Text;
                string query = "Select count(*) from tbUserAccounts where Username='" + usernameTxt + "' and Password='" + passwordTxt + "'";
                string query2 = "Select UserId from tbUserAccounts where Username='" + usernameTxt + "' and Password='" + passwordTxt + "'";
                SqlCommand cmd = new SqlCommand(query, mySqlConn);
                int numDetectedUsers = Convert.ToInt32(cmd.ExecuteScalar());
                string strUserID = "";
                if (numDetectedUsers > 0)
                {
                    myMessageArea.InnerHtml += "<p>Username and Password correct!</p>";
                    SqlCommand cmd2 = new SqlCommand(query2, mySqlConn);
                    SqlDataReader reader = cmd2.ExecuteReader();                    
                    if (reader.Read())
                    {
                        strUserID = reader["UserId"].ToString();
                    }
                    mySqlConn.Close();
                    Response.Cookies["UserId"].Value = strUserID;
                    Response.Cookies["UserId"].Expires = DateTime.Now.AddMinutes(15);
                    Response.Redirect("Page1.aspx");
                }
                else
                {
                    mySqlConn.Close();
                    myMessageArea.InnerHtml = "<p>Username and/or Password incorrect!</p>";                    
                    Response.Redirect("default.aspx");
                }
            }
        }
    }
}