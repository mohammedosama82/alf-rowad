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
        lbl_today.Text = DateTime.Now.ToString("yyyy-MM-dd");
        string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        // SqlConnection con = new SqlConnection(my_connection);
        con.Open();
        string sql11 = "select assess_code, assess_name, assess_link from assess where assess_date='"+lbl_today.Text+"'  order by assess_date desc" ;
        SqlCommand cmd = new SqlCommand(sql11, con);
        SqlDataReader read= cmd.ExecuteReader();
        if(read.HasRows==true)
        {

            ListView1.DataSource = read;
            ListView1.DataBind();
        }
        read.Close();
        con.Close();



    }

    protected void btn_trainee_dasboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("trainee_dashboard.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5 {
            font-weight: bold;
            color: #FFFFFF;
            background-color: #000000;
        }
        .auto-style6 {
            text-decoration: underline;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <asp:Button ID="btn_trainee_dasboard" runat="server" CssClass="auto-style5" OnClick="btn_trainee_dasboard_Click" Text="Trainee DashBoard" />
        <asp:Label ID="lbl_today" runat="server" Visible="False"></asp:Label>
        &nbsp;<strong><span class="auto-style6">ALL Today&#39;s Assessments</span></strong><asp:ListView ID="ListView1" runat="server">
            <ItemTemplate>
                                    <div>
                                        <table>
                                           <tr style=" background-color:#FFF8DC; font-size:x-large"><td> <asp:Label ID="assess_name" Text='<%# Eval("assess_name") %>' runat="server" /></td></tr>
                                                <tr style="font-size:small;"><td>  <p> Assessment Link:<a href="<%# Eval("assess_link") %>">Click Here To Start the Assessment</a> ---The Assessment include Only ONE response---
                                                                                    
                                        </table>
                                     </div>

                                </ItemTemplate>
        </asp:ListView>
    </p>
        <div>
            <asp:Label ID="lbl_status" runat="server" Text=""></asp:Label>
        </div>
</asp:Content>

