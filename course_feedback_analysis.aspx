<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dash_master.master" MaintainScrollPositionOnPostback="true" %>
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
        if(!IsPostBack)
        {
            string sql2 = "select course_code, course_title from daily_schedule";
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            con.Open();
            drop_courses_list.DataSource = cmd2.ExecuteReader();
            drop_courses_list.DataTextField = "course_title";
            drop_courses_list.DataValueField = "course_code";
            drop_courses_list.DataBind();
            ListItem selectlistitem = new ListItem("Select","-1");
            drop_courses_list.Items.Insert(0, selectlistitem);
            con.Close();
        }
        
    }

    protected void btn_analyize_Click(object sender, EventArgs e)
    {
       lbl_today.Text = DateTime.Now.ToString("dd/MM/yyyy");
        string sql10 = "select course_code, course_title, course_date, course_provider from daily_schedule where course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd10 = new SqlCommand(sql10, con);
        SqlDataReader read10= cmd10.ExecuteReader();
        while (read10.Read())
        {
            lbl_course_title.Text = (read10["course_title"].ToString());
            lbl_course_date2.Text = (read10["course_date"].ToString());
            DateTime dt = Convert.ToDateTime(lbl_course_date2.Text);
            string dt2 = dt.ToString("dd/MM/yyyy");
            lbl_course_date2.Text = dt2;
            lbl_course_provider.Text = (read10["course_provider"].ToString());


        }
        read10.Close();
        con.Close();

        string sql11 = "EXEC countq1_eval @eval_value=1 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd11 = new SqlCommand(sql11, con);
        SqlDataReader read11= cmd11.ExecuteReader();
        while (read11.Read())
        {
            lbl_q1_eval_1.Text = (read11["q1_count"].ToString());
        }
        read11.Close();
        con.Close();

        string sql12 = "EXEC countq1_eval @eval_value=2 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd12 = new SqlCommand(sql12, con);
        SqlDataReader read12= cmd12.ExecuteReader();
        while (read12.Read())
        {
            lbl_q1_eval_2.Text = (read12["q1_count"].ToString());
        }
        read12.Close();
        con.Close();

        string sql13 = "EXEC countq1_eval @eval_value=3 , @course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd13 = new SqlCommand(sql13, con);
        SqlDataReader read13= cmd13.ExecuteReader();
        while (read13.Read())
        {
            lbl_q1_eval_3.Text = (read13["q1_count"].ToString());
        }
        read13.Close();
        con.Close();

        string sql14 = "EXEC countq1_eval @eval_value=4 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd14 = new SqlCommand(sql14, con);
        SqlDataReader read14= cmd14.ExecuteReader();
        while (read14.Read())
        {
            lbl_q1_eval_4.Text = (read14["q1_count"].ToString());
        }
        read14.Close();
        con.Close();
        int q1_sum = Convert.ToInt32(lbl_q1_eval_1.Text) + Convert.ToInt32(lbl_q1_eval_2.Text) + Convert.ToInt32(lbl_q1_eval_3.Text) + Convert.ToInt32(lbl_q1_eval_4.Text);
        lbl_sum_q1_answers.Text = q1_sum.ToString();

        lbl_sample_size.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size2.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size3.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size4.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size5.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size6.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size7.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size8.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size9.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size10.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size11.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size12.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size13.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size14.Text = lbl_sum_q1_answers.Text;
        lbl_sample_size15.Text = lbl_sum_q1_answers.Text;

        string sql15 = "EXEC countq2_eval @eval_value=1 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd15 = new SqlCommand(sql15, con);
        SqlDataReader read15= cmd15.ExecuteReader();
        while (read15.Read())
        {
            lbl_q2_eval_1.Text = (read15["q2_count"].ToString());
        }
        read15.Close();
        con.Close();

        string sql16 = "EXEC countq2_eval @eval_value=2 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd16 = new SqlCommand(sql16, con);
        SqlDataReader read16= cmd16.ExecuteReader();
        while (read16.Read())
        {
            lbl_q2_eval_2.Text = (read16["q2_count"].ToString());
        }
        read16.Close();
        con.Close();

        string sql17 = "EXEC countq2_eval @eval_value=3 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd17 = new SqlCommand(sql17, con);
        SqlDataReader read17= cmd17.ExecuteReader();
        while (read17.Read())
        {
            lbl_q2_eval_3.Text = (read17["q2_count"].ToString());
        }
        read17.Close();
        con.Close();

        string sql18 = "EXEC countq2_eval @eval_value=4 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd18 = new SqlCommand(sql18, con);
        SqlDataReader read18= cmd18.ExecuteReader();
        while (read18.Read())
        {
            lbl_q2_eval_4.Text = (read18["q2_count"].ToString());
        }
        read18.Close();
        con.Close();
        int q2_sum = Convert.ToInt32(lbl_q2_eval_1.Text) + Convert.ToInt32(lbl_q2_eval_2.Text) + Convert.ToInt32(lbl_q2_eval_3.Text) + Convert.ToInt32(lbl_q2_eval_4.Text);
        lbl_sum_q2_answers.Text = q2_sum.ToString();

        string sql19 = "EXEC countq3_eval @eval_value=1 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd19 = new SqlCommand(sql19, con);
        SqlDataReader read19= cmd19.ExecuteReader();
        while (read19.Read())
        {
            lbl_q3_eval_1.Text = (read19["q3_count"].ToString());
        }
        read19.Close();
        con.Close();

        string sql20 = "EXEC countq3_eval @eval_value=2 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd20 = new SqlCommand(sql20, con);
        SqlDataReader read20= cmd20.ExecuteReader();
        while (read20.Read())
        {
            lbl_q3_eval_2.Text = (read20["q3_count"].ToString());
        }
        read20.Close();
        con.Close();

        string sql21 = "EXEC countq3_eval @eval_value=3 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd21 = new SqlCommand(sql21, con);
        SqlDataReader read21= cmd21.ExecuteReader();
        while (read21.Read())
        {
            lbl_q3_eval_3.Text = (read21["q3_count"].ToString());
        }
        read21.Close();
        con.Close();

        string sql22 = "EXEC countq3_eval @eval_value=4 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd22 = new SqlCommand(sql22, con);
        SqlDataReader read22= cmd22.ExecuteReader();
        while (read22.Read())
        {
            lbl_q3_eval_4.Text = (read22["q3_count"].ToString());
        }
        read22.Close();
        con.Close();
        int q3_sum = Convert.ToInt32(lbl_q3_eval_1.Text) + Convert.ToInt32(lbl_q3_eval_2.Text) + Convert.ToInt32(lbl_q3_eval_3.Text) + Convert.ToInt32(lbl_q3_eval_4.Text);
        lbl_sum_q3_answers.Text = q3_sum.ToString();

        string sql23 = "EXEC countq4_eval @eval_value=1 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd23 = new SqlCommand(sql23, con);
        SqlDataReader read23= cmd23.ExecuteReader();
        while (read23.Read())
        {
            lbl_q4_eval_1.Text = (read23["q4_count"].ToString());
        }
        read23.Close();
        con.Close();

        string sql24 = "EXEC countq4_eval @eval_value=2 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd24 = new SqlCommand(sql24, con);
        SqlDataReader read24= cmd24.ExecuteReader();
        while (read24.Read())
        {
            lbl_q4_eval_2.Text = (read24["q4_count"].ToString());
        }
        read24.Close();
        con.Close();

        string sql25 = "EXEC countq4_eval @eval_value=3 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd25 = new SqlCommand(sql25, con);
        SqlDataReader read25= cmd25.ExecuteReader();
        while (read25.Read())
        {
            lbl_q4_eval_3.Text = (read25["q4_count"].ToString());
        }
        read25.Close();
        con.Close();

        string sql26 = "EXEC countq4_eval @eval_value=4 ,@course_code='"+drop_courses_list.SelectedValue+"'";
        con.Open();
        SqlCommand cmd26 = new SqlCommand(sql26, con);
        SqlDataReader read26= cmd26.ExecuteReader();
        while (read26.Read())
        {
            lbl_q4_eval_4.Text = (read26["q4_count"].ToString());
        }
        read26.Close();
        con.Close();
        int q4_sum = Convert.ToInt32(lbl_q4_eval_1.Text) + Convert.ToInt32(lbl_q4_eval_2.Text) + Convert.ToInt32(lbl_q4_eval_3.Text) + Convert.ToInt32(lbl_q4_eval_4.Text);
        lbl_sum_q4_answers.Text = q4_sum.ToString();


        int q1_to_q4_poor_sum = Convert.ToInt32(lbl_q1_eval_1.Text) + Convert.ToInt32(lbl_q2_eval_1.Text) + Convert.ToInt32(lbl_q3_eval_1.Text) + Convert.ToInt32(lbl_q4_eval_1.Text);
        lbl_sum_q1_to_q4_poor.Text = q1_to_q4_poor_sum.ToString();

        int q1_to_q4_average_sum = Convert.ToInt32(lbl_q1_eval_2.Text) + Convert.ToInt32(lbl_q2_eval_2.Text) + Convert.ToInt32(lbl_q3_eval_2.Text) + Convert.ToInt32(lbl_q4_eval_2.Text);
        lbl_sum_q1_to_q4_average.Text = q1_to_q4_average_sum.ToString();

        int q1_to_q4_good_sum = Convert.ToInt32(lbl_q1_eval_3.Text) + Convert.ToInt32(lbl_q2_eval_3.Text) + Convert.ToInt32(lbl_q3_eval_3.Text) + Convert.ToInt32(lbl_q4_eval_3.Text);
        lbl_sum_q1_to_q4_good.Text = q1_to_q4_good_sum.ToString();

        int q1_to_q4_excellent_sum = Convert.ToInt32(lbl_q1_eval_4.Text) + Convert.ToInt32(lbl_q2_eval_4.Text) + Convert.ToInt32(lbl_q3_eval_4.Text) + Convert.ToInt32(lbl_q4_eval_4.Text);
        lbl_sum_q1_to_q4_excellent.Text = q1_to_q4_excellent_sum.ToString();

        int q1_to_q4_answers_sum = Convert.ToInt32(lbl_sum_q1_answers.Text) + Convert.ToInt32(lbl_sum_q2_answers.Text) + Convert.ToInt32(lbl_sum_q3_answers.Text) + Convert.ToInt32(lbl_sum_q4_answers.Text);
        lbl_sum_q1_to_q4_total.Text = q1_to_q4_answers_sum.ToString();

        if (lbl_sum_q1_to_q4_total.Text == "0")
        {
            Session["error"] = "invalid_feedback";
            Response.Redirect("Errors.aspx");

        }

        else
        {


            decimal q1_to_q4_poor_precentage = (Convert.ToDecimal(lbl_sum_q1_to_q4_poor.Text) / Convert.ToDecimal(lbl_sum_q1_to_q4_total.Text)) * 100;
            lbl_precentage_q1_to_q4_poor.Text = q1_to_q4_poor_precentage.ToString("N0") + "%";

            decimal q1_to_q4_average_precentage = (Convert.ToDecimal(lbl_sum_q1_to_q4_average.Text) / Convert.ToDecimal(lbl_sum_q1_to_q4_total.Text)) * 100;
            lbl_precentage_q1_to_q4_average.Text = q1_to_q4_average_precentage.ToString("N0") + "%";

            decimal q1_to_q4_good_precentage = (Convert.ToDecimal(lbl_sum_q1_to_q4_good.Text) / Convert.ToDecimal(lbl_sum_q1_to_q4_total.Text)) * 100;
            lbl_precentage_q1_to_q4_good.Text = q1_to_q4_good_precentage.ToString("N0") + "%";

            decimal q1_to_q4_excellent_precentage = (Convert.ToDecimal(lbl_sum_q1_to_q4_excellent.Text) / Convert.ToDecimal(lbl_sum_q1_to_q4_total.Text)) * 100;
            lbl_precentage_q1_to_q4_excellent.Text = q1_to_q4_excellent_precentage.ToString("N0") + "%";

            decimal q1_to_q4_total_precentage = (Convert.ToDecimal(lbl_sum_q1_to_q4_total.Text) / Convert.ToDecimal(lbl_sum_q1_to_q4_total.Text)) * 100;
            lbl_precentage_q1_to_q4_total.Text = q1_to_q4_total_precentage.ToString("N0") + "%";


            string sql27 = "EXEC countq5_eval @eval_value=1 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd27 = new SqlCommand(sql27, con);
            SqlDataReader read27 = cmd27.ExecuteReader();
            while (read27.Read())
            {
                lbl_q5_eval_1.Text = (read27["q5_count"].ToString());
            }
            read27.Close();
            con.Close();

            string sql28 = "EXEC countq5_eval @eval_value=2 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd28 = new SqlCommand(sql28, con);
            SqlDataReader read28 = cmd28.ExecuteReader();
            while (read28.Read())
            {
                lbl_q5_eval_2.Text = (read28["q5_count"].ToString());
            }
            read28.Close();
            con.Close();

            string sql29 = "EXEC countq5_eval @eval_value=3 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd29 = new SqlCommand(sql29, con);
            SqlDataReader read29 = cmd29.ExecuteReader();
            while (read29.Read())
            {
                lbl_q5_eval_3.Text = (read29["q5_count"].ToString());
            }
            read29.Close();
            con.Close();

            string sql30 = "EXEC countq5_eval @eval_value=4 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd30 = new SqlCommand(sql30, con);
            SqlDataReader read30 = cmd30.ExecuteReader();
            while (read30.Read())
            {
                lbl_q5_eval_4.Text = (read30["q5_count"].ToString());
            }
            read30.Close();
            con.Close();
            int q5_sum = Convert.ToInt32(lbl_q5_eval_1.Text) + Convert.ToInt32(lbl_q5_eval_2.Text) + Convert.ToInt32(lbl_q5_eval_3.Text) + Convert.ToInt32(lbl_q5_eval_4.Text);
            lbl_sum_q5_answers.Text = q5_sum.ToString();

            string sql31 = "EXEC countq6_eval @eval_value=1 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd31 = new SqlCommand(sql31, con);
            SqlDataReader read31 = cmd31.ExecuteReader();
            while (read31.Read())
            {
                lbl_q6_eval_1.Text = (read31["q6_count"].ToString());
            }
            read31.Close();
            con.Close();

            string sql32 = "EXEC countq6_eval @eval_value=2 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd32 = new SqlCommand(sql32, con);
            SqlDataReader read32 = cmd32.ExecuteReader();
            while (read32.Read())
            {
                lbl_q6_eval_2.Text = (read32["q6_count"].ToString());
            }
            read32.Close();
            con.Close();

            string sql33 = "EXEC countq6_eval @eval_value=3 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd33 = new SqlCommand(sql33, con);
            SqlDataReader read33 = cmd33.ExecuteReader();
            while (read33.Read())
            {
                lbl_q6_eval_3.Text = (read33["q6_count"].ToString());
            }
            read33.Close();
            con.Close();

            string sql34 = "EXEC countq6_eval @eval_value=4 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd34 = new SqlCommand(sql34, con);
            SqlDataReader read34 = cmd34.ExecuteReader();
            while (read34.Read())
            {
                lbl_q6_eval_4.Text = (read34["q6_count"].ToString());
            }
            read34.Close();
            con.Close();
            int q6_sum = Convert.ToInt32(lbl_q6_eval_1.Text) + Convert.ToInt32(lbl_q6_eval_2.Text) + Convert.ToInt32(lbl_q6_eval_3.Text) + Convert.ToInt32(lbl_q6_eval_4.Text);
            lbl_sum_q6_answers.Text = q6_sum.ToString();

            string sql35 = "EXEC countq7_eval @eval_value=1 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd35 = new SqlCommand(sql35, con);
            SqlDataReader read35 = cmd35.ExecuteReader();
            while (read35.Read())
            {
                lbl_q7_eval_1.Text = (read35["q7_count"].ToString());
            }
            read35.Close();
            con.Close();

            string sql36 = "EXEC countq7_eval @eval_value=2 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd36 = new SqlCommand(sql36, con);
            SqlDataReader read36 = cmd36.ExecuteReader();
            while (read36.Read())
            {
                lbl_q7_eval_2.Text = (read36["q7_count"].ToString());
            }
            read36.Close();
            con.Close();

            string sql37 = "EXEC countq7_eval @eval_value=3 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd37 = new SqlCommand(sql37, con);
            SqlDataReader read37 = cmd37.ExecuteReader();
            while (read37.Read())
            {
                lbl_q7_eval_3.Text = (read37["q7_count"].ToString());
            }
            read37.Close();
            con.Close();

            string sql38 = "EXEC countq7_eval @eval_value=4 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd38 = new SqlCommand(sql38, con);
            SqlDataReader read38 = cmd38.ExecuteReader();
            while (read38.Read())
            {
                lbl_q7_eval_4.Text = (read38["q7_count"].ToString());
            }
            read38.Close();
            con.Close();
            int q7_sum = Convert.ToInt32(lbl_q7_eval_1.Text) + Convert.ToInt32(lbl_q7_eval_2.Text) + Convert.ToInt32(lbl_q7_eval_3.Text) + Convert.ToInt32(lbl_q7_eval_4.Text);
            lbl_sum_q7_answers.Text = q7_sum.ToString();

            int q5_to_q7_poor_sum = Convert.ToInt32(lbl_q5_eval_1.Text) + Convert.ToInt32(lbl_q6_eval_1.Text) + Convert.ToInt32(lbl_q7_eval_1.Text);
            lbl_sum_q5_to_q7_poor.Text = q5_to_q7_poor_sum.ToString();

            int q5_to_q7_average_sum = Convert.ToInt32(lbl_q5_eval_2.Text) + Convert.ToInt32(lbl_q6_eval_2.Text) + Convert.ToInt32(lbl_q7_eval_2.Text);
            lbl_sum_q5_to_q7_average.Text = q5_to_q7_average_sum.ToString();

            int q5_to_q7_good_sum = Convert.ToInt32(lbl_q5_eval_3.Text) + Convert.ToInt32(lbl_q6_eval_3.Text) + Convert.ToInt32(lbl_q7_eval_3.Text);
            lbl_sum_q5_to_q7_good.Text = q5_to_q7_good_sum.ToString();

            int q5_to_q7_excellent_sum = Convert.ToInt32(lbl_q5_eval_4.Text) + Convert.ToInt32(lbl_q6_eval_4.Text) + Convert.ToInt32(lbl_q7_eval_4.Text);
            lbl_sum_q5_to_q7_excellent.Text = q5_to_q7_excellent_sum.ToString();

            int q5_to_q7_answers_sum = Convert.ToInt32(lbl_sum_q5_answers.Text) + Convert.ToInt32(lbl_sum_q6_answers.Text) + Convert.ToInt32(lbl_sum_q7_answers.Text);
            lbl_sum_q5_to_q7_total.Text = q5_to_q7_answers_sum.ToString();

            decimal q5_to_q7_poor_precentage = (Convert.ToDecimal(lbl_sum_q5_to_q7_poor.Text) / Convert.ToDecimal(lbl_sum_q5_to_q7_total.Text)) * 100;
            lbl_precentage_q5_to_q7_poor.Text = q5_to_q7_poor_precentage.ToString("N0") + "%";

            decimal q5_to_q7_average_precentage = (Convert.ToDecimal(lbl_sum_q5_to_q7_average.Text) / Convert.ToDecimal(lbl_sum_q5_to_q7_total.Text)) * 100;
            lbl_precentage_q5_to_q7_average.Text = q5_to_q7_average_precentage.ToString("N0") + "%";

            decimal q5_to_q7_good_precentage = (Convert.ToDecimal(lbl_sum_q5_to_q7_good.Text) / Convert.ToDecimal(lbl_sum_q5_to_q7_total.Text)) * 100;
            lbl_precentage_q5_to_q7_good.Text = q5_to_q7_good_precentage.ToString("N0") + "%";

            decimal q5_to_q7_excellent_precentage = (Convert.ToDecimal(lbl_sum_q5_to_q7_excellent.Text) / Convert.ToDecimal(lbl_sum_q5_to_q7_total.Text)) * 100;
            lbl_precentage_q5_to_q7_excellent.Text = q5_to_q7_excellent_precentage.ToString("N0") + "%";

            decimal q5_to_q7_total_precentage = (Convert.ToDecimal(lbl_sum_q5_to_q7_total.Text) / Convert.ToDecimal(lbl_sum_q5_to_q7_total.Text)) * 100;
            lbl_precentage_q5_to_q7_total.Text = q5_to_q7_total_precentage.ToString("N0") + "%";

            string sql39 = "EXEC countq8_eval @eval_value=1 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd39 = new SqlCommand(sql39, con);
            SqlDataReader read39 = cmd39.ExecuteReader();
            while (read39.Read())
            {
                lbl_q8_eval_1.Text = (read39["q8_count"].ToString());
            }
            read39.Close();
            con.Close();

            string sql40 = "EXEC countq8_eval @eval_value=2 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd40 = new SqlCommand(sql40, con);
            SqlDataReader read40 = cmd40.ExecuteReader();
            while (read40.Read())
            {
                lbl_q8_eval_2.Text = (read40["q8_count"].ToString());
            }
            read40.Close();
            con.Close();

            string sql41 = "EXEC countq8_eval @eval_value=3 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd41 = new SqlCommand(sql41, con);
            SqlDataReader read41 = cmd41.ExecuteReader();
            while (read41.Read())
            {
                lbl_q8_eval_3.Text = (read41["q8_count"].ToString());
            }
            read41.Close();
            con.Close();

            string sql42 = "EXEC countq8_eval @eval_value=4 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd42 = new SqlCommand(sql42, con);
            SqlDataReader read42 = cmd42.ExecuteReader();
            while (read42.Read())
            {
                lbl_q8_eval_4.Text = (read42["q8_count"].ToString());
            }
            read42.Close();
            con.Close();
            int q8_sum = Convert.ToInt32(lbl_q8_eval_1.Text) + Convert.ToInt32(lbl_q8_eval_2.Text) + Convert.ToInt32(lbl_q8_eval_3.Text) + Convert.ToInt32(lbl_q8_eval_4.Text);
            lbl_sum_q8_answers.Text = q8_sum.ToString();


            string sql43 = "EXEC countq9_eval @eval_value=1 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd43 = new SqlCommand(sql43, con);
            SqlDataReader read43 = cmd43.ExecuteReader();
            while (read43.Read())
            {
                lbl_q9_eval_1.Text = (read43["q9_count"].ToString());
            }
            read43.Close();
            con.Close();

            string sql44 = "EXEC countq9_eval @eval_value=2 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd44 = new SqlCommand(sql44, con);
            SqlDataReader read44 = cmd44.ExecuteReader();
            while (read44.Read())
            {
                lbl_q9_eval_2.Text = (read44["q9_count"].ToString());
            }
            read44.Close();
            con.Close();

            string sql45 = "EXEC countq9_eval @eval_value=3 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd45 = new SqlCommand(sql45, con);
            SqlDataReader read45 = cmd45.ExecuteReader();
            while (read45.Read())
            {
                lbl_q9_eval_3.Text = (read45["q9_count"].ToString());
            }
            read45.Close();
            con.Close();

            string sql46 = "EXEC countq9_eval @eval_value=4 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd46 = new SqlCommand(sql46, con);
            SqlDataReader read46 = cmd46.ExecuteReader();
            while (read46.Read())
            {
                lbl_q9_eval_4.Text = (read46["q9_count"].ToString());
            }
            read46.Close();
            con.Close();
            int q9_sum = Convert.ToInt32(lbl_q9_eval_1.Text) + Convert.ToInt32(lbl_q9_eval_2.Text) + Convert.ToInt32(lbl_q9_eval_3.Text) + Convert.ToInt32(lbl_q9_eval_4.Text);
            lbl_sum_q9_answers.Text = q9_sum.ToString();

            string sql47 = "EXEC countq10_eval @eval_value=1 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd47 = new SqlCommand(sql47, con);
            SqlDataReader read47 = cmd47.ExecuteReader();
            while (read47.Read())
            {
                lbl_q10_eval_1.Text = (read47["q10_count"].ToString());
            }
            read47.Close();
            con.Close();

            string sql48 = "EXEC countq10_eval @eval_value=2 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd48 = new SqlCommand(sql48, con);
            SqlDataReader read48 = cmd48.ExecuteReader();
            while (read48.Read())
            {
                lbl_q10_eval_2.Text = (read48["q10_count"].ToString());
            }
            read48.Close();
            con.Close();

            string sql49 = "EXEC countq10_eval @eval_value=3 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd49 = new SqlCommand(sql49, con);
            SqlDataReader read49 = cmd49.ExecuteReader();
            while (read49.Read())
            {
                lbl_q10_eval_3.Text = (read49["q10_count"].ToString());
            }
            read49.Close();
            con.Close();

            string sql50 = "EXEC countq10_eval @eval_value=4 ,@course_code='" + drop_courses_list.SelectedValue + "'";
            con.Open();
            SqlCommand cmd50 = new SqlCommand(sql50, con);
            SqlDataReader read50 = cmd50.ExecuteReader();
            while (read50.Read())
            {
                lbl_q10_eval_4.Text = (read50["q10_count"].ToString());
            }
            read50.Close();
            con.Close();
            int q10_sum = Convert.ToInt32(lbl_q10_eval_1.Text) + Convert.ToInt32(lbl_q10_eval_2.Text) + Convert.ToInt32(lbl_q10_eval_3.Text) + Convert.ToInt32(lbl_q10_eval_4.Text);
            lbl_sum_q10_answers.Text = q10_sum.ToString();

            int q8_to_q10_poor_sum = Convert.ToInt32(lbl_q8_eval_1.Text) + Convert.ToInt32(lbl_q9_eval_1.Text) + Convert.ToInt32(lbl_q10_eval_1.Text);
            lbl_sum_q8_to_q10_poor.Text = q8_to_q10_poor_sum.ToString();

            int q8_to_q10_average_sum = Convert.ToInt32(lbl_q8_eval_2.Text) + Convert.ToInt32(lbl_q9_eval_2.Text) + Convert.ToInt32(lbl_q10_eval_2.Text);
            lbl_sum_q8_to_q10_average.Text = q8_to_q10_average_sum.ToString();

            int q8_to_q10_good_sum = Convert.ToInt32(lbl_q8_eval_3.Text) + Convert.ToInt32(lbl_q9_eval_3.Text) + Convert.ToInt32(lbl_q10_eval_3.Text);
            lbl_sum_q8_to_q10_good.Text = q8_to_q10_good_sum.ToString();

            int q8_to_q10_excellent_sum = Convert.ToInt32(lbl_q8_eval_4.Text) + Convert.ToInt32(lbl_q9_eval_4.Text) + Convert.ToInt32(lbl_q10_eval_4.Text);
            lbl_sum_q8_to_q10_excellent.Text = q8_to_q10_excellent_sum.ToString();

            int q8_to_q10_answers_sum = Convert.ToInt32(lbl_sum_q8_answers.Text) + Convert.ToInt32(lbl_sum_q9_answers.Text) + Convert.ToInt32(lbl_sum_q10_answers.Text);
            lbl_sum_q8_to_q10_total.Text = q8_to_q10_answers_sum.ToString();

            decimal q8_to_q10_poor_precentage = (Convert.ToDecimal(lbl_sum_q8_to_q10_poor.Text) / Convert.ToDecimal(lbl_sum_q8_to_q10_total.Text)) * 100;
            lbl_precentage_q8_to_q10_poor.Text = q8_to_q10_poor_precentage.ToString("N0") + "%";

            decimal q8_to_q10_average_precentage = (Convert.ToDecimal(lbl_sum_q8_to_q10_average.Text) / Convert.ToDecimal(lbl_sum_q8_to_q10_total.Text)) * 100;
            lbl_precentage_q8_to_q10_average.Text = q8_to_q10_average_precentage.ToString("N0") + "%";

            decimal q8_to_q10_good_precentage = (Convert.ToDecimal(lbl_sum_q8_to_q10_good.Text) / Convert.ToDecimal(lbl_sum_q8_to_q10_total.Text)) * 100;
            lbl_precentage_q8_to_q10_good.Text = q8_to_q10_good_precentage.ToString("N0") + "%";

            decimal q8_to_q10_excellent_precentage = (Convert.ToDecimal(lbl_sum_q8_to_q10_excellent.Text) / Convert.ToDecimal(lbl_sum_q8_to_q10_total.Text)) * 100;
            lbl_precentage_q8_to_q10_excellent.Text = q8_to_q10_excellent_precentage.ToString("N0") + "%";

            decimal q8_to_q10_total_precentage = (Convert.ToDecimal(lbl_sum_q8_to_q10_total.Text) / Convert.ToDecimal(lbl_sum_q8_to_q10_total.Text)) * 100;
            lbl_precentage_q8_to_q10_total.Text = q8_to_q10_total_precentage.ToString("N0") + "%";

        }
       

    }

    protected void btn_admin_dashboard_Click(object sender, EventArgs e)
    {
        Response.Redirect("admin_dashboard.aspx");
    }
    
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style5 {
            font-weight: bold;
            display:inline-block;
        }
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
        .auto-style16 {
            border-style: solid;
            border-color: inherit;
            border-width: medium;
            width: 25%;
            height: 100%;
            color: #003399;
        }
        .auto-style19 {
            border-style: solid;
            border-color: inherit;
            border-width: medium;
            width: 25%;
            height: 100%;
            color: #003399;
        }
        .auto-style20 {
            border-style: solid;
            border-color: inherit;
            border-width: medium;
height: 100%;
            text-align: center;
        }
        .auto-style21 {
            width: 100%;
            height:100%;
            border-collapse: collapse;
            border: 5px solid #000000;
            
        }
        .auto-style46 {
            width: 100%;
            text-align: right;
            height: 100%;
        }
        .auto-style52 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style53 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style55 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style57 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style61 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style86 {
            width: 100%;
            text-align: right;
            height: 100%;
        }
        .auto-style91 {
            width: 100%;
            text-align: right;
            height: 100%;
        }
        .auto-style114 {
            width: 100%;
            height: 100%;
        }
        .auto-style115 {
            height: 100%;
            text-align: center;
        }
        .auto-style116 {
            border-style: solid;
            border-color: inherit;
            border-width: medium;
            width: 25%;
            height: 100%;
            color: #003399;
        }
        .auto-style117 {
            border-style: solid;
            border-color: inherit;
            border-width: medium;
            height: 100%;
            text-align: center;
        }
        .auto-style118 {
            width: 100%;
            height: 100%;
            color: #003399;
            text-decoration: underline;
        }
        .auto-style120 {
            color: #000000;
        }
        .auto-style124 {
            width: 100%;
            text-align: center;
            height: 100%;
        }
        .auto-style134 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style135 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style136 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style137 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style138 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style139 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style140 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style141 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style142 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style143 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style144 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style145 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style146 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style147 {
            width: 100%;
            height: 100%;
            text-align: center;
        }
        .auto-style148 {
            width: 100%;
            text-align: right;
            height: 100%;
        }
        .auto-style149 {
            font-weight: bold;
            display: inline-block;
            color: #FFFFFF;
            background-color: #000000;
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
            width: 100%;
            height: 100%;
            color: #000000;
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
    </p>
    <p class="auto-style2">
        <asp:DropDownList ID="drop_courses_list" runat="server" CssClass="auto-style5">
        </asp:DropDownList>
    &nbsp;<strong><asp:Button ID="btn_analyize" runat="server" CssClass="auto-style149" OnClick="btn_analyize_Click" Text="Analyize Feedback" />
        &nbsp;<asp:Button ID="btn_admin_dashboard" runat="server" CssClass="auto-style149" OnClick="btn_admin_dashboard_Click" Text="Admin Dashboard" />
        &nbsp;</strong><asp:Button ID="btn_print" CssClass="auto-style149" runat="server" Text="Print" OnClientClick="javascript:printdiv('divprint');" />
    </p>
    <div id="divprint">
    <div class="auto-style2" >

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
                <td class="auto-style11" colspan="2">Ref.No. : QR7.2.0/3</td>
            </tr>
            <tr>
                <td rowspan="2" class="auto-style152"><strong>Document Title<br />
                    Course feedback analysis</strong></td>
                <td class="auto-style154">Issue: 02.</td>
                <td class="auto-style11">Rev:00</td>
            </tr>
            <tr>
                <td colspan="2" style="border:solid">Issuing Date:
                    <asp:Label ID="lbl_today" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

    </div>
    <div>

        <strong>1- Training Information:
        </strong>
        <table class="auto-style8" >
            <tr>
                <td class="auto-style19"><strong>Course Title:</strong></td>
                <td class="auto-style20">
                    <asp:Label ID="lbl_course_title" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style116"><strong>Training Date:</strong></td>
                <td class="auto-style117">
                    <asp:Label ID="lbl_course_date2" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style16"><strong>Trainer&#39;s Name:</strong></td>
                <td class="auto-style115">
                    <asp:Label ID="lbl_course_provider" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

    </div>
    <div>

        <strong>

        2- Training Feedback:</strong><table class="auto-style21">
            <tr>
                <td class="auto-style118" ><strong>Course Feedback</strong></td>
                <td class="auto-style61" style="border:solid">Poor</td>
                <td class="auto-style55" style="border:solid">average</td>
                <td class="auto-style57" style="border:solid">Good</td>
                <td class="auto-style53" style="border:solid">Excellent</td>
                <td class="auto-style52" style="border:solid">TOTAL</td>
            </tr>
            <tr>
                <td class="auto-style155"><strong>1- Were the topics covered in sufficient detail?</strong></td>
                <td class="auto-style138" style="border:solid">
                    <asp:Label ID="lbl_q1_eval_1" runat="server"></asp:Label>
                </td>
                <td class="auto-style137" style="border:solid">
                    <asp:Label ID="lbl_q1_eval_2" runat="server"></asp:Label>
                </td>
                <td class="auto-style136" style="border:solid">
                    <asp:Label ID="lbl_q1_eval_3" runat="server" Text=""></asp:Label>
                </td>
                <td class="auto-style135" style="border:solid">
                    <asp:Label ID="lbl_q1_eval_4" runat="server"></asp:Label>
                </td>
                <td class="auto-style134" style="border:solid">
                    <asp:Label ID="lbl_sum_q1_answers" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style155"><strong>2- was the content suited to your requirments?</strong></td>
                <td class="auto-style138" style="border:solid">
                    <asp:Label ID="lbl_q2_eval_1" runat="server"></asp:Label>
                </td>
                <td class="auto-style137" style="border:solid">
                    <asp:Label ID="lbl_q2_eval_2" runat="server"></asp:Label>
                </td>
                <td class="auto-style136" style="border:solid">
                    <asp:Label ID="lbl_q2_eval_3" runat="server"></asp:Label>
                </td>
                <td class="auto-style135" style="border:solid">
                    <asp:Label ID="lbl_q2_eval_4" runat="server"></asp:Label>
                </td>
                <td class="auto-style134" style="border:solid">
                    <asp:Label ID="lbl_sum_q2_answers" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style114"><span class="auto-style120"><strong>3- How easy was the course to understand</strong></span>?</td>
                <td class="auto-style138"style="border:solid">
                    <asp:Label ID="lbl_q3_eval_1" runat="server"></asp:Label>
                </td>
                <td class="auto-style137"style="border:solid">
                    <asp:Label ID="lbl_q3_eval_2" runat="server"></asp:Label>
                </td>
                <td class="auto-style136"style="border:solid">
                    <asp:Label ID="lbl_q3_eval_3" runat="server"></asp:Label>
                </td>
                <td class="auto-style135"style="border:solid">
                    <asp:Label ID="lbl_q3_eval_4" runat="server"></asp:Label>
                </td>
                <td class="auto-style134"style="border:solid">
                    <asp:Label ID="lbl_sum_q3_answers" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style155"><strong>4- Woud you recommend this course to others?</strong></td>
                <td class="auto-style138"style="border:solid">
                    <asp:Label ID="lbl_q4_eval_1" runat="server"></asp:Label>
                </td>
                <td class="auto-style137"style="border:solid">
                    <asp:Label ID="lbl_q4_eval_2" runat="server"></asp:Label>
                </td>
                <td class="auto-style136"style="border:solid">
                    <asp:Label ID="lbl_q4_eval_3" runat="server"></asp:Label>
                </td>
                <td class="auto-style135"style="border:solid">
                    <asp:Label ID="lbl_q4_eval_4" runat="server"></asp:Label>
                </td>
                <td class="auto-style134"style="border:solid">
                    <asp:Label ID="lbl_sum_q4_answers" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style46"><strong>&nbsp;&nbsp;&nbsp; TOTAL:</strong></td>
                <td class="auto-style138"style="border:solid">
                    <asp:Label ID="lbl_sum_q1_to_q4_poor" runat="server"></asp:Label>
                </td>
                <td class="auto-style137"style="border:solid">
                    <asp:Label ID="lbl_sum_q1_to_q4_average" runat="server"></asp:Label>
                </td>
                <td class="auto-style136"style="border:solid">
                    <asp:Label ID="lbl_sum_q1_to_q4_good" runat="server"></asp:Label>
                </td>
                <td class="auto-style135"style="border:solid">
                    <asp:Label ID="lbl_sum_q1_to_q4_excellent" runat="server"></asp:Label>
                </td>
                <td class="auto-style134"style="border:solid">
                    <asp:Label ID="lbl_sum_q1_to_q4_total" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style86"><strong>Sample Size&nbsp;:</strong></td>
                <td class="auto-style147"style="border:solid">
                    <asp:Label ID="lbl_sample_size" runat="server"></asp:Label>
                </td>
                <td class="auto-style146"style="border:solid">
                    <asp:Label ID="lbl_sample_size2" runat="server"></asp:Label>
                </td>
                <td class="auto-style145"style="border:solid">
                    <asp:Label ID="lbl_sample_size3" runat="server"></asp:Label>
                </td>
                <td class="auto-style144"style="border:solid">
                    <asp:Label ID="lbl_sample_size4" runat="server"></asp:Label>
                </td>
                <td class="auto-style124"style="border:solid">
                    <asp:Label ID="lbl_sample_size5" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style91" ><strong>Precentag&nbsp;:</strong></td>
                <td class="auto-style143"style="border:solid">
                    <asp:Label ID="lbl_precentage_q1_to_q4_poor" runat="server"></asp:Label>
                </td>
                <td class="auto-style142"style="border:solid">
                    <asp:Label ID="lbl_precentage_q1_to_q4_average" runat="server"></asp:Label>
                </td>
                <td class="auto-style141"style="border:solid">
                    <asp:Label ID="lbl_precentage_q1_to_q4_good" runat="server"></asp:Label>
                </td>
                <td class="auto-style140"style="border:solid">
                    <asp:Label ID="lbl_precentage_q1_to_q4_excellent" runat="server"></asp:Label>
                </td>
                <td class="auto-style139"style="border:solid">
                    <asp:Label ID="lbl_precentage_q1_to_q4_total" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

    </div>

    <div>

        <table class="auto-style21">
            <tr>
                <td class="auto-style118" ><strong>Was the trainer prepared?</strong></td>
                <td class="auto-style61" style="border:solid">Poor</td>
                <td class="auto-style55" style="border:solid">average</td>
                <td class="auto-style57" style="border:solid">Good</td>
                <td class="auto-style53" style="border:solid">Excellent</td>
                <td class="auto-style52" style="border:solid">TOTAL</td>
            </tr>
            <tr>
                <td class="auto-style155"><strong>1- How well conucted was the training?</strong></td>
                <td class="auto-style138" style="border:solid">
                    <asp:Label ID="lbl_q5_eval_1" runat="server"></asp:Label>
                </td>
                <td class="auto-style137" style="border:solid">
                    <asp:Label ID="lbl_q5_eval_2" runat="server"></asp:Label>
                </td>
                <td class="auto-style136" style="border:solid">
                    <asp:Label ID="lbl_q5_eval_3" runat="server"></asp:Label>
                </td>
                <td class="auto-style135" style="border:solid">
                    <asp:Label ID="lbl_q5_eval_4" runat="server"></asp:Label>
                </td>
                <td class="auto-style134" style="border:solid">
                    <asp:Label ID="lbl_sum_q5_answers" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style155"><strong>2- How well paced was the delivery of information?</strong></td>
                <td class="auto-style138" style="border:solid">
                    <asp:Label ID="lbl_q6_eval_1" runat="server"></asp:Label>
                </td>
                <td class="auto-style137" style="border:solid">
                    <asp:Label ID="lbl_q6_eval_2" runat="server"></asp:Label>
                </td>
                <td class="auto-style136" style="border:solid">
                    <asp:Label ID="lbl_q6_eval_3" runat="server"></asp:Label>
                </td>
                <td class="auto-style135" style="border:solid">
                    <asp:Label ID="lbl_q6_eval_4" runat="server"></asp:Label>
                </td>
                <td class="auto-style134" style="border:solid">
                    <asp:Label ID="lbl_sum_q6_answers" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style155"><strong>3- How effectively did the trainer deliver the material?</strong></td>
                <td class="auto-style138"style="border:solid">
                    <asp:Label ID="lbl_q7_eval_1" runat="server"></asp:Label>
                </td>
                <td class="auto-style137"style="border:solid">
                    <asp:Label ID="lbl_q7_eval_2" runat="server"></asp:Label>
                </td>
                <td class="auto-style136"style="border:solid">
                    <asp:Label ID="lbl_q7_eval_3" runat="server"></asp:Label>
                </td>
                <td class="auto-style135"style="border:solid">
                    <asp:Label ID="lbl_q7_eval_4" runat="server"></asp:Label>
                </td>
                <td class="auto-style134"style="border:solid">
                    <asp:Label ID="lbl_sum_q7_answers" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style46"><strong>&nbsp;&nbsp;&nbsp; TOTAL:</strong></td>
                <td class="auto-style138"style="border:solid">
                    <asp:Label ID="lbl_sum_q5_to_q7_poor" runat="server"></asp:Label>
                </td>
                <td class="auto-style137"style="border:solid">
                    <asp:Label ID="lbl_sum_q5_to_q7_average" runat="server"></asp:Label>
                </td>
                <td class="auto-style136"style="border:solid">
                    <asp:Label ID="lbl_sum_q5_to_q7_good" runat="server"></asp:Label>
                </td>
                <td class="auto-style135"style="border:solid">
                    <asp:Label ID="lbl_sum_q5_to_q7_excellent" runat="server"></asp:Label>
                </td>
                <td class="auto-style134"style="border:solid">
                    <asp:Label ID="lbl_sum_q5_to_q7_total" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style86"><strong>Sample Size&nbsp;:</strong></td>
                <td class="auto-style147"style="border:solid">
                    <asp:Label ID="lbl_sample_size6" runat="server"></asp:Label>
                </td>
                <td class="auto-style146"style="border:solid">
                    <asp:Label ID="lbl_sample_size7" runat="server"></asp:Label>
                </td>
                <td class="auto-style145"style="border:solid">
                    <asp:Label ID="lbl_sample_size8" runat="server"></asp:Label>
                </td>
                <td class="auto-style144"style="border:solid">
                    <asp:Label ID="lbl_sample_size9" runat="server"></asp:Label>
                </td>
                <td class="auto-style124"style="border:solid">
                    <asp:Label ID="lbl_sample_size10" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style91" ><strong>Precentag&nbsp;:</strong></td>
                <td class="auto-style143"style="border:solid">
                    <asp:Label ID="lbl_precentage_q5_to_q7_poor" runat="server"></asp:Label>
                </td>
                <td class="auto-style142"style="border:solid">
                    <asp:Label ID="lbl_precentage_q5_to_q7_average" runat="server"></asp:Label>
                </td>
                <td class="auto-style141"style="border:solid">
                    <asp:Label ID="lbl_precentage_q5_to_q7_good" runat="server"></asp:Label>
                </td>
                <td class="auto-style140"style="border:solid">
                    <asp:Label ID="lbl_precentage_q5_to_q7_excellent" runat="server"></asp:Label>
                </td>
                <td class="auto-style139"style="border:solid">
                    <asp:Label ID="lbl_precentage_q5_to_q7_total" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

    </div>

    <div>

        <table class="auto-style21">
            <tr>
                <td class="auto-style118" ><strong>Facilities</strong></td>
                <td class="auto-style61" style="border:solid">Poor</td>
                <td class="auto-style55" style="border:solid">average</td>
                <td class="auto-style57" style="border:solid">Good</td>
                <td class="auto-style53" style="border:solid">Excellent</td>
                <td class="auto-style52" style="border:solid">TOTAL</td>
            </tr>
            <tr>
                <td class="auto-style155"><strong>1- Were the training rooms as you expected?</strong></td>
                <td class="auto-style138" style="border:solid">
                    <asp:Label ID="lbl_q8_eval_1" runat="server"></asp:Label>
                </td>
                <td class="auto-style137" style="border:solid">
                    <asp:Label ID="lbl_q8_eval_2" runat="server"></asp:Label>
                </td>
                <td class="auto-style136" style="border:solid">
                    <asp:Label ID="lbl_q8_eval_3" runat="server"></asp:Label>
                </td>
                <td class="auto-style135" style="border:solid">
                    <asp:Label ID="lbl_q8_eval_4" runat="server"></asp:Label>
                </td>
                <td class="auto-style134" style="border:solid">
                    <asp:Label ID="lbl_sum_q8_answers" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style155"><strong>2- Was the standard of the equipment satisfactory?</strong></td>
                <td class="auto-style138" style="border:solid">
                    <asp:Label ID="lbl_q9_eval_1" runat="server"></asp:Label>
                </td>
                <td class="auto-style137" style="border:solid">
                    <asp:Label ID="lbl_q9_eval_2" runat="server"></asp:Label>
                </td>
                <td class="auto-style136" style="border:solid">
                    <asp:Label ID="lbl_q9_eval_3" runat="server"></asp:Label>
                </td>
                <td class="auto-style135" style="border:solid">
                    <asp:Label ID="lbl_q9_eval_4" runat="server"></asp:Label>
                </td>
                <td class="auto-style134" style="border:solid">
                    <asp:Label ID="lbl_sum_q9_answers" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style155"><strong>3- Were you satisfied with the refreshment facilities?</strong></td>
                <td class="auto-style138"style="border:solid">
                    <asp:Label ID="lbl_q10_eval_1" runat="server"></asp:Label>
                </td>
                <td class="auto-style137"style="border:solid">
                    <asp:Label ID="lbl_q10_eval_2" runat="server"></asp:Label>
                </td>
                <td class="auto-style136"style="border:solid">
                    <asp:Label ID="lbl_q10_eval_3" runat="server"></asp:Label>
                </td>
                <td class="auto-style135"style="border:solid">
                    <asp:Label ID="lbl_q10_eval_4" runat="server"></asp:Label>
                </td>
                <td class="auto-style134"style="border:solid">
                    <asp:Label ID="lbl_sum_q10_answers" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style148"><strong>&nbsp;&nbsp;&nbsp; TOTAL:</strong></td>
                <td class="auto-style138"style="border:solid">
                    <asp:Label ID="lbl_sum_q8_to_q10_poor" runat="server"></asp:Label>
                </td>
                <td class="auto-style137"style="border:solid">
                    <asp:Label ID="lbl_sum_q8_to_q10_average" runat="server"></asp:Label>
                </td>
                <td class="auto-style136"style="border:solid">
                    <asp:Label ID="lbl_sum_q8_to_q10_good" runat="server"></asp:Label>
                </td>
                <td class="auto-style135"style="border:solid">
                    <asp:Label ID="lbl_sum_q8_to_q10_excellent" runat="server"></asp:Label>
                </td>
                <td class="auto-style134"style="border:solid">
                    <asp:Label ID="lbl_sum_q8_to_q10_total" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style86"><strong>Sample Size&nbsp;:</strong></td>
                <td class="auto-style147"style="border:solid">
                    <asp:Label ID="lbl_sample_size11" runat="server"></asp:Label>
                </td>
                <td class="auto-style146"style="border:solid">
                    <asp:Label ID="lbl_sample_size12" runat="server"></asp:Label>
                </td>
                <td class="auto-style145"style="border:solid">
                    <asp:Label ID="lbl_sample_size13" runat="server"></asp:Label>
                </td>
                <td class="auto-style144"style="border:solid">
                    <asp:Label ID="lbl_sample_size14" runat="server"></asp:Label>
                </td>
                <td class="auto-style124"style="border:solid">
                    <asp:Label ID="lbl_sample_size15" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style91" ><strong>Precentag&nbsp;:</strong></td>
                <td class="auto-style143"style="border:solid">
                    <asp:Label ID="lbl_precentage_q8_to_q10_poor" runat="server"></asp:Label>
                </td>
                <td class="auto-style142"style="border:solid">
                    <asp:Label ID="lbl_precentage_q8_to_q10_average" runat="server"></asp:Label>
                </td>
                <td class="auto-style141"style="border:solid">
                    <asp:Label ID="lbl_precentage_q8_to_q10_good" runat="server"></asp:Label>
                </td>
                <td class="auto-style140"style="border:solid">
                    <asp:Label ID="lbl_precentage_q8_to_q10_excellent" runat="server"></asp:Label>
                </td>
                <td class="auto-style139"style="border:solid">
                    <asp:Label ID="lbl_precentage_q8_to_q10_total" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

    </div>
        </div>
</asp:Content>

