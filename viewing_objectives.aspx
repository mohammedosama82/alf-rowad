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

            string sql2 = "select candidate_name, candidate_code from candidates where candidate_status='2' order by candidate_name";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            con.Open();
            DropDownList2.DataSource = cmd2.ExecuteReader();
            DropDownList2.DataTextField = "candidate_name";
            DropDownList2.DataValueField = "candidate_code";
            DropDownList2.DataBind();
            ListItem selectlistitem = new ListItem("Select", "-1");
            DropDownList2.Items.Insert(0, selectlistitem);
            con.Close();

        }
    }

    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {

        



    }

    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        


    }





    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {

            con.Open();
        string sql = "SELECT candidate_code  from candidates where candidate_name=@candidate_name";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@candidate_name", DropDownList2.SelectedItem.Text);
        SqlDataReader read= cmd.ExecuteReader();
        while (read.Read())
        {
            Label3.Text = (read["candidate_code"].ToString());
        }
        read.Close();
        con.Close();

        con.Open();
        string sql3 = "SELECT candidate_code, goals_month, goals_self_satisfaction,goals_date, goals_completed_activities, goals_in_progress_activities, goals_future_activities, goals_improvment, goals_suggestions  from goals where candidate_code=@candidate_code and goals_month=@goals_month";
        SqlCommand cmd3 = new SqlCommand(sql3, con);
        cmd3.Parameters.AddWithValue("@candidate_code", DropDownList2.SelectedValue);
        cmd3.Parameters.AddWithValue("@goals_month", DropDownList3.SelectedValue);
        SqlDataReader read3= cmd3.ExecuteReader();
        if(read3.HasRows==true)
        {

            while (read3.Read())
            {
                lbl_status.Text = "";
                txt_goals_date.Text = (read3["goals_date"].ToString());
                DateTime dt = Convert.ToDateTime(txt_goals_date.Text);
                string goals_date = dt.ToString("yyyy-MM-dd");
                txt_goals_date.Text = goals_date;
                self_satisfaction.SelectedValue = (read3["goals_self_satisfaction"].ToString());
                txt_goals_completed_activities.Text = (read3["goals_completed_activities"].ToString());
                txt_goals_in_progress_activities.Text = (read3["goals_in_progress_activities"].ToString());
                txt_goals_future_activities.Text = (read3["goals_future_activities"].ToString());
                txt_goals_improvment.Text = (read3["goals_improvment"].ToString());
                txt_goals_suggestions.Text = (read3["goals_suggestions"].ToString());
            }
            read3.Close();
            con.Close();
        }

        else
        {
            read3.Close();
            con.Close();
            txt_goals_completed_activities.Text = "";
            txt_goals_date.Text = "";
            txt_goals_future_activities.Text = "";
            txt_goals_improvment.Text = "";
            txt_goals_in_progress_activities.Text = "";
            txt_goals_suggestions.Text = "";
            self_satisfaction.ClearSelection();
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "No Info for your inputs";


        }


        }
        catch (Exception excep)
        {
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "Unknow Error, IT Team will resolve this technical problem as soon as, Please Try Later";
            

        }
        finally
        {
            con.Close();

        }

        


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
        <asp:Label ID="Label1" runat="server" Text="Select Trainee" CssClass="displaying"></asp:Label>
        <asp:DropDownList ID="DropDownList2" runat="server" CssClass="displaying" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" AutoPostBack="True">
        </asp:DropDownList>
        <asp:Label ID="Label2" runat="server" Text="Select Month" CssClass="displaying"></asp:Label>
        <asp:DropDownList ID="DropDownList3" runat="server" CssClass="displaying" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem>Select</asp:ListItem>
            <asp:ListItem>One</asp:ListItem>
            <asp:ListItem>Two</asp:ListItem>
            <asp:ListItem>Three</asp:ListItem>
            <asp:ListItem>Four</asp:ListItem>
            <asp:ListItem>Five</asp:ListItem>
            <asp:ListItem>Six</asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="Label3" runat="server" Text="Label" Visible="False"></asp:Label>
        <asp:Button CssClass="auto-style14" ID="Button1" runat="server" Text="Check" OnClick="Button1_Click" />
            <asp:Button CssClass="auto-style14" ID="Button2" runat="server" Text="Print" OnClientClick="javascript:printdiv('divprint');"   />
        </strong>
    </p>
    

                            
    <div class="auto-style2" __designer:mapid="4da">
                                <b style="mso-bidi-font-weight:normal" __designer:mapid="4db"><span style="font-size:15.0pt;mso-bidi-font-size:16.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:EN-US;mso-fareast-language:
AR-SA;mso-bidi-language:AR-SA" __designer:mapid="4dc">Trainee goals and objectives<br __designer:mapid="4dd" />
                                </span></b>
                            </div>
                            <div class="auto-style8" __designer:mapid="4de">

                                <table class="auto-style9" __designer:mapid="4df">
                                    <tr __designer:mapid="4e0">
                                        <td class="auto-style12" __designer:mapid="4e1"><strong>Date</strong></td>
                                        <td class="auto-style11" __designer:mapid="4e3"><strong __designer:mapid="4e4"><asp:TextBox ID="txt_goals_date" runat="server" ReadOnly="True" Width="238px"></asp:TextBox>
                                            </strong></td>
                                    </tr>
                                    </table>

                                <table class="auto-style9" __designer:mapid="4fa">
                                    <tr __designer:mapid="4fb">
                                        <td class="auto-style30" __designer:mapid="4fc">
                                            <h4 __designer:mapid="4fd"><strong><span class="auto-style9">1- Trainee Self-Satisfaction</span></strong>&nbsp;<strong><asp:RadioButtonList ID="self_satisfaction" runat="server" RepeatDirection="Horizontal" CssClass="auto-style9">
                                                <asp:ListItem Text="Completely Not Satisfied " Value="1" />
                                                <asp:ListItem Text="Average Satisfied" Value="2" />
                                                <asp:ListItem Text="Completely Satisfied" Value="3" />
                                                </asp:RadioButtonList>
                                                </strong></h4>
                                        </td>
                                    </tr>
                                    <tr __designer:mapid="503">
                                        <td __designer:mapid="504"><b style="mso-bidi-font-weight:normal" __designer:mapid="505"><span style="mso-bidi-font-size:14.0pt;font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Arabic Transparent&quot;;
mso-ansi-language:EN-US;mso-fareast-language:AR-SA;mso-bidi-language:AR-SA" __designer:mapid="506">Trainee completed activities in this month</span><span style="font-size:12.0pt;mso-bidi-font-size:14.0pt;font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Arabic Transparent&quot;;
mso-ansi-language:EN-US;mso-fareast-language:AR-SA;mso-bidi-language:AR-SA" __designer:mapid="506"><br __designer:mapid="507" /></span>
                                            <asp:TextBox ID="txt_goals_completed_activities" runat="server" Height="100px" TextMode="MultiLine" Width="749px" onKeyUp="CheckTextLength(this,5)" onChange="CheckTextLength(this,5)" ReadOnly="True"></asp:TextBox>
                                            </b></td>
                                    </tr>
                                    <tr __designer:mapid="50a">
                                        <td __designer:mapid="50b">
                                            <p class="MsoNormal" __designer:mapid="50c">
                                                <b style="mso-bidi-font-weight:normal" __designer:mapid="50d"><span style="font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;" __designer:mapid="50e">Trainee in progress Activities </span></b>
                                            </p>
                                        </td>
                                    </tr>
                                    <tr __designer:mapid="50f">
                                        <td __designer:mapid="510"><b style="mso-bidi-font-weight: normal" __designer:mapid="511">
                                            <asp:TextBox ID="txt_goals_in_progress_activities" runat="server" Height="100px" TextMode="MultiLine" Width="749px" ReadOnly="True"></asp:TextBox>
                                            </b></td>
                                    </tr>
                                    <tr __designer:mapid="514">
                                        <td __designer:mapid="515">
                                            <p class="MsoNormal" __designer:mapid="516">
                                                <b style="mso-bidi-font-weight:normal" __designer:mapid="517"><span style="font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;" class="auto-style29" __designer:mapid="518">Trainee Future goals and activities</span></b></p>
                                        </td>
                                    </tr>
                                    <tr __designer:mapid="519">
                                        <td __designer:mapid="51a"><b style="mso-bidi-font-weight: normal" __designer:mapid="51b">
                                            <asp:TextBox ID="txt_goals_future_activities" runat="server" Height="100px" TextMode="MultiLine" Width="749px" ReadOnly="True"></asp:TextBox>
                                            </b></td>
                                    </tr>
                                    <tr __designer:mapid="51e">
                                        <td __designer:mapid="51f">
                                            <p class="MsoNormal" __designer:mapid="520">
                                                <b style="mso-bidi-font-weight:normal" __designer:mapid="521"><span style="font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;" class="auto-style29" __designer:mapid="522">Trainee Ideas to improve his self</span></b></p>
                                        </td>
                                    </tr>
                                    <tr __designer:mapid="523">
                                        <td __designer:mapid="524"><b style="mso-bidi-font-weight: normal" __designer:mapid="525">
                                            <asp:TextBox ID="txt_goals_improvment" runat="server" Height="100px" TextMode="MultiLine" Width="749px" ReadOnly="True"></asp:TextBox>
                                            </b></td>
                                    </tr>
                                    <tr __designer:mapid="528">
                                        <td __designer:mapid="529">
                                            <p class="MsoNormal" __designer:mapid="52a">
                                                <b style="mso-bidi-font-weight:normal" __designer:mapid="52b"><span style="font-family:&quot;Bookman Old Style&quot;,&quot;serif&quot;" class="auto-style29" __designer:mapid="52c">Trainee Suggestions</span></b></p>
                                        </td>
                                    </tr>
                                    <tr __designer:mapid="52d">
                                        <td __designer:mapid="52e"><b style="mso-bidi-font-weight: normal" __designer:mapid="52f">
                                            <asp:TextBox ID="txt_goals_suggestions" runat="server" Height="100px" TextMode="MultiLine" Width="749px" ReadOnly="True"></asp:TextBox>
                                            </b></td>
                                    </tr>
                                </table>

                            </div>
        </div>
                            
    </asp:Content>

