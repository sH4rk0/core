<%@ Import NameSpace="System.Drawing"%>
<%@ Import NameSpace="System.Drawing.Imaging"%>
<%@ Import NameSpace="System.Drawing.Text"%>
<%@ Import NameSpace="System.Drawing.Drawing2D"%>

<script language="VB" runat="server">

    Sub page_load()
        
        Response.ContentType = ("image/jpeg")
                        
        Dim img As System.Drawing.Image = New Bitmap(Server.MapPath(Request("img")))
        Dim bm As Bitmap = New Bitmap(img)
        img.Dispose()
       
              
        Dim x As Int32 = 0
        Dim y As Int32 = 0
        Dim stored As String = String.Empty
        If Request("w") <> "" Then x = Request("w")
        If Request("h") <> "" Then y = Request("h")
           
        If x > 0 Or y > 0 Then
            
            If x > 0 And y = 0 Then
                stored = "[" & x.ToString & "x0]"
            ElseIf x = 0 And y > 0 Then
                stored = "[0x" & y.ToString & "]"
            Else
                stored = "[" & x.ToString & "x" & y.ToString & "]"
            End If
            
            Dim thumb As Bitmap = CORE.resizeImage(bm, x, y)
            Dim fileImageName As String = Server.MapPath(Request("img").Replace(".jpg", stored & ".jpg"))
            If Not CORE_filesystem.fileExists(fileImageName) Then thumb.Save(fileImageName, System.Drawing.Imaging.ImageFormat.Jpeg)
            thumb.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg)
            bm.Dispose()
            thumb.Dispose()
            
        Else
            bm.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg)
            bm.Dispose()
        End If

             
    End Sub
    
</script>