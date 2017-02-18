<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Import Namespace="System.IO" %>


<script runat="server">
    Dim language_id As Integer
    Dim id_content As Integer
    Dim id_related As Integer
    
    Dim related_type As String
    Dim related_tipology As String
    Dim related_context As String
    
    Dim related_width As Integer
    Dim related_height As Integer
    Dim related_duration As Integer
    
    Dim id_key As Integer
    Dim id_tree As Integer
    Dim id_site As Integer
    Dim id_user As Integer
    Dim rows As Integer
    Dim mypage As Integer
    Dim id_context As Integer
    Dim responseType As String
    Dim orderBy As String
    Dim status As String
    
    Sub page_load()
     
        If Request("idLanguage") <> "" Then language_id = Convert.ToInt32(Request("idLanguage"))
        If Request("idContent") <> "" Then id_content = Convert.ToInt32(Request("idContent"))
        If Request("idRelated") <> "" Then id_related = Convert.ToInt32(Request("idRelated"))
        If Request("related_width") <> "" Then related_width = Request("related_width")
        If Request("related_height") <> "" Then related_height = Request("related_height")
        If Request("related_duration") <> "" Then related_duration = Request("related_duration")
        If Request("related_type") <> "" Then related_type = Request("related_type")
        
        If Request("related_tipology") <> "" Then related_tipology = Request("related_tipology")
        If Request("related_context") <> "" Then related_context = Request("related_context")
        If Request("idKey") <> "" Then id_key = Convert.ToInt32(Request("idKey"))
        If Request("idTree") <> "" Then id_tree = Convert.ToInt32(Request("idTree"))
        If Request("idSite") <> "" Then id_site = Convert.ToInt32(Request("idSite"))
        If Request("idUser") <> "" Then id_user = Convert.ToInt32(CORE_CRYPTOGRAPHY.decrypt(Request("idUser")))
        If Request("rows") <> "" Then rows = Convert.ToInt32(Request("rows"))
        If Request("page") <> "" Then mypage = Convert.ToInt32(Request("page"))
        If Request("idLanguage") <> "" Then id_context = Request("idLanguage")
        If Request("orderBy") <> "" Then orderBy = Request("orderBy")
        If Request("status") <> "" Then status = Request("status")
        
        responseType = CORE.checkResponse()
        
        
        If Not CORE_USER.hasRole(CORE_USER.userRole.relatedAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMsg=""Your account is not authenticated to execute this action.""/></values>") : Return
     
        Select Case Request("who")
            
    		
            '#############################################################
            '#############################################################	
            '#############################################################	
        	
            Case "removeRelated"
                
                Dim related As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED(id_related)
                Try
                   
                    related.removeRelation(id_content, id_related)
                    related.Dispose()
                    related = Nothing
    		
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("contents_related_list_" & id_content.ToString().ToLower(), "contents")
                    cacheobj.remove_cache()
                    cacheobj.Dispose()
                    cacheobj = Nothing
                
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""500"" errorLabel=""Remove Related Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not related Is Nothing Then related.Dispose() : related = Nothing
                End Try
                
              
    		
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "deleteRelated"
                
                Dim related As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED(id_related)
                Try
    					
                    
                    Dim path As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & related.related_link
                    
                    
                    related.content_delete(id_related)
                    System.IO.Directory.Delete(MapPath(ConfigurationManager.AppSettings("CORE_related_folder").ToString() & "/" & related.id_key), True)
                    'CORE_filesystem.fileDelete(path)
                    
                    
                    related.Dispose()
                    related = Nothing
    		
                    
    		
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("contents_related_list_" & id_content.ToString().ToLower(), "contents")
                    cacheobj.remove_cache()
                    cacheobj.Dispose()
                    cacheobj = Nothing
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""501"" errorLabel=""Delete Related Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not related Is Nothing Then related.Dispose() : related = Nothing
                End Try
                
           
    		
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "removeRelatedFile"
                
                Dim related As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED
                Try
                    If id_related > 0 Then
                        Dim cacheobj As CORE_CACHE = New CORE_CACHE("related_" & id_related.ToString() & ".cache", "relateds")
                        cacheobj.remove_cache()
    		
                        related = New CORE_CONTENT_RELATED(id_related)
                        Dim path As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & "/" & id_related & "/" & related.related_link
                        related.related_link = ""
                        related.related_size = 0
                        related.content_related_update(related)
    		
                        CORE_filesystem.fileDelete(path)
                        related.Dispose()
                        related = Nothing
    		
                        cacheobj.remove_cache()
                        cacheobj.Dispose()
                        cacheobj = Nothing
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                        'Response.Write(path)
                    End If
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""502"" errorLabel=""Delete Related File Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not related Is Nothing Then related.Dispose() : related = Nothing
                End Try
    		
    	
   

                '############################################################# 
                '#############################################################	
                '#############################################################			
            Case "getRelatedValues"
    		
                Dim searcher As CORE_CONTENT_RELATED_SEARCHER = New CORE_CONTENT_RELATED_SEARCHER
                Dim cSearcher As CORE_CONTENT_SEARCHER = New CORE_CONTENT_SEARCHER
                
                Try
                                                    
                    If related_type > 0 Then searcher.type = CORE_utility.stringToArraylist(related_type, "|")
                    If related_tipology > 0 Then searcher.tipology = CORE_utility.stringToArraylist(related_tipology, "|")
                    If id_content > 0 Then searcher.contentsCollection.Add(id_content)
                                       
                    cSearcher.relatedSearcher = searcher
                    cSearcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentDateCreationAsc
                    cSearcher.type = CORE_CONTENT.contentType.contentRelated
                    If language_id > 0 Then cSearcher.id_language = language_id
                    If rows > 0 Then cSearcher.rows = rows
                    If mypage > 0 Then cSearcher.page = mypage
                    If id_user > 0 Then cSearcher.usersCollection = CORE_utility.stringToCollection(id_user, "|", New SEARCH_VALUE_COLLECTION(Of Int32))
                    
                    Select Case status
                        
                            Case "0"
                            cSearcher.searchStatus = CORE_CONTENT_SEARCHER.status.enabled
                            Case "1"
                            cSearcher.searchStatus = CORE_CONTENT_SEARCHER.status.disabled
                            Case "2"
                            cSearcher.searchStatus = CORE_CONTENT_SEARCHER.status.all
                        
                        End Select
                                        
                        Dim myvalues As StringBuilder = New StringBuilder
               
                        Dim mycoll As CORE_CONTENT_COLLECTION(Of CORE_CONTENT_HOLDER) = cSearcher.search()
                        Dim count As Integer = cSearcher.searchcount()
                        Dim re As CORE_CONTENT_HOLDER
        
                        For Each re In mycoll
                                                
                        myvalues.Append("<value title=""" & Server.HtmlEncode(re.contentRelatedData.content_title) & """  id_related=""" & re.contentRelatedData.id_key & """  language=""" & re.contentRelatedData.id_language & """ target=""" & re.contentRelatedData.related_target & """ enabled=""" & re.contentRelatedData.content_enabled & """  clicks=""" & re.contentRelatedData.related_downloads & """ link=""" & Server.HtmlEncode(re.contentRelatedData.related_link) & """ type=""" & re.contentRelatedData.related_type & """ tipology=""" & re.contentRelatedData.related_tipology & """  width=""" & re.contentRelatedData.related_width & """ height=""" & re.contentRelatedData.related_height & """  duration=""" & re.contentRelatedData.related_duration & """ size=""" & re.contentRelatedData.related_size & """ date=""" & re.contentRelatedData.content_date_creation & """  />")
                        
                        Next
                 
                        returnData("<values><error errorId=""0"" errorLabel=""""/><count count=""" & count & """/>" & myvalues.ToString() & "</values>")
                        searcher.Dispose()
                        searcher = Nothing
                        cSearcher.Dispose()
                        cSearcher = Nothing
                    
                Catch ex As Exception
                    returnData("<values><error errorId=""503"" errorLabel=""Get Related Values Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString) & """ /></values>")
                                       
                Finally
                
                    If Not searcher Is Nothing Then searcher.Dispose() : searcher = Nothing
                    If Not cSearcher Is Nothing Then cSearcher.Dispose() : cSearcher = Nothing
                    
                End Try
            		
                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "manageRelated"
    		
                Dim contentRelated As CORE_CONTENT = New CORE_CONTENT
                Dim related As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED
    		 
                Try
                    
                    Dim related_title As String = Request("related_title")
                    Dim related_type As Integer = 0
                    If Request("related_type") <> "" Then related_type = Convert.ToInt32(Request("related_type"))
                    Dim related_link As String = Request("related_link")
                    Dim related_enabled As String = Request("related_enabled")
                    If related_enabled = "" Then related_enabled = "false"
                    Dim related_target As String = Request("related_target")
                    If related_target = "" Then related_target = "0" Else related_target = "1"
                    Dim related_size As Integer = 0
                    If Request("related_size") <> "" Then related_size = Convert.ToInt32(Request("related_size"))
    				
                    If id_related > 0 Then
                        contentRelated = New CORE_CONTENT(id_related)
                        related = New CORE_CONTENT_RELATED(id_related)
                    Else
                        contentRelated = New CORE_CONTENT()
                        related = New CORE_CONTENT_RELATED()
                    End If
    				                 
                    
                    If related_title <> "" Then contentRelated.content_title = related_title
                    If related_enabled <> "" Then contentRelated.content_enabled = related_enabled
                    
                    If related_title <> "" Then related.content_title = related_title
                    If related_enabled <> "" Then related.content_enabled = related_enabled
                    If related_type > 0 Then related.related_type = related_type
                    If related_link <> "" Then related.related_link = related_link
                    If related_target <> "" Then related.related_target = related_target
                    If related_width > 0 Then related.related_width = related_width
                    If related_height > 0 Then related.related_height = related_height
                    If related_duration > 0 Then related.related_duration = related_duration
                    If related_size > 0 Then related.related_size = related_size
                   
                                        
                    If id_related > 0 Then
                        
                        Dim cacheobj As CORE_CACHE = New CORE_CACHE()
                        
                        cacheobj = New CORE_CACHE("related_" & id_related.ToString().ToLower(), "relateds")
                        cacheobj.remove_cache()
                        
                        cacheobj = New CORE_CACHE("contents_related_list_" & id_related.ToString().ToLower(), "contents")
                        cacheobj.remove_cache()
                        
                        cacheobj.Dispose()
                        cacheobj = Nothing
                        
                        ' Response.Write(contentRelated.content_title & " " & contentRelated.content_enabled)
                       
                        contentRelated.content_update(contentRelated)
                        related.content_related_update(related)
                        returnData("<values><related id=""0""/><error errorId=""0"" errorLabel="""" /></values>")
                        
                    Else
                        related.content_type = CORE_CONTENT.contentType.contentRelated
                        related.content_views = 0
                        
                        related.content_covers = 0
                        related.content_default_cover = 0
                        related.post_option = 0
                        related.id_language = language_id
                        related.id_site = id_site
                        related.id_user = id_user
                        
                        Dim newId As Integer = related.content_insert(related)
                        related.id_key = newId
                        related.content_update(related)
                        related.id_content_key = newId
                        related.content_related_insert(related)
                        
                        returnData("<values><related id=""" & newId & """/><error errorId=""0"" errorLabel=""""/></values>")
                        related.newRelation(id_content, newId)
    						
                    End If
    				
                    related.Dispose()
                    related = Nothing
    			
                Catch err As Exception
                    returnData("<values><error errorId=""504"" errorLabel=""Manage Related Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not related Is Nothing Then related.Dispose() : related = Nothing
                End Try
    		
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "addRelations"
                
                Dim relatedKeys As String = Request("relatedKeys")
                Dim contentKeys As String = Request("contentKeys")
                Dim cacheobj As CORE_CACHE = New CORE_CACHE
                Dim related As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED
                Dim rKeys() As String = relatedKeys.Split("|")
                Dim cKeys() As String = contentKeys.Split("|")
                
                Try
                                      
                    Dim cValue As Integer
                    Dim rValue As Integer
                    
                    For Each cValue In cKeys
                        
                        
                        For Each rValue In rKeys
                        
                            related.newRelation(cValue, rValue)
                        
                        Next
                        cacheobj = New CORE_CACHE("contents_related_list_" & cValue.ToString().ToLower(), "contents")
                        cacheobj.remove_cache()
                        
                    Next
                    
                    
                               
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""505"" errorLabel=""Add Relateds"" errorMsg=""" & Server.HtmlEncode(err.Message.ToString()) & """/></values>")
    		
                Finally
                    If Not cacheobj Is Nothing Then cacheobj.Dispose() : cacheobj = Nothing
    		
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "removeAllRelated"
                
               
                Dim cacheobj As CORE_CACHE = New CORE_CACHE
                Dim related As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED
             
                
                Try
                                      
                  
                    related.removeAllRelated(id_content)
                       
                    cacheobj = New CORE_CACHE("contents_related_list_" & id_content.ToString().ToLower(), "contents")
                    cacheobj.remove_cache()
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""506"" errorLabel=""Add Relateds"" errorMsg=""" & Server.HtmlEncode(err.Message.ToString()) & """/></values>")
    		
                Finally
                    If Not cacheobj Is Nothing Then cacheobj.Dispose() : cacheobj = Nothing
    		
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "getRelated"
    		
                Try
                    
              
                    Dim re As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED(id_related)
    		
                                       
                    returnData("<values><value title=""" & Server.HtmlEncode(re.content_title) & """  id_related=""" & re.id_key & """  language=""" & re.id_language & """ target=""" & re.related_target & """ enabled=""" & re.content_enabled & """  clicks=""" & re.related_downloads & """ link=""" & Server.HtmlEncode(re.related_link) & """ type=""" & re.related_type & """  tipology=""" & re.related_tipology & """ width=""" & re.related_width & """ height=""" & re.related_height & """ duration=""" & re.related_duration & """ size=""" & re.related_size & """ date=""" & re.content_date_creation & """  /><error errorId=""0"" errorLabel=""""/></values>")
                    re.Dispose()
                    re = Nothing
                
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""507"" errorLabel=""Get Related Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString) & """/></values>")
                    
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "updateRelatedField"
                Dim re As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED(id_related)
                
                Try
                                       
                    re.update_field(id_related, Request("field"), Request("value"))
                    re.refreshCache()
                    If Not re Is Nothing Then re.Dispose() : re = Nothing
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                              
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""508"" errorLabel=""Update Post Field Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString) & """/></values>")
                    
                Finally
                    If Not re Is Nothing Then re.Dispose() : re = Nothing
                    
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "deleteRelateds"
                
                Dim related As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED(id_related)
                Dim relateds() As String = Request("relateds").Split("|")
                
                Try
    					
                    
                    Dim rel As Integer = 0
                    For Each rel In relateds
                    
                        related = New CORE_CONTENT_RELATED(rel)
                        
                        'If related.related_type > 1 Then
                        'Dim path As String = ConfigurationManager.AppSettings("CORE_related_folder").ToString() & "/" & related.id_key & "/" & related.related_link
                        'CORE_filesystem.fileDelete(path)
                        'End If
                        
                        System.IO.Directory.Delete(MapPath(ConfigurationManager.AppSettings("CORE_related_folder").ToString() & "/" & related.id_key), True)
                        related.content_delete(rel)
                        related.Dispose()
                        related = Nothing
                       
    		
                    Next
                        
                    
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""509"" errorLabel=""Delete Relateds Error"" errorMsg=""" & Server.HtmlEncode(err.ToString) & """/></values>")
    		
                Finally
    		
                    If Not related Is Nothing Then related.Dispose() : related = Nothing
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "relatedImageExist"
    		
               
                Dim exist As String = "false"
                               
                Try
                   
                    If CORE_filesystem.fileExists(Request("imgPath")) Then exist = "true"
                    
                    returnData("<values><image exist=""" & exist & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""510"" errorLabel=""related Image Exist"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                   
                End Try
                 
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "relatedImageRemove"
    		
                Dim myrelated As CORE_CONTENT_RELATED = Nothing
                Try
                    
                    
                    myrelated = New CORE_CONTENT_RELATED(id_related)

                    myrelated.deleteImages()
                    myrelated.Dispose()
                    myrelated = Nothing
                    
                   
                                   
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""511"" errorLabel=""related Image Remove"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    If Not myrelated Is Nothing Then myrelated.Dispose() : myrelated = Nothing
                End Try
        End Select
    		
    		
    End Sub
   
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