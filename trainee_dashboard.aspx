<%@ Page Title="" Language="C#" MasterPageFile="~/trainee_dash_master.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void btn_assessments_Click(object sender, EventArgs e)
    {
        Response.Redirect("assess.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["candidate_name"]==null)
        {
            Response.Redirect("index.html");
        }
        else
        {
            lbl_candidate_name.Text = Session["candidate_name"].ToString();
        }
    }

    protected void btn_tasks_Click(object sender, EventArgs e)
    {
        Response.Redirect("trainee_tasks.aspx");
    }

    protected void btn_discussion_board_Click(object sender, EventArgs e)
    {
        Response.Redirect("upload_candidates_posts.aspx");
    }

    protected void btn_announcements_Click(object sender, EventArgs e)
    {
        Response.Redirect("announcements.aspx");
    }

    protected void btn_materials_Click(object sender, EventArgs e)
    {
        Response.Redirect("materials.aspx");
    }

    protected void btn_trainee_profile_Click(object sender, EventArgs e)
    {
        Response.Redirect("trainee_profile.aspx");
    }

    protected void btn_dms_Click(object sender, EventArgs e)
    {
        Response.Redirect("materials_dms.aspx");
    }

    protected void btn_setting_objectives_Click(object sender, EventArgs e)
    {
        Response.Redirect("trainee_tasks.aspx");
       

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5 {
            width: 627px;
            border: 3px solid #003399;
        }
        .auto-style7 {
            height: 31px;
            text-align: center;
            width: 191px;
        }
        .auto-style9 {
            font-size: large;
            color: black;
        }
        .auto-style10 {
            text-align: center;
            height: 40px;
            width: 191px;
        }
        .auto-style14 {
        height: 31px;
            width: 190px;
        }
    .auto-style16 {
        width: 170px;
        height: 156px;
    }
    .auto-style17 {
        width: 170px;
        height: 155px;
    }
    .auto-style18 {
            font-weight: bold;
            color: #000000;
            background-color: #FFFFFF;
            border-style:none;
        }
        .auto-style19 {
            width: 170px;
            height: 155px;
            float: left;
        }
    .auto-style20 {
        width: 170px;
        height: 155px;
    }
        .auto-style21 {
            height: 40px;
            width: 190px;
        }
        .auto-style22 {
            text-align: center;
            width: 190px;
        }
        .auto-style23 {
            height: 31px;
            text-align: center;
            width: 190px;
        }
        .auto-style25 {
            width: 190px;
        }
        .auto-style26 {
            width: 191px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p class="auto-style2">
        <br />
        <span class="auto-style9"><strong>Welcome
        <asp:Label ID="lbl_candidate_name" runat="server"></asp:Label>
        </strong></span></p>
    <table class="auto-style5">
        <tr>
            <td class="auto-style21">
                <asp:Button ID="btn_trainee_profile" runat="server" Text="Trainee Profile" CssClass="auto-style18" OnClick="btn_trainee_profile_Click" Width="185px" />
            </td>
            <td class="auto-style21">
                <strong>
                <asp:Button ID="btn_tasks" runat="server" Text="Tasks" CssClass="auto-style18" OnClick="btn_tasks_Click" Width="185px" />
                </strong>
            </td>
            <td class="auto-style10">
                <strong>
                <asp:Button ID="btn_announcements" runat="server" Text="Announcements" CssClass="auto-style18" OnClick="btn_announcements_Click" Width="185px" />
                </strong>
            </td>
        </tr>
        <tr>
            <td class="auto-style22"><img src="images/profile2.jpg" class="auto-style19" />&nbsp;</td>
            <td class="auto-style25"><img src="images/tasks.jpg" class="auto-style17" />&nbsp;</td>
            <td class="auto-style26"><img src="images/announce.jpg" class="auto-style16" />&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style23">
                <strong>
                <asp:Button ID="btn_assessments" runat="server" OnClick="btn_assessments_Click" Text="Assessments" CssClass="auto-style18" Width="185px" />
                </strong>
            </td>
            <td class="auto-style14">
                <strong>
                <asp:Button ID="btn_materials" runat="server" Text="Materials" CssClass="auto-style18" OnClick="btn_materials_Click" Width="185px" />
                </strong>
            </td>
            <td class="auto-style7">
                <strong>
                <asp:Button ID="btn_dms" runat="server" Text="DMS" CssClass="auto-style18" Width="185px" OnClick="btn_dms_Click" />
                </strong>
            </td>
        </tr>
        <tr>
            <td class="auto-style25"><img src="images/assessments.png" class="auto-style17" />&nbsp;</td>
            <td class="auto-style25"><img src="images/materials.png" class="auto-style17" />&nbsp;</td>
            <td class="auto-style26"><img src="images/dms2.png" class="auto-style17" />&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style25">
                <strong>
                <asp:Button ID="btn_program_structure" runat="server" Text="Program Structure" CssClass="auto-style18" Width="185px" />
                </strong>
            </td>
            <td class="auto-style25">
                <strong>
                <asp:Button ID="btn_discussion_board" runat="server" Text="Discussion Board" CssClass="auto-style18" OnClick="btn_discussion_board_Click" Width="185px" />
                </strong>
            </td>
            <td class="auto-style26">
                <strong>
                <asp:Button ID="btn_setting_objectives" runat="server" Text="Setting Objectivies" CssClass="auto-style18" Width="185px" OnClick="btn_setting_objectives_Click" />
                </strong>
            </td>
        </tr>
        <tr>
            <td class="auto-style25"><img src="images/analysis.png" class="auto-style17" />&nbsp;</td>
            <td class="auto-style25"><img src="images/wall.jpg" class="auto-style17" />&nbsp;</td>
            <td class="auto-style26"><img src="images/obj.png" class="auto-style20" /></td>
        </tr>
    </table>
</asp:Content>

