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

    Sub page_load()


        Try
        		
        			
            Dim idRelated As Integer = Request("idRelated")
            Dim myFile As HttpPostedFile = Request.Files("Filedata")
            Dim contentFolder As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & idRelated.ToString() & "/"
            Dim myupload As CORE_UPLOAD = New CORE_UPLOAD
            myupload.file_object = myFile
            myupload.file_path = contentFolder
            myupload.file_type = 2
            myupload.file_name = idRelated.ToString() & ".jpg"
            Dim filename As String = myupload.upload()
            myupload.Dispose()
            myupload = Nothing
            		
            Response.StatusCode = 200
            Response.Write(filename)
        		
        Catch
        		
            			
            Response.StatusCode = 500
            Response.Write("An error occured")
            Response.End()
            		
        Finally
        		
        			
            Response.End()
        End Try

    End Sub

</script>

