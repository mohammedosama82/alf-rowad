<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dash_master.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
    // SqlConnection con = new SqlConnection("server=NEW-LAPTOP\\SQLEXPRESS;database=rwad; integrated security=sspi");
   SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void btn_assessments_Click(object sender, EventArgs e)
    {
        Response.Redirect("assessments.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["admin_name"]==null)
        {
            Response.Redirect("index.html");
        }
        else
        {
            lbl_admin_name.Text = Session["admin_name"].ToString();
        }
    }




    protected void btn_add_new_assessment_Click(object sender, EventArgs e)
    {
        Response.Redirect("add_assess.aspx");
    }



    protected void btn_update_candidates_Click(object sender, EventArgs e)
    {
        Response.Redirect("view_all_candidates.aspx");
    }

    protected void course_evaluation_analysis_Click(object sender, EventArgs e)
    {
        Response.Redirect("course_feedback_analysis.aspx");
    }

    protected void btn_absent_registeration_Click(object sender, EventArgs e)
    {
        Response.Redirect("absent_registeration.aspx");
    }

    protected void Unnamed1_Click(object sender, EventArgs e)
    {

        Response.Redirect("upload_files.aspx");
    }

    protected void btn_post_to_discussion_group_Click(object sender, EventArgs e)
    {
        Response.Redirect("upload_posts.aspx");
    }

    protected void btn_post_announcements_Click(object sender, EventArgs e)
    {
        Response.Redirect("upload_announcements.aspx");
    }

    protected void btn_trainers_Click(object sender, EventArgs e)
    {
        Response.Redirect("add_trainer_mentor.aspx");
    }

    protected void btn_courses_Click(object sender, EventArgs e)
    {
        Response.Redirect("add_courses.aspx");
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
            width: 635px;
            border: 3px solid #003399;
        }
        .auto-style8 {
            font-weight: bold;
            color: #000000;
            background-color: #FFFFFF;
        }
        .auto-style9 {
            font-size: large;
            color: #000000;
        }
        .auto-style20 {
            height: 40px;
            width: 193px;
        }
        .auto-style22 {
            height: 31px;
            text-align: center;
            width: 193px;
        }
        .auto-style24 {
            width: 186px;
            height: 135px;
            
            float: left;
        }
        .auto-style25 {
            width: 186px;
            height: 135px;
            float: left;
        }
        .auto-style26 {
            text-align: center;
            height: 40px;
            width: 192px;
        }
        .auto-style27 {
            text-align: center;
            width: 192px;
        }
        .auto-style28 {
            height: 31px;
            text-align: center;
            width: 192px;
        }
        .auto-style29 {
            width: 192px;
        }
        .auto-style34 {
            width: 193px;
            text-align: center;
        }
        .auto-style35 {
            width: 193px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p class="auto-style2">
        <br />
        <span class="auto-style9"><strong>Welcome
        <asp:Label ID="lbl_admin_name" runat="server"></asp:Label>
        </strong></span></p>
    <table class="auto-style5">
        <tr>
            <td class="auto-style26">
                <asp:Button ID="btn_add_new_assessment" runat="server" Text="Add Assessments" CssClass="auto-style8" OnClick="btn_add_new_assessment_Click" Width="185px" BorderStyle="None" />
            </td>
            <td class="auto-style26">
                <strong>
                <asp:Button ID="btn_update_candidates" runat="server" CssClass="auto-style8" OnClick="btn_update_candidates_Click" Text="Update Candidates" Width="185px" BorderStyle="None" />
                </strong>
            </td>
            <td class="auto-style20">
                <strong>
                <asp:Button ID="btn_absent_registeration" runat="server" Text="Register Absent" CssClass="auto-style8" OnClick="btn_absent_registeration_Click" Width="185px" BorderStyle="None" />
                </strong>
            </td>
        </tr>
        <tr>
            <td class="auto-style27"><img src="images/assessments.png" class="auto-style24" />&nbsp;</td>
            <td class="auto-style27"><img src="images/update.png" class="auto-style24" />&nbsp;</td>
            <td class="auto-style34"><img src="images/absent.jpg" class="auto-style24" />&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style28">
                <strong>
                <asp:Button runat="server" CssClass="auto-style8" ID="course_evaluation_analysis" Text="Feedback Analysis" OnClick="course_evaluation_analysis_Click" Width="185px" BorderStyle="None" />
                </strong>
            </td>
            <td class="auto-style28">
                <strong>
                <asp:Button runat="server" CssClass="auto-style8" Text="Upload Materials" OnClick="Unnamed1_Click" Width="185px" BorderStyle="None" />
                </strong>
            </td>
            <td class="auto-style22">
                <strong>
                <asp:Button runat="server" CssClass="auto-style8" ID="btn_post_to_discussion_group" OnClick="btn_post_to_discussion_group_Click" Text="Program Wall" Width="185px" BorderStyle="None" />
                </strong>
            </td>
        </tr>
        <tr>
            <td class="auto-style27"><img src="images/analysis.png" class="auto-style24" />&nbsp;</td>
            <td class="auto-style27"><img src="images/materials.PNG" class="auto-style25" />&nbsp;</td>
            <td class="auto-style34"><img src="images/wall.jpg" class="auto-style24" />&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style29">
                <strong>
                <asp:Button runat="server" CssClass="auto-style8" ID="btn_post_announcements" Text="Post Announcements" OnClick="btn_post_announcements_Click" Width="185px" BorderStyle="None" />
                </strong>
            </td>
            <td class="auto-style29">
                <strong>
                <asp:Button runat="server" CssClass="auto-style8" Width="185px" ID="btn_trainers" OnClick="btn_trainers_Click" Text="Trainers &amp; Mentors" BorderStyle="None" />
                </strong>
            </td>
            <td class="auto-style35"><asp:Button runat="server" CssClass="auto-style8" Width="185px" ID="btn_courses" OnClick="btn_courses_Click" Text="Courses" BorderStyle="None" /></td>
        </tr>
        <tr>
            <td class="auto-style27"><img src="images/announce.jpg" class="auto-style24" />&nbsp;</td>
            <td class="auto-style27"><img src="images/trainer.jpg" class="auto-style25" />&nbsp;</td>
            <td class="auto-style35"><img src="images/cources.png" class="auto-style25" />&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style29">&nbsp;</td>
            <td class="auto-style35">&nbsp;</td>
        </tr>
    </table>
</asp:Content>

