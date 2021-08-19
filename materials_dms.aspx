<%@ Page Title="" Language="C#" MasterPageFile="~/trainee_dash_master.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["candidate_name"]==null)
        {
            Response.Redirect("index.html");
        }
        if (!IsPostBack)
        {
            string qs = Request.QueryString["course_id"];
            con.Open();
            string sql = "SELECT * from dms";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader read= cmd.ExecuteReader();
            if(read.HasRows==true)
            {

                GridView1.DataSource = read;
                GridView1.DataBind();
            }
            read.Close();
            con.Close();
        }

    }

    protected void btn_trainee_dashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("trainee_dashboard.aspx");
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "down")
        {
            int row_number = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[row_number];
            Label file = (Label)row.FindControl("lbl_path");
            Response.Clear();
            Response.ContentType = "application/octet-stream";
            Response.AddHeader("Content-Disposition", "filename=" + file.Text);
            Response.ContentType = "application/octet-stream";
            Response.TransmitFile(file.Text);
            Response.End();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5 {
            font-size: x-large;
            color: #000000;
        }
        .auto-style6 {
            font-weight: bold;
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
        <asp:Button ID="btn_trainee_dashboard" runat="server" CssClass="auto-style6" OnClick="btn_trainee_dashboard_Click" Text="Trainee DashBoard" />
        </strong>
        <br />
        <strong><span class="auto-style5">Data Managment System </span></strong></p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="0" ForeColor="#333333" GridLines="None" OnRowCommand="GridView1_RowCommand">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="dms_id" HeaderText="File ID" HeaderStyle-Font-Size="X-Small" ItemStyle-Font-Size="X-Small" >
<HeaderStyle Font-Size="X-Small"></HeaderStyle>

<ItemStyle Font-Size="X-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="dms_title" HeaderText="File Title" HeaderStyle-Font-Size="X-Small" ItemStyle-Font-Size="X-Small" >
<HeaderStyle Font-Size="X-Small"></HeaderStyle>

<ItemStyle Font-Size="X-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="dms_upload_date" HeaderText="Upload Date" DataFormatString="{0:yyyy-MM-dd}" HeaderStyle-Font-Size="X-Small" ItemStyle-Font-Size="X-Small" >
<HeaderStyle Font-Size="X-Small"></HeaderStyle>

<ItemStyle Font-Size="X-Small"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="File Path" Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="lbl_path" runat="server" Text='<%# bind("file_path") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:ButtonField CommandName="down" Text="DownLoad">
                <ControlStyle BackColor="#009933" ForeColor="White" />
                </asp:ButtonField>
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

