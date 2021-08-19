<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Session.Remove("admin_code");
        Session.Remove("candidate_code");
        Session.Remove("trainer_file_number");
        Session.Remove("mentor_file_number");
        Response.Redirect("index.html");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Thank You
    
    </div>
    </form>
</body>
</html>
