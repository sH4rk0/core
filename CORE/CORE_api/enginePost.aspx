<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Import Namespace="System.io" %>

<script runat="server">
    
    Dim id_content As Integer
    Dim id_post As Integer
    Dim rows As Integer
    Dim mypage As Integer
    Dim id_user As Integer
    Dim id_user_from As Integer
    Dim postType As Integer
    Dim orderBy As String
    Dim post_enabled As String
    Dim post_read As String
    Dim post_subject As String
    Dim post_description As String
    Dim post_to As String
    Dim post_author As String
    Dim post_author_link As String
    Dim post_author_email As String
    Dim id_site As Integer
    Dim id_language As Integer
    
    
    Dim responseType As String
    Dim who As String
    
    Sub page_load()
     
        If Request("id_content") <> "" Then id_content = Convert.ToInt32(Request("id_content"))
        If Request("id_post") <> "" Then id_post = Convert.ToInt32(Request("id_post"))
        rows = Convert.ToInt32(Request("rows"))
        mypage = Convert.ToInt32(Request("page"))
        If Request("id_user") <> "" Then id_user = Convert.ToInt32(CORE_CRYPTOGRAPHY.decrypt(Request("id_user")))
        If Request("idSite") <> "" Then id_site = Convert.ToInt32(Request("idSite"))
        If Request("idLanguage") <> "" Then id_language = Convert.ToInt32(Request("idLanguage"))
        If Request("postType") <> "" Then postType = Convert.ToInt32(Request("postType"))
        orderBy = Request("orderBy")
        post_enabled = Request("post_enabled")
        post_read = Request("post_read")
        post_subject = Request("post_subject")
        post_description = Request("post_description")
        If Request("post_to") <> "" Then post_to = Convert.ToInt32(Request("post_to"))
        post_author = Request("post_author")
        post_author_link = Request("post_author_link")
        post_author_email = Request("post_author_email")
        
        
        who = Request("who")
                     
        responseType = CORE.checkResponse()
        If Not CORE_USER.hasRole(CORE_USER.userRole.postAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMessage=""Your account is not authenticated to execute this action.""/></values>") : Return
        
     
        Select Case who
    		
    		
            '#############################################################
            '#############################################################	
            '#############################################################	
            Case "getPost"
    		
                Try
                   
                    Dim mypost As CORE_CONTENT_POST = New CORE_CONTENT_POST(id_post)
    		
                    returnData("<values><post idPost=""" & mypost.id_key & """ to=""" & mypost.post_to & """ id_user=""" & mypost.id_user & """ author=""" & mypost.post_author & """ email=""" & mypost.post_author_email & """ link=""" & mypost.post_author_link & """  date=""" & mypost.content_date_creation & """ enabled=""" & mypost.content_enabled & """   subject=""" & Server.HtmlEncode(mypost.content_title) & """ description=""" & Server.HtmlEncode(mypost.content_description) & """ /><error errorId=""0"" errorLabel=""""/></values>")
					
                    mypost.Dispose()
                    mypost = Nothing
                
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""1000"" errorLabel=""Get Post Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                End Try
               
                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "getPosts"
    		
                Dim searcher As CORE_CONTENT_POST_SEARCHER = New CORE_CONTENT_POST_SEARCHER
                Dim cSearcher As CORE_CONTENT_SEARCHER = New CORE_CONTENT_SEARCHER
               
                Try
                    
                                     
                    searcher.id_content = id_content
                    
                    
                    If rows > 0 Then cSearcher.rows = rows
                    If mypage > 0 Then cSearcher.page = mypage
               
                    
                    Select Case orderBy
                        Case "0"
                            searcher.ordersCollection.Add(CORE_CONTENT_POST_SEARCHER.order.postIdDesc)
                        Case "1"
                            searcher.ordersCollection.Add(CORE_CONTENT_POST_SEARCHER.order.postIdAsc)
                                                 
                    End Select
                    
                    cSearcher.postSearcher = searcher
                    cSearcher.searchStatus = CORE_CONTENT_SEARCHER.status.all
                    cSearcher.type = CORE_CONTENT.contentType.contentPost
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim mycoll As CORE_CONTENT_COLLECTION(Of CORE_CONTENT_HOLDER) = cSearcher.search()
                    Dim re As CORE_CONTENT_HOLDER
                  
        
                    For Each re In mycoll
                        
                        myvalues.Append("<post idPost=""" & re.contentPostData.id_key & """ to=""" & re.contentPostData.post_to & """ idUser=""" & re.contentPostData.id_user & """ author=""" & re.contentPostData.post_author & """ email=""" & re.contentPostData.post_author_email & """ link=""" & re.contentPostData.post_author_link & """  date=""" & re.contentPostData.content_date_creation & """ enabled=""" & re.contentPostData.content_enabled & """   subject=""" & Server.HtmlEncode(re.contentPostData.content_title) & """ description=""" & Server.HtmlEncode(re.contentPostData.content_description) & """ />")
                    Next
                                                 
                    returnData("<values><value count=""" & cSearcher.searchcount() & """/>" & myvalues.ToString() & "<error errorId=""0"" errorLabel=""""/></values>")
    			
                    searcher.Dispose()
                    searcher = Nothing
                    
                Catch err As Exception
                    returnData("<values><error errorId=""1001"" errorLabel=""Get Post Values Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not searcher Is Nothing Then searcher.Dispose() : searcher = Nothing
                    
                End Try
                
    		
             	
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "insertPost"
    		
                Try
                    
                    Dim mycontent As CORE_CONTENT = New CORE_CONTENT()
                    Dim mypost As CORE_CONTENT_POST = New CORE_CONTENT_POST()
                    
                    Try
                        
                        mycontent.content_title = post_subject
                        mycontent.content_description = post_description
                        mycontent.content_type = CORE_CONTENT.contentType.contentPost
                        If id_user > 0 Then mycontent.id_user = id_user
                        If id_site > 0 Then mycontent.id_site = id_site
                        If id_language > 0 Then mycontent.id_language = id_language
                        If post_enabled <> String.Empty Then mycontent.content_enabled = Convert.ToBoolean(post_enabled)
                        mycontent.content_date_creation = Date.Now()
                        Dim id_content_key As Integer = mycontent.content_insert(mycontent)
                       
                        mypost.id_content_key = id_content_key
                        If id_content > 0 Then mypost.post_id_content = id_content
                        If post_to <> String.Empty Then mypost.post_to = Convert.ToInt32(post_to)
                        If post_author <> String.Empty Then mypost.post_author = post_author
                        If post_author_link <> String.Empty Then mypost.post_author_link = post_author_link
                        If post_author_email <> String.Empty Then mypost.post_author_email = post_author_email
                        
                        mypost.post_author = CORE_USER.getUserNickname
                        mypost.post_author_link = CORE_USER.getUserHomepage
                        
                        mypost.insert(mypost)
                                             
                        mypost.Dispose()
                        mypost = Nothing
                   
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
					
                                      
                    Catch ex As Exception
                        CORE.application_error_trace(Err.ToString())
                        returnData("<values><error errorId=""2"" errorLabel=""Error!"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    End Try
                        
                
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""1003"" errorLabel=""Get Post Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "deletePosts"
                Dim post As CORE_CONTENT_POST = New CORE_CONTENT_POST
                
                Try
                    
                    Dim posts() As String = Request("posts").Split("|")
                    
                    Dim id As Integer = 0
                    
                    
                    
                    For Each id In posts
                    
                        post.post_delete(id)
                        
                    Next
                    
                    If Not post Is Nothing Then post.Dispose() : post = Nothing
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                              
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""1004"" errorLabel=""Delete Posts Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                Finally
                    If Not post Is Nothing Then post.Dispose() : post = Nothing
                    
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "deletePost"
                Dim post As CORE_CONTENT_POST = New CORE_CONTENT_POST
                
                Try
                    
                    post.post_delete(ID)
                 
                    If Not post Is Nothing Then post.Dispose() : post = Nothing
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                              
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""1005"" errorLabel=""Delete Post Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                Finally
                    If Not post Is Nothing Then post.Dispose() : post = Nothing
                    
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "updatePost"
    		
                Try
                    
              
                    Dim mypost As CORE_CONTENT_POST = New CORE_CONTENT_POST(id_post)
                    Dim mycontent As CORE_CONTENT = New CORE_CONTENT(id_post)
                    
                    Try
                        
                        mycontent.content_title = post_subject
                        mycontent.content_description = post_description
                        If post_enabled <> String.Empty Then mycontent.content_enabled = Convert.ToBoolean(post_enabled)
                        mycontent.content_update(mycontent)
                       
                        If id_content > 0 Then mypost.id_content = id_content
                        If id_user > 0 Then mypost.id_user = id_user
                        If post_to <> String.Empty Then mypost.post_to = Convert.ToInt32(post_to)
                        If post_author <> String.Empty Then mypost.post_author = post_author
                        If post_author_link <> String.Empty Then mypost.post_author_link = post_author_link
                        If post_author_email <> String.Empty Then mypost.post_author_email = post_author_email
                        mypost.update(mypost)
                        mypost.refreshCache()
                        
                        mypost.Dispose()
                        mypost = Nothing
                   
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
					
					
                                      
                    Catch ex As Exception
                        CORE.application_error_trace(Err.ToString())
                        returnData("<values><error errorId=""2"" errorLabel=""Error!"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    End Try
                        
                
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""1006"" errorLabel=""Get Post Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "updatePostField"
                Dim post As CORE_CONTENT = New CORE_CONTENT(id_post)
                
                Try
                                       
                    post.update_field(id_post, Request("field"), Request("value"))
                    post.refreshCache()
                    If Not post Is Nothing Then post.Dispose() : post = Nothing
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                              
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""1007"" errorLabel=""Update Post Field Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                Finally
                    If Not post Is Nothing Then post.Dispose() : post = Nothing
                    
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