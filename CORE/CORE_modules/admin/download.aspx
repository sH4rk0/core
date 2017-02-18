 
<Script runat="Server">

   
    Dim mymaterial As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED
    
    Sub Page_Load()

        Try
            
            
       
            Dim _id_material As Integer = CORE.getIntValue(HttpContext.Current.Request.Url.ToString(), "download-", "-")

            mymaterial = New CORE_CONTENT_RELATED(_id_material)
      
            Dim _material_type As Integer = mymaterial.related_tipology
            Dim _material_filename As String = mymaterial.related_link
            Dim _material_title As String = mymaterial.content_title
        
            mymaterial.related_downloads = mymaterial.related_downloads + 1
            mymaterial.content_related_update(mymaterial)
            
            If _material_type = 1 Then Response.Redirect(_material_filename)
            
            Dim path As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString()

            
            
            If _material_filename <> String.Empty And CORE_filesystem.fileExists(Server.MapPath(path & _material_filename)) Then
               
                     
            
                Dim ext As String = Right(_material_filename.ToLower, 3)
            
                _material_filename = _material_title & "." & ext
                
                Select Case ext

                    Case "gif"
                        Response.ContentType = "image/gif"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".gif")
                        Response.WriteFile(Server.MapPath(path & _material_filename))

                    Case "jpg"
                        Response.ContentType = "image/JPEG"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".jpg")
                        Response.WriteFile(Server.MapPath(path & _material_filename))

                    Case "mp3"
                        Response.ContentType = "audio/mpeg"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".mp3")
                        Response.WriteFile(Server.MapPath(path & _material_filename))

                    Case "flv"
                        Response.ContentType = "application/octet-stream"

                    Case "doc"
                        Response.ContentType = "application/msword"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".doc")
                        Response.WriteFile(Server.MapPath(path & _material_filename))
                
                    Case "rtf"
                        Response.ContentType = "application/rtf"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".doc")
                        Response.WriteFile(Server.MapPath(path & _material_filename))

                    Case "pdf"
                        Response.ContentType = "application/pdf"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".pdf")
                        Response.WriteFile(Server.MapPath(path & _material_filename))

                    Case "rar"
                        Response.ContentType = "application/octet-stream"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".rar")
                        Response.WriteFile(Server.MapPath(path & _material_filename))
            
                    Case "exe"
                        Response.ContentType = "application/octet-stream"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".rar")
                        Response.WriteFile(Server.MapPath(path & _material_filename))
            
                    Case "zip"
                        Response.ContentType = "application/zip"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".zip")
                        Response.WriteFile(Server.MapPath(path & _material_filename))

                    Case "txt"
                        Response.ContentType = "text/plain"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".txt")
                        Response.WriteFile(Server.MapPath(path & _material_filename))

                    Case "ppt"
                        Response.ContentType = "application/vnd.ms-powerpoint"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".ppt")
                        Response.WriteFile(Server.MapPath(path & _material_filename))

                    Case "xls"
                        Response.ContentType = "application/vnd.ms-excel"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & CORE_formatting.urlFilter(_material_title) & ".xls")
                        Response.WriteFile(Server.MapPath(path & _material_filename))

                    Case "swf"
                        Response.ContentType = "application/x-shockwave-flash"


                End Select
            
            Else
            
                Response.Redirect("/error_404.html")
                
            End If
            
            
            
            
                
            If Not mymaterial Is Nothing Then mymaterial.Dispose() : mymaterial = Nothing
            
            
        Catch ex As Exception

            CORE.application_error_trace(ex.ToString())
        Finally
            
            If Not mymaterial Is Nothing Then mymaterial.Dispose() : mymaterial = Nothing
            
        End Try

    End Sub
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////

</script>