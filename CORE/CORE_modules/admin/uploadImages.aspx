Imports System
Imports System.Web
Imports System.io
Imports System.Object
Imports System.io.path
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.Control
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.TemplateControl
Imports System.Configuration
Imports System.Collections
Imports System.Collections.Specialized
Imports System.Reflection
Imports System.Text
Imports System.Text.RegularExpressions
Imports System.Xml
Imports System.Xml.XPath
Imports System.Data
Imports System.Data.sqlClient
Imports Microsoft.VisualBasic
Imports Microsoft.VisualBasic.CompilerServices
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Drawing.Text
Imports System.Drawing.Drawing2D
Imports System.math
Imports System.Runtime
Imports System.Runtime.Serialization
Imports System.Runtime.Serialization.Formatters.Binary
Imports System.Runtime.CompilerServices
Imports System.Web.Caching
Imports System.Web.Caching
Imports core
Imports core_upload
<script runat="server">

sub page_load


		try
		
			
            Dim idContent As Integer = Request("idContent")
            
           
            Dim cacheobj As CORE_CACHE = New CORE_CACHE("content_detail_" & idContent & ".cache".ToLower(), "contents")
            cacheobj.remove_cache()
            Dim mycontent As CORE_CONTENT = New CORE_CONTENT(idContent)
            Dim seq As Integer = mycontent.content_covers
            seq = seq + 1
            mycontent.content_covers = seq
            mycontent.content_update(mycontent)
            
            cacheobj = New CORE_CACHE("content_detail_" & idContent & ".cache".ToLower(), "contents")
            cacheobj.remove_cache()
            
            mycontent.Dispose()
            mycontent = Nothing
                        
			dim myFile as HttpPostedFile = Request.Files("Filedata")

            Dim contentFolder As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & idContent.ToString() & "/"
            If Not System.IO.Directory.Exists(Server.MapPath(contentFolder)) Then System.IO.Directory.CreateDirectory(Server.MapPath(contentFolder))
                                  
			dim myupload as core_upload = new core_upload
			myupload.file_object=myFile
            myupload.file_path = contentFolder
            myupload.file_type = 2
            myupload.file_name = idContent.ToString() & "_" & seq.ToString() & ".jpg"
			dim filename as string=myupload.upload()
			myupload.dispose()
			myupload=nothing
			            
		
			Response.StatusCode = 200
			response.write(filename)		
		
		catch
		
			
			Response.StatusCode = 500
			Response.Write("An error occured")
			Response.End()
		
		finally
		
			
			Response.End()
		end try

end sub

</script>

