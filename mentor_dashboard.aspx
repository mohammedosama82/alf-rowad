<%@ Page Title="" Language="C#" MasterPageFile="~/mentor_dash_master.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);


    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["mentor_name"]==null)
        {
            Response.Redirect("index.html");
        }
        else
        {
            lbl_mentor_name.Text = Session["mentor_name"].ToString();
        }
    }



    protected void btn_evaluate_trainee_Click(object sender, EventArgs e)
    {
        Response.Redirect("evaluate_trainee_by_mentor.aspx");
    }

    protected void btn_dms_Click(object sender, EventArgs e)
    {
        Response.Redirect("upload_dms.aspx");
    }

    protected void btn_wall_Click(object sender, EventArgs e)
    {
        Response.Redirect("upload_mentors_posts.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">

        .myButton {
	box-shadow: 0px 0px 0px 2px #9fb4f2;
	background:linear-gradient(to bottom, #7892c2 5%, #476e9e 100%);
	background-color:#7892c2;
	border-radius:10px;
	border:1px solid #4e6096;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:19px;
	padding:12px 37px;
	text-decoration:none;
	text-shadow:0px 1px 0px #283966;
}
.myButton:hover {
	background:linear-gradient(to bottom, #476e9e 5%, #7892c2 100%);
	background-color:#476e9e;
}
.myButton:active {
	position:relative;
	top:1px;
}
        .auto-style5 {
            width: 637px;
            border: 3px solid #003399;
        }
        .auto-style8 {
            font-weight: bold;
            color: #000000;
            background-color: #FFFFFF;
            border-style:none;
        }
        .auto-style9 {
            font-size:large;
            color: #000000;
        }
        .auto-style10 {
            text-align: center;
            height: 40px;
            width: 191px;
        }
        .auto-style24 {
            width: 186px;
            height: 135px;
            float: left;
        }
        .auto-style25 {
            width: 190px;
        }
        .auto-style26 {
            text-align: center;
            width: 191px;
        }
        .auto-style27 {
            text-align: center;
            width: 186px;
            height: 135px;
            float: left;
        }
        .auto-style28 {
            text-align: center;
            width: 190px;
        }
        .auto-style29 {
            text-align: center;
            height: 40px;
            width: 190px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p class="auto-style2">
        <br />
        <span class="auto-style9"><strong>Welcome
        <asp:Label ID="lbl_mentor_name" runat="server"></asp:Label>
        </strong></span></p>
    <table class="auto-style5">
        <tr>
            <td class="auto-style25">
                <asp:Button ID="btn_evaluate_trainee" runat="server" Text="Evaluate Trainees" CssClass="auto-style8" OnClick="btn_evaluate_trainee_Click" Width="185px" />
            </td>
            <td class="auto-style29">
                <asp:Button ID="btn_dms" runat="server" Text="DMS" CssClass="auto-style8" Width="185px" OnClick="btn_dms_Click" />
            </td>
            <td class="auto-style10">
                <asp:Button ID="btn_wall" runat="server" Text="RAP wall" CssClass="auto-style8" Width="185px" OnClick="btn_wall_Click" />
            </td>
        </tr>
        <tr>
            <td><img src="images/evaluate.png" class="auto-style24" /></td>
            <td class="auto-style28"><img src="images/dms2.png" class="auto-style27" /></td>
            <td class="auto-style26"><img src="images/wall.jpg" class="auto-style27" /></td>
        </tr>
        </table>
</asp:Content>

