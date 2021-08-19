<%@ Page Title="" Language="C#" MasterPageFile="~/login_master.master" UnobtrusiveValidationMode="None" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>


<script runat="server">
   SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {

        


    }

    protected void btn_login_Click(object sender, EventArgs e)
    {
        string str_candidate_info = "select admin_name, admin_type from admins  where admin_code=@admin_code and admin_password=hashbytes('sha2_256', @admin_password) and admin_type=@admin_type";
        con.Open();
        SqlCommand cmd_candidate_info = new SqlCommand(str_candidate_info, con);
        cmd_candidate_info.Parameters.AddWithValue("admin_code", HttpUtility.HtmlEncode( txt_admin_code.Text));
        byte[] newbyte = Encoding.ASCII.GetBytes(HttpUtility.HtmlEncode(txt_admin_password.Text) );
        cmd_candidate_info.Parameters.AddWithValue("@admin_password",SqlDbType.VarBinary).Value=newbyte;
         cmd_candidate_info.Parameters.AddWithValue("@admin_type", 1);
        SqlDataReader read_candidate_info = cmd_candidate_info.ExecuteReader();

        if (read_candidate_info.HasRows == false)
        {
            read_candidate_info.Close();
            con.Close();
            Session["error"] = "invalid_code";
            Response.Redirect("errors.aspx");

        }
        else
        {
            while (read_candidate_info.Read())
            {
                Session["admin_name"] = (read_candidate_info["admin_name"].ToString());
                Session["admin_code"] = txt_admin_code.Text;
                Session["admin_type"]=(read_candidate_info["admin_type"].ToString());

            }

            read_candidate_info.Close();
            con.Close();
            Session["mentor_file_number"] = null;
            Session["candidate_code"] = null;
            Session["trainer_file_number"] = null;

            Response.Redirect("add_admins.aspx");
        }
    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        Response.Write("Action Cancelled");
        Response.AddHeader("REFRESH", "1;URL=super_admin.aspx");
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
            <td class="auto-style12"><strong>Super Admin Code </strong>
                <asp:TextBox ID="txt_admin_code" autocomplete="off" placeholder="Enter Super Admin Code" runat="server" Width="341px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_admin_code"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server" ControlToValidate="txt_admin_code" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{5}"></asp:RegularExpressionValidator>
                <br />
                <strong>Super Admin Password </strong>
                <asp:TextBox ID="txt_admin_password" autocomplete="off" placeholder="Enter Super Admin Password" runat="server" Width="341px" TextMode="Password"></asp:TextBox>
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
                <asp:Label ID="lbl_assessment_code" runat="server"></asp:Label>
            &nbsp;<strong><asp:Label ID="lbl_invalid_code" runat="server" CssClass="auto-style8" Text="Invalid Code" Visible="False"></asp:Label>
                </strong>
            </td>
        </tr>
    </table>
    <br />
</p>
</asp:Content>

