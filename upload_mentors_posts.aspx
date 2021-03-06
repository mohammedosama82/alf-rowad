<%@ Page Title="" Language="C#" MasterPageFile="~/mentor_dash_master.master" UnobtrusiveValidationMode="None" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
   SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);


    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        lbl_status.Text = "";
        txt_post.Text = "";
        FileUpload.Attributes.Clear();

    }

    protected void btn_post_Click(object sender, EventArgs e)
    {
       lbl_status.Text = "";
        
        if (Session["mentor_file_number"] != null)
        {

            if(txt_post.Text!=null)
            {
                if (FileUpload.HasFile)
                {
                    string ext = System.IO.Path.GetExtension(FileUpload.FileName);
                    if (ext != ".pdf" && ext != ".png" && ext != ".jpg" && ext != ".docx" && ext != ".doc" && ext != ".xlsx" && ext != ".xls" && ext != ".pptx" && ext != ".ppt")
                    {
                        Response.Write("This Type of File Not Allowed");
                        lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "This Type of File Not Allowed";
                        return;
                    }

                    string fn = "";
                    fn = fn + Session["mentor_file_number"].ToString() + "_" + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString();
                    FileUpload.SaveAs(Server.MapPath("posts_files") + "\\" + fn + ext);
                    string path = "~\\posts_files\\" + fn + ext;

                    string sql = "insert into posts (mentor_file_number, post, post_upload_date, post_path,count, post_type ) values (@mentor_file_number, @post, @post_upload_date, @post_path,@count, @post_type)";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@mentor_file_number", Session["mentor_file_number"].ToString());
                    cmd.Parameters.AddWithValue("@post",HttpUtility.HtmlEncode( txt_post.Text));
                    cmd.Parameters.AddWithValue("@post_upload_date", DateTime.Now.ToString("yyyy-MM-dd"));
                    cmd.Parameters.AddWithValue("@post_path", path);
                    cmd.Parameters.AddWithValue("@count", 0);
                    cmd.Parameters.AddWithValue("@post_type", 3);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    lbl_message.ForeColor = System.Drawing.Color.Green;
                    lbl_message.Text = "Successful Posted to admin for checking";
                    txt_post.Text = "";
                    FileUpload.Attributes.Clear();
                    Response.AddHeader("REFRESH", "3;URL=upload_mentors_posts.aspx");
                }
                else
                {
                    string sql = "insert into posts (mentor_file_number, post, post_upload_date, count, post_type ) values (@mentor_file_number, @post, @post_upload_date, @count, @post_type)";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@mentor_file_number", Session["mentor_file_number"].ToString());
                    cmd.Parameters.AddWithValue("@post",HttpUtility.HtmlEncode( txt_post.Text));
                    cmd.Parameters.AddWithValue("@post_upload_date", DateTime.Now.ToString("yyyy-MM-dd"));
                    cmd.Parameters.AddWithValue("@count", 0);
                    cmd.Parameters.AddWithValue("@post_type", 3);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    lbl_message.ForeColor = System.Drawing.Color.Green;
                    lbl_message.Text = "Successful Posted to admin for checking";
                    txt_post.Text = "";
                    FileUpload.Attributes.Clear();
                    Response.AddHeader("REFRESH", "3;URL=upload_mentors_posts.aspx");
                }
            }
            else
            {
                lbl_message.Text = "Please Add Text inside Post Area";
                lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "Please Add Text inside Post Area";
                return;
            }
            
        }
        else
        {
            Response.Redirect("index.html");
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lbl_status.Text = "";

        if(Session["mentor_file_number"]==null )
        {
            Response.Redirect("index.html");
        }

        string my_connection =ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(my_connection);
        con.Open();
        string sql11 = "select post_id,admin_name,trainer_name, mentor_name, candidate_name,  post,post_upload_date,post_path,count from posts left join admins on dbo.admins.admin_code = dbo.posts.admin_code left join trainers on dbo.trainers.trainer_file_number=dbo.posts.trainer_file_number left join mentors on dbo.mentors.mentor_file_number=dbo.posts.mentor_file_number left join candidates on dbo.candidates.candidate_code=dbo.posts.candidate_code where post_type=1 order by post_upload_date desc " ;
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





</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">


        .auto-style5 {
            font-weight: bold;
            display:inline-block;
        }
        .auto-style6 {
            color: #FF0000;
        }
        .auto-style7 {
            font-size: x-large;
        }
        .auto-style9 {
            font-weight: bold;
            display: inline-block;
            color: #FFFFFF;
            background-color: #000000;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <strong>Write Post Here </strong>
    </p>
    <p>
        <strong>
                <asp:TextBox ID="txt_post" autocomplete="off" runat="server" CssClass="auto-style5" TextMode="MultiLine" Width="581px" Height="202px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_post" CssClass="auto-style6" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                </strong></p>
    <p>
        <strong>
        <asp:FileUpload ID="FileUpload" runat="server" CssClass="auto-style5" />
        </strong></p>
    <p>
        <strong>
        <asp:Button ID="btn_post" runat="server" CssClass="auto-style9" Text="Post" OnClick="btn_post_Click" Width="70px" />
        </strong>&nbsp;<strong><asp:Button ID="btn_cancel" runat="server" CssClass="auto-style9" OnClick="btn_cancel_Click" Text="Cancel" CausesValidation="False" Width="70px" />
        <asp:Label ID="lbl_message" runat="server"></asp:Label>
        </strong>
        <asp:Label ID="lbl_status" runat="server" Text=""></asp:Label>
    </p>
    <p>
        &nbsp;</p>
    <p class="auto-style7">
        <strong>Posts Wall
        </strong></p>
    <p class="auto-style7">
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="post_id" >
            <ItemTemplate>
                                    <div>
                                        <table>
                                           <tr style="background-color:#DCDCDC;color: #000000; font-family:'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; font-size:x-large;"><td> <asp:Label ID="post" Text='<%# Eval("post") %>' runat="server" /></td></tr>
                                            <tr style="background-color:#FFF8DC; font-family:Tahoma; font-size:small;"><td>  <p>Attchment : <asp:HyperLink runat="server"  NavigateUrl='<%#Eval("post_path") %>'>DownLoad</asp:HyperLink> </td></tr>
                                                <tr style=" font-family:Tahoma; font-size:x-small;"><td>  <p> Posted at : <asp:Label ID="post_upload_date" Text='<%# Eval("post_upload_date", "{0:yyyy-MM-dd}") %>' runat="server"   /> --- by Candidate: <%#Eval("candidate_name") %> --- by Trainer: <%#Eval("trainer_name") %> --- by Mentor: <%#Eval("mentor_name") %> --- by admin: <%#Eval("admin_name") %> /Ref#:<%#Eval("post_id") %></p></td></tr>
                                           
                                                                                    
                                        </table>
                                     </div>

            </ItemTemplate>

        </asp:ListView>
    <br />
    </p>
    <p>
        &nbsp;</p>
</asp:Content>

