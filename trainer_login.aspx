<%@ Page Title="" Language="C#" MasterPageFile="~/login_master.master" UnobtrusiveValidationMode="None" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>


<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["trainer_file_number"]!=null)
        {
            Response.Redirect("trainer_dashboard.aspx");
        }



    }

    protected void btn_login_Click(object sender, EventArgs e)
    {



        /* string str_candidate_info = "select trainer_name from trainers  where trainer_file_number=@trainer_file_number and trainer_password=hashbytes('sha2_256', @trainer_password)";
         con.Open();
         SqlCommand cmd_candidate_info = new SqlCommand(str_candidate_info, con);
          cmd_candidate_info.Parameters.AddWithValue("@trainer_file_number", HttpUtility.HtmlEncode( txt_trainer_file_number.Text));
         byte[] newbyte = Encoding.ASCII.GetBytes(HttpUtility.HtmlEncode(txt_trainer_password.Text));
         cmd_candidate_info.Parameters.AddWithValue("@trainer_password",SqlDbType.VarBinary).Value=newbyte;
         SqlDataReader read_candidate_info = cmd_candidate_info.ExecuteReader();
         if (read_candidate_info.HasRows == false)
         {
             Session["error"] = "invalid_code";
             read_candidate_info.Close();
             con.Close();
             Response.Redirect("errors.aspx");

         }
         else
         {
             while (read_candidate_info.Read())
             {

                 Session["trainer_name"] = (read_candidate_info["trainer_name"].ToString());
                 Session["trainer_file_number"] = txt_trainer_file_number.Text;


             }
             read_candidate_info.Close();
             con.Close();
             Session["mentor_file_number"] = null;
             Session["candidate_code"] = null;
             Session["admin_code"] = null;

             Response.Redirect("trainer_dashboard.aspx");

         }*/

        //if account not exist 
        con.Open();
        string sql = "SELECT trainer_file_number from trainers where trainer_file_number=@trainer_file_number";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@trainer_file_number", txt_trainer_file_number.Text);
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
            string locked_checked = "select islocked from trainers where trainer_file_number=@trainer_file_number";
            con.Open();
            SqlCommand cmd_locked_checked = new SqlCommand(locked_checked, con);
            cmd_locked_checked.Parameters.AddWithValue("@trainer_file_number", HttpUtility.HtmlEncode(txt_trainer_file_number.Text));
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
            string str_candidate_info = "select trainer_name,islocked,attempt from trainers  where trainer_file_number=@trainer_file_number and trainer_password=hashbytes('sha2_256', @trainer_password)";
            con.Open();
            SqlCommand cmd_candidate_info = new SqlCommand(str_candidate_info, con);
            cmd_candidate_info.Parameters.AddWithValue("@trainer_file_number", HttpUtility.HtmlEncode(txt_trainer_file_number.Text));
            byte[] newbyte = Encoding.ASCII.GetBytes(HttpUtility.HtmlEncode(txt_trainer_password.Text));
            cmd_candidate_info.Parameters.AddWithValue("@trainer_password", SqlDbType.VarBinary).Value = newbyte;
            SqlDataReader read_candidate_info = cmd_candidate_info.ExecuteReader();

            //if the password is not true 
            if (read_candidate_info.HasRows == false)
            {

                /*  read_candidate_info.Close();
                  con.Close();
                  Session["error"] = "invalid_code";
                  Response.Redirect("errors.aspx");*/
                read_candidate_info.Close();
                con.Close();

                //check how many attempt and increase it
                string str_candidate_info4 = "select islocked,attempt from trainers  where trainer_file_number=@trainer_file_number ";
                con.Open();
                SqlCommand cmd_candidate_info4 = new SqlCommand(str_candidate_info4, con);
                cmd_candidate_info4.Parameters.AddWithValue("@trainer_file_number", HttpUtility.HtmlEncode(txt_trainer_file_number.Text));
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
                string str_insert_new_candidate = "UPDATE trainers SET attempt=@attempt where trainer_file_number=@trainer_file_number";
                SqlCommand cmd_insert_new_candidate = new SqlCommand(str_insert_new_candidate, con);
                cmd_insert_new_candidate.Parameters.AddWithValue("@attempt", lbl_assessment_code.Text);
                cmd_insert_new_candidate.Parameters.AddWithValue("@trainer_file_number", HttpUtility.HtmlEncode(txt_trainer_file_number.Text));
                con.Open();
                cmd_insert_new_candidate.ExecuteNonQuery();
                con.Close();

                int attemptfinal = Convert.ToInt32(lbl_assessment_code.Text);
                //update islocked to true if attempet reach to 5 and will not restore to false without edited by admin from the db
                if (attemptfinal >= 5)
                {
                    string str_insert_new_candidate2 = "UPDATE trainers SET islocked=@islocked where trainer_file_number=@trainer_file_number";
                    SqlCommand cmd_insert_new_candidate2 = new SqlCommand(str_insert_new_candidate2, con);
                    cmd_insert_new_candidate2.Parameters.AddWithValue("@islocked", 1);
                    cmd_insert_new_candidate2.Parameters.AddWithValue("@trainer_file_number", HttpUtility.HtmlEncode(txt_trainer_file_number.Text));
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
                    Session["trainer_name"] = (read_candidate_info["trainer_name"].ToString());
                    Session["trainer_file_number"] = txt_trainer_file_number.Text;


                }

                read_candidate_info.Close();
                con.Close();
                Session["mentor_file_number"] = null;
                Session["candidate_code"] = null;
                Session["admin_code"] = null;

                //restore attempt to 0
                string str_insert_new_candidate = "UPDATE trainers SET attempt=@attempt where trainer_file_number=@trainer_file_number";
                SqlCommand cmd_insert_new_candidate = new SqlCommand(str_insert_new_candidate, con);
                cmd_insert_new_candidate.Parameters.AddWithValue("@attempt", 0);
                cmd_insert_new_candidate.Parameters.AddWithValue("@trainer_file_number", HttpUtility.HtmlEncode(txt_trainer_file_number.Text));
                con.Open();
                cmd_insert_new_candidate.ExecuteNonQuery();
                con.Close();

                Response.Redirect("trainer_dashboard.aspx");
            }

        }

    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        Response.Write("Action Cancelled");
        Response.AddHeader("REFRESH", "1;URL=trainer_login.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .auto-style5 {
        width: 369px;
    }
    .auto-style6 {
        width: 351px;
    }
        .auto-style9 {
            width: 351px;
            height: 39px;
            text-align: left;
        }
        .auto-style11 {
            width: 351px;
            text-align: left;
        }
        .auto-style12 {
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
            <td class="auto-style9"><strong>Trainer File# </strong>
                <asp:TextBox ID="txt_trainer_file_number" autocomplete="off" placeholder="Enter Trainer  File#" runat="server" Width="341px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_trainer_file_number"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server" ControlToValidate="txt_trainer_file_number" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{5}"></asp:RegularExpressionValidator>
                <br />
                <strong>Trainer Password </strong>
                <asp:TextBox ID="txt_trainer_password" autocomplete="off" placeholder="Enter Trainer Password" runat="server" Width="341px" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_trainer_password"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style6"><strong>
                <asp:Button ID="btn_login" runat="server" CssClass="auto-style12" Text="Login" Width="126px" OnClick="btn_login_Click" />
                <asp:Button ID="btn_cancel" runat="server" CssClass="auto-style12" Text="Cancel" Width="126px" OnClick="btn_cancel_Click" CausesValidation="False" />
                </strong></td>
        </tr>
        <tr>
            <td class="auto-style11">
                <asp:Label ID="lbl_assessment_code" runat="server" Visible="False"></asp:Label>
            &nbsp;<strong><asp:Label ID="lbl_invalid_code" runat="server" CssClass="auto-style8"></asp:Label>
                </strong>
            </td>
        </tr>
    </table>
    <br />
</p>
</asp:Content>

