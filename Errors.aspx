<%@ Page Title="" Language="C#" MasterPageFile="~/body_master.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {


        // con.Close();

        if (Session["error"] != null)
        {
            if (Session["error"].ToString() == "assessment_session_terminate")
            {
                lbl_assessment_session_terminate.Visible = true;
                Session.Clear();
            }
            else if (Session["error"].ToString() == "not_your_session")
            {
                lbl_not_your_session.Visible = true;
                Session.Clear();
            }
            else if (Session["error"].ToString() == "diff_assessment")
            {
                lbl_diff_assessment.Visible = true;

            }
            else if (Session["error"].ToString() == "invalid_code")
            {
                lbl_invalid_code.Visible = true;
             

            }
            else if (Session["error"].ToString() == "invalid_feedback")
            {
                lbl_invalid_feedback.Visible = true;
                

            }

            else
            {
                // Response.Write("Unknown Error");
                lbl_status.Text = "Unknown Error! - Please Try Later";
            }
        }
        else
        {
            lbl_status.Text = "Server Error! :(    Please try Later or contact to the administrator to help you  ";
        }

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5 {
            color: #CC0000;
        }
        .auto-style6 {
            color: #FF0000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p class="auto-style2">
        <br />
        <strong>
        <asp:Label ID="lbl_assessment_session_terminate" runat="server" CssClass="auto-style5" Text="Your Assessment Session Terminated" Visible="False"></asp:Label>
        </strong>
    </p>
    <p class="auto-style2">
        <strong>
        <asp:Label ID="lbl_not_your_session" runat="server" CssClass="auto-style5" Text="It Is Not Your Session - Please Press Assessments Link And Try Again" Visible="False"></asp:Label>
        </strong>
    </p>
    <p class="auto-style2">
        <strong>
        <asp:Label ID="lbl_diff_assessment" runat="server" CssClass="auto-style5" Text="You Try To access different assessment" Visible="False"></asp:Label>
        </strong>
    </p>
    <p class="auto-style2">
        <strong>
        <asp:Label ID="lbl_invalid_code" runat="server" CssClass="auto-style5" Text="You Try To access by Invalid authintication or the account is blocked because unusual activity" Visible="False"></asp:Label>
        </strong>
    </p>
    <p class="auto-style2">
        <strong>
        <asp:Label ID="lbl_invalid_feedback" runat="server" CssClass="auto-style5" Text="No Feedback to that course" Visible="False"></asp:Label>
        </strong>
    </p>
    <div>
        <strong>
        <asp:Label ID="lbl_status" runat="server" Text="" CssClass="auto-style6"></asp:Label>
        &nbsp;<asp:Label ID="lbl_status0" runat="server" Text="" CssClass="auto-style6"></asp:Label>
        &nbsp;<asp:Label ID="lbl_status1" runat="server" Text="" CssClass="auto-style6"></asp:Label>
        &nbsp;<asp:Label ID="lbl_status2" runat="server" Text="" CssClass="auto-style6"></asp:Label>
        </strong>
    </div>
</asp:Content>

