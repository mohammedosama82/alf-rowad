<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dash_master.master" MaintainScrollPositionOnPostback="true" UnobtrusiveValidationMode="None" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Configuration" %>


<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        btn_no.Visible = false;
        btn_no2.Visible = false;
        btn_yes.Visible = false;
        lbl_sure.Visible = false;
        lbl_select_status.Visible = false;
        btn_update_candidate_status.Visible = false;
        ddl_status.Visible = false;
        btn_filter.Visible = false;


        if (!IsPostBack)
        {
            con.Open();
            string sql2 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status order by candidate_name ";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            SqlDataReader read2 = cmd2.ExecuteReader();
            if (read2.HasRows == true)
            {

                GridView1.DataSource = read2;
                GridView1.DataBind();
            }
            else
            {
                GridView1.Visible = false;
                Response.Write("There is no info for your selection");
                lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "There is no info for your selection";
            }
            read2.Close();
            con.Close();
        }
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        lbl_status.Text = "";
        btn_no.Visible = false;
        btn_no2.Visible = false;
        btn_yes.Visible = false;
        lbl_sure.Visible = false;
        lbl_select_status.Visible = false;
        btn_update_candidate_status.Visible = false;
        ddl_status.Visible = false;
        btn_filter.Visible = false;


        GridView1.EditIndex = e.NewEditIndex;
        con.Open();
        string sql2 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status order by candidate_name ";
        SqlCommand cmd2 = new SqlCommand(sql2, con);
        SqlDataReader read2= cmd2.ExecuteReader();
        if(read2.HasRows==true)
        {
            GridView1.DataSource = read2;
            GridView1.DataBind();

        }
        read2.Close();
        con.Close();

    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        lbl_status.Text = "";
        btn_no.Visible = false;
        btn_no2.Visible = false;
        btn_yes.Visible = false;
        lbl_sure.Visible = false;
        lbl_select_status.Visible = false;
        btn_update_candidate_status.Visible = false;
        ddl_status.Visible = false;
        btn_filter.Visible = false;



        string candidate_id = GridView1.DataKeys[e.RowIndex].Value.ToString();
        int.Parse(candidate_id);
        string candidate_code = ((TextBox)GridView1.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
        //string candidate_code = ((Label)GridView1.Rows[e.RowIndex].FindControl("Label1")).Text;
        //string candidate_name = ((TextBox)GridView1.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
        string candidate_name = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox2")).Text;
        //string candidate_email = ((TextBox)GridView1.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
        string candidate_email = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox3")).Text;
        //string candidate_telephone = ((TextBox)GridView1.Rows[e.RowIndex].Cells[4].Controls[0]).Text;
        string candidate_telephone = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox4")).Text;
        //string candidate_address = ((TextBox)GridView1.Rows[e.RowIndex].Cells[5].Controls[0]).Text;
        string candidate_address = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox5")).Text;
        //string candidate_city = ((TextBox)GridView1.Rows[e.RowIndex].Cells[6].Controls[0]).Text;
        string candidate_city = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox6")).Text;
        //string candidate_university = ((TextBox)GridView1.Rows[e.RowIndex].Cells[7].Controls[0]).Text;
        string candidate_university = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox7")).Text;
        //string candidate_college = ((TextBox)GridView1.Rows[e.RowIndex].Cells[8].Controls[0]).Text;
        string candidate_college = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox8")).Text;
        //string candidate_qualification = ((TextBox)GridView1.Rows[e.RowIndex].Cells[9].Controls[0]).Text;
        string candidate_qualification = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox9")).Text;
        //string candidate_specialization = ((TextBox)GridView1.Rows[e.RowIndex].Cells[10].Controls[0]).Text;
        string candidate_specialization = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox10")).Text;
        //string candidate_notes = ((TextBox)GridView1.Rows[e.RowIndex].Cells[11].Controls[0]).Text;
        string candidate_notes = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox11")).Text;
        //string candidate_file_number = ((TextBox)GridView1.Rows[e.RowIndex].Cells[13].Controls[0]).Text;
        string candidate_file_number = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox12")).Text;
        con.Open();
        string sql2 = "UPDATE candidates SET candidate_code = @candidate_code, candidate_name = @candidate_name,candidate_email = @candidate_email,candidate_telephone = @candidate_telephone,candidate_address = @candidate_address,candidate_city = @candidate_city ,candidate_university = @candidate_university,candidate_college = @candidate_college,candidate_qualification = @candidate_qualification,candidate_specialization = @candidate_specialization,candidate_notes = @candidate_notes, candidate_file_number=@candidate_file_number WHERE candidate_id =@candidate_id";
        SqlCommand cmd2 = new SqlCommand(sql2, con);
        cmd2.Parameters.AddWithValue("@candidate_code", candidate_code);
         cmd2.Parameters.AddWithValue("@candidate_name", candidate_name);
         cmd2.Parameters.AddWithValue("@candidate_email", candidate_email);
         cmd2.Parameters.AddWithValue("@candidate_telephone", candidate_telephone);
         cmd2.Parameters.AddWithValue("@candidate_address", candidate_address);
         cmd2.Parameters.AddWithValue("@candidate_city", candidate_city);
         cmd2.Parameters.AddWithValue("@candidate_university", candidate_university);
         cmd2.Parameters.AddWithValue("@candidate_college", candidate_college);
         cmd2.Parameters.AddWithValue("@candidate_qualification", candidate_qualification);
         cmd2.Parameters.AddWithValue("@candidate_specialization", candidate_specialization);
         cmd2.Parameters.AddWithValue("@candidate_notes", candidate_notes);
         cmd2.Parameters.AddWithValue("@candidate_file_number", candidate_file_number);
        cmd2.Parameters.AddWithValue("@candidate_id", candidate_id);
        int t=cmd2.ExecuteNonQuery();
        if(t>0)
        {
            Response.Write("updated");
            lbl_status.ForeColor = System.Drawing.Color.Green;
            lbl_status.Text = "updated";
            GridView1.EditIndex = -1;
            GridView1.DataBind();
        }
        else
        {
            Response.Write("no info updated");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "no info updated";
        }
        con.Close();

        con.Open();
        string sql3 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status order by candidate_name ";
        SqlCommand cmd3 = new SqlCommand(sql3, con);
        SqlDataReader read2= cmd3.ExecuteReader();
        if(read2.HasRows==true)
        {
            GridView1.DataSource = read2;
            GridView1.DataBind();
        }
        read2.Close();
        con.Close();



    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        lbl_status.Text = "";
        btn_no.Visible = false;
        btn_no2.Visible = false;
        btn_yes.Visible = false;
        lbl_sure.Visible = false;
        lbl_select_status.Visible = false;
        btn_update_candidate_status.Visible = false;
        ddl_status.Visible = false;
        btn_filter.Visible = false;


        GridView1.EditIndex = -1;
        con.Open();
        string sql3 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status order by candidate_name ";
        SqlCommand cmd3 = new SqlCommand(sql3, con);
        SqlDataReader read2= cmd3.ExecuteReader();
        if(read2.HasRows==true)
        {
            GridView1.DataSource = read2;
            GridView1.DataBind();
        }
        read2.Close();
        con.Close();
    }

    

    protected void btn_admin_dashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("admin_dashboard.aspx");
    }


    protected void btn_delete_Click(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        lbl_select_status.Visible = false;
        btn_update_candidate_status.Visible = false;
        ddl_status.Visible = false;
        btn_no2.Visible = false;
        btn_filter.Visible = false;


        int tip = 0;
        foreach (GridViewRow grow in GridView1.Rows)
        {
            CheckBox selected_checkbox = grow.FindControl("select_candidate") as CheckBox;
            if (selected_checkbox.Checked == true)
            {
                tip++;

            }
        }

        if (tip > 0)
        {
            btn_no.Visible = true;
            btn_yes.Visible = true;
            lbl_sure.Visible = true;
        }

        else
        {
            Response.Write("No Selected Candidates To delete");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "No Selected Candidates To delete";
        }



    }

    protected void btn_no_Click(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        GridView1.EditIndex = -1;
        con.Open();
        string sql3 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status order by candidate_name ";
        SqlCommand cmd3 = new SqlCommand(sql3, con);
        SqlDataReader read2= cmd3.ExecuteReader();
        if(read2.HasRows==true)
        {
            GridView1.DataSource = read2;
            GridView1.DataBind();
        }
        read2.Close();
        con.Close();

        btn_no.Visible = false;
        btn_no2.Visible = false;
        btn_yes.Visible = false;
        lbl_sure.Visible = false;
        lbl_select_status.Visible = false;
        btn_update_candidate_status.Visible = false;
        ddl_status.Visible = false;
        btn_filter.Visible = false;

    }

    protected void btn_yes_Click(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        int tip = 0;
        foreach (GridViewRow grow in GridView1.Rows)
        {
            CheckBox selected_checkbox = grow.FindControl("select_candidate") as CheckBox;
            if (selected_checkbox.Checked == true)
            {
                tip++;

                string sql4 = "insert into dbo.deleted_candidates(candidate_code, candidate_name, candidate_email, candidate_telephone, candidate_address, candidate_city, candidate_college, candidate_university, candidate_qualification, candidate_specialization, candidate_notes, candidate_status ) select candidate_code, candidate_name, candidate_email, candidate_telephone, candidate_address, candidate_city, candidate_college, candidate_university, candidate_qualification, candidate_specialization, candidate_notes, candidate_status  from candidates where candidate_code='" + grow.Cells[1].Text + "'";
                SqlCommand cmd4 = new SqlCommand(sql4, con);

                con.Open();
                cmd4.ExecuteNonQuery();
                con.Close();

                con.Open();
                string sql2 = "DELETE from candidates WHERE candidate_code ='"+ grow.Cells[1].Text +"'";
                SqlCommand cmd2 = new SqlCommand(sql2, con);
                cmd2.ExecuteNonQuery();
                con.Close();
                con.Open();
                string sql3 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status order by candidate_name ";
                SqlCommand cmd3 = new SqlCommand(sql3, con);
                SqlDataReader read3= cmd3.ExecuteReader();
                if(read3.HasRows==true)
                {
                    GridView1.DataSource = read3;
                    GridView1.DataBind();
                }
                read3.Close();
                con.Close();

            }
        }

        if(tip>0)
        {
            Response.Write("Selected Candidates Deleted");
            lbl_status.ForeColor = System.Drawing.Color.Green;
            lbl_status.Text = "Selected Candidates Deleted";
        }
        else
        {
            Response.Write("No Selected Candidates To delete");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "No Selected Candidates To delete";
        }
    }

    protected void btn_change_status_Click(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        btn_no.Visible = false;
        btn_no2.Visible = false;
        btn_yes.Visible = false;
        lbl_sure.Visible = false;
        lbl_select_status.Visible = false;
        btn_update_candidate_status.Visible = false;
        ddl_status.Visible = false;
        btn_filter.Visible = false;



        int tip = 0;
        foreach (GridViewRow grow in GridView1.Rows)
        {
            CheckBox selected_checkbox = grow.FindControl("select_candidate") as CheckBox;
            if (selected_checkbox.Checked == true)
            {
                tip++;

            }
        }

        if (tip > 0)
        {
            lbl_select_status.Visible = true;
            btn_update_candidate_status.Visible = true;
            ddl_status.Visible = true;
            btn_no2.Visible = true;

            string sql2 = "select status_id, status_type from status";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            con.Open();
            ddl_status.DataSource = cmd2.ExecuteReader();
            ddl_status.DataTextField = "status_type";
            ddl_status.DataValueField = "status_id";
            ddl_status.DataBind();
            ListItem selectlistitem = new ListItem("Select","-1");
            ddl_status.Items.Insert(0, selectlistitem);
            con.Close();

        }

        else
        {
            Response.Write("No Selected Candidates To Change Thier status");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "No Selected Candidates To Change Thier status";
        }


    }

    protected void btn_no2_Click(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        GridView1.EditIndex = -1;
        con.Open();
        string sql3 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status order by candidate_name ";
        SqlCommand cmd3 = new SqlCommand(sql3, con);
        SqlDataReader read2= cmd3.ExecuteReader();
        if(read2.HasRows==true)
        {
            GridView1.DataSource = read2;
            GridView1.DataBind();
        }
        read2.Close();
        con.Close();

        btn_no.Visible = false;
        btn_no2.Visible = false;
        btn_yes.Visible = false;
        lbl_sure.Visible = false;
        lbl_select_status.Visible = false;
        btn_update_candidate_status.Visible = false;
        ddl_status.Visible = false;
        btn_filter.Visible = false;

    }

    protected void btn_update_candidate_status_Click(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        int tip = 0;
        foreach (GridViewRow grow in GridView1.Rows)
        {
            CheckBox selected_checkbox = grow.FindControl("select_candidate") as CheckBox;
            if (selected_checkbox.Checked == true)
            {
                tip++;

                con.Open();
                
                string sql2 = "UPDATE candidates SET candidate_status = '"+ddl_status.SelectedValue+"'  WHERE candidate_code ='"+ grow.Cells[1].Text +"'";
                SqlCommand cmd2 = new SqlCommand(sql2, con);
                cmd2.ExecuteNonQuery();
                con.Close();

                con.Open();
                string sql3 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status order by candidate_name ";
                SqlCommand cmd3 = new SqlCommand(sql3, con);
                SqlDataReader read3= cmd3.ExecuteReader();
                if(read3.HasRows==true)
                {
                    GridView1.DataSource = read3;
                    GridView1.DataBind();
                }
                read3.Close();
                con.Close();

            }
        }

        if(tip>0)
        {
            Response.Write(" Status Updated For Selected Candidates ");
            lbl_status.ForeColor = System.Drawing.Color.Green;
            lbl_status.Text = "Status Updated For Selected Candidates";
        }
        else
        {
            Response.Write("No Selected Candidates To Change Thier status");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "No Selected Candidates To Change Thier status";
        }
    }

    protected void btn_filter_by_status_Click(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        btn_no.Visible = false;
        btn_no2.Visible = true;
        btn_yes.Visible = false;
        lbl_sure.Visible = false;
        lbl_select_status.Visible = false;
        btn_update_candidate_status.Visible = false;
        ddl_status.Visible = true;
        btn_filter.Visible = true;


        string sql2 = "select status_id, status_type from status";
        SqlCommand cmd2 = new SqlCommand(sql2, con);
        con.Open();
        ddl_status.DataSource = cmd2.ExecuteReader();
        ddl_status.DataTextField = "status_type";
        ddl_status.DataValueField = "status_id";
        ddl_status.DataBind();
        ListItem selectlistitem = new ListItem("Select","-1");
        ddl_status.Items.Insert(0, selectlistitem);
        con.Close();




    }

    protected void btn_filter_Click(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        con.Open();
        string sql3 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status where candidate_status = '"+ddl_status.SelectedValue+"' order by candidate_name ";
        SqlCommand cmd3 = new SqlCommand(sql3, con);
        SqlDataReader read3= cmd3.ExecuteReader();
        if(read3.HasRows==true)
        {
            GridView1.DataSource = read3;
            GridView1.DataBind();
        }
        else
        {
            GridView1.Visible = false;
            Response.Write("No information For selected Filter");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "No information For selected Filter";
        }
        read3.Close();
        con.Close();
    }

    protected void btn_view_all_candidates_Click(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        GridView1.Visible = true;
        con.Open();
        string sql2 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status order by candidate_name ";
        SqlCommand cmd2 = new SqlCommand(sql2, con);
        SqlDataReader read2 = cmd2.ExecuteReader();
        if (read2.HasRows == true)
        {

            GridView1.DataSource = read2;
            GridView1.DataBind();
        }
        else
        {
            GridView1.Visible = false;
            Response.Write("There is no info for your selection");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "There is no info for your selection";
        }
        read2.Close();
        con.Close();

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style6 {
            color: #FF0000;
        }
        .auto-style8 {
            font-weight: bold;
            display: inline-block;
            color: #FFFFFF;
            background-color: #000000;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        &nbsp;</p>
    <p>
        <strong>
        <asp:Button ID="btn_view_all_candidates"  runat="server" CssClass="auto-style8"  OnClick="btn_view_all_candidates_Click" Text="View All Candidates" />
&nbsp;<asp:Button ID="btn_filter_by_status" runat="server" CssClass="auto-style8" OnClick="btn_filter_by_status_Click" Text="Filter By Status" />
        &nbsp;
        </strong>
        <asp:Button ID="btn_delete" runat="server" CssClass="auto-style8" Text="Delete Selected" OnClick="btn_delete_Click" Enabled="False" Visible="False" />
        <strong>
        &nbsp;<asp:Button ID="btn_change_status" runat="server" CssClass="auto-style8" OnClick="btn_change_status_Click" Text="Change Status" />
        &nbsp;<asp:Button ID="btn_admin_dashboard" runat="server" CssClass="auto-style8" OnClick="btn_admin_dashboard_Click" Text="Admin Dashboard" />
        </strong></p>
    <p>
        <strong>
        <asp:Label ID="lbl_sure" runat="server" CssClass="auto-style6" Text="Are You Sure For Deleting Selected Candidates?" Visible="False"></asp:Label>
&nbsp;</strong></p>
    <asp:Button ID="btn_yes" runat="server" CssClass="auto-style8" Text="Yes, Sure" Visible="False" OnClick="btn_yes_Click" />
&nbsp;<strong><asp:Button ID="btn_no" runat="server" CssClass="auto-style8" OnClick="btn_no_Click" Text="No, Cancel" Visible="False" />
        <br />
    <br />
        <asp:Label ID="lbl_select_status" runat="server" CssClass="auto-style6" Text="Select Satus From the List:" Visible="False"></asp:Label>
    <br />
    <asp:DropDownList ID="ddl_status" runat="server" Visible="False">
    </asp:DropDownList>
&nbsp;</strong><asp:Button ID="btn_update_candidate_status" runat="server" CssClass="auto-style8" Text="Update status" Visible="False" OnClick="btn_update_candidate_status_Click" />
    &nbsp;<strong><asp:Button ID="btn_filter" runat="server" CssClass="auto-style8" Text="Filter" Visible="False" OnClick="btn_filter_Click" />
    </strong>&nbsp;<strong><asp:Button ID="btn_no2" runat="server" CssClass="auto-style8" OnClick="btn_no2_Click" Text="No, Cancel" Visible="False" />
        </strong>
    <div>
        <asp:Label ID="lbl_status" runat="server" Text=""></asp:Label>
    </div>
    <p>
        <strong>
        All Candidates:</strong></p>
    <div style="overflow-x:auto;">
        <asp:GridView ID="GridView1" runat="server"  AutoGenerateColumns="False" CellPadding="0" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" DataKeyNames="candidate_id" OnRowCancelingEdit="GridView1_RowCancelingEdit"  ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="candidate_id" HeaderText="ID" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="candidate_code" HeaderText="Code" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("candidate_name") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox2" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("candidate_name") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" />
                    <ItemStyle Font-Size="XX-Small" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("candidate_email") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox3" CssClass="auto-style35" ErrorMessage="Invalid" ValidationExpression="^[a-z0-9][-a-z0-9._]+@([-a-z0-9]+.)+[a-z]{2,5}$" ForeColor="Red"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("candidate_email") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" Wrap="True" />
                    <ItemStyle Font-Size="XX-Small" Wrap="True" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tel.">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("candidate_telephone") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox4" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{10}"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("candidate_telephone") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" />
                    <ItemStyle Font-Size="XX-Small" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Add.">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("candidate_address") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox5" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("candidate_address") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" />
                    <ItemStyle Font-Size="XX-Small" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="City">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("candidate_city") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="TextBox6" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("candidate_city") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" />
                    <ItemStyle Font-Size="XX-Small" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Uni.">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("candidate_university") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="TextBox7" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("candidate_university") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" />
                    <ItemStyle Font-Size="XX-Small" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Coll.">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("candidate_college") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="TextBox8" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("candidate_college") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" />
                    <ItemStyle Font-Size="XX-Small" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quali.">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("candidate_qualification") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="TextBox9" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("candidate_qualification") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" />
                    <ItemStyle Font-Size="XX-Small" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Spec.">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("candidate_specialization") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="TextBox10" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label10" runat="server" Text='<%# Bind("candidate_specialization") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" />
                    <ItemStyle Font-Size="XX-Small" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("candidate_notes") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ControlToValidate="TextBox11" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression=".{0,200}"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("candidate_notes") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" />
                    <ItemStyle Font-Size="XX-Small" />
                </asp:TemplateField>
                <asp:BoundField DataField="status_type" HeaderText="Stat." ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="F#">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("candidate_file_number") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="TextBox12" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{5}"></asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label12" runat="server" Text='<%# Bind("candidate_file_number") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small" />
                    <ItemStyle Font-Size="XX-Small" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sel." HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
                    <ItemTemplate>
                        <asp:CheckBox ID="select_candidate" runat="server" />
                    </ItemTemplate>

<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:TemplateField>
                <asp:CommandField ButtonType="Button" ShowEditButton="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
                <ControlStyle BackColor="#009900" ForeColor="White" />

<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

                <ItemStyle BackColor="White" ForeColor="White" />
                </asp:CommandField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
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
    <p>
        &nbsp;</p>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <strong>
&nbsp;</strong>&nbsp;
    <br />
    </asp:Content>

