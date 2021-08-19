<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dash_master.master"  UnobtrusiveValidationMode="None" MaintainScrollPositionOnPostback="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>
<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if(( Session["admin_code"]==null) || (Session["admin_type"].ToString()=="2" ))
        {
            Response.Redirect("index.html");
        }
        if (!IsPostBack)
        {
            string qs = Request.QueryString["admin_code"];
            con.Open();
            string sql = "SELECT * from admins";
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

    protected void Button1_Click(object sender, EventArgs e)
    {
        con.Open();
        string sql = "SELECT admin_code from admins where admin_code=@admin_code";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@admin_code", txt_admin_code.Text);
        SqlDataReader read= cmd.ExecuteReader();
        if(read.HasRows==true)
        {


            lbl_status.Text = "That Admin Added Before!";
            read.Close();
            con.Close();
        }
        else
        {
            read.Close();
            con.Close();
            string str_insert_new_candidate ="insert into admins (admin_code, admin_name, admin_password, admin_type, islocked, attempt )values(@admin_code, @admin_name, hashbytes('sha2_256', @admin_password), @admin_type,@islocked,@attempt)";
            SqlCommand cmd_insert_new_candidate = new SqlCommand(str_insert_new_candidate, con);
            cmd_insert_new_candidate.Parameters.AddWithValue("@admin_code", HttpUtility.HtmlEncode( txt_admin_code.Text.ToString()));
            cmd_insert_new_candidate.Parameters.AddWithValue("@admin_name", HttpUtility.HtmlEncode( HttpUtility.HtmlEncode(txt_admin_name.Text.ToString())));
            byte[] newbyte = Encoding.ASCII.GetBytes(HttpUtility.HtmlEncode(txt_admin_password.Text));
            cmd_insert_new_candidate.Parameters.AddWithValue("@admin_password",SqlDbType.VarBinary).Value=newbyte;
            cmd_insert_new_candidate.Parameters.AddWithValue("@admin_type", (int)2);
            cmd_insert_new_candidate.Parameters.AddWithValue("@islocked",0);
            cmd_insert_new_candidate.Parameters.AddWithValue("@attempt", (int)0);
            con.Open();
            cmd_insert_new_candidate.ExecuteNonQuery();
            con.Close();
            lbl_status.Text = "Admin Added Successfuly";
            Response.AddHeader("REFRESH", "2;URL=add_admins.aspx");
        }

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("reset_pwd.aspx");
    }
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>
        .inline {
   display:inline-block;
   margin-right:5px;
}
        .transformtoupper
        {
            text-transform:capitalize;
        }
        .auto-style2 {
            font-weight: bold;
            color: #FFFFFF;
            background-color: #000000;
            height:25px;
            width:120px;
        }
    </style>
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="0" ForeColor="#333333" GridLines="None" >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="admin_id" HeaderText="Admin ID" HeaderStyle-Font-Size="X-Small" ItemStyle-Font-Size="X-Small" >
<HeaderStyle Font-Size="X-Small"></HeaderStyle>

<ItemStyle Font-Size="X-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="admin_name" HeaderText="Admin Name" HeaderStyle-Font-Size="X-Small" ItemStyle-Font-Size="X-Small" >
<HeaderStyle Font-Size="X-Small"></HeaderStyle>

<ItemStyle Font-Size="X-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="admin_code" HeaderText="File Number"  HeaderStyle-Font-Size="X-Small" ItemStyle-Font-Size="X-Small" >
<HeaderStyle Font-Size="X-Small"></HeaderStyle>

<ItemStyle Font-Size="X-Small"></ItemStyle>
                </asp:BoundField>
                
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
        <strong>Admin File# :
    </strong>
        <asp:TextBox ID="txt_admin_code" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_admin_code"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server" ControlToValidate="txt_admin_code" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{5}"></asp:RegularExpressionValidator>
    </div>
    <div>
        <strong>Admin Name:
    </strong>
        <asp:TextBox ID="txt_admin_name" runat="server" CssClass="transformtoupper"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_admin_name"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_admin_name" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator18" runat="server" ControlToValidate="txt_admin_name" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9\s]+$"></asp:RegularExpressionValidator>

    </div>
    <div>
        <strong>Admin Password:
    </strong>
        <asp:TextBox ID="txt_admin_password" runat="server" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_admin_password"></asp:RequiredFieldValidator>
    </div>
    <div>
        <strong>Confirm Password:
    </strong>
        <asp:TextBox ID="txt_admin_password_confirm" runat="server" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_admin_password_confirm"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Not Matching" ControlToCompare="txt_admin_password" ControlToValidate="txt_admin_password_confirm" ForeColor="#FF3300"></asp:CompareValidator>
    </div>
    <div class="inline">

        <strong>

        <asp:Button  ID="Button1" runat="server" Text="ADD" CssClass="auto-style2" OnClick="Button1_Click" />
        <asp:Button  ID="Button2" runat="server" Text="Reset PWD" CssClass="auto-style2" OnClick="Button2_Click" CausesValidation="False" />

        </strong>

    </div>
    <div>

        <asp:Label ID="lbl_status" runat="server"></asp:Label>

    </div>
</asp:Content>

