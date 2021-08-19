<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dash_master.master" UnobtrusiveValidationMode="None" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void btn_admin_dashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("admin_dashboard.aspx");
    }

    protected void btn_upload_file_Click(object sender, EventArgs e)
    {
        lbl_message.Text = "";
        string admin_code = Session["admin_code"].ToString();
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
            if(Session["admin_code"]==null)
            {
                Response.Redirect("index.html");
            }

            string fn = "";
            fn = fn + Session["admin_code"].ToString() + "_" + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString()  + DateTime.Now.Year.ToString()  + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString();
            FileUpload.SaveAs(Server.MapPath("files") + "\\" + fn + ext);
            string path = "~\\files\\" + fn + ext;

            string sql ="insert into files (admin_code, file_title, file_upload_date, file_path,downloads ) values (@admin_code, @file_title, @file_upload_date, @file_path,@downloads)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@admin_code",Session["admin_code"].ToString() );
            cmd.Parameters.AddWithValue("@file_title",HttpUtility.HtmlEncode(txt_file_title.Text));
            cmd.Parameters.AddWithValue("@file_upload_date", DateTime.Now.ToString("yyyy-MM-dd"));
            cmd.Parameters.AddWithValue("@file_path", path);
            cmd.Parameters.AddWithValue("@downloads", 0);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            lbl_message.ForeColor = System.Drawing.Color.Green;
            lbl_message.Text = "Successful Added";
            txt_file_title.Text = "";
            FileUpload.Attributes.Clear();
            Response.AddHeader("REFRESH", "3;URL=upload_files.aspx");
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
        if(Session["admin_code"]==null)
        {
            Response.Redirect("index.html");
        }

        string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(my_connection);
        con.Open();
        string sql11 = "select file_id, admin_name, file_title, file_upload_date, file_path, downloads from files inner join admins on dbo.admins.admin_code=dbo.files.admin_code order by file_upload_date desc " ;
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

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        lbl_message.Text = "";
            string file_id = GridView1.DataKeys[e.RowIndex].Value.ToString();
            int.Parse(file_id);
            con.Open();
            string sql2 = "DELETE from files WHERE file_id ='"+file_id+"' ";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            cmd2.ExecuteNonQuery();
            int t=cmd2.ExecuteNonQuery();
            if(t>=0)
            {
                Response.Write("Deleted");
                lbl_message.ForeColor = System.Drawing.Color.Red;
                lbl_message.Text = "File Deleted";
                GridView1.EditIndex = -1;
            con.Close();
                Response.AddHeader("REFRESH", "1;URL=upload_files.aspx");

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
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        &nbsp;</p>
    <p>
        <strong>
        <asp:Button ID="btn_admin_dashboard" runat="server" CssClass="auto-style7" OnClick="btn_admin_dashboard_Click" Text="Admin Dashboard" CausesValidation="False" />
        &nbsp;</strong></p>
    <p>
        <br />
        <strong>File Title:</strong>
        <asp:TextBox ID="txt_file_title" autocomplete="off" runat="server" Width="436px"></asp:TextBox>
        <strong>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_file_title" CssClass="auto-style6" ErrorMessage="*Required"></asp:RequiredFieldValidator>
&nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_file_title" CssClass="auto-style6" ErrorMessage="- Invalid" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator18" runat="server" ControlToValidate="txt_file_title" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9\s]+$"></asp:RegularExpressionValidator>
        </strong>
    </p>
    <p>
        <asp:FileUpload ID="FileUpload" runat="server" CssClass="auto-style5" Width="283px" />
    &nbsp;</p>
    <p>
        <asp:Button ID="btn_upload_file" runat="server" CssClass="auto-style7" OnClick="btn_upload_file_Click" Text="Upload File" />
        <strong>
        <asp:Label ID="lbl_message" runat="server"></asp:Label>
        </strong>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDeleting="GridView1_RowDeleting" DataKeyNames="file_id">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="file_id" HeaderText="ID" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="admin_name" HeaderText="Uploaded By" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="file_title" HeaderText="File Title" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="file_upload_date" HeaderText="Upload Date" ReadOnly="True" DataFormatString="{0:yyyy-MM-dd}" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="file_path" HeaderText="File Path" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="downloads" HeaderText="Downloaded" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" Visible="False" >
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

