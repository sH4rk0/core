<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Import Namespace="System.io" %>
<%@ Import NameSpace="System.Drawing"%>
<%@ Import NameSpace="System.Drawing.Imaging"%>
<%@ Import NameSpace="System.Drawing.Text"%>
<%@ Import NameSpace="System.Drawing.Drawing2D"%>

<script runat="server">
   
    Dim coverIndex As Integer
    Dim id_content As Integer
    Dim covers As Integer
    
    Dim responseType As String
    
    Sub page_load()
     
       
        id_content = Request("idContent")
        coverIndex = Request("coverIndex")
        covers = Request("covers")
        responseType = CORE.checkResponse()
        
        If Not CORE_USER.hasRole(CORE_USER.userRole.contentAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMessage=""Your account is not authenticated to execute this action.""/></values>") : Return
     
        Select Case Request("who")
    		
            '#############################################################
            '#############################################################	
            '#############################################################	
    		
            Case "setDefaultCover"
    		
                Dim mycontent As CORE_CONTENT = Nothing
                
                Try
                    
                    mycontent = New CORE_CONTENT(id_content)
                    mycontent.content_default_cover = coverIndex
                    mycontent.content_update(mycontent)
                    mycontent.refreshCache()
                    mycontent.Dispose()
                    mycontent = Nothing
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""700"" errorLabel=""setDefaultCover Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                    If Not mycontent Is Nothing Then mycontent.Dispose() : mycontent = Nothing
                    
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "removeCover"
                Dim mycontent As CORE_CONTENT = Nothing
                
                Try
                    mycontent = New CORE_CONTENT(id_content)
                    mycontent.content_covers = mycontent.content_covers - 1
                    If mycontent.content_default_cover > mycontent.content_covers Then mycontent.content_default_cover = mycontent.content_covers
                    mycontent.content_update(mycontent)
                    mycontent.refreshCache()
                    
                    Dim _covers As Integer = mycontent.content_covers
                    Dim _defaultCover As Integer = mycontent.content_default_cover
                    
                    mycontent.Dispose()
                    mycontent = Nothing
                    
                    Dim contentFolder As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & id_content.ToString() & "/"
                    
                  
                    If CORE_filesystem.fileExists(contentFolder & id_content.ToString() & "_" & coverIndex & ".jpg") Then
                        CORE_filesystem.fileDelete(contentFolder & id_content.ToString() & "_" & coverIndex & ".jpg")
                        CORE_filesystem.fileDelete(contentFolder, id_content.ToString() & "_" & coverIndex & "[*.*")
                    End If
                    
                   
                    If coverIndex < covers Then
                        
                        Dim start As Integer = covers - coverIndex
                        Dim i As Integer = 0
                        
                        For i = coverIndex + 1 To covers
                            
                            
                            If i > 1 Then
                               
                                If Not File.Exists(Server.MapPath(contentFolder & id_content.ToString() & "_" & i - 1 & ".jpg")) Then
                                    CORE_filesystem.fileDelete(contentFolder, id_content.ToString() & "_" & i - 1 & "[*.*")
                                    CORE_filesystem.fileDelete(contentFolder, id_content.ToString() & "_" & i & "[*.*")
                                    File.Move(Server.MapPath(contentFolder & id_content.ToString() & "_" & i & ".jpg"), Server.MapPath(contentFolder & id_content.ToString() & "_" & i - 1 & ".jpg"))
                                    
                                    
                                End If
                                
                            End If
                                                        
                        Next
                        
                        
                    End If
                    
                    
                    
                    returnData("<values><cover covers=""" & _covers & """ defaultCover=""" & _defaultCover & """ /><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    Response.Write(Err.ToString)
                    returnData("<values><error errorId=""701"" errorLabel=""removeCover Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    If Not mycontent Is Nothing Then mycontent.Dispose() : mycontent = Nothing
                 
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	   
            Case "coversInfo"
    		
                Dim myvalues As StringBuilder = New StringBuilder
                Dim contentFolder As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & id_content.ToString() & "/"
                Dim fName As String = String.Empty
                Dim fSize As Integer = 0
                Dim bmpW As Integer = 0
                Dim bmpH As Integer = 0
                
                Try
                  
                    
                    For Each FileFound As String In Directory.GetFiles(HttpContext.Current.Server.MapPath(contentFolder), id_content.ToString() & "_" & coverIndex & "[*.jpg")
                 
                        Dim bmp As Bitmap = New Bitmap(FileFound)
                        bmpW = bmp.Width
                        bmpH = bmp.Height
                        bmp.Dispose()
                        bmp = Nothing
                        
                        Dim myfile As FileInfo = New FileInfo(FileFound)
                        fName = myfile.Name
                        fSize = myfile.Length
                        myfile = Nothing
                        
                        myvalues.Append("<coverInfo name=""" & fName & """ size=""" & fSize & """  width=""" & bmpW & """ height=""" & bmpH & """ />")
                        
                    Next
                    
                    
                    returnData("<values>" & myvalues.ToString() & "<error errorId=""0"" errorLabel=""""/></values>")
                                       
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""702"" errorLabel=""coversInfo Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                                        
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "removeCovers"
    		
                Dim contentFolder As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & id_content.ToString() & "/"
                
                Try
                    
                    If CORE_filesystem.fileExists(contentFolder & id_content.ToString() & "_" & coverIndex & ".jpg") Then
                        CORE_filesystem.fileDelete(contentFolder, id_content.ToString() & "_" & coverIndex & "[*.*")
                    End If
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""703"" errorLabel=""removeCovers Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                   
                                       
                End Try
            
                
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "removeAllCovers"
                Dim mycontent As CORE_CONTENT = Nothing
                Dim contentFolder As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & id_content.ToString() & "/"
                
                Try
                    
                  
                    mycontent = New CORE_CONTENT(id_content)
                    mycontent.content_covers = 0
                    mycontent.content_default_cover = 0
                    mycontent.content_update(mycontent)
                    mycontent.refreshCache()
                    mycontent.Dispose()
                    mycontent = Nothing
                    CORE_filesystem.fileDelete(contentFolder, "*.*")
                    
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""703"" errorLabel=""removeCovers Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    If Not mycontent Is Nothing Then mycontent.Dispose() : mycontent = Nothing
                                       
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "removeAllResizedCovers"
    		
                Dim contentFolder As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & id_content.ToString() & "/"
                
                Try
                     
                   
                    CORE_filesystem.fileDelete(contentFolder, "*].*")
                  
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""704"" errorLabel=""removeAllResizedCovers Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                   
                                       
                End Try
                
        End Select
    		
    		
    End Sub
 
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////	
    Sub returnData(ByVal myData As String)
               
        If responseType = "json" Then
            Dim Doc As New XmlDocument()
            Doc.LoadXml(myData)
            Response.ContentType = "text/plain"
            Response.Write(JSON.XmlToJSON(Doc))
            Doc = Nothing
        ElseIf responseType = "jsonp" Then
            Dim Doc As New XmlDocument()
            Doc.LoadXml(myData)
            Response.ContentType = "text/plain"
            Response.Write(Request("callback") & "(" & JSON.XmlToJSON(Doc) & ")")
            Doc = Nothing
        ElseIf responseType = "xml" Then
            Response.ContentType = "text/xml"
            Response.Write(myData)
        End If

     		
    End Sub
 
        </script>