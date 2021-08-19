<%@ Page Title="" Language="C#" MasterPageFile="~/trainee_dash_master.master" UnobtrusiveValidationMode="None" MaintainScrollPositionOnPostback="true" %>
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
        lbl_today.Text = DateTime.Now.ToString("yyyy-MM-dd");

        if(Session["candidate_name"]==null)
        {
            Response.Redirect("index.html");
        }
        else
        {
            lbl_trainee_name.Text = Session["candidate_name"].ToString();
        }

        con.Open();
        
        string sql11 = "select course_title,course_code, course_start_at, course_end_at, course_delivery_medium, course_capability, course_level, course_provider, course_pass_criteria, course_link, course_evaluation, course_post_assessment, course_pre_assessment  from dbo.daily_schedule  where course_date='"+lbl_today.Text+"'" ;
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




    protected void btn_daily_schedule_Click(object sender, EventArgs e)
    {
        q1.ClearSelection();
        q2.ClearSelection();
        q3.ClearSelection();
        q4.ClearSelection();
        q5.ClearSelection();
        q6.ClearSelection();
        q7.ClearSelection();
        q8.ClearSelection();
        q9.ClearSelection();
        q10.ClearSelection();
        txt_q11.Text = "";
        txt_q12.Text = "";
        self_satisfaction.ClearSelection();
        txt_goals_completed_activities.Text = "";
        txt_goals_in_progress_activities.Text = "";
        txt_goals_future_activities.Text = "";
        txt_goals_improvment.Text = "";
        txt_goals_suggestions.Text = "";
        Label1.Visible = false;
        Label2.Visible = false;
        btn_goals_submit.Enabled = true;
        lbl_evaluation.Visible = false;
        lbl_evaluation2.Visible = false;
        btn_submit.Enabled = true;


        MultiView1.ActiveViewIndex = 0;


    }

    protected void btn_trainee_feedback_Click(object sender, EventArgs e)
    {

        MultiView1.ActiveViewIndex = 1;
    }

    protected void btn_setting_evaluation_Click(object sender, EventArgs e)
    {
        if(Session["candidate_name"]==null)
        {
            Response.Redirect("index.html");
        }
        if(Session["candidate_code"]==null)
        {
            Response.Redirect("index.html");
        }
        txt_goals_candidate_name.Text = lbl_trainee_name.Text;
        txt_goals_candidate_code.Text = Session["candidate_code"].ToString();
        txt_goals_today_date.Text = lbl_today.Text;
        MultiView1.ActiveViewIndex = 2;

        con.Open();
        string sql = "SELECT candidate_code, goals_month, goals_self_satisfaction, goals_completed_activities, goals_in_progress_activities, goals_future_activities, goals_improvment, goals_suggestions  from goals where candidate_code='"+txt_goals_candidate_code.Text+"' and goals_month='"+DropDownList1.SelectedValue.ToString()+"' ";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader read= cmd.ExecuteReader();
        if(read.HasRows==true)
        {

            btn_goals_submit.Enabled = false;
            Label2.Visible = true;
            while (read.Read())
            {
                self_satisfaction.SelectedValue = (read["goals_self_satisfaction"].ToString());
                txt_goals_completed_activities.Text = (read["goals_completed_activities"].ToString());
                txt_goals_in_progress_activities.Text = (read["goals_in_progress_activities"].ToString());
                txt_goals_future_activities.Text = (read["goals_future_activities"].ToString());
                txt_goals_improvment.Text = (read["goals_improvment"].ToString());
                txt_goals_suggestions.Text = (read["goals_suggestions"].ToString());
            }
        }
        read.Close();
        con.Close();


    }

    protected void go_to_assessment(object sender, EventArgs e)
    {
        Response.Redirect("assess.aspx");
    }



    protected void ListView1_SelectedIndexChanging(object sender, ListViewSelectEventArgs e)
    {

    }

    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if(Session["candidate_name"]==null)
        {
            Response.Redirect("index.html");
        }
        else
        {
            Label lbl_course_title = (Label)e.Item.FindControl("course_title");
            string course_title = lbl_course_title.Text;
            txt_course_title.Text = course_title;
            Label lbl_course_code = (Label)e.Item.FindControl("course_code");
            string course_code = lbl_course_code.Text;
            txt_course_code.Text = course_code;
            Label lbl_course_provider = (Label)e.Item.FindControl("course_provider");
            string course_provider = lbl_course_provider.Text;
            txt_course_provider.Text = course_provider;
            txt_course_date.Text = lbl_today.Text;
            txt_trainee_name.Text = lbl_trainee_name.Text;
            txt_trainee_code.Text = Session["candidate_code"].ToString();

        }

        con.Open();
        string sql = "SELECT course_code, trainee_code from course_evaluation where course_code='"+txt_course_code.Text+"' and trainee_code='"+txt_trainee_code.Text+"' ";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader read= cmd.ExecuteReader();
        if(read.HasRows==true)
        {

            btn_submit.Enabled = false;
            lbl_evaluation2.Visible = true;
        }
        read.Close();

        con.Close();


    }

    protected void btn_submit_Click(object sender, EventArgs e)
    {
        string q1_eval = q1.SelectedValue.ToString();
        string q2_eval = q2.SelectedValue.ToString();
        string q3_eval = q3.SelectedValue.ToString();
        string q4_eval = q4.SelectedValue.ToString();
        string q5_eval = q5.SelectedValue.ToString();
        string q6_eval = q6.SelectedValue.ToString();
        string q7_eval = q7.SelectedValue.ToString();
        string q8_eval = q8.SelectedValue.ToString();
        string q9_eval = q9.SelectedValue.ToString();
        string q10_eval = q10.SelectedValue.ToString();
        string q11_eval = HttpUtility.HtmlEncode(txt_q11.Text);
        string q12_eval = HttpUtility.HtmlEncode(txt_q12.Text);
        DateTime dt = Convert.ToDateTime(txt_course_date.Text);
        string dt2 = dt.ToString("yyyy-MM-dd");
        string sql4 = "insert into course_evaluation (course_code,trainee_code, course_date, q1_eval, q2_eval, q3_eval, q4_eval, q5_eval, q6_eval, q7_eval, q8_eval, q9_eval, q10_eval, q11_eval, q12_eval ) values (@course_code,@trainee_code, @course_date, @q1_eval, @q2_eval, @q3_eval, @q4_eval, @q5_eval, @q6_eval, @q7_eval, @q8_eval, @q9_eval, @q10_eval, @q11_eval, @q12_eval)";
        SqlCommand cmd4 = new SqlCommand(sql4, con);
        cmd4.Parameters.AddWithValue("@course_code", txt_course_code.Text);
        cmd4.Parameters.AddWithValue("@trainee_code", txt_trainee_code.Text);
        cmd4.Parameters.AddWithValue("@course_date", dt2);
        cmd4.Parameters.AddWithValue("@q1_eval", q1_eval);
        cmd4.Parameters.AddWithValue("@q2_eval", q2_eval);
        cmd4.Parameters.AddWithValue("@q3_eval", q3_eval);
        cmd4.Parameters.AddWithValue("@q4_eval", q4_eval);
        cmd4.Parameters.AddWithValue("@q5_eval", q5_eval);
        cmd4.Parameters.AddWithValue("@q6_eval", q6_eval);
        cmd4.Parameters.AddWithValue("@q7_eval", q7_eval);
        cmd4.Parameters.AddWithValue("@q8_eval", q8_eval);
        cmd4.Parameters.AddWithValue("@q9_eval", q9_eval);
        cmd4.Parameters.AddWithValue("@q10_eval", q10_eval);
        cmd4.Parameters.AddWithValue("@q11_eval", q11_eval);
        cmd4.Parameters.AddWithValue("@q12_eval", q12_eval);
        con.Open();
        cmd4.ExecuteNonQuery();
        con.Close();
        lbl_evaluation.Visible = true;
        btn_submit.Enabled = false;


    }

    protected void btn_trainee_dashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("trainee_dashboard.aspx");
    }

    protected void btn_goals_submit_Click(object sender, EventArgs e)
    {
        string goals_self_satisfaction = self_satisfaction.SelectedValue.ToString();
        string goals_month = DropDownList1.SelectedValue.ToString();
        string goals_completed_activities =HttpUtility.HtmlEncode(txt_goals_completed_activities.Text.ToString()) ;
        string goals_in_progress_activities =HttpUtility.HtmlEncode(txt_goals_in_progress_activities.Text.ToString()) ;
        string goals_future_activities = HttpUtility.HtmlEncode(txt_goals_future_activities.Text.ToString());
        string goals_improvment =HttpUtility.HtmlEncode(txt_goals_improvment.Text.ToString()) ;
        string goals_suggestions =HttpUtility.HtmlEncode(txt_goals_suggestions.Text.ToString()) ;
        DateTime dt = Convert.ToDateTime(txt_goals_today_date.Text);
        string goals_date = dt.ToString("yyyy-MM-dd");
        string sql4 = "insert into goals(goals_self_satisfaction,goals_month, goals_completed_activities, goals_in_progress_activities, goals_future_activities, goals_improvment, goals_suggestions, goals_date, candidate_code) values (@goals_self_satisfaction, @goals_month, @goals_completed_activities, @goals_in_progress_activities, @goals_future_activities, @goals_improvment, @goals_suggestions, @goals_date, @candidate_code)";
        SqlCommand cmd4 = new SqlCommand(sql4, con);
        cmd4.Parameters.AddWithValue("@candidate_code", txt_goals_candidate_code.Text);
        cmd4.Parameters.AddWithValue("@goals_self_satisfaction", goals_self_satisfaction);
        cmd4.Parameters.AddWithValue("@goals_date", goals_date);
        cmd4.Parameters.AddWithValue("@goals_completed_activities", goals_completed_activities);
        cmd4.Parameters.AddWithValue("@goals_in_progress_activities", goals_in_progress_activities);
        cmd4.Parameters.AddWithValue("@goals_future_activities", goals_future_activities);
        cmd4.Parameters.AddWithValue("@goals_improvment", goals_improvment);
        cmd4.Parameters.AddWithValue("@goals_suggestions", goals_suggestions);
        cmd4.Parameters.AddWithValue("@goals_month", goals_month);
        con.Open();
        cmd4.ExecuteNonQuery();
        con.Close();
        Label1.Visible = true;
        btn_goals_submit.Enabled = false;

    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        con.Open();
        string sql = "SELECT candidate_code, goals_month, goals_self_satisfaction, goals_completed_activities, goals_in_progress_activities, goals_future_activities, goals_improvment, goals_suggestions  from goals where candidate_code='"+txt_goals_candidate_code.Text+"' and goals_month='"+DropDownList1.SelectedValue.ToString()+"' ";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader read= cmd.ExecuteReader();
        if(read.HasRows==true)
        {

            btn_goals_submit.Enabled = false;
            Label2.Visible = true;
            while (read.Read())
            {
                self_satisfaction.SelectedValue = (read["goals_self_satisfaction"].ToString());
                txt_goals_completed_activities.Text = (read["goals_completed_activities"].ToString());
                txt_goals_in_progress_activities.Text = (read["goals_in_progress_activities"].ToString());
                txt_goals_future_activities.Text = (read["goals_future_activities"].ToString());
                txt_goals_improvment.Text = (read["goals_improvment"].ToString());
                txt_goals_suggestions.Text = (read["goals_suggestions"].ToString());
            }
            read.Close();
            con.Close();
        }

        else
        {
            self_satisfaction.ClearSelection();
            txt_goals_completed_activities.Text = "";
            txt_goals_in_progress_activities.Text = "";
            txt_goals_future_activities.Text = "";
            txt_goals_improvment.Text = "";
            txt_goals_suggestions.Text = "";
            btn_goals_submit.Enabled = true;
            Label1.Visible = false;
            Label2.Visible = false;
            read.Close();
            con.Close();
        }

        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5 {
            width: 100%;
            border: 3px solid #003399
        }
        .auto-style8 {
            text-align: left;
        }
        .auto-style9 {
            width: 100%;
            border: 4px solid #003399;
        }
        .auto-style11 {
            width: 331px;
        }
        .auto-style13 {
            width: 266px;
            text-align: right;
        }
        .auto-style14 {
            text-align: right;
        }
        .auto-style15 {
            width: 150px;
            text-align: right;
        }
        .auto-style16 {
            width: 266px;
            text-align: right;
            height: 39px;
        }
        .auto-style17 {
            width: 331px;
            height: 39px;
        }
        .auto-style18 {
            width: 150px;
            text-align: right;
            height: 39px;
        }
        .auto-style19 {
            height: 39px;
        }
        .auto-style20 {
            text-align: right;
            height: 39px;
        }
        .auto-style21 {
            height: 31px;
        }
        .auto-style22 {
            text-decoration: underline;
        }
        .auto-style25 {
            width: 170px;
            height: 135px;
            mix-blend-mode: multiply;
        }
        .auto-style26 {
            font-weight: bold;
            color: #FFFFFF;
            background-color: #000000;
        }
        .auto-style28 {
            color: #006600;
            font-size: small;
        }
        .auto-style29 {
            font-size: large;
        }
        .auto-style30 {
            height: 121px;
        }
        .auto-style31 {
            margin-bottom: 0px;
        }
        .auto-style32 {
            width: 94px;
            text-align: right;
            height: 39px;
            display:inline-block;
        }
        .auto-style34 {
            width: 145px;
            text-align: left;
            height: 39px;
            
        }
        .auto-style35 {
            width: 145px;
            text-align: left;
            

        }
        .auto-style37 {
            width: 112px;
            text-align: left;
        }
        .auto-style39 {
            width: 94px;
        }
        .auto-style40 {
            width: 112px;
        }
        .auto-style41 {
            width: 39%;
        }
        .auto-style44 {
            width: 191px;
        }
        .auto-style45 {
            font-weight: bold;
            font-size: x-large;
            color: #FFFFFF;
            background-color: #000000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        &nbsp;</p>
    <p class="auto-style2">
        <strong>
        <asp:Button ID="btn_trainee_dashboard" runat="server" CssClass="auto-style26" OnClick="btn_trainee_dashboard_Click" Text="Trainee DashBoard" CausesValidation="False" />
        </strong>
        <div class="auto-style2">
            <strong>
            <asp:Label ID="lbl_today" runat="server"></asp:Label>
            <br />
            Let&#39;s start with your daily tasks&nbsp;
            <asp:Label ID="lbl_trainee_name" runat="server"></asp:Label>
            &nbsp;<asp:Button ID="btn_trainee_feedback" runat="server" CssClass="auto-style26" Text="Trainee Feedback" OnClick="btn_trainee_feedback_Click" CausesValidation="false" Enabled="False" Width="98px" Visible="False" />
            </strong>
        <br />
        </div>
        <table class="auto-style5">
            <tr>
                <td class="auto-style41"><strong>
                    <asp:Button ID="btn_daily_schedule" runat="server" CssClass="auto-style26" Text="Daily Schedule" OnClick="btn_daily_schedule_Click" CausesValidation="false" Width="185px"/>
                    </strong></td>
                <td class="auto-style44"><strong>
                    <asp:Button ID="btn_setting_evaluation" runat="server" CssClass="auto-style26" Text="Setting Objectives" OnClick="btn_setting_evaluation_Click" CausesValidation="false" Width="185px" />
                    </strong></td>
            </tr>
            <tr>
                <td class="auto-style41"><img src="images/tasks.jpg" class="auto-style25" />&nbsp;</td>
                <td class="auto-style44"><img src="images/obj.png" class="auto-style25" />&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2" colspan="2">
                    <br />
                    <asp:MultiView ID="MultiView1" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:ListView ID="ListView1" runat="server" DataKeyNames="course_code" OnSelectedIndexChanging="ListView1_SelectedIndexChanging" OnItemCommand="ListView1_ItemCommand" >
                                <ItemTemplate>
                                    <div>
                                        <table>
                                           <tr style=" background-color:#FFF8DC; font-size:xx-large"><td> <asp:Label ID="course_title" Text='<%# Eval("course_title") %>' runat="server" /></td></tr>
                                            <tr style="font-size:small;"><td><p> Course Code:  <asp:Label ID="course_code" Text='<%# Eval("course_code") %>' runat="server" /> </p></td></tr>
                                                <tr style="font-size:small;"><td>  <p> Start at: <%#Eval("course_start_at") %> ------ End at: <%#Eval("course_end_at") %></p></td><td rowspan="6"></td></tr>
                                            <tr style="font-size:small;"><td><p> Course Medium:  <asp:Label ID="course_delivery_medium" Text='<%# Eval("course_delivery_medium") %>' runat="server" /></p></td></tr>
                                            <tr style="font-size:small;"><td><p> Course Capability:  <asp:Label ID="course_capability" Text='<%# Eval("course_capability") %>' runat="server" /> </p></td></tr>
                                            <tr style="font-size:small;"><td><p> Provider:  <asp:Label ID="course_provider" Text='<%# Eval("course_provider") %>' runat="server" /> </p></td></tr>
                                            <tr style="font-size:small;"><td><p> Course Pre-Assessment:<asp:linkbutton runat="server" OnClick="go_to_assessment"><%#Eval("course_pre_assessment") %></asp:linkbutton> </p></td></tr>
                                            <tr style="font-size:small;"><td><p> Pass Criteria: <%#Eval("course_pass_criteria") %> </p></td></tr>
                                            <tr style="font-size:small;"><td><p> Course URL:<a href="<%#Eval("course_link") %>" target="_blank"><%#Eval("course_link") %></a></p></td></tr>
                                            <tr style="font-size:small;"><td><p> Course Assessment:<asp:linkbutton runat="server" OnClick="go_to_assessment"><%#Eval("course_Post_assessment") %></asp:linkbutton> </p></td></tr>
                                            <tr style="font-size:small;"><td><p> Evaluate Course:<asp:linkbutton runat="server" OnClick="btn_trainee_feedback_Click"><%#Eval("course_evaluation") %></asp:linkbutton> </p></td></tr>
                                        </table>
                                     </div>

                                </ItemTemplate>
                            </asp:ListView>
                        </asp:View>
                        <asp:View ID="View2" runat="server">
                            <div class="auto-style2">
                                <b style="mso-bidi-font-weight:normal"><span style="font-size:15.0pt;mso-bidi-font-size:16.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:
AR-SA;mso-bidi-language:AR-SA">Training Course Feedback<br />
                                </span></b>
                            </div>
                            <div class="auto-style8">

                                <table class="auto-style9">
                                    <tr>
                                        <td class="auto-style16"><strong>Trainee Name</strong></td>
                                        <td class="auto-style17"><strong>&nbsp;<asp:TextBox ID="txt_trainee_name" runat="server" Width="195px" ReadOnly="True"></asp:TextBox>
                                            </strong>
                                        </td>
                                        <td class="auto-style18"><strong>Course Title</strong></td>
                                        <td class="auto-style19"><strong>&nbsp;<asp:TextBox ID="txt_course_title" runat="server" Width="179px" ReadOnly="True"></asp:TextBox>
                                            </strong>
                                        </td>
                                        <td class="auto-style20"><strong>Course Date</strong></td>
                                        <td class="auto-style19"><strong>&nbsp;<asp:TextBox ID="txt_course_date" runat="server" ReadOnly="True" Width="141px"></asp:TextBox>
                                            </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style13"><strong>Trainee Code</strong></td>
                                        <td class="auto-style11"><strong>&nbsp;<asp:TextBox ID="txt_trainee_code" runat="server" Width="190px" ReadOnly="True"></asp:TextBox>
                                            </strong>
                                        </td>
                                        <td class="auto-style15"><strong>Provider</strong></td>
                                        <td><strong>&nbsp;<asp:TextBox ID="txt_course_provider" runat="server" Width="180px" ReadOnly="True"></asp:TextBox>
                                            </strong>
                                        </td>
                                        <td class="auto-style14"><strong>Course Code</strong></td>
                                        <td><strong>&nbsp;<asp:TextBox ID="txt_course_code" runat="server" ReadOnly="True" style="width: 148px"></asp:TextBox>
                                            </strong>
                                        </td>
                                    </tr>
                                </table>

                            </div>
                            <div class="auto-style8">

                                <br />
                                <table class="auto-style9">
                                    <tr>
                                        <td>
                                            <p class="auto-style2">
                                                <![if !supportLists]><![endif]><b style="mso-bidi-font-weight:
normal"><span style="font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;">Training Feedback</span></b></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b style="mso-bidi-font-weight:normal"><i style="mso-bidi-font-style:normal"><span style="font-size:12.0pt;mso-bidi-font-size:
14.0pt;font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;;
mso-bidi-font-family:&quot;Arabic Transparent&quot;;mso-ansi-language:EN-US;mso-fareast-language:
AR-SA;mso-bidi-language:AR-SA" class="auto-style22">Course Feedback</span></i></b></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            
        <h4>1- Were the topics covered in sufficient detail?<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="q1" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:RadioButtonList ID="q1" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Poor" Value="1" />
            <asp:ListItem Text="Average" Value="2" />
            <asp:ListItem Text="Good" Value="3" />
            <asp:ListItem Text="Excellent" Value="4" />
        </asp:RadioButtonList> 
                                            </h4>
                                            <h4>2-Was the content suited to your requirements?<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="q2" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:RadioButtonList ID="q2" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Poor" Value="1" />
            <asp:ListItem Text="Average" Value="2" />
            <asp:ListItem Text="Good" Value="3" />
            <asp:ListItem Text="Excellent" Value="4" />
        </asp:RadioButtonList> 
                                            </h4>
                                            <h4>3- How easy was the course to understand?<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="q3" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:RadioButtonList ID="q3" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Poor" Value="1" />
            <asp:ListItem Text="Average" Value="2" />
            <asp:ListItem Text="Good" Value="3" />
            <asp:ListItem Text="Excellent" Value="4" />
        </asp:RadioButtonList> 
                                            </h4>
                                            <h4>4- Would you recommend this course to others?<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="q4" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:RadioButtonList ID="q4" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Poor" Value="1" />
            <asp:ListItem Text="Average" Value="2" />
            <asp:ListItem Text="Good" Value="3" />
            <asp:ListItem Text="Excellent" Value="4" />
        </asp:RadioButtonList> 
                                            </h4>
        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style21"><b style="mso-bidi-font-weight:normal"><i style="mso-bidi-font-style:normal"><span style="font-size:12.0pt;mso-bidi-font-size:
14.0pt;font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;;
mso-bidi-font-family:&quot;Arabic Transparent&quot;;mso-ansi-language:EN-US;mso-fareast-language:
AR-SA;mso-bidi-language:AR-SA" class="auto-style22">Was the trainer prepared?</span></i></b></td>
                                    </tr>
                                    <tr>
                                        <td>
                                             <h4>1- How well conducted was the training?<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="q5" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:RadioButtonList ID="q5" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Poor" Value="1" />
            <asp:ListItem Text="Average" Value="2" />
            <asp:ListItem Text="Good" Value="3" />
            <asp:ListItem Text="Excellent" Value="4" />
        </asp:RadioButtonList> 
                                             </h4>
                                            <h4>2-How well paced was the delivery of information?<asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="q6" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:RadioButtonList ID="q6" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Poor" Value="1" />
            <asp:ListItem Text="Average" Value="2" />
            <asp:ListItem Text="Good" Value="3" />
            <asp:ListItem Text="Excellent" Value="4" />
        </asp:RadioButtonList> 
                                             </h4>
                                            <h4>3- How effectively did the trainer deliver the course material?<asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="q7" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:RadioButtonList ID="q7" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Poor" Value="1" />
            <asp:ListItem Text="Average" Value="2" />
            <asp:ListItem Text="Good" Value="3" />
            <asp:ListItem Text="Excellent" Value="4" />
        </asp:RadioButtonList> 
                                             </h4>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b style="mso-bidi-font-weight:normal"><i style="mso-bidi-font-style:normal"><span style="font-size:12.0pt;mso-bidi-font-size:
14.0pt;font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;;
mso-bidi-font-family:&quot;Arabic Transparent&quot;;mso-ansi-language:EN-US;mso-fareast-language:
AR-SA;mso-bidi-language:AR-SA" class="auto-style22">Facilities</span></i></b></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <h4>1- Were the standard of the training rooms as you expected?<asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="q8" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:RadioButtonList ID="q8" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Poor" Value="1" />
            <asp:ListItem Text="Average" Value="2" />
            <asp:ListItem Text="Good" Value="3" />
            <asp:ListItem Text="Excellent" Value="4" />
        </asp:RadioButtonList> 
                                            </h4>
                                            <h4>2-Was the standard of the equipment satisfactory?<asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="q9" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:RadioButtonList ID="q9" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Poor" Value="1" />
            <asp:ListItem Text="Average" Value="2" />
            <asp:ListItem Text="Good" Value="3" />
            <asp:ListItem Text="Excellent" Value="4" />
        </asp:RadioButtonList> 
                                            </h4>
                                            <h4>3- Were you satisfied with the refreshment facilities?<asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="q10" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:RadioButtonList ID="q10" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="Poor" Value="1" />
            <asp:ListItem Text="Average" Value="2" />
            <asp:ListItem Text="Good" Value="3" />
            <asp:ListItem Text="Excellent" Value="4" />
        </asp:RadioButtonList> 
                                            </h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style2"><b style="mso-bidi-font-weight:normal"><span style="font-size:12.0pt;mso-bidi-font-size:14.0pt;font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Arabic Transparent&quot;;
mso-ansi-language:EN-US;mso-fareast-language:AR-SA;mso-bidi-language:AR-SA">Summary</span></b></td>
                                    </tr>
                                    <tr>
                                        <td><b style="mso-bidi-font-weight:normal"><span style="font-size:12.0pt;mso-bidi-font-size:14.0pt;font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Arabic Transparent&quot;;
mso-ansi-language:EN-US;mso-fareast-language:AR-SA;mso-bidi-language:AR-SA">What, if anything, would you have improved on the course?<br /> </span>
                                            <asp:TextBox ID="txt_q11" runat="server" Height="127px" TextMode="MultiLine" Width="749px" onKeyUp="CheckTextLength(this,5)" onChange="CheckTextLength(this,5)"></asp:TextBox>
                                            </b>
                                            <strong>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_q11" ErrorMessage="Only 250 Letter maximum" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression=".{0,250}"></asp:RegularExpressionValidator>
                                            </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <p class="MsoNormal">
                                                <b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;">Is there anything else you would like us to know?</span></b></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b style="mso-bidi-font-weight: normal">
                                            <asp:TextBox ID="txt_q12" runat="server" Height="127px" TextMode="MultiLine" Width="749px"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txt_q12" EnableTheming="True" ErrorMessage="Only 250 Letter maximum" ForeColor="#CC0000" SetFocusOnError="True" ValidationExpression=".{0,250}"></asp:RegularExpressionValidator>
                                            </b></td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style2">
                                            <strong>
                                            <asp:Button ID="btn_submit" runat="server" CssClass="auto-style45" Text="Submit" OnClick="btn_submit_Click" Height="45px" Width="197px" />
                                            <asp:Label ID="lbl_evaluation" runat="server" CssClass="auto-style28" Text="Evaluation Completed - Thank You" Visible="False"></asp:Label>
                                            &nbsp;<asp:Label ID="lbl_evaluation2" runat="server" CssClass="auto-style28" Text="Evaluation Completed  Before - Thank You" Visible="False"></asp:Label>
                                            </strong>
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </asp:View>
                        <asp:View ID="View3" runat="server">
                            <div class="auto-style2">
                                <b style="mso-bidi-font-weight:normal"><span style="font-size:15.0pt;mso-bidi-font-size:16.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:
AR-SA;mso-bidi-language:AR-SA">Setting your goals and objectives<br />
                                </span></b>
                            </div>
                            <div class="auto-style8">

                                <table class="auto-style9">
                                    <tr>
                                        <td class="auto-style40"><strong>Trainee Name</strong></td>
                                        <td class="auto-style32"><strong><asp:TextBox ID="txt_goals_candidate_name" runat="server" ReadOnly="True" Width="238px"></asp:TextBox>
                                            </strong></td>
                                        <td class="auto-style34"><strong>Month No.<asp:DropDownList ID="DropDownList1" runat="server" Height="32px" Width="163px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                            <asp:ListItem>One</asp:ListItem>
                                            <asp:ListItem>Two</asp:ListItem>
                                            <asp:ListItem>Three</asp:ListItem>
                                            <asp:ListItem>Four</asp:ListItem>
                                            <asp:ListItem>Five</asp:ListItem>
                                            <asp:ListItem>Six</asp:ListItem>
                                            </asp:DropDownList>
                                            </strong></td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style37"><strong>Trainee Code</strong></td>
                                        <td class="auto-style39"><strong>
                                            <asp:TextBox ID="txt_goals_candidate_code" runat="server" ReadOnly="True" Width="190px"></asp:TextBox>
                                            </strong></td>
                                        <td class="auto-style35"><strong>Date<asp:TextBox ID="txt_goals_today_date" runat="server" CssClass="auto-style31" ReadOnly="True" Width="180px"></asp:TextBox>
                                            </strong></td>
                                    </tr>
                                </table>

                            </div>
                            <div class="auto-style8">

                                <br />
                                <table class="auto-style9">
                                    <tr>
                                        <td class="auto-style30">
                                             <h4>1- Self-Satisfaction?<asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ControlToValidate="self_satisfaction" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                 &nbsp;<asp:RadioButtonList ID="self_satisfaction" runat="server" RepeatDirection="Horizontal">
                                                     <asp:ListItem Text="Completely Not Satisfied " Value="1" />
                                                     <asp:ListItem Text="Average Satisfied" Value="2" />
                                                     <asp:ListItem Text="Completely Satisfied" Value="3" />
                                                     
                                                 </asp:RadioButtonList>
                                             </h4>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b style="mso-bidi-font-weight:normal"><span style="font-size:12.0pt;mso-bidi-font-size:14.0pt;font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Arabic Transparent&quot;;
mso-ansi-language:EN-US;mso-fareast-language:AR-SA;mso-bidi-language:AR-SA">List your completed activities this month?<br /> </span>
                                            <asp:TextBox ID="txt_goals_completed_activities" runat="server" Height="127px" TextMode="MultiLine" Width="749px" onKeyUp="CheckTextLength(this,5)" onChange="CheckTextLength(this,5)"></asp:TextBox>
                                            </b>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ErrorMessage="*" Font-Bold="True" ForeColor="Red" ControlToValidate="txt_goals_completed_activities"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <p class="MsoNormal">
                                                <b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;" class="auto-style29">List Activities in progress?</span></b></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b style="mso-bidi-font-weight: normal">
                                            <asp:TextBox ID="txt_goals_in_progress_activities" runat="server" Height="127px" TextMode="MultiLine" Width="749px"></asp:TextBox>
                                            </b>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ErrorMessage="*" Font-Bold="True" ForeColor="Red" ControlToValidate="txt_goals_in_progress_activities"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <p class="MsoNormal">
                                                <b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;" class="auto-style29">List Future goals and activities?</span></b></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b style="mso-bidi-font-weight: normal">
                                            <asp:TextBox ID="txt_goals_future_activities" runat="server" Height="127px" TextMode="MultiLine" Width="749px"></asp:TextBox>
                                            </b>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ErrorMessage="*" Font-Bold="True" ForeColor="Red" ControlToValidate="txt_goals_future_activities"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <p class="MsoNormal">
                                                <b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;" class="auto-style29">How can you improve yourself?</span></b></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b style="mso-bidi-font-weight: normal">
                                            <asp:TextBox ID="txt_goals_improvment" runat="server" Height="127px" TextMode="MultiLine" Width="749px"></asp:TextBox>
                                            </b>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="*" Font-Bold="True" ForeColor="Red" ControlToValidate="txt_goals_improvment"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <p class="MsoNormal">
                                                <b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;" class="auto-style29">List any Suggestions?</span></b></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b style="mso-bidi-font-weight: normal">
                                            <asp:TextBox ID="txt_goals_suggestions" runat="server" Height="127px" TextMode="MultiLine" Width="749px"></asp:TextBox>
                                            </b></td>
                                    </tr>

                                    <tr>
                                        <td class="auto-style2">
                                            <strong>
                                            <asp:Button ID="btn_goals_submit" runat="server" CssClass="auto-style45" Text="Submit" OnClick="btn_goals_submit_Click" Height="45px" Width="197px" />
                                            <asp:Label ID="Label1" runat="server" CssClass="auto-style28" Text="Setting goals Completed - Thank You" Visible="False"></asp:Label>
                                            &nbsp;<asp:Label ID="Label2" runat="server" CssClass="auto-style28" Text="Goals Completed for that month before  - Thank You" Visible="False"></asp:Label>
                                            </strong>
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </asp:View>
                    </asp:MultiView>
                </td>
            </tr>
        </table>
    </p>
</asp:Content>

