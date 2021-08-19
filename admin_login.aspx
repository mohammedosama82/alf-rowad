<%@ Page Title="" Language="C#" MasterPageFile="~/login_master.master" UnobtrusiveValidationMode="None" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Text" %>



<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {

        // Session.Clear();
        if(Session["admin_code"]!=null)
        {
            Response.Redirect("admin_dashboard.aspx");
        }



    }

    protected void btn_login_Click(object sender, EventArgs e)
    {
        
        //if account not exist 
        con.Open();
        string sql = "SELECT admin_code from admins where admin_code=@admin_code";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@admin_code", txt_admin_code.Text);
        SqlDataReader read= cmd.ExecuteReader();
        if (read.HasRows == false)
        {
            lbl_invalid_code.Text = "Invalid Authentication!";
            read.Close();
            con.Close();

        }
        else
        {
            read.Close();
            con.Close();

            //check if the user is locked 
            string locked_checked = "select islocked from admins where admin_code=@admin_code";
            con.Open();
            SqlCommand cmd_locked_checked = new SqlCommand(locked_checked, con);
            cmd_locked_checked.Parameters.AddWithValue("@admin_code", HttpUtility.HtmlEncode(txt_admin_code.Text));
            SqlDataReader reader_locked_checked = cmd_locked_checked.ExecuteReader();
            while (reader_locked_checked.Read())
            {
                bool lockedfinal = Convert.ToBoolean(reader_locked_checked["islocked"].ToString());
                if (lockedfinal)
                {
                    Session["error"] = "invalid_code";
                    Response.Redirect("errors.aspx");
                    reader_locked_checked.Close();
                    con.Close();
                    break;
                }

            }
            reader_locked_checked.Close();
            con.Close();

            //read login ifno
            string str_candidate_info = "select admin_name, admin_type, islocked,attempt from admins  where admin_code=@admin_code and admin_password=hashbytes('sha2_256', @admin_password)";
            con.Open();
            SqlCommand cmd_candidate_info = new SqlCommand(str_candidate_info, con);
            cmd_candidate_info.Parameters.AddWithValue("@admin_code", HttpUtility.HtmlEncode(txt_admin_code.Text));
            byte[] newbyte = Encoding.ASCII.GetBytes(HttpUtility.HtmlEncode(txt_admin_password.Text));
            cmd_candidate_info.Parameters.AddWithValue("@admin_password", SqlDbType.VarBinary).Value = newbyte;
            SqlDataReader read_candidate_info = cmd_candidate_info.ExecuteReader();

            //if the password is not true 
            if (read_candidate_info.HasRows == false)
            {
                //first writing code

                /*  read_candidate_info.Close();
                  con.Close();
                  Session["error"] = "invalid_code";
                  Response.Redirect("errors.aspx");*/
                read_candidate_info.Close();
                con.Close();

                //check how many attempt and increase it
                string str_candidate_info4 = "select islocked,attempt from admins  where admin_code=@admin_code ";
                con.Open();
                SqlCommand cmd_candidate_info4 = new SqlCommand(str_candidate_info4, con);
                cmd_candidate_info4.Parameters.AddWithValue("@admin_code", HttpUtility.HtmlEncode(txt_admin_code.Text));
                read_candidate_info.Close();

                SqlDataReader read_candidate_info4 = cmd_candidate_info4.ExecuteReader();
                while (read_candidate_info4.Read())
                {
                    int attempt = Convert.ToInt32(read_candidate_info4["attempt"].ToString());
                    attempt++;
                    lbl_assessment_code.Text = attempt.ToString();
                }

                read_candidate_info4.Close();
                con.Close();
                //update new attempt in the database
                string str_insert_new_candidate = "UPDATE admins SET attempt=@attempt where admin_code=@admin_code";
                SqlCommand cmd_insert_new_candidate = new SqlCommand(str_insert_new_candidate, con);
                cmd_insert_new_candidate.Parameters.AddWithValue("@attempt", lbl_assessment_code.Text);
                cmd_insert_new_candidate.Parameters.AddWithValue("@admin_code", HttpUtility.HtmlEncode(txt_admin_code.Text));
                con.Open();
                cmd_insert_new_candidate.ExecuteNonQuery();
                con.Close();

                int attemptfinal = Convert.ToInt32(lbl_assessment_code.Text);
                //update islocked to true if attempet reach to 5 and will not restore to false without edited by admin from the db
                if (attemptfinal >= 5)
                {
                    string str_insert_new_candidate2 = "UPDATE admins SET islocked=@islocked where admin_code=@admin_code";
                    SqlCommand cmd_insert_new_candidate2 = new SqlCommand(str_insert_new_candidate2, con);
                    cmd_insert_new_candidate2.Parameters.AddWithValue("@islocked", 1);
                    cmd_insert_new_candidate2.Parameters.AddWithValue("@admin_code", HttpUtility.HtmlEncode(txt_admin_code.Text));
                    con.Open();
                    cmd_insert_new_candidate2.ExecuteNonQuery();
                    con.Close();
                    Session["error"] = "invalid_code";
                    Response.Redirect("errors.aspx");
                }
                else
                {
                    lbl_invalid_code.Text = "Authentication Failed - you have only 5 attempt to login - " + attemptfinal + " failed attempt";
                }

            }
            else
            {


                while (read_candidate_info.Read())
                {
                    Session["admin_name"] = (read_candidate_info["admin_name"].ToString());
                    Session["admin_code"] = txt_admin_code.Text;
                    Session["admin_type"] = (read_candidate_info["admin_type"].ToString());

                }

                read_candidate_info.Close();
                con.Close();
                Session["mentor_file_number"] = null;
                Session["candidate_code"] = null;
                Session["trainer_file_number"] = null;

                //restore attempt to 0
                string str_insert_new_candidate = "UPDATE admins SET attempt=@attempt where admin_code=@admin_code";
                SqlCommand cmd_insert_new_candidate = new SqlCommand(str_insert_new_candidate, con);
                cmd_insert_new_candidate.Parameters.AddWithValue("@attempt", 0);
                cmd_insert_new_candidate.Parameters.AddWithValue("@admin_code", HttpUtility.HtmlEncode(txt_admin_code.Text));
                con.Open();
                cmd_insert_new_candidate.ExecuteNonQuery();
                con.Close();

                Response.Redirect("admin_dashboard.aspx");
            }
        }
    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        Response.Write("Action Cancelled");
        Response.AddHeader("REFRESH", "1;URL=admin_login.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .auto-style5 {
        border-style: none;
            border-color: inherit;
            border-width: medium;
width: 367px;
        }
        .auto-style12 {
            width: 349px;
            height: 39px;
            text-align: left;
        }
        .auto-style13 {
            width: 349px;
        }
        .auto-style14 {
            width: 349px;
            text-align: left;
        }
        .auto-style16 {
            font-weight: bold;
            display: inline-block;
            color: #FFFFFF;
            background-color: #000000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >
    <p>
    <table class="auto-style5">
        <tr>
            <td class="auto-style12"><strong>Admin Code </strong>
                <asp:TextBox ID="txt_admin_code" autocomplete="off" placeholder="Enter Admin Code" runat="server" Width="341px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_admin_code"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server" ControlToValidate="txt_admin_code" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{5}"></asp:RegularExpressionValidator>
                <br />
                <strong>Admin Password </strong>
                <asp:TextBox ID="txt_admin_password" autocomplete="off" placeholder="Enter Admin Password" runat="server" Width="341px" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_admin_password"></asp:RequiredFieldValidator>

            </td>
        </tr>
        <tr>
            <td class="auto-style13"><strong>
                <asp:Button ID="btn_login" runat="server" CssClass="auto-style16" Text="Login" Width="126px" OnClick="btn_login_Click" />
                <asp:Button ID="btn_cancel" runat="server" CssClass="auto-style16" Text="Cancel" Width="126px" OnClick="btn_cancel_Click" CausesValidation="False" />
                </strong></td>
        </tr>
        <tr>
            <td class="auto-style14">
                <asp:Label ID="lbl_assessment_code" runat="server" Visible="False"></asp:Label>
            &nbsp;<strong><asp:Label ID="lbl_invalid_code" runat="server" CssClass="auto-style8"></asp:Label>
                </strong>
            </td>
        </tr>
    </table>
    <br />
</p>
</asp:Content>

