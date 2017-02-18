<%@ Import NameSpace="System.Drawing"%>
<%@ Import NameSpace="System.Drawing.Imaging"%>
<%@ Import NameSpace="System.Drawing.Text"%>
<%@ Import NameSpace="System.Drawing.Drawing2D"%>

<script language="VB" runat="server">

    Sub page_load()
        
        Session("captcha") = CORE.random_key("A|Z,A|Z,A|Z,A|Z,A|Z,A|Z")
        Dim w As Integer = 200
        Dim h As Integer = 100
        
        If Request("w") <> "" Then w = Convert.ToInt32(Request("w"))
        If Request("h") <> "" Then h = Convert.ToInt32(Request("h"))
        
        Dim img As CORE_CAPTCHA = New CORE_CAPTCHA(Session("captcha"), w, h)
            
        Response.ContentType = "image/JPEG"
        
        Dim captcha As Bitmap = img.Image()
        captcha.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg)
        captcha.Dispose()
       
    End Sub
    
</script>