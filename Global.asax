<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
       

    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs
        Response.Redirect("Errors.aspx");

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started
        //Session["init"] = 0;
       // Session["init"] = "session start";

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

    protected void Application_PreSendRequestHeaders()
{
    Response.Headers.Remove("Server");
    Response.Headers.Remove("X-AspNet-Version");
    Response.Headers.Remove("X-AspNetMvc-Version");
     
}
</script>
