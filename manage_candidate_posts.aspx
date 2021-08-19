<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dash_master.master" UnobtrusiveValidationMode="None" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Configuration" %>


<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);

    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Label lbl_post_id = (Label)e.Item.FindControl("post_id");
        string post_id= lbl_post_id.Text;
        txt_post_id.Text = post_id;

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            if(Session["admin_code"]==null)
            {
                Response.Redirect("index.html");
            }

            string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(my_connection);
            con.Open();
            string sql11 = "select post_id,admin_name,trainer_name, mentor_name, candidate_name,  post,post_upload_date,post_path,count from posts left join admins on dbo.admins.admin_code = dbo.posts.admin_code left join trainers on dbo.trainers.trainer_file_number=dbo.posts.trainer_file_number left join mentors on dbo.mentors.mentor_file_number=dbo.posts.mentor_file_number left join candidates on dbo.candidates.candidate_code=dbo.posts.candidate_code where post_type=3 order by post_upload_date desc " ;
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


    }

    protected void btn_admin_dashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("admin_dashboard.aspx");
    }

    protected void accept (object sender, EventArgs e)
    {
        txt_post_id.Visible = true;
        btn_confirm_acception.Visible = true;
        btn_confirm_reject.Visible = true;
        btn_cancel.Visible = true;
         
      }

     

    protected void reject (object sender, EventArgs e)
    {
        txt_post_id.Visible = true;
        btn_confirm_acception.Visible = true;
        btn_confirm_reject.Visible = true;
        btn_cancel.Visible = true;
                
    }

    

    protected void btn_confirm_acception_Click(object sender, EventArgs e)
    {
        con.Open();
          string sql2 = "UPDATE posts SET post_type = 1 WHERE post_id ='"+txt_post_id.Text+"' ";
          SqlCommand cmd2 = new SqlCommand(sql2, con);
          int t=cmd2.ExecuteNonQuery();
          if(t>0)
          {
              Response.Write("Post Accepted");
            lbl_status.ForeColor = System.Drawing.Color.Green;
            lbl_status.Text = "Post Accepted";
            con.Close();
              Response.AddHeader("REFRESH", "1;URL=manage_candidate_posts.aspx");

          }
          else
          {
              Response.Write("no info updated");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "no info updated";
            con.Close();
            Response.AddHeader("REFRESH", "1;URL=manage_candidate_posts.aspx");
          }
          

    }

    protected void btn_confirm_reject_Click(object sender, EventArgs e)
    {
        con.Open();
          string sql2 = "UPDATE posts SET post_type = 2 WHERE post_id ='"+txt_post_id.Text+"' ";
          SqlCommand cmd2 = new SqlCommand(sql2, con);
          int t=cmd2.ExecuteNonQuery();
          if(t>0)
          {
              Response.Write("Post Rejected");
            lbl_status.ForeColor = System.Drawing.Color.Green;
            lbl_status.Text = "Post Rejected";
            con.Close();
              Response.AddHeader("REFRESH", "1;URL=manage_candidate_posts.aspx");

          }
          else
          {
              Response.Write("no info updated");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "no info updated";
            con.Close();
            Response.AddHeader("REFRESH", "1;URL=manage_candidate_posts.aspx");
          }
         
    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {

        Response.Write("Action Cancelled");
        Response.AddHeader("REFRESH", "1;URL=manage_candidate_posts.aspx");

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5 {
            font-weight: bold;
            display: inline-block;
            color: #FFFFFF;
            background-color: #000000;
        }
        .auto-style6 {
            font-size: x-large;
        }
        .button {
  background-color: #FF9900;
  border: none;
  color: #FFFFFF;
  padding: 10px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 16px;
}
        .auto-style7 {
            color: #FFFFFF;
            background-color: #000000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <br />
        <strong>
        <asp:Button ID="btn_admin_dashboard" runat="server" CssClass="auto-style5" Text="Admin Dashboard" CausesValidation="False" OnClick="btn_admin_dashboard_Click" />
        &nbsp;
            <div>Post Ref#:<asp:TextBox ID="txt_post_id" runat="server" Visible="False" Width="87px" ReadOnly="True" CssClass="auto-style7"></asp:TextBox></div>
        &nbsp;<asp:Button ID="btn_confirm_acception" runat="server" CssClass="auto-style5" Text="Confirm Acception" Visible="False" OnClick="btn_confirm_acception_Click" />
        &nbsp;</strong><asp:Button ID="btn_confirm_reject" runat="server" Text="Confirm Rejection" CssClass="auto-style5" OnClick="btn_confirm_reject_Click" Visible="False" />
&nbsp;<strong><asp:Button ID="btn_cancel" runat="server" Text="Cancel Action" CssClass="auto-style5" OnClick="btn_cancel_Click" Visible="False" />
        </strong>
    </p>
    <p class="auto-style6">
        <strong>All Pending Posts:</strong></p>
    <p>
        
        <asp:Label ID="lbl_status" runat="server" Text=""></asp:Label>
        
        <asp:ListView ID="ListView1" runat="server"  DataKeyNames="post_id" OnItemCommand="ListView1_ItemCommand" >
            <ItemTemplate>
                                    <div>
                                        <table>
                                           <tr style="background-color:#DCDCDC;color: #000000; font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-size:x-large;"><td> <asp:Label ID="post" Text='<%# Eval("post") %>' runat="server" /></td></tr>
                                            <tr style="background-color:#FFF8DC; font-family:Tahoma; font-size:small;"><td>  <p>Attchment : <asp:HyperLink runat="server"  NavigateUrl='<%#Eval("post_path") %>'>DownLoad</asp:HyperLink> </td></tr>
                                                <tr style=" font-family:Tahoma; font-size:x-small;"><td>  <p> Posted at : <asp:Label ID="post_upload_date" Text='<%# Eval("post_upload_date", "{0:yyyy-MM-dd}") %>' runat="server"   /> --- by candidate: <%#Eval("candidate_name") %> --- by Trainer: <%#Eval("trainer_name") %> --- by Mentor: <%#Eval("mentor_name") %> /Ref#:<asp:Label ID="post_id" Text='<%# Eval("post_id") %>' runat="server" /></p></td></tr>
                                            <tr style="display:inline-block;"><td>  <p> <asp:Button CssClass="button"  ID="accept" runat="server" Text="Accept" OnClick="accept" /> <asp:Button CssClass="button" ID="reject" runat="server" Text="Reject" OnClick="reject" /> </p></td></tr>
                                                                                    
                                        </table>
                                     </div>

            </ItemTemplate>

        </asp:ListView>
    </p>
</asp:Content>

