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
    Imports core
    Imports core_upload
    <script runat="server">

        Sub page_load()


            Try
    		
                Dim mytype As Integer = Request("type")
                Dim idContent As Integer = Request("idContent")
                Dim idSite As Integer = Request("idSite")
                Dim idUser As Integer = Convert.ToInt32(CORE_CRYPTOGRAPHY.decrypt(Request("idUser")))
                Dim idLanguage As Integer = Request("idLanguage")
                
                Dim myFile As HttpPostedFile = Request.Files("Filedata")
 
                Dim related As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED()
                related.content_enabled = True
                related.related_size = myFile.ContentLength
                related.related_type = mytype
                related.content_type = CORE_CONTENT.contentType.contentRelated
                related.content_views = 0
                related.content_covers = 0
                related.content_default_cover = 0
                related.post_option = 0
                related.id_language = idLanguage
                related.id_site = idSite
                        
                Dim newId As Integer = related.content_insert(related)
                
                Dim contentFolder As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & newId.ToString() & "/"
                If Not System.IO.Directory.Exists(Server.MapPath(contentFolder)) Then System.IO.Directory.CreateDirectory(Server.MapPath(contentFolder))
               
                
                Dim myupload As CORE_UPLOAD = New CORE_UPLOAD
                myupload.file_object = myFile
                myupload.file_path = contentFolder
                myupload.file_type = mytype
                Dim filename As String = myupload.upload()
                myupload.Dispose()
                myupload = Nothing
                
                related.id_key = newId
                related.content_title = filename
                related.related_link = filename
                related.related_tipology = CORE_CONTENT_RELATED.whichTipology(filename, mytype)
                
                related.content_update(related)
                related.id_content_key = newId
                
                Dim img As System.Drawing.Image = Nothing
                Dim bm As System.Drawing.Bitmap = Nothing
                Try
                      
                    img = New System.Drawing.Bitmap(Server.MapPath(contentFolder & filename))
                    bm = New System.Drawing.Bitmap(img)
                    img.Dispose()
                    img = Nothing
                        
                    If Not bm Is Nothing Then
                        related.related_width = bm.Width
                        related.related_height = bm.Height
                    End If
                      
                    bm.Dispose()
                    bm = Nothing
                        
                Catch ex As Exception
                    CORE.application_error_trace(ex.ToString)
                        
                Finally
                    If Not img Is Nothing Then img.Dispose() : img = Nothing
                    If Not bm Is Nothing Then bm.Dispose() : bm = Nothing
                End Try
                
                related.content_related_insert(related)
                related.newRelation(idContent, newId)
                                                
                related.Dispose()
                related = Nothing
                
                Dim cacheobj As CORE_CACHE = New CORE_CACHE("contents_related_list_" & idContent.ToString().ToLower(), "contents")
                cacheobj.remove_cache()
                cacheobj.Dispose()
                cacheobj = Nothing
                
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

