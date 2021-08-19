﻿<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dash_master.master" UnobtrusiveValidationMode="None" MaintainScrollPositionOnPostback="true" %>
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

            txt_assess_code.Text = "";
            txt_assess_title.Text = "";
            txt_assess_link.Text = "";
            txt_assess_date.Text = "";



            string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(my_connection);


            con.Open();
            string sql11 = "select assess_id, assess_code, assess_name, assess_link, assess_date from assess order by assess_name" ;
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

    }

    protected void btn_add_Click(object sender, EventArgs e)
    {
       
        con.Open();
        string sql = "SELECT assess_code from assess where assess_code='"+txt_assess_code.Text+"'";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader read= cmd.ExecuteReader();
        if(read.HasRows==true)
        {

            Response.Write("That Assessment Added before");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "That Assessment Added before";
            read.Close();
            con.Close();
            Response.AddHeader("REFRESH", "3;URL=add_assess.aspx");
        }
        else
        {
            read.Close();
            con.Close();
            string str_insert_new_assess ="insert into assess (assess_code, assess_name, assess_link, assess_date)values (@assess_code, @assess_name,@assess_link, @assess_date)";
            SqlCommand cmd_insert_new_assess = new SqlCommand(str_insert_new_assess, con);
            cmd_insert_new_assess.Parameters.AddWithValue("@assess_code", HttpUtility.HtmlEncode(txt_assess_code.Text.ToString()));
            cmd_insert_new_assess.Parameters.AddWithValue("@assess_name", HttpUtility.HtmlEncode(txt_assess_title  .Text.ToString()));
            cmd_insert_new_assess.Parameters.AddWithValue("@assess_link", txt_assess_link.Text.ToString());
            cmd_insert_new_assess.Parameters.AddWithValue("@assess_date", txt_assess_date.Text.ToString());

            con.Open();
            cmd_insert_new_assess.ExecuteNonQuery();
            con.Close();
            Response.Write("Added Successfully");
            lbl_status.ForeColor = System.Drawing.Color.Green;
            lbl_status.Text = "Added Successfully";

            Response.AddHeader("REFRESH", "2;URL=add_assess.aspx");
        }
    }




    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        Response.Write("Action Cancelled");
        lbl_status.ForeColor = System.Drawing.Color.Red;
        lbl_status.Text = "Action Cancelled";

        Response.AddHeader("REFRESH", "3;URL=add_assess.aspx");
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string assess_id = GridView1.DataKeys[e.RowIndex].Value.ToString();
        int.Parse(assess_id);
        con.Open();
        string sql2 = "DELETE from assess WHERE assess_id ='"+assess_id+"' ";
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

            Response.AddHeader("REFRESH", "3;URL=add_assess.aspx");

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
        <span class="auto-style1"><strong>Add New Assessment Details</strong></span>
    </p>
    <table align="left" cellpadding="0" class="auto-style3">
        <tr>
            <td class="auto-style4"><strong>Assessment Code</strong></td>
            <td>
                <div style="display: inline-block;"><asp:TextBox ID="txt_assess_code" CssClass="upper" runat="server" autocomplete="off" Width="270px"></asp:TextBox></div>
                <div style="display: inline-block;"><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_assess_code" ErrorMessage="*" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_assess_code" ErrorMessage="invalid" Font-Bold="True" ForeColor="Red" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator></div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator18" runat="server" ControlToValidate="txt_assess_code" ErrorMessage="invalid" Font-Bold="True"  ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9\s]+$"></asp:RegularExpressionValidator>
                
            </td>
        </tr>
        <tr>
            <td class="auto-style4"><strong>Assessment Title</strong></td>
            <td>
                <div style="display: inline-block;"><asp:TextBox ID="txt_assess_title" CssClass="upper" runat="server" autocomplete="off" Width="270px"></asp:TextBox></div>
                <div style="display: inline-block;"><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_assess_title" ErrorMessage="*" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txt_assess_title" ErrorMessage="invalid" Font-Bold="True" ForeColor="Red" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator></div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txt_assess_title" ErrorMessage="invalid" Font-Bold="True"  ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9\s]+$"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style4"><strong>Assessment Link</strong></td>
            <td>
                <div style="display: inline-block;"><asp:TextBox ID="txt_assess_link" autocomplete="off" runat="server" Width="270px"></asp:TextBox></div>
                <div style="display: inline-block;"><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_assess_link" ErrorMessage="*" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txt_assess_link" ErrorMessage="invalid Shorten URL" Font-Bold="True" ForeColor="Red" ValidationExpression=".{0,50}"></asp:RegularExpressionValidator></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txt_assess_link" ErrorMessage="invalid" Font-Bold="True" ForeColor="Red" ValidationExpression="^((ftp|http|https):\/\/)?(www.)?(?!.*(ftp|http|https|www.))[a-zA-Z0-9_-]+(\.[a-zA-Z]+)+((\/)[\w#]+)*(\/\w+\?[a-zA-Z0-9_]+=\w+(&[a-zA-Z0-9_]+=\w+)*)?$"></asp:RegularExpressionValidator></div>
            </td>
        </tr>
        <tr>
            <td class="auto-style4"><strong>Assessment Date </strong></td>
            <td>
                <div style="display: inline-block;"><asp:TextBox ID="txt_assess_date" autocomplete="off" placeholder="YYYY-MM-DD" runat="server" Width="270px"></asp:TextBox></div>
                <div style="display: inline-block;"><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_assess_date" ErrorMessage="*" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator></div>
                <div style="display: inline-block;"><asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txt_assess_date" ErrorMessage="invalid" Font-Bold="True" ForeColor="Red" ValidationExpression="^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$"></asp:RegularExpressionValidator></div>
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

       <span class="auto-style1"><strong> All Assessments</strong></span><br />
        </span>
        <asp:GridView ID="GridView1" runat="server" CellPadding="0" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="assess_id" OnRowDeleting="GridView1_RowDeleting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="assess_id" HeaderText="ID" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="assess_code" HeaderText="Code" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="assess_name" HeaderText="Name" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="assess_link" HeaderText="Link" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="assess_date" HeaderText="Date" HeaderStyle-Font-Size="XX-Small" DataFormatString="{0:yyyy-MM-dd}" ItemStyle-Font-Size="XX-Small" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"><ControlStyle BackColor="Red" ForeColor="White" />
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

