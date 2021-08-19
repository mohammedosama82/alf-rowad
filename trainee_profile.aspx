<%@ Page Title="" Language="C#" MasterPageFile="~/trainee_dash_master.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["candidate_code"]==null)
        {
            Response.Redirect("index.html");
        }
        else
        {
            string sql10 = "select candidate_name, status_type, candidate_code, candidate_email, candidate_telephone, candidate_address, candidate_city, candidate_university, candidate_college, candidate_qualification, candidate_specialization, candidate_status,candidate_batch_number,  candidate_file_number, candidate_notes from candidates inner join status on dbo.status.status_id = dbo.candidates.candidate_status where candidate_code='"+Session["candidate_code"].ToString()+"'";
            con.Open();
            SqlCommand cmd10 = new SqlCommand(sql10, con);
            SqlDataReader read10= cmd10.ExecuteReader();
            while (read10.Read())
            {
                lbl_candidate_address.Text = (read10["candidate_address"].ToString());
               // lbl_candidate_batch_number.Text = (read10["candidate_batch_number"].ToString());
                lbl_candidate_city.Text = (read10["candidate_city"].ToString());
                lbl_candidate_code.Text = (read10["candidate_code"].ToString());
                lbl_candidate_college.Text = (read10["candidate_college"].ToString());
                lbl_candidate_email.Text = (read10["candidate_email"].ToString());
                lbl_candidate_file_number.Text = (read10["candidate_file_number"].ToString());
                lbl_candidate_name.Text = (read10["candidate_name"].ToString());
                lbl_candidate_notes.Text = (read10["candidate_notes"].ToString());
                lbl_candidate_qualification.Text = (read10["candidate_qualification"].ToString());
                lbl_candidate_specialization.Text = (read10["candidate_specialization"].ToString());
                lbl_candidate_status.Text = (read10["status_type"].ToString());
                lbl_candidate_telephone.Text = (read10["candidate_telephone"].ToString());
                 lbl_candidate_university.Text = (read10["candidate_university"].ToString());
                 
            }
            read10.Close();
            con.Close();
            string sql11 = "select count(candidate_code)  as absense_days from candidate_absent where candidate_code='"+Session["candidate_code"].ToString()+"' ";
            con.Open();
            SqlCommand cmd11 = new SqlCommand(sql11, con);
            SqlDataReader read11= cmd11.ExecuteReader();
            while (read11.Read())
            {
                
               lbl_candidate_batch_number.Text = (read11["absense_days"].ToString());
               
                 
            }
            read11.Close();
            con.Close();
        }

    }

    protected void btn_trainee_dashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("trainee_dashboard.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .auto-style5 {
            overflow: hidden;
            background-color: #e9e9e9;
            font-size: x-large;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <div class="auto-style5">
            <strong>Trainee Profile
</strong>
</div>
        <br /> <br /><span >Name:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_name" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label>
        <br /> <br />
        <span >Email:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_email" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >Telephone:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_telephone" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >Code:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_code" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >File#:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_file_number" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >Status:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_status" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >Address:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_address" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >City:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_city" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >University:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_university" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >College:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_college" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >Qualification:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_qualification" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >Specialization:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_specialization" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >Number Of Absense Days:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_batch_number" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        <span >Notes:</span>&nbsp;&nbsp;<asp:Label ID="lbl_candidate_notes" CssClass=" label warning" runat="server" Text="Label" style="color: #000000; background-color: #FFFFFF"></asp:Label><br /><br />
        
    <asp:Button ID="btn_trainee_dashboard" Text="Trainee Dashboard" class="btn" runat="server" CssClass="fa fa-bars" OnClick="btn_trainee_dashboard_Click" style="color: #FFFFFF; background-color: #000000"> </asp:Button>
    </p>
</asp:Content>

