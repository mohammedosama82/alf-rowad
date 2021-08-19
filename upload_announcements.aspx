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

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        lbl_message.Text = "";
        txt_post.Text = "";

    }

    protected void btn_post_Click(object sender, EventArgs e)
    {
        lbl_message.Text = "";

        if (Session["admin_code"] != null)
        {
            if(txt_post.Text!=null)
            {

                string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(my_connection);
                string sql = "insert into announcements (admin_code, announcement, announcement_date, count ) values (@admin_code, @announcement, @announcement_date, @count)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@admin_code", Session["admin_code"].ToString());
                cmd.Parameters.AddWithValue("@announcement", HttpUtility.HtmlEncode( txt_post.Text));
                cmd.Parameters.AddWithValue("@announcement_date", DateTime.Now.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@count", 0);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                lbl_message.ForeColor = System.Drawing.Color.Green;
                lbl_message.Text = "Successful Posted";
                txt_post.Text = "";
                Response.AddHeader("REFRESH", "1;URL=upload_announcements.aspx");

            }
            else
            {
                lbl_message.ForeColor = System.Drawing.Color.Red;
                lbl_message.Text = "Please Add Text inside Post Area";
                return;
            }

        }
        else
        {
            Response.Redirect("index.html");
        }


    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lbl_message.Text = "";

        string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(my_connection);

        if(Session["admin_code"]==null)
        {
            Response.Redirect("index.html");
        }

        con.Open();
        string sql11 = "select announcement_id, admin_name, announcement, announcement_date, count from announcements inner join admins on dbo.admins.admin_code=dbo.announcements.admin_code order by announcement_date desc " ;
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
            string announcement_id = GridView1.DataKeys[e.RowIndex].Value.ToString();
            int.Parse(announcement_id);
            con.Open();
            string sql2 = "DELETE from announcements WHERE announcement_id ='"+announcement_id+"' ";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            cmd2.ExecuteNonQuery();
            int t=cmd2.ExecuteNonQuery();
            if(t>=0)
            {
                Response.Write("Deleted");
                lbl_message.ForeColor = System.Drawing.Color.Red;
                lbl_message.Text = "Deleted";
                GridView1.EditIndex = -1;
                con.Close();
                Response.AddHeader("REFRESH", "1;URL=upload_announcements.aspx");

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
        <br />
        <strong>
        <asp:Button ID="btn_admin_dashboard" runat="server" CssClass="auto-style8" OnClick="btn_admin_dashboard_Click" Text="Admin Dashboard" CausesValidation="False" />
        </strong>
    </p>
    <p>
        <strong>Write Announcement Here </strong></p>
    <p>
        <strong>
                <asp:TextBox ID="txt_post" autocomplete="off" runat="server" CssClass="auto-style5" TextMode="MultiLine" Width="581px" Height="202px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_post" CssClass="auto-style6" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                </strong></p>
    <p>
        &nbsp;</p>
    <p>
        <strong>
        <asp:Button ID="btn_post" runat="server" CssClass="auto-style8" Text="Post" OnClick="btn_post_Click" Width="80px" />
        </strong>&nbsp;<strong><asp:Button ID="btn_cancel" runat="server" CssClass="auto-style8" OnClick="btn_cancel_Click" Text="Cancel" Width="80px" />
        <asp:Label ID="lbl_message" runat="server"></asp:Label>
        </strong></p>
    <p>
        &nbsp;</p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="0" ForeColor="#333333" GridLines="None" OnRowDeleting="GridView1_RowDeleting" DataKeyNames="announcement_id">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="announcement_id" HeaderText="ID" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="admin_name" HeaderText="Uploaded By" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="announcement" HeaderText="Announcement" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="announcement_date" HeaderText="Upload Date" ReadOnly="True" DataFormatString="{0:yyyy-MM-dd}" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="count" HeaderText="View Count" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" Visible="False" >
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
    </asp:Content>

