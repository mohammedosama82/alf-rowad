<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/admin_dash_master.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Configuration" %>



<script runat="server">
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
    protected void img_btn_absent_date_Click(object sender, ImageClickEventArgs e)
    {
        cln_absent_date.Visible = true;
        GridView1.Visible = true;
       
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        GridView1.Visible = true;
        if (!IsPostBack)
        {
            con.Open();
            string sql2 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status where status_id=2 ";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            SqlDataReader read2 = cmd2.ExecuteReader();
            if (read2.HasRows == true)
            {

                GridView1.DataSource = read2;
                GridView1.DataBind();
            }
            else
            {
                GridView1.Visible = false;
                Response.Write("There is no info for your selection");
                lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "There is no info for your selection";
            }
            read2.Close();
            con.Close();
        }
    }

    protected void btn_admin_dashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("admin_dashboard.aspx");
    }

    protected void cln_absent_date_SelectionChanged(object sender, EventArgs e)
    {
        GridView1.Visible = true;
        txt_absent_date.Text = cln_absent_date.SelectedDate.ToString("yyyy-MM-dd");
        cln_absent_date.Visible = false;

    }

    protected void btn_absence_register_Click(object sender, EventArgs e)
    {
        GridView1.Visible = true;
            if (txt_absent_date.Text != "")
            {

                int tip = 0;
                foreach (GridViewRow grow in GridView1.Rows)
                {
                    CheckBox selected_checkbox = grow.FindControl("select_candidate") as CheckBox;
                    if (selected_checkbox.Checked == true)
                    {
                        tip++;

                        string str_insert_absent_candidate = "insert into candidate_absent (candidate_code, absent_date)values (@candidate_code, @absent_date)";
                        SqlCommand cmd_insert_absent_candidate = new SqlCommand(str_insert_absent_candidate, con);
                        cmd_insert_absent_candidate.Parameters.AddWithValue("@candidate_code", grow.Cells[1].Text);
                        cmd_insert_absent_candidate.Parameters.AddWithValue("@absent_date", txt_absent_date.Text);
                        con.Open();
                        cmd_insert_absent_candidate.ExecuteNonQuery();
                        con.Close();


                        con.Open();
                        string sql3 = "SELECT * from candidates inner join status on dbo.status.status_id=dbo.candidates.candidate_status where status_id=2 ";
                        SqlCommand cmd3 = new SqlCommand(sql3, con);
                        SqlDataReader read3 = cmd3.ExecuteReader();
                        if (read3.HasRows == true)
                        {
                            GridView1.DataSource = read3;
                            GridView1.DataBind();
                        }
                        read3.Close();
                        con.Close();

                    }
                }

                if (tip > 0)
                {
                    Response.Write("Absence Registertion Completed");
                lbl_status.ForeColor = System.Drawing.Color.Green;
            lbl_status.Text = "Absence Registertion Completed";
                }
                else
                {
                    Response.Write("No Selected Candidates To Register The Absence");
                lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "No Selected Candidates To Register The Absence";
                }
            }
            else
            {
                Response.Write("Please Select Absence Date!");
            lbl_status.ForeColor = System.Drawing.Color.Red;
            lbl_status.Text = "Please Select Absence Date!";
            }

    }

    protected void btn_absence_daily_report_Click(object sender, EventArgs e)
    {
        Response.Redirect("absent_report.aspx");
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style6 {
            font-size: large;
            display:inline;
        }
        .auto-style7 {
            font-weight: bold;
            display: inline;
            color: #FFFFFF;
            background-color: #000000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <br />
        <strong><span class="auto-style6">Select Absence Date</span></strong><asp:ImageButton CssClass="auto-style6" ID="img_btn_absent_date" runat="server" ImageUrl="~/images/calender_icon.jpg" Height="20px" Width="20px" OnClick="img_btn_absent_date_Click" />&nbsp;<asp:Calendar ID="cln_absent_date" runat="server" BackColor="White" BorderColor="#999999" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Visible="False" Width="200px" OnSelectionChanged="cln_absent_date_SelectionChanged" CellPadding="4" DayNameFormat="Shortest" >
            <DayHeaderStyle Font-Bold="True" Font-Size="7pt" ForeColor="#333333" BackColor="#CCCCCC" />
            <NextPrevStyle Font-Bold="True" VerticalAlign="Bottom" />
            <OtherMonthDayStyle ForeColor="#808080" />
            <SelectedDayStyle BackColor="#666666" ForeColor="White" />
            <SelectorStyle BackColor="#CCCCCC" />
            <TitleStyle BackColor="#999999" Font-Bold="True" BorderStyle="Solid" Height="12pt" BorderColor="Black" />
            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
            <WeekendDayStyle BackColor="#FFFFCC" />
        </asp:Calendar>
        <asp:TextBox ID="txt_absent_date" runat="server" ReadOnly="True"></asp:TextBox>
</p>
    <p>
&nbsp;<asp:Button ID="btn_absence_register" runat="server" Text="Absence Register" CssClass="auto-style7" OnClick="btn_absence_register_Click" />
&nbsp;<strong><asp:Button ID="btn_admin_dashboard" runat="server" CssClass="auto-style7" OnClick="btn_admin_dashboard_Click" Text="Admin Dashboard" />
        &nbsp;<asp:Button ID="btn_absence_daily_report" runat="server" CssClass="auto-style7" Text="Absence Report" Width="220px" OnClick="btn_absence_daily_report_Click" />
&nbsp;</strong></p>
        <asp:GridView ID="GridView1" runat="server"  AutoGenerateColumns="False" CellPadding="4"  DataKeyNames="candidate_id" ForeColor="#333333" ShowFooter="True" GridLines="None" >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="candidate_id" HeaderText="ID" ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="candidate_code" HeaderText="Code" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="candidate_name" HeaderText="Name" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="candidate_email" HeaderText="Email" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="candidate_telephone" HeaderText="Tel." HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="candidate_address" HeaderText="Add." HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="candidate_notes" HeaderText="Comm." HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="status_type" HeaderText="Stat." ReadOnly="True" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="candidate_file_number" HeaderText="File#" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small"  >
<HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:BoundField>
                <asp:TemplateField HeaderText="Select" HeaderStyle-Font-Size="XX-Small" ItemStyle-Font-Size="XX-Small">
                    <ItemTemplate>
                        <asp:CheckBox ID="select_candidate" runat="server" />
                    </ItemTemplate>
                    <HeaderStyle Font-Size="XX-Small"></HeaderStyle>

<ItemStyle Font-Size="XX-Small"></ItemStyle>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    <br />
    <div>
        <asp:Label ID="lbl_status" runat="server" Text=""></asp:Label>
    </div>
    <br />
    </asp:Content>

