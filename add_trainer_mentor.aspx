<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dash_master.master" UnobtrusiveValidationMode="None" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>


<script runat="server">
   SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);


    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            if(Session["admin_code"]==null)
            {
                Response.Redirect("index.html");
            }

            txt_department.Text = "";
            txt_email.Text = "";
            txt_file_number.Text = "";
            txt_job_title.Text = "";
            txt_name.Text = "";
            txt_tel.Text = "";
            DropDownList1.SelectedIndex = -1;
            txt_department.Enabled = true;


            string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(my_connection);


            con.Open();
            string sql11 = "select trainer_id, trainer_name, trainer_email, trainer_file_number, trainer_job_title, trainer_telephone from trainers order by trainer_name" ;
            SqlCommand cmd = new SqlCommand(sql11, con);
            SqlDataReader read= cmd.ExecuteReader();
            if(read.HasRows==true)
            {

                GridView1.DataSource = read;
                GridView1.DataBind();
            }
            read.Close();
            con.Close();

            con.Open();
            string sql12 = "select mentor_id, mentor_name, mentor_email, mentor_file_number, mentor_job_title, mentor_telephone, mentor_department from mentors order by mentor_name" ;
            SqlCommand cmd12 = new SqlCommand(sql12, con);
            SqlDataReader read12= cmd12.ExecuteReader();
            if(read12.HasRows==true)
            {

                GridView2.DataSource = read12;
                GridView2.DataBind();
            }
            read12.Close();
            con.Close();
        }

    }

    protected void btn_add_Click(object sender, EventArgs e)
    {
        if(DropDownList1.SelectedValue=="0")
        {

            con.Open();
            string sql = "SELECT trainer_file_number from trainers where trainer_file_number='"+txt_file_number.Text+"'";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader read= cmd.ExecuteReader();
            if(read.HasRows==true)
            {

                Response.Write("That Trainer Added before");
                lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "That Trainer Added before";
                read.Close();
                con.Close();
                Response.AddHeader("REFRESH", "2;URL=add_trainer_mentor.aspx");
            }
            else
            {
                read.Close();
                con.Close();
                string str_insert_new_candidate ="insert into trainers (trainer_file_number, trainer_name, trainer_email, trainer_telephone, trainer_job_title, trainer_password, islocked, attempt)values (@trainer_file_number, @trainer_name, @trainer_email, @trainer_telephone, @trainer_job_title,hashbytes('sha2_256', @trainer_password),@islocked, @attempt)";
                SqlCommand cmd_insert_new_candidate = new SqlCommand(str_insert_new_candidate, con);
                cmd_insert_new_candidate.Parameters.AddWithValue("@trainer_file_number", HttpUtility.HtmlEncode(txt_file_number.Text.ToString()) );
                cmd_insert_new_candidate.Parameters.AddWithValue("@trainer_name", HttpUtility.HtmlEncode(txt_name.Text.ToString()) );
                cmd_insert_new_candidate.Parameters.AddWithValue("@trainer_email", HttpUtility.HtmlEncode(txt_email.Text.ToString()) );
                cmd_insert_new_candidate.Parameters.AddWithValue("@trainer_telephone", HttpUtility.HtmlEncode(txt_tel.Text.ToString()) );
                cmd_insert_new_candidate.Parameters.AddWithValue("@trainer_job_title", HttpUtility.HtmlEncode(txt_job_title.Text.ToString()) );
                byte[] newbyte = Encoding.ASCII.GetBytes("admin");
            cmd_insert_new_candidate.Parameters.AddWithValue("@trainer_password",SqlDbType.VarBinary).Value=newbyte;
                cmd_insert_new_candidate.Parameters.AddWithValue("@islocked",0);
            cmd_insert_new_candidate.Parameters.AddWithValue("@attempt", (int)0);
                con.Open();
                cmd_insert_new_candidate.ExecuteNonQuery();
                con.Close();
                Response.Write("Added Successfully");
                lbl_status.ForeColor = System.Drawing.Color.Green;
                 lbl_status.Text = "Added Successfully";
                
                Response.AddHeader("REFRESH", "2;URL=add_trainer_mentor.aspx");
            }
        }
        else if(DropDownList1.SelectedValue=="1")
        {
            con.Open();
            string sql = "SELECT mentor_file_number from mentors where mentor_file_number='"+txt_file_number.Text+"'";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader read= cmd.ExecuteReader();
            if(read.HasRows==true)
            {

                Response.Write("That Mentor Added before");
                lbl_status.ForeColor = System.Drawing.Color.Red;
                 lbl_status.Text = "That Mentor Added before";
                read.Close();
                con.Close();
                Response.AddHeader("REFRESH", "2;URL=add_trainer_mentor.aspx");
            }
            else
            {
                read.Close();
                con.Close();
                string str_insert_new_candidate ="insert into mentors (mentor_file_number, mentor_name, mentor_email, mentor_telephone, mentor_job_title, mentor_department, mentor_password, islocked, attempt)values (@mentor_file_number, @mentor_name, @mentor_email, @mentor_telephone, @mentor_job_title, @mentor_department, hashbytes('sha2_256', @mentor_password), @islocked, @attempt)";
                SqlCommand cmd_insert_new_candidate = new SqlCommand(str_insert_new_candidate, con);
                cmd_insert_new_candidate.Parameters.AddWithValue("@mentor_file_number", HttpUtility.HtmlEncode(txt_file_number.Text.ToString()) );
                cmd_insert_new_candidate.Parameters.AddWithValue("@mentor_name", HttpUtility.HtmlEncode(txt_name.Text.ToString()) );
                cmd_insert_new_candidate.Parameters.AddWithValue("@mentor_email", HttpUtility.HtmlEncode(txt_email.Text.ToString()) );
                cmd_insert_new_candidate.Parameters.AddWithValue("@mentor_telephone", HttpUtility.HtmlEncode(txt_tel.Text.ToString()) );
                cmd_insert_new_candidate.Parameters.AddWithValue("@mentor_job_title", HttpUtility.HtmlEncode(txt_job_title.Text.ToString())) ;
                cmd_insert_new_candidate.Parameters.AddWithValue("@mentor_department", HttpUtility.HtmlEncode(txt_department.Text.ToString()) );
                byte[] newbyte = Encoding.ASCII.GetBytes("admin");
            cmd_insert_new_candidate.Parameters.AddWithValue("@mentor_password",SqlDbType.VarBinary).Value=newbyte;
                cmd_insert_new_candidate.Parameters.AddWithValue("@islocked",0);
            cmd_insert_new_candidate.Parameters.AddWithValue("@attempt", (int)0);
                con.Open();
                cmd_insert_new_candidate.ExecuteNonQuery();
                con.Close();
                Response.Write("Added Successfully");
                lbl_status.ForeColor = System.Drawing.Color.Green;
                 lbl_status.Text = "Added Successfully";
                
                Response.AddHeader("REFRESH", "2;URL=add_trainer_mentor.aspx");
            }

        }
        else
        {
            Response.Write("Please You have to select type");
            lbl_status.ForeColor = System.Drawing.Color.Red;
                 lbl_status.Text = "Please You have to select type";
        
            Response.AddHeader("REFRESH", "2;URL=add_trainer_mentor.aspx");
        }


    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(DropDownList1.SelectedValue=="0")
        {
            txt_department.Enabled = false;
        }
        else
        {
            txt_department.Enabled = true;
        }
    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        Response.Write("Action Cancelled");
        lbl_status.ForeColor = System.Drawing.Color.Red;
                 lbl_status.Text = "Action Cancelled";
        
        Response.AddHeader("REFRESH", "2;URL=add_trainer_mentor.aspx");
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string trainer_id = GridView1.DataKeys[e.RowIndex].Value.ToString();
        int.Parse(trainer_id);
        con.Open();
        string sql2 = "DELETE from trainers WHERE trainer_id ='"+trainer_id+"' ";
        SqlCommand cmd2 = new SqlCommand(sql2, con);
        cmd2.ExecuteNonQuery();
        int t=cmd2.ExecuteNonQuery();
        con.Close();
        if(t>=0)
        {
            Response.Write("Deleted");
            lbl_status.ForeColor = System.Drawing.Color.Red;
                 lbl_status.Text = "Deleted";
            GridView1.EditIndex = -1;
            
            Response.AddHeader("REFRESH", "1;URL=add_trainer_mentor.aspx");

        }


    }

    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string mentor_id = GridView2.DataKeys[e.RowIndex].Value.ToString();
        int.Parse(mentor_id);
        con.Open();
        string sql2 = "DELETE from mentors WHERE mentor_id ='"+mentor_id+"' ";
        SqlCommand cmd2 = new SqlCommand(sql2, con);
        cmd2.ExecuteNonQuery();
        int t=cmd2.ExecuteNonQuery();
        con.Close();
        if(t>=0)
        {
            Response.Write("Deleted");
            lbl_status.ForeColor = System.Drawing.Color.Red;
                 lbl_status.Text = "Deleted";
            GridView1.EditIndex = -1;
           
            Response.AddHeader("REFRESH", "1;URL=add_trainer_mentor.aspx");

        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            font-size: large;
           
        }
        .auto-style2 {
            color: #000000;
            
        }
        .auto-style3 {
            width: 100%;
            border-collapse: collapse;
            float: left;
            border: 5px solid #00ACEE;
        }
        .auto-style4 {
            width: 127px;
            font-size: small;
           
        }
        .auto-style5 {
            font-weight: bold;
            color: #FFFFFF;
            background-color: #000000;
            display: inline-block;
        }
        .auto-style6 {
            font-size: large;
            color: #000000;
        }
        .upper{
            text-transform:capitalize;
        }
        .lower{
            text-transform:lowercase;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p class="auto-style2">
        <br />
        <span class="auto-style1"><strong>Add New Trainer - Mentor </strong></span>
    </p>
    <table align="left" cellpadding="0" class="auto-style3">
        <tr>
            <td class="auto-style4"><strong>Type</strong></td>
            <td>
                <div style="display:inline"><asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem Value="-1">Select</asp:ListItem>
                    <asp:ListItem Value="0">Trainer</asp:ListItem>
                    <asp:ListItem Value="1">Mentor</asp:ListItem>
                </asp:DropDownList>
                </div> 
            </td>
        </tr>
        <tr>
            <td class="auto-style4"><strong>File#</strong></td>
            <td>
                <div style="display: inline-block;"><asp:TextBox ID="txt_file_number" runat="server" autocomplete="off" >
                </asp:TextBox></div>
                <div style="display: inline-block;"><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_file_number" ErrorMessage="*" Font-Bold="True" ForeColor="Red" ></asp:RequiredFieldValidator></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_file_number" ErrorMessage="Only 5 digits" Font-Bold="True" ForeColor="Red" ValidationExpression="\d\d\d\d\d" ></asp:RegularExpressionValidator></div>
        </tr>
        <tr>
            <td class="auto-style4"><strong>Name</strong></td>
            <td>
                <div style="display: inline-block;"><asp:TextBox ID="txt_name" CssClass="upper" runat="server" autocomplete="off" Width="270px"></asp:TextBox></div>
                <div style="display: inline-block;"><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_name" ErrorMessage="*" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txt_name" ErrorMessage="invalid" Font-Bold="True" ForeColor="Red" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator></div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator18" runat="server" ControlToValidate="txt_name" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9\s]+$"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style4"><strong>Department</strong></td>
            <td>
                <div style="display: inline-block;"><asp:TextBox ID="txt_department" autocomplete="off" runat="server" Width="270px"></asp:TextBox></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txt_department" ErrorMessage="invalid" Font-Bold="True" ForeColor="Red" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator></div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txt_department" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9\s]+$"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style4"><strong>Job title</strong></td>
            <td>
                <div style="display: inline-block;"><asp:TextBox ID="txt_job_title" autocomplete="off" runat="server" Width="270px"></asp:TextBox></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txt_job_title" ErrorMessage="invalid" Font-Bold="True" ForeColor="Red" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator></div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txt_job_title" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9\s]+$"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style4"><strong>Tel</strong></td>
            <td>
               <div style="display: inline-block;"> <asp:TextBox ID="txt_tel" autocomplete="off" runat="server" Width="270px"></asp:TextBox></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txt_tel" ErrorMessage="invalid" Font-Bold="True" ForeColor="Red" ValidationExpression="\d{10}"></asp:RegularExpressionValidator></div>
            </td>
        </tr>
        <tr>
            <td class="auto-style4"><strong>Email</strong></td>
            <td>
               <div style="display: inline-block;"> <asp:TextBox ID="txt_email" autocomplete="off" CssClass="lower" runat="server" Width="270px"></asp:TextBox></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txt_email" ErrorMessage="invalid" Font-Bold="True" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></div>
            </td>
        </tr>
        <tr>
            <td class="auto-style4">&nbsp;</td>
            <td><strong>
                <asp:Button ID="btn_add" runat="server" CssClass="auto-style5" Text="Add" OnClick="btn_add_Click" />
                <asp:Button ID="btn_cancel" runat="server" CssClass="auto-style5" Text="Cancel" CausesValidation="False" OnClick="btn_cancel_Click" />
                </strong>&nbsp;</td>
        </tr>
    </table>
    <div>
        <asp:Label ID="lbl_status" runat="server" Text=""></asp:Label>
    </div>
    <div>

        <span class="auto-style2">

       <span class="auto-style1"><strong> All Trainers</strong></span><br />
        </span>
        <asp:GridView ID="GridView1" runat="server" CellPadding="0" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="trainer_id" OnRowDeleting="GridView1_RowDeleting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="trainer_id" HeaderText="ID" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="trainer_file_number" HeaderText="File#" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="trainer_name" HeaderText="Name" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="trainer_email" HeaderText="Email" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="trainer_telephone" HeaderText="Tel" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="trainer_job_title" HeaderText="Job Title" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" Visible="False"><ControlStyle BackColor="Red" ForeColor="White" />
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle></asp:CommandField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>

    </div>

    <div>

        <span class="auto-style6"><strong>All Mentors<br />
        </strong></span><br />
        <asp:GridView ID="GridView2" runat="server" CellPadding="0" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="mentor_id" OnRowDeleting="GridView2_RowDeleting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="mentor_id" HeaderText="ID" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="mentor_file_number" HeaderText="File#" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="mentor_name" HeaderText="Name" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="mentor_email" HeaderText="Email" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="mentor_telephone" HeaderText="Tel" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="mentor_department" HeaderText="Department" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="mentor_job_title" HeaderText="Job Title" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" Visible="False"><ControlStyle BackColor="Red" ForeColor="White" />
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle></asp:CommandField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>

    </div>
</asp:Content>

