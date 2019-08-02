using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace WebAppTest4Siavash
{
    public partial class CreateAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateUserNamePassword(object sender, EventArgs e)
        {
            SqlConnection mySqlConn = new SqlConnection();
            String cSqlServerUsername = "*******";
            String cSqlServerPassword = "******";
            String cSqlServerName = "*******";
            String cSqlServerPort = "1433";
            String cSqlServerDatabaseName = "WebAppTest4Siavash";
            String mConnectionString = "Server=" + cSqlServerName + "," + cSqlServerPort + ";Database=" + cSqlServerDatabaseName + ";Uid=" + cSqlServerUsername + ";Pwd=" + cSqlServerPassword + ";Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;";
            mySqlConn.ConnectionString = mConnectionString;
            mySqlConn.Open();
            if (mySqlConn.State == System.Data.ConnectionState.Open)
            {
                myMessageArea.InnerHtml = "<p>Database connected successfully!</p>";
                string usernameTxt = myUsername.Text;
                string passwordTxt = myPassword.Text;
                string fnTxt = myFirstname.Text;
                string lnTxt = myLastname.Text;

                string query = "Select count(*) from tbUserAccounts where Username='" + usernameTxt + "'";
                SqlCommand cmd = new SqlCommand(query, mySqlConn);
                int numDetectedUsers = Convert.ToInt32(cmd.ExecuteScalar());
                
                if (numDetectedUsers > 0)
                {
                    myMessageArea.InnerHtml += "<p style=\"color:#ff0000;font-size:18px;font-weight:800\">Username already exists in DB!</p>";
                    mySqlConn.Close();
                    return;
                }
                query = "INSERT INTO tbUserAccounts (Username,Password,Firstname,Lastname) VALUES ('" + usernameTxt + "','" + passwordTxt + "','" + fnTxt + "','" + lnTxt +"')";
                SqlCommand cmd2 = new SqlCommand(query, mySqlConn);
                cmd2.ExecuteNonQuery();

                query = "Select count(*) from tbUserAccounts where Username='" + usernameTxt + "'";
                SqlCommand cmd3 = new SqlCommand(query, mySqlConn);
                numDetectedUsers = Convert.ToInt32(cmd.ExecuteScalar());                
                if (numDetectedUsers == 0)
                {
                    myMessageArea.InnerHtml += "<p style=\"color:#ff0000;font-size:18px;font-weight:800\">User account was not created!</p>";
                    mySqlConn.Close();
                    return;
                }                
                Response.Redirect("default.aspx?msg=SuccessfulCreateAccount");
                mySqlConn.Close();
            }
        }

        protected void SendToLoginPage(object sender, EventArgs e)
        {
            Response.Redirect("default.aspx");
        }
    }
}