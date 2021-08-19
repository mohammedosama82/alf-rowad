<%@ Page Title="" Language="C#" MasterPageFile="~/trainer_dash_master.master" MaintainScrollPositionOnPostback="true" UnobtrusiveValidationMode="None" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>

<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void btn_prepare_Click(object sender, EventArgs e)
    {

        lbl_trainer_name.Text = Session["trainer_name"].ToString();
        lbl_today.Text = DateTime.Now.ToString("dd/MM/yyyy");
        lbl_today2.Text = lbl_today.Text;
        string sql10 = "SELECT * from grades where trainer_file_number='"+lbl_trainer_file_number.Text.ToString()+"' and course_code='"+DropDownList1.SelectedValue.ToString()+"'";
        SqlCommand cmd10 = new SqlCommand(sql10, con);
        con.Open();
        SqlDataReader read10= cmd10.ExecuteReader();

        if (read10.HasRows == true)
        {

            string sql11 = "SELECT candidate_name, candidate_file_number,grade_id,comm_grade, resp_grade, group_grade, team_grade from candidates inner join grades on candidates.candidate_code  = grades.candidate_code where course_code='"+DropDownList1.SelectedValue.ToString()+"'and trainer_file_number='"+lbl_trainer_file_number.Text.ToString()+"' order by candidate_name";
            SqlCommand cmd11 = new SqlCommand(sql11, con);
            read10.Close();
            con.Close();
            con.Open();
            SqlDataReader read11 = cmd11.ExecuteReader();

            if (read11.HasRows == true)
            {

                GridView1.DataSource = read11;
                GridView1.DataBind();

            }
            read11.Close();
            con.Close();

        }

        else
        {
            read10.Close();
            con.Close();

            string sql4 = "insert into grades (candidate_code) select candidate_code from candidates where candidate_status='2'";
            SqlCommand cmd4 = new SqlCommand(sql4, con);

            con.Open();
            cmd4.ExecuteNonQuery();
            con.Close();

            string sql2 = "UPDATE grades SET course_code = '" + DropDownList1.SelectedValue.ToString() + "', trainer_file_number='" + lbl_trainer_file_number.Text.ToString() + " ' where ( course_code is NULL and trainer_file_number is NULL)";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            con.Open();
            cmd2.ExecuteNonQuery();
            con.Close();

            con.Open();
            string sql = "SELECT candidate_name, candidate_file_number,grade_id,comm_grade, resp_grade, group_grade, team_grade from candidates inner join grades on candidates.candidate_code  = grades.candidate_code where course_code='"+DropDownList1.SelectedValue.ToString()+"'and trainer_file_number='"+lbl_trainer_file_number.Text.ToString()+"' order by candidate_name" ;
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader read = cmd.ExecuteReader();
            if (read.HasRows == true)
            {

                GridView1.DataSource = read;
                GridView1.DataBind();
            }
            read.Close();
            con.Close();


        }


    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            if(Session["trainer_file_number"]==null)
            {
                Response.Redirect("index.html");
                return;
            }
            lbl_trainer_file_number.Text = Session["trainer_file_number"].ToString();

            string sql2 = "select course_code, course_name from courses";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            con.Open();
            DropDownList1.DataSource = cmd2.ExecuteReader();
            DropDownList1.DataTextField = "course_name";
            DropDownList1.DataValueField = "course_code";
            DropDownList1.DataBind();
            ListItem selectlistitem = new ListItem("Select","-1");
            DropDownList1.Items.Insert(0, selectlistitem);
            con.Close();

        }


    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkTest = (CheckBox)sender;
        GridViewRow grdRow = (GridViewRow)chkTest.NamingContainer;
        TextBox comm_grade = (TextBox)grdRow.FindControl("TextBox2");

        TextBox resp_grade = (TextBox)grdRow.FindControl("TextBox3");

        TextBox group_grade = (TextBox)grdRow.FindControl("TextBox4");

        TextBox team_grade = (TextBox)grdRow.FindControl("TextBox5");

        if (chkTest.Checked)
        {
            comm_grade.ReadOnly = false;
            resp_grade.ReadOnly = false;
            group_grade.ReadOnly = false;
            team_grade.ReadOnly = false;
            comm_grade.ForeColor = System.Drawing.Color.Black;
            resp_grade.ForeColor = System.Drawing.Color.Black;
            group_grade.ForeColor = System.Drawing.Color.Black;
            team_grade.ForeColor = System.Drawing.Color.Black;
        }
        else
        {
            comm_grade.ReadOnly = true;
            resp_grade.ReadOnly = true;
            group_grade.ReadOnly = true;
            team_grade.ReadOnly = true;
            comm_grade.ForeColor = System.Drawing.Color.Blue;
            resp_grade.ForeColor = System.Drawing.Color.Blue;
            group_grade.ForeColor = System.Drawing.Color.Blue;
            team_grade.ForeColor = System.Drawing.Color.Blue;
        }
    }

    protected void btn_accreditation_Click(object sender, EventArgs e)
    {
        //Create stringbuilder to store multiple DML statements 
        StringBuilder strSql = new StringBuilder(string.Empty);

        //Create sql connection and command
        SqlCommand cmd = new SqlCommand();
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            CheckBox chkUpdate = (CheckBox)GridView1.Rows[i].Cells[7].FindControl("CheckBox1");

            if (chkUpdate != null)
            {
                if (chkUpdate.Checked)
                {
                    // Get the values of textboxes using findControl
                    string strID = GridView1.Rows[i].Cells[0].Text;

                    string comm_grade= ((TextBox)GridView1.Rows[i].FindControl("Textbox2")).Text;


                    string resp_grade = ((TextBox)GridView1.Rows[i].FindControl("Textbox3")).Text;

                    string group_grade = ((TextBox)GridView1.Rows[i].FindControl("Textbox4")).Text;

                    string team_grade = ((TextBox)GridView1.Rows[i].FindControl("Textbox5")).Text;

                    //edit the data to database:
                    string strUpdate = "Update grades set comm_grade = '" + comm_grade + "', resp_grade = '" + resp_grade + "', group_grade= '" + group_grade + "', team_grade='" + team_grade + "' WHERE grade_id ='" + strID + "'";

                    //append update statement in stringBuilder 

                    strSql.Append(strUpdate);
                    con.Close();
                }
                else
                {
                    lbl_status.Text = "Please  Select Trainee first";
                    con.Close();
                    Response.AddHeader("REFRESH", "1;URL=evaluate_trainee_by_trainer.aspx");
                    return;

                }
            }
        }
        try
        {
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strSql.ToString();
            cmd.Connection = con;
            con.Open();
            cmd.ExecuteNonQuery();
            string sql11 = "SELECT candidate_name, candidate_file_number,grade_id,comm_grade, resp_grade, group_grade, team_grade from candidates inner join grades on candidates.candidate_code  = grades.candidate_code where course_code='"+DropDownList1.SelectedValue.ToString()+"'and trainer_file_number='"+lbl_trainer_file_number.Text.ToString()+"' order by candidate_name";
            SqlCommand cmd11 = new SqlCommand(sql11, con);
            // con.Close();
            // con.Open();
            SqlDataReader read11 = cmd11.ExecuteReader();

            if (read11.HasRows == true)
            {

                GridView1.DataSource = read11;
                GridView1.DataBind();
            }
            read11.Close();
            con.Close();
        }
        catch (SqlException ex)
        {
            string errorMsg = "Error in Update";
            errorMsg += ex.Message;
            throw new Exception(errorMsg);
        }
        finally
        {
            con.Close();
        }


    }


    protected void btn_select_all_Click(object sender, EventArgs e)
    {

        foreach (GridViewRow row in GridView1.Rows)
        {
            CheckBox chkcheck = (CheckBox)row.FindControl("CheckBox1");
            chkcheck.Checked = true;
            TextBox comm_grade = (TextBox)row.FindControl("TextBox2");

            TextBox resp_grade = (TextBox)row.FindControl("TextBox3");

            TextBox group_grade = (TextBox)row.FindControl("TextBox4");

            TextBox team_grade = (TextBox)row.FindControl("TextBox5");
            comm_grade.ReadOnly = false;
            resp_grade.ReadOnly = false;
            group_grade.ReadOnly = false;
            team_grade.ReadOnly = false;
            comm_grade.ForeColor = System.Drawing.Color.Black;
            resp_grade.ForeColor = System.Drawing.Color.Black;
            group_grade.ForeColor = System.Drawing.Color.Black;
            team_grade.ForeColor = System.Drawing.Color.Black;
        }





    }

    protected void btn_clear_Click(object sender, EventArgs e)
    {
        con.Open();
        string sql2 = "DELETE from grades WHERE course_code='"+DropDownList1.SelectedValue.ToString()+"'and trainer_file_number='"+lbl_trainer_file_number.Text.ToString()+"'";
        SqlCommand cmd2 = new SqlCommand(sql2, con);
        cmd2.ExecuteNonQuery();
        int t=cmd2.ExecuteNonQuery();
        if(t>=0)
        {
            Response.Write("The Sheet Cleared");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "The Sheet Cleared ";
            con.Close();
            Response.AddHeader("REFRESH", "1;URL=evaluate_trainee_by_trainer.aspx");

        }
        else
        {
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "No Sheet To Clear  ";
            con.Close();
            Response.AddHeader("REFRESH", "1;URL=evaluate_trainee_by_trainer.aspx");

        }

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        
            .auto-style8 {
            width: 100%;
            height:50%;
            border-collapse: collapse;
            border: 5px solid #000000;
                  }

            .auto-style9 {
            width: 20%;
            height:20%;
            border:solid;
        }

            .auto-style11 {
            width: 100%;
            height: 20%;
            border:solid;
        }

            .auto-style151 {
            width: 114px;
        }
        .auto-style152 {
            width: 55%;
            text-align: center;
        }
        .auto-style153 {
            border-style: solid;
            border-color: inherit;
            border-width: medium;
            width: 55%;
            height: 20%;
            text-align: center;
        }
        .auto-style154 {
            border-style: solid;
            border-color: inherit;
            border-width: medium;
            width: 62%;
            height: 20%;
        }
        .auto-style155 {
            font-weight: bold;
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
        Trainer File#
        <asp:Label ID="lbl_trainer_file_number" runat="server"></asp:Label>
       <div style="display:inline-block">Select Course</div>
       <div style="display:inline-block"> <asp:DropDownList ID="DropDownList1" runat="server">
        </asp:DropDownList> </div>
        <div style="display:inline-block"><asp:Button ID="btn_prepare" runat="server" Text="Prepare Evauation Sheet" OnClick="btn_prepare_Click" CssClass="auto-style155" />  </div>
        <div style="display:inline-block"><asp:Button ID="btn_clear" runat="server" Text="Clear Sheet" OnClick="btn_clear_Click" CssClass="auto-style155" Width="127px" />  </div>
        </br>
        </br>
        <div id="divprint" >

            <table cellpadding="0" cellspacing="1" class="auto-style8" style="border:solid">
            <tr>
                <td class="auto-style9" rowspan="3"><span style="font-size:12.0pt;mso-bidi-font-size:14.0pt;
font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;;
mso-bidi-font-family:&quot;Arabic Transparent&quot;;mso-ansi-language:EN-US;mso-fareast-language:
AR-SA;mso-bidi-language:AR-SA"><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
 coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
 filled="f" stroked="f">
 <v:stroke joinstyle="miter" xmlns:v="urn:schemas-microsoft-com:vml"/>
 <v:formulas>
  <v:f eqn="if lineDrawn pixelLineWidth 0" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="sum @0 1 0" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="sum 0 0 @1" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="prod @2 1 2" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="prod @3 21600 pixelWidth" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="prod @3 21600 pixelHeight" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="sum @0 0 1" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="prod @6 1 2" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="prod @7 21600 pixelWidth" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="sum @8 21600 0" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="prod @7 21600 pixelHeight" xmlns:v="urn:schemas-microsoft-com:vml"/>
  <v:f eqn="sum @10 21600 0" xmlns:v="urn:schemas-microsoft-com:vml"/>
 </v:formulas>
 <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect" xmlns:v="urn:schemas-microsoft-com:vml"/>
 <o:lock v:ext="edit" aspectratio="t" xmlns:o="urn:schemas-microsoft-com:office:office"/>
</v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_i1025" type="#_x0000_t75"
 style='width:127.5pt;height:47pt;visibility:visible'>
 <v:imagedata src="file:///C:\Users\engmo\AppData\Local\Temp\msohtmlclip1\01\clip_image001.jpg"
  o:title="LOGO-Construction" xmlns:v="urn:schemas-microsoft-com:vml"/>
</v:shape><![endif]--><![if !vml]>
                    <img  src="images\alfanar_logo2.png" v:shapes="Picture_x0020_1" class="auto-style151" /><![endif]></span></td>
                <td class="auto-style153" ><strong>QUALITY MANAGMENT SYSTEM</strong></td>
                <td class="auto-style11" colspan="2">Ref.No. : QR7.2.0/5</td>
            </tr>
            <tr>
                <td rowspan="2" class="auto-style152"><strong>Document Title<br />
                    Trainees Evaluation Report</strong></td>
                <td class="auto-style154">Issue: 02.</td>
                <td class="auto-style11">Rev:00</td>
            </tr>
            <tr>
                <td colspan="2" style="border:solid">Issuing Date:
                    <asp:Label ID="lbl_today" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="0" ForeColor="#333333" GridLines="None" DataKeyNames="grade_id">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="grade_id" HeaderText="ID" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" ReadOnly="True" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
            <asp:BoundField DataField="candidate_name" HeaderText="Name" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" ReadOnly="True" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
            <asp:BoundField DataField="candidate_file_number" HeaderText="File#" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small" ReadOnly="True" >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
            <asp:TemplateField HeaderText="Communication" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small">
                        <ItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("comm_grade") %>' ReadOnly="true" ></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox2" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="10|[0-9]"></asp:RegularExpressionValidator>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Responsiveness" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"> 
                        <ItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("resp_grade") %>' ReadOnly="true" ></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox3" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="10|[0-9]"></asp:RegularExpressionValidator>
                        </ItemTemplate>
                    </asp:TemplateField>
            <asp:TemplateField HeaderText="Group Discussion" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small">
                        <ItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("group_grade") %>' ReadOnly="true" ></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox4" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="10|[0-9]"></asp:RegularExpressionValidator>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Team work" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small">
                        <ItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("team_grade") %>' ReadOnly="true" ></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox5" ErrorMessage="Invalid" ForeColor="Red" SetFocusOnError="True" ValidationExpression="10|[0-9]"></asp:RegularExpressionValidator>
                        </ItemTemplate>
                    </asp:TemplateField>
           
            <asp:TemplateField HeaderText="Select">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="CheckBox1_CheckedChanged" AutoPostBack="true"/>
                </ItemTemplate>
            </asp:TemplateField>

            
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
</br>
            <strong>TRAINER’S SIGNATURE:</strong>
            <asp:Label ID="lbl_trainer_name" runat="server"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>DATE:</strong><asp:Label ID="lbl_today2" runat="server"></asp:Label>
        </div>

       <div style="display:inline-block"> <asp:Button ID="btn_select_all" runat="server" Text="Select All" OnClick="btn_select_all_Click" CssClass="auto-style155" /></div>
     <div style="display:inline-block"><asp:Button ID="btn_accreditation" runat="server" Text="Accreditation of grades" OnClick="btn_accreditation_Click" CssClass="auto-style155" /></div>
       <div style="display:inline-block"> <asp:Button ID="btn_print" CssClass="auto-style149" runat="server" Text="Print" OnClientClick="javascript:printdiv('divprint');" style="font-weight: bold; color: #FFFFFF; background-color: #000000" /></div>
        <div>
            <asp:Label ID="lbl_status" runat="server" Text=""></asp:Label>
        </div>
</asp:Content>

