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

sub page_load


		try
		
            Dim mytype As CORE_CONTENT_RELATED.relatedType = Convert.ToInt32(Request("type"))
			dim myfilename as string=request("myfilename")
			dim relatedId as integer=request("relatedId")
			dim myFile as HttpPostedFile = Request.Files("Filedata")
			
			
            
            Dim contentFolder As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & relatedId.ToString() & "/"
            If Not System.IO.Directory.Exists(Server.MapPath(contentFolder)) Then System.IO.Directory.CreateDirectory(Server.MapPath(contentFolder))
            
			dim myupload as core_upload = new core_upload
            myupload.file_object = myFile
            myupload.file_path = contentFolder
            myupload.file_type = mytype
			if myfilename<>"" then myupload.file_name=myfilename
			dim filename as string=myupload.upload()
			myupload.dispose()
			myupload=nothing
			
            
            If relatedId > 0 Then
                
                Dim myNewRelated As New CORE_CONTENT_RELATED(relatedId)
				
				'Response.Write(" ---> " & filename & " " & relatedId)
				
                myNewRelated.related_link = filename
                myNewRelated.related_tipology = CORE_CONTENT_RELATED.whichTipology(filename, mytype)
               
                If mytype = CORE_CONTENT_RELATED.relatedType.image Then
                    
                    Dim img As System.Drawing.Image = Nothing
                    Dim bm As System.Drawing.Bitmap = Nothing
                    Try
                      
                        img = New System.Drawing.Bitmap(Server.MapPath(contentFolder & filename))
                        bm = New System.Drawing.Bitmap(img)
                        img.Dispose()
                        img = Nothing
                        
                        If Not bm Is Nothing Then
                            myNewRelated.related_width = bm.Width
                            myNewRelated.related_height = bm.Height
                        End If
                      
                        bm.Dispose()
                        bm = Nothing
                        
                    Catch ex As Exception
                        CORE.application_error_trace(ex.ToString)
                        
                    Finally
                        If Not img Is Nothing Then img.Dispose() : img = Nothing
                        If Not bm Is Nothing Then bm.Dispose() : bm = Nothing
                    End Try
                                        
										
					
                    
                    
                End If
				
								
                myNewRelated.content_related_update(myNewRelated)
                
            End If
            			
            Response.StatusCode = 200
            Response.Write(filename)
		
        Catch
		
			
            Response.StatusCode = 500
            Response.Write("An error occured")
            Response.End()
		
        Finally
		
			
            Response.End()
        End Try

end sub

</script>

