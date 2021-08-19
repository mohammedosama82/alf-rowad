<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dash_master.master" UnobtrusiveValidationMode="None" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);

    protected void Button2_Click(object sender, EventArgs e)
    {
        txt_admin_code.Text  = "";
        txt_old_admin_password.Text = "";
        txt_new_admin_password.Text = "";
        txt_confirm_new_admin_password.Text = "";
        Response.AddHeader("REFRESH", "2;URL=change_pwd.aspx");
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        con.Open();
        string sql = "SELECT admin_code from admins where admin_code=@admin_code";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@admin_code", txt_admin_code.Text);
        SqlDataReader read= cmd.ExecuteReader();
        if(read.HasRows==false)
        {


            lbl_status.Text = "That Admin Not Exist!";
            read.Close();
            con.Close();
        }
        else
        {
            read.Close();
            con.Close();

            con.Open();
            string sql2 = "SELECT admin_password from admins where admin_password=hashbytes('sha2_256', @admin_password) and admin_code=@admin_code";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            cmd2.Parameters.AddWithValue("@admin_code", HttpUtility.HtmlEncode( txt_admin_code.Text.ToString()));
            byte[] newbyte2 = Encoding.ASCII.GetBytes( HttpUtility.HtmlEncode(txt_old_admin_password.Text));
            cmd2.Parameters.AddWithValue("@admin_password",SqlDbType.VarBinary).Value=newbyte2;
            SqlDataReader read2= cmd2.ExecuteReader();
            if (read2.HasRows == false)
            {


                lbl_status.Text = "Wrong Old Password!";
                read2.Close();
                con.Close();                
                Response.AddHeader("REFRESH", "3;URL=change_pwd.aspx");
            }
            else
            {
                read2.Close();
                con.Close();

                string str_insert_new_candidate = "UPDATE admins SET admin_password= hashbytes('sha2_256', @admin_password) where admin_code=@admin_code";
                SqlCommand cmd_insert_new_candidate = new SqlCommand(str_insert_new_candidate, con);
                cmd_insert_new_candidate.Parameters.AddWithValue("@admin_code", HttpUtility.HtmlEncode( txt_admin_code.Text.ToString()));
                byte[] newbyte = Encoding.ASCII.GetBytes(HttpUtility.HtmlEncode(txt_new_admin_password.Text));
                cmd_insert_new_candidate.Parameters.AddWithValue("@admin_password", SqlDbType.VarBinary).Value = newbyte;

                con.Open();
                cmd_insert_new_candidate.ExecuteNonQuery();
                con.Close();
                lbl_status.Text = "Password Changed";
                Response.AddHeader("REFRESH", "2;URL=logout.aspx");
            }
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(( Session["admin_code"]==null))
        {
            Response.Redirect("index.html");
        }
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
            width: 120px;
        }
    </style>
<div>
    <strong>Admin File#:
</strong>
</div>
<div>
    <asp:TextBox ID="txt_admin_code" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_admin_code"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator16" runat="server" ControlToValidate="txt_admin_code" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{5}"></asp:RegularExpressionValidator>
</div>
    <div>
        <strong>Old Password:
</strong>
</div>
<div>
    <asp:TextBox ID="txt_old_admin_password" runat="server" TextMode="Password"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_old_admin_password"></asp:RequiredFieldValidator>
</div>
    <div>
        <strong>New Password:
</strong>
</div>
<div>
    <asp:TextBox ID="txt_new_admin_password" runat="server" TextMode="Password"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_new_admin_password"></asp:RequiredFieldValidator>
        
</div>
    <div>
        <strong>Confirm New Password:
</strong>
</div>
    <div>
    <asp:TextBox ID="txt_confirm_new_admin_password" runat="server" TextMode="Password"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" CssClass="inline" ControlToValidate="txt_confirm_new_admin_password"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Not Matching" ControlToCompare="txt_new_admin_password" ControlToValidate="txt_confirm_new_admin_password" ForeColor="#FF3300"></asp:CompareValidator>
</div>
    <div class="inline">
        <strong>

        <asp:Button  ID="Button1" runat="server" Text="Change" CssClass="auto-style2" OnClick="Button1_Click" />
        <asp:Button  ID="Button2" runat="server" Text="Cancel" CssClass="auto-style2" OnClick="Button2_Click" CausesValidation="False" />

        </strong>

    </div>
    <div>
        <asp:Label ID="lbl_status" runat="server"></asp:Label>
    </div>
</asp:Content>

