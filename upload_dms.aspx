<%@ Page Title="" Language="C#"  UnobtrusiveValidationMode="None" MaintainScrollPositionOnPostback="true"
 %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">

    protected void Page_PreInit(object sender, EventArgs e)
    {
        if(Session["admin_code"]!=null)
        {
            this.MasterPageFile = "admin_dash_master.master";
        }
        if(Session["trainer_file_number"]!=null)
        {
            this.MasterPageFile = "trainer_dash_master.master";
        }
        if(Session["mentor_file_number"]!=null)
        {
            this.MasterPageFile = "mentor_dash_master.master";
        }

    }
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);


    protected void btn_upload_file_Click(object sender, EventArgs e)
    {
        lbl_message.Text = "";

        if(FileUpload.HasFile)
        {
            string ext = System.IO.Path.GetExtension(FileUpload.FileName);
            if(ext!=".pdf" && ext!=".png" && ext!=".jpg" && ext!=".docx" && ext!=".doc" && ext!=".xlsx" && ext!=".xls" && ext!=".pptx" && ext!=".ppt" )
            {
                Response.Write("This Type of File Not Allowed");
                lbl_message.ForeColor = System.Drawing.Color.Red;
                lbl_message.Text = "This Type of File Not Allowed";
                return;
            }
            if(Session["admin_code"]!=null)
            {
                string admin_code = Session["admin_code"].ToString();
                string fn = "";
                fn = fn + Session["admin_code"].ToString() + "_" + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString()  + DateTime.Now.Year.ToString()  + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString();
                FileUpload.SaveAs(Server.MapPath("dms") + "\\" + fn + ext);
                string path = "~\\dms\\" + fn + ext;

                string sql ="insert into dms (admin_code,  dms_title, dms_upload_date, file_path,downloads ) values (@admin_code, @dms_title, @dms_upload_date, @file_path,@downloads)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@admin_code",Session["admin_code"].ToString() );
                cmd.Parameters.AddWithValue("@dms_title", txt_file_title.Text);
                cmd.Parameters.AddWithValue("@dms_upload_date", DateTime.Now.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@file_path", path);
                cmd.Parameters.AddWithValue("@downloads", 0);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                lbl_message.ForeColor = System.Drawing.Color.Green;
                lbl_message.Text = "Successful Added";
                txt_file_title.Text = "";
                FileUpload.Attributes.Clear();
                Response.AddHeader("REFRESH", "3;URL=upload_dms.aspx");
            }
            else if(Session["trainer_file_number"]!=null)
            {
                string trainer_file_number = Session["trainer_file_number"].ToString();
                string fn = "";
                fn = fn + Session["trainer_file_number"].ToString() + "_" + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString()  + DateTime.Now.Year.ToString()  + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString();
                FileUpload.SaveAs(Server.MapPath("dms") + "\\" + fn + ext);
                string path = "~\\dms\\" + fn + ext;

                string sql ="insert into dms (trainer_file_number,  dms_title, dms_upload_date, file_path,downloads ) values (@trainer_file_number, @dms_title, @dms_upload_date, @file_path,@downloads)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@trainer_file_number",Session["trainer_file_number"].ToString() );
                cmd.Parameters.AddWithValue("@dms_title", HttpUtility.HtmlEncode( txt_file_title.Text));
                cmd.Parameters.AddWithValue("@dms_upload_date", DateTime.Now.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@file_path", path);
                cmd.Parameters.AddWithValue("@downloads", 0);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                lbl_message.ForeColor = System.Drawing.Color.Green;
                lbl_message.Text = "Successful Added";
                txt_file_title.Text = "";
                FileUpload.Attributes.Clear();
                Response.AddHeader("REFRESH", "3;URL=upload_dms.aspx");
            }
            else if(Session["mentor_file_number"]!=null)
            {
                string mentor_file_number = Session["mentor_file_number"].ToString();
                string fn = "";
                fn = fn + Session["mentor_file_number"].ToString() + "_" + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString()  + DateTime.Now.Year.ToString()  + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString();
                FileUpload.SaveAs(Server.MapPath("dms") + "\\" + fn + ext);
                string path = "~\\dms\\" + fn + ext;

                string sql ="insert into dms (mentor_file_number,  dms_title, dms_upload_date, file_path,downloads ) values (@mentor_file_number, @dms_title, @dms_upload_date, @file_path,@downloads)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@mentor_file_number",Session["mentor_file_number"].ToString() );
                cmd.Parameters.AddWithValue("@dms_title", HttpUtility.HtmlEncode( txt_file_title.Text));
                cmd.Parameters.AddWithValue("@dms_upload_date", DateTime.Now.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@file_path", path);
                cmd.Parameters.AddWithValue("@downloads", 0);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                lbl_message.ForeColor = System.Drawing.Color.Green;
                lbl_message.Text = "Successful Added";
                txt_file_title.Text = "";
                FileUpload.Attributes.Clear();
                Response.AddHeader("REFRESH", "3;URL=upload_dms.aspx");
            }
            else
            {

                Response.Redirect("index.html");

            }


        }
        else
        {
            lbl_message.ForeColor = System.Drawing.Color.Red;
            lbl_message.Text = "Please Upload the file";
        }



    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lbl_message.Text = "";



        if(Session["admin_code"]!=null)
        {
            string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(my_connection);
            con.Open();
            string sql11 = "select dms_id, admin_name, mentor_name, trainer_name, dms_title, dms_upload_date, file_path, downloads from dms inner join admins on dbo.admins.admin_code=dbo.dms.admin_code left join trainers on dbo.trainers.trainer_file_number=dbo.dms.trainer_file_number left join mentors on dbo.mentors.mentor_file_number=dbo.dms.mentor_file_number order by dms_upload_date desc " ;
            SqlCommand cmd = new SqlCommand(sql11, con);
            SqlDataReader read= cmd.ExecuteReader();
            if(read.HasRows==true)
            {

                GridView1.DataSource = read;
                GridView1.DataBind();
            }
            read.Close();
            con.Close();

        }
        else if(Session["trainer_file_number"]!=null)
        {
            string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(my_connection);
            con.Open();
            string sql11 = "select dms_id, admin_name, mentor_name, trainer_name, dms_title, dms_upload_date, file_path, downloads from dms inner join trainers on dbo.trainers.trainer_file_number=dbo.dms.trainer_file_number left join admins on dbo.admins.admin_code=dbo.dms.admin_code left join mentors on dbo.mentors.mentor_file_number=dbo.dms.mentor_file_number order by dms_upload_date desc  " ;
            SqlCommand cmd = new SqlCommand(sql11, con);
            SqlDataReader read= cmd.ExecuteReader();
            if(read.HasRows==true)
            {

                GridView1.DataSource = read;
                GridView1.DataBind();
            }
            read.Close();
            con.Close();
        }
        else if(Session["mentor_file_number"]!=null)
        {
            string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(my_connection);
            con.Open();
            string sql11 = "select dms_id, admin_name, mentor_name, trainer_name, dms_title, dms_upload_date, file_path, downloads from dms left join admins on dbo.admins.admin_code=dbo.dms.admin_code left join trainers on dbo.trainers.trainer_file_number=dbo.dms.trainer_file_number inner join mentors on dbo.mentors.mentor_file_number=dbo.dms.mentor_file_number order by dms_upload_date desc " ;
            SqlCommand cmd = new SqlCommand(sql11, con);
            SqlDataReader read= cmd.ExecuteReader();
            if(read.HasRows==true)
            {

                GridView1.DataSource = read;
                GridView1.DataBind();
            }
            read.Close();
            con.Close();
        }
        else
        {

            Response.Redirect("index.html");

        }

    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        lbl_message.Text = "";
        string dms_id = GridView1.DataKeys[e.RowIndex].Value.ToString();
        int.Parse(dms_id);
        con.Open();
        string sql2 = "DELETE from dms WHERE dms_id ='"+dms_id+"' ";
        SqlCommand cmd2 = new SqlCommand(sql2, con);
        cmd2.ExecuteNonQuery();
        int t=cmd2.ExecuteNonQuery();
        if(t>=0)
        {
            Response.Write("Deleted");
            con.Close();
            lbl_message.ForeColor = System.Drawing.Color.Red;
            lbl_message.Text = "Deleted";
            GridView1.EditIndex = -1;
            Response.AddHeader("REFRESH", "3;URL=upload_dms.aspx");

        }
        con.Close();

        

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">

        .auto-style5 {
            font-weight: bold;
            display:inline-block;
        }
        .auto-style6 {
            color: #FF0000;
        }
        .auto-style7 {
            font-weight: bold;
            display: inline-block;
            color: #FFFFFF;
            background-color: #000000;
        }
        .auto-style8 {
            font-size: large;
        }
        .auto-style9 {
            color: #000000;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        &nbsp;</p>
    <p>
        <span class="auto-style8"><strong><span class="auto-style9">Data Managment System</span> </strong></span>
        <br />
    </p>
    <p>
        <strong>File Title:</strong>
        <asp:TextBox ID="txt_file_title" autocomplete="off" runat="server" Width="436px"></asp:TextBox>
        <strong>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_file_title" CssClass="auto-style6" ErrorMessage="Title is Required"></asp:RequiredFieldValidator>
&nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_file_title" CssClass="auto-style6" ErrorMessage="- Only 50 letters as maximum" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator18" runat="server" ControlToValidate="txt_file_title" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9\s]+$"></asp:RegularExpressionValidator>

        </strong>
    </p>
    <p>
        <asp:FileUpload ID="FileUpload" runat="server" CssClass="auto-style5" Width="283px" />
    &nbsp;<strong>
        </strong>
    </p>
    <p>
        <asp:Button ID="btn_upload_file" runat="server" CssClass="auto-style7" OnClick="btn_upload_file_Click" Text="Upload File" />
        <strong>
        <asp:Label ID="lbl_message" runat="server"></asp:Label>
        </strong>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDeleting="GridView1_RowDeleting" DataKeyNames="dms_id">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="dms_id" HeaderText="ID" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="Uploaded By" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
                    <ItemTemplate>
            <%# Eval("admin_name") + " " + Eval("mentor_name")+ " " +Eval("trainer_name") %>
        </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:TemplateField>
                <asp:BoundField DataField="dms_title" HeaderText="File Title" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="dms_upload_date" HeaderText="Upload Date" ReadOnly="True" DataFormatString="{0:yyyy-MM-dd}" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="file_path" HeaderText="File Path" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="downloads" visible="false" HeaderText="Downloaded" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small">
                <ControlStyle BackColor="Red" ForeColor="White" />
                    <HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:CommandField>
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
    </p>
    <p>
        &nbsp;</p>
</asp:Content>

