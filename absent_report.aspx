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





    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (Session["admin_code"] == null)
            {
                Response.Redirect("index.html");
            }

            Label3.Visible = false;
            string sql2 = "select distinct candidate_name, dbo.candidate_absent.candidate_code from candidates inner join candidate_absent on dbo.candidates.candidate_code = dbo.candidate_absent.candidate_code order by candidate_name";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            con.Open();
            DropDownList2.DataSource = cmd2.ExecuteReader();
            DropDownList2.DataTextField = "candidate_name";
            DropDownList2.DataValueField = "candidate_code";
            DropDownList2.DataBind();
            ListItem selectlistitem = new ListItem("Select", "-1");
            DropDownList2.Items.Insert(0, selectlistitem);
            con.Close();


            string sql4 = "select distinct absent_date from candidate_absent order by absent_date DESC";
            SqlCommand cmd4 = new SqlCommand(sql4, con);
            con.Open();
            DropDownList3.DataSource = cmd4.ExecuteReader();
            DropDownList3.DataTextField = "absent_date";
            DropDownList3.DataValueField = "absent_date";
            DropDownList3.DataBind();
            ListItem selectlistitem2 = new ListItem("Select", "-1");
            DropDownList3.Items.Insert(0, selectlistitem);
            con.Close();



            con.Open();
            string sql3 = "SELECT candidate_absent_id,  dbo.candidate_absent.candidate_code, candidate_name, candidate_telephone , absent_date from candidate_absent inner join candidates on dbo.candidates.candidate_code=dbo.candidate_absent.candidate_code order by absent_date DESC  ";
            SqlCommand cmd3 = new SqlCommand(sql3, con);
            SqlDataReader read3 = cmd3.ExecuteReader();
            if (read3.HasRows == true)
            {

                GridView1.DataSource = read3;
                GridView1.DataBind();
            }
            else
            {
                GridView1.Visible = false;
                Response.Write("There is no info ");
                lbl_status.ForeColor = System.Drawing.Color.Red;
                lbl_status.Text = "There is no info ";
            }
            read3.Close();
            con.Close();


        }
    }

    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList2.ClearSelection();
        con.Open();
        string sql3 = "SELECT candidate_absent_id,  dbo.candidate_absent.candidate_code, candidate_name, candidate_telephone , absent_date  from candidate_absent inner join candidates on dbo.candidates.candidate_code=dbo.candidate_absent.candidate_code where absent_date=@absent_date order by absent_date DESC  ";
        SqlCommand cmd3 = new SqlCommand(sql3, con);
        DateTime date = Convert.ToDateTime(DropDownList3.SelectedValue.ToString());
        cmd3.Parameters.AddWithValue("@absent_date", date);
        SqlDataReader read3 = cmd3.ExecuteReader();
        if (read3.HasRows == true)
        {

            GridView1.DataSource = read3;
            GridView1.DataBind();
        }
        else
        {
            GridView1.Visible = false;
            Response.Write("There is no info ");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "There is no info ";
        }
        read3.Close();
        con.Close();

        con.Open();
        string sql = "SELECT count(candidate_code) as co from candidate_absent where absent_date=@absent_date";
        SqlCommand cmd = new SqlCommand(sql, con);
        DateTime date2 = Convert.ToDateTime(DropDownList3.SelectedValue.ToString());
        cmd.Parameters.AddWithValue("@absent_date", date2);
        SqlDataReader read= cmd.ExecuteReader();
        while (read.Read())
        {
            Label3.Text = (read["co"].ToString());
            Label3.Visible = true;
        }
        read.Close();
        con.Close();






    }

    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList3.ClearSelection();
        con.Open();
        string sql3 = "SELECT candidate_absent_id,  dbo.candidate_absent.candidate_code, candidate_name, candidate_telephone , absent_date  from candidate_absent inner join candidates on dbo.candidates.candidate_code=dbo.candidate_absent.candidate_code where candidate_name=@candidate_name order by absent_date DESC  ";
        SqlCommand cmd3 = new SqlCommand(sql3, con);
        cmd3.Parameters.AddWithValue("@candidate_name", DropDownList2.SelectedItem.Text);
        SqlDataReader read3 = cmd3.ExecuteReader();
        if (read3.HasRows == true)
        {

            GridView1.DataSource = read3;
            GridView1.DataBind();
        }
        else
        {
            GridView1.Visible = false;
            Response.Write("There is no info ");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "There is no info ";
        }
        read3.Close();
        con.Close();

        con.Open();
        string sql = "SELECT count(candidate_code) as co from candidate_absent where candidate_code=@candidate_code";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@candidate_code", DropDownList2.SelectedValue.ToString());
        SqlDataReader read= cmd.ExecuteReader();
        while (read.Read())
        {
            Label3.Text = (read["co"].ToString());
            Label3.Visible = true;
        }
        read.Close();
        con.Close();



    }





    protected void Button1_Click(object sender, EventArgs e)
    {
        Label3.Visible = false;
        string sql2 = "select distinct candidate_name, dbo.candidate_absent.candidate_code from candidates inner join candidate_absent on dbo.candidates.candidate_code = dbo.candidate_absent.candidate_code order by candidate_name";
        SqlCommand cmd2 = new SqlCommand(sql2, con);
        con.Open();
        DropDownList2.DataSource = cmd2.ExecuteReader();
        DropDownList2.DataTextField = "candidate_name";
        DropDownList2.DataValueField = "candidate_code";
        DropDownList2.DataBind();
        ListItem selectlistitem = new ListItem("Select", "-1");
        DropDownList2.Items.Insert(0, selectlistitem);
        con.Close();


        string sql4 = "select distinct absent_date from candidate_absent order by absent_date DESC";
        SqlCommand cmd4 = new SqlCommand(sql4, con);
        con.Open();
        DropDownList3.DataSource = cmd4.ExecuteReader();
        DropDownList3.DataTextField = "absent_date";
        DropDownList3.DataValueField = "absent_date";
        DropDownList3.DataBind();
        ListItem selectlistitem2 = new ListItem("Select", "-1");
        DropDownList3.Items.Insert(0, selectlistitem);
        con.Close();



        con.Open();
        string sql3 = "SELECT candidate_absent_id,  dbo.candidate_absent.candidate_code, candidate_name, candidate_telephone , absent_date from candidate_absent inner join candidates on dbo.candidates.candidate_code=dbo.candidate_absent.candidate_code order by absent_date DESC  ";
        SqlCommand cmd3 = new SqlCommand(sql3, con);
        SqlDataReader read3 = cmd3.ExecuteReader();
        if (read3.HasRows == true)
        {

            GridView1.DataSource = read3;
            GridView1.DataBind();
        }
        else
        {
            GridView1.Visible = false;
            Response.Write("There is no info ");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "There is no info ";
        }
        read3.Close();
        con.Close();


    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">


        .auto-style8 {
            font-size: large;
        }
        .auto-style9 {
            font-size:x-small;
            float:left;
        }
        .auto-style11 {
            width: 275px;
        }
        .auto-style12 {
            font-size: small;
            width: 58px;
        }
        .displaying{display:inline-block;}
        .auto-style14 {
            font-weight: bold;
            display: inline-block;
            color: #FFFFFF;
            background-color: #000000;
        }
        </style>
    <script language="javascript">
function printdiv(printpage)
{
var headstr = "<html><head><title></title></head><body>";
var footstr = "</body>";
var newstr = document.all.item(printpage).innerHTML;
var oldstr = document.body.innerHTML;
document.body.innerHTML = headstr+newstr+footstr;
window.print();
document.body.innerHTML = oldstr;
return false;
}
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <br />
        <strong>
        <asp:Button ID="btn_admin_dashboard" runat="server" CssClass="auto-style14" OnClick="btn_admin_dashboard_Click" Text="Admin Dashboard" CausesValidation="False" />
        </strong>
    </p>
    <div>
        <asp:Label ID="lbl_status" runat="server" Text=""></asp:Label>
    </div>
    <div id="divprint">
    <p>
        <strong>
        <asp:Label ID="Label1" runat="server" Text="Trainee Filter" CssClass="displaying"></asp:Label>
        <asp:DropDownList ID="DropDownList2" runat="server" CssClass="displaying" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" AutoPostBack="True">
        </asp:DropDownList>
        <asp:Label ID="Label2" runat="server" Text="OR Date Filter" CssClass="displaying"></asp:Label>
        <asp:DropDownList ID="DropDownList3" runat="server" CssClass="displaying" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" AutoPostBack="True" DataTextFormatString="{0:d}" >
        </asp:DropDownList>
        <asp:Label ID="Label3" runat="server" Text="Label" Visible="False"></asp:Label>
        <asp:Button CssClass="auto-style14" ID="Button1" runat="server" Text="Cancel Filter" OnClick="Button1_Click" />
            <asp:Button CssClass="auto-style14" ID="Button2" runat="server" Text="Print" OnClientClick="javascript:printdiv('divprint');"   />
        </strong>
    </p>
    

    <div>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="candidate_absent_id">
            <Columns>
                <asp:BoundField DataField="candidate_absent_id" HeaderText="ID" />
                <asp:BoundField DataField="candidate_code" HeaderText="Trainee ID" />
                <asp:BoundField DataField="candidate_name" HeaderText="Name" />
                <asp:BoundField DataField="candidate_telephone" HeaderText="Tel." />
                <asp:BoundField DataField="absent_date" HeaderText="Absent Date" DataFormatString="{0:yyyy-MM-dd}" />
            </Columns>
        </asp:GridView>

    </div>

   </div>                         
    
                            
    </asp:Content>

