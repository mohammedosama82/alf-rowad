<%@ Page Title="" Language="C#" MasterPageFile="~/mentor_dash_master.master" UnobtrusiveValidationMode="None" MaintainScrollPositionOnPostback="true" %>
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

            con.Open();

            string sql11 = "select candidate_code,candidate_name, candidate_file_number from dbo.candidates where candidate_status='2' order by candidate_name" ;
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


    protected void btn_trainee_feedback_Click(object sender, EventArgs e)
    {

        MultiView1.ActiveViewIndex = 1;
    }

    protected void btn_setting_evaluation_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 2;
    }



    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
       if (Session["mentor_name"] == null)
        {
            Response.Redirect("index.html");
        }
        else
        {
            Label lbl_candidate_name = (Label)e.Item.FindControl("candidate_name");
            string candidate_name = lbl_candidate_name.Text;
            txt_trainee_name.Text = candidate_name;
            Label lbl_candidate_file_number = (Label)e.Item.FindControl("candidate_file_number");
            string candidate_file_number = lbl_candidate_file_number.Text;
            txt_trainee_file_number.Text = candidate_file_number;
            Label lbl_candidate_code = (Label)e.Item.FindControl("candidate_code");
            string candidate_code = lbl_candidate_code.Text;
            txt_candidate_code.Text = candidate_code;

            string str_candidate_info = "select mentor_name, mentor_department, mentor_file_number from mentors  where mentor_file_number='" + Session["mentor_file_number"] + "'";
            con.Open();
            SqlCommand cmd_candidate_info = new SqlCommand(str_candidate_info, con);
            SqlDataReader read_candidate_info = cmd_candidate_info.ExecuteReader();
            if (read_candidate_info.HasRows == false)
            {
                read_candidate_info.Close();
                con.Close();
                Response.Redirect("mentor_login.aspx");

            }
            else
            {
                while (read_candidate_info.Read())
                {

                    txt_mentor_file_number.Text = (read_candidate_info["mentor_file_number"].ToString());
                    txt_mentor_name.Text = (read_candidate_info["mentor_name"].ToString());
                    txt_mentor_department.Text = (read_candidate_info["mentor_department"].ToString());


                }
                read_candidate_info.Close();

                con.Close();

            }

            con.Open();
            string sql = "SELECT mentor_file_number, candidate_code from mentor_evaluation where mentor_file_number='" + txt_mentor_file_number.Text + "' and candidate_code='" + txt_candidate_code.Text + "' ";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader read = cmd.ExecuteReader();
            if (read.HasRows == true)
            {

                btn_submit.Enabled = false;
                lbl_evaluation2.Visible = true;
                string sql20 = "select q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15 from mentor_evaluation where mentor_file_number='" + txt_mentor_file_number.Text + "' and candidate_code='" + txt_candidate_code.Text + "' ";
                read.Close();
                con.Close();
                con.Open();
                SqlCommand cmd20 = new SqlCommand(sql20, con);
                SqlDataReader read20 = cmd20.ExecuteReader();

                while (read20.Read())
                {

                    q1.SelectedValue = (read20["q1"].ToString());
                    q2.SelectedValue = (read20["q2"].ToString());
                    q3.SelectedValue = (read20["q3"].ToString());
                    q4.SelectedValue = (read20["q4"].ToString());
                    q5.SelectedValue = (read20["q5"].ToString());
                    q6.SelectedValue = (read20["q6"].ToString());
                    q7.SelectedValue = (read20["q7"].ToString());
                    q8.SelectedValue = (read20["q8"].ToString());
                    q9.SelectedValue = (read20["q9"].ToString());
                    q10.SelectedValue = (read20["q10"].ToString());
                    q11.SelectedValue = (read20["q11"].ToString());
                    q12.SelectedValue = (read20["q12"].ToString());
                    q13.SelectedValue = (read20["q13"].ToString());
                    q14.SelectedValue = (read20["q14"].ToString());
                    q15.SelectedValue = (read20["q15"].ToString());



                }
                read20.Close();

                con.Close();

            }
            read.Close();
            con.Close();

        }
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
        string q11_eval = q11.SelectedValue.ToString();
        string q12_eval = q12.SelectedValue.ToString();
        string q13_eval = q13.SelectedValue.ToString();
        string q14_eval = q14.SelectedValue.ToString();
        string q15_eval = q15.SelectedValue.ToString();

        string sql4 = "insert into mentor_evaluation (mentor_file_number,candidate_code, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15 ) values (@mentor_file_number,@candidate_code,  @q1_eval, @q2_eval, @q3_eval, @q4_eval, @q5_eval, @q6_eval, @q7_eval, @q8_eval, @q9_eval, @q10_eval, @q11_eval, @q12_eval,  @q13_eval,  @q14_eval, @q15_eval)";
        SqlCommand cmd4 = new SqlCommand(sql4, con);
        cmd4.Parameters.AddWithValue("@mentor_file_number", txt_mentor_file_number.Text);
        cmd4.Parameters.AddWithValue("@candidate_code", txt_candidate_code.Text);
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
        cmd4.Parameters.AddWithValue("@q13_eval", q13_eval);
        cmd4.Parameters.AddWithValue("@q14_eval", q14_eval);
        cmd4.Parameters.AddWithValue("@q15_eval", q15_eval);
        con.Open();
        cmd4.ExecuteNonQuery();
        con.Close();
        lbl_evaluation.Visible = true;
        btn_submit.Enabled = false;

        

    }



    protected void btn_mentor_dashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("mentor_dashboard.aspx");
    }

    protected void btn_all_trainees_Click(object sender, EventArgs e)
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
        q11.ClearSelection();
        q12.ClearSelection();
        q13.ClearSelection();
        q14.ClearSelection();
        q15.ClearSelection();
        lbl_evaluation.Visible = false;
        lbl_evaluation2.Visible = false;
        btn_submit.Enabled = true;


        MultiView1.ActiveViewIndex = 0;

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
        .auto-style23 {
            font-weight: bold;
            font-size: small;
            color: #FFFFFF;
            background-color: #000000;
            display:inline-block
        }
        .auto-style26 {
            font-weight: bold;
            color: #FFFFFF;
            background-color: #000000;
        }
        .auto-style27 {
            text-decoration: underline;
            font-size: x-small;
        }
        .auto-style29 {
            color: #006600;
            font-size: x-small;
        }

        .myRadioList input[type="radio"] { display:inline-block; width: auto; font-size:x-small; }
.myRadioList label { display:inline-block; width: auto; font-size:x-small; }
       
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
        &nbsp;</p>
    <p class="auto-style2">
        <strong>
        <asp:Button ID="btn_mentor_dashboard" runat="server" CssClass="auto-style26" OnClick="btn_mentor_dashboard_Click" Text="Mentor Dashboard" CausesValidation="False" />
        </strong>
        <table class="auto-style5">
            <tr>
                <td class="auto-style2"><strong>
                    <asp:Button ID="btn_all_trainees" runat="server" CssClass="auto-style26" Text="View All Trainees" OnClick="btn_all_trainees_Click" CausesValidation="false" Width="185px"/>
                    <asp:Button ID="btn_trainee_feedback" runat="server" CssClass="auto-style26" Text="Trainee Feedback" OnClick="btn_trainee_feedback_Click" CausesValidation="false" Enabled="False" Width="185px" Visible="False" />
                    </strong></td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <br />
                    <asp:MultiView ID="MultiView1" runat="server">
                        <asp:View ID="View1" runat="server">
                            <asp:ListView ID="ListView1" runat="server" DataKeyNames="candidate_code"  OnItemCommand="ListView1_ItemCommand" >
                                <ItemTemplate>
                                    <div>
                                        <table>
                                           <tr style=" background-color:#FFF8DC; font-size:xx-large"><td> <asp:Label ID="candidate_name" Text='<%# Eval("candidate_name") %>' runat="server" /></td></tr>
                                            <tr style="font-size:small;"><td><p> File#:  <asp:Label ID="candidate_file_number" Text='<%# Eval("candidate_file_number") %>' runat="server" /> 
                - Trainee Code:  <asp:Label ID="candidate_code" Text='<%# Eval("candidate_code") %>' runat="server" />
                                                                             </p></td></tr>
                                                                                 <tr style="font-size:small;"><td><p> Evaluate Trainee:<asp:linkbutton runat="server" OnClick="btn_trainee_feedback_Click">From Here</asp:linkbutton> </p></td></tr>
                                        </table>
                                     </div>

                                </ItemTemplate>
                            </asp:ListView>
                        </asp:View>
                        <asp:View ID="View2" runat="server">
                            <div id="divprint">
                            <div class="auto-style2">
                                <b style="mso-bidi-font-weight:normal"><span style="font-size:15.0pt;mso-bidi-font-size:16.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:
AR-SA;mso-bidi-language:AR-SA">Mentor Feedback<br />
                                </span></b>
                            </div>
                            <div class="auto-style8">

                                <table class="auto-style9">
                                    <tr>
                                        <td class="auto-style16"><strong>Trainee Name</strong></td>
                                        <td class="auto-style17"><strong>&nbsp;<asp:TextBox ID="txt_trainee_name" runat="server" Width="195px" ReadOnly="True"></asp:TextBox>
                                            </strong>
                                        </td>
                                        <td class="auto-style18"><strong>Trainee File#</strong></td>
                                        <td class="auto-style19"><strong>&nbsp;<asp:TextBox ID="txt_trainee_file_number" runat="server" Width="179px" ReadOnly="True"></asp:TextBox>
                                            </strong>
                                        </td>
                                        <td class="auto-style20"><strong>Trainee Code</strong></td>
                                        <td class="auto-style19"><strong>&nbsp;<asp:TextBox ID="txt_candidate_code" runat="server" ReadOnly="True" Width="141px"></asp:TextBox>
                                            </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style13"><strong>Mentor Name</strong></td>
                                        <td class="auto-style11"><strong>&nbsp;<asp:TextBox ID="txt_mentor_name" runat="server" Width="190px" ReadOnly="True"></asp:TextBox>
                                            </strong>
                                        </td>
                                        <td class="auto-style15"><strong>Mentor File#</strong></td>
                                        <td><strong>&nbsp;<asp:TextBox ID="txt_mentor_file_number" runat="server" Width="180px" ReadOnly="True"></asp:TextBox>
                                            </strong>
                                        </td>
                                        <td class="auto-style14"><strong>Workplace</strong></td>
                                        <td><strong>&nbsp;<asp:TextBox ID="txt_mentor_department" runat="server" ReadOnly="True" style="width: 148px"></asp:TextBox>
                                            </strong>
                                        </td>
                                    </tr>
                                </table>

                                <table class="auto-style9">
                                    <tr>
                                        <td><span style="mso-bidi-font-weight:normal"><i style="mso-bidi-font-style:normal"><span class="auto-style27" style="mso-bidi-font-size:
14.0pt;font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;;
mso-bidi-font-family:&quot;Arabic Transparent&quot;;mso-ansi-language:EN-US;mso-fareast-language:
AR-SA;mso-bidi-language:AR-SA"><strong>The below points should be evaluated by the mentor who has a relationship with the newcomer:</strong></span></i></span></td>
                                    </tr>
                                    <tr>
                                        <td>1- Acts in accordance with alfanar mission, values, policies, and procedures.العمل وفقا لرؤية وسياسات الفنار<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="q1" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q1" runat="server" RepeatDirection="Horizontal" CellPadding="0" CellSpacing="0" CssClass="myRadioList"  >
                                    
                                                <asp:ListItem  Text="Poor" Value="1"  /> 
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            2-Work Accuracy, quality. دقة وجودة العمل
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="q2" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q2" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList"  >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            3- Written Communication. المراسلات الكتابية
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="q3" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q3" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            4- Verbal Communication. التواصل اللفظى<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="q4" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q4" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            5- Cooperative attitude. سلوك التعاون<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="q5" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q5" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            6- Shares knowledge, insights. مشاركة المعلومات والافكار<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="q6" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q6" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            7- Takes appropriate action independently.
                                            اتخاذ الاجراءات المناسبة بشكل مناسب<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="q7" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q7" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            8- Accomplish tasks, despite obstacles, in a timely manner.تنفيذ المهام فى الوقت المناسب بالرغم من الصعوبات
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="q8" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q8" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            9- Seeks out new and better ways of accomplishing tasks.يبحث عن طرق جديدة وأفضل لإنجاز المهام
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="q9" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q9" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            10- Accomplishes set goals in a timely manner.وضع الاهداف فى الوقت المطلوب<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="q10" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q10" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            11- Takes initiative in follow-through. المبادرة بمتابعة المهام<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="q11" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q11" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            12-listening skills. مهارات الاستماع<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="q12" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q12" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            13- Makes suggestions. عرض الاقتراحات<asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="q13" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q13" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            14- Acquires new skills , and Seeks new information.اكتساب مهارات و معلومات جديدة
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="q14" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q14" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                            15- Resolve Conflicts in a professional Manner.حل المشاكل بطريقة مهنية<asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="q15" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            &nbsp;<asp:RadioButtonList ID="q15" runat="server" RepeatDirection="Horizontal" CssClass="myRadioList" >
                                                <asp:ListItem Text="Poor" Value="1" />
                                                <asp:ListItem Text="Average" Value="2" />
                                                <asp:ListItem Text="Good" Value="3" />
                                                <asp:ListItem Text="Excellent" Value="4" />
                                                <asp:ListItem Text="N/A" Value="5" />
                                            </asp:RadioButtonList>
                                                                                        
                                        </td>
                                    </tr>
                                    
                                </table>

                            </div>
                                </div>
                                            <asp:Button ID="btn_submit" runat="server" CssClass="auto-style23" Text="Submit" OnClick="btn_submit_Click" Height="30px" Width="128px" /> 
                                                <div style="display:inline-block"> <asp:Button ID="btn_print" CssClass="auto-style149" runat="server" Text="Print" OnClientClick="javascript:printdiv('divprint');" style="font-weight: bold; color: #FFFFFF; background-color: #000000" Height="30px" Width="128px" /></div>
                                            <asp:Label ID="lbl_evaluation" runat="server" CssClass="auto-style29" Text="Evaluation Completed - Thank You" Visible="False"></asp:Label>
                                            &nbsp;<asp:Label ID="lbl_evaluation2" runat="server" CssClass="auto-style29" Text="Evaluation Completed  Before - Thank You" Visible="False"></asp:Label>
                                            </strong>
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </asp:View>
                        <asp:View ID="View3" runat="server">TMAAAAAAAAAAAAAAAAAAAAAAM</asp:View>
                    </asp:MultiView>
                </td>
            </tr>
        </table>
    </p>
</asp:Content>

