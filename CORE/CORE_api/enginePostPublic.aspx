<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Import Namespace="System.io" %>

<script runat="server">
    Dim language_id As Integer
    Dim id_content As Integer
    Dim id_post As Integer
    Dim id_related As Integer
    Dim id_key As Integer
    Dim id_tree As Integer
    Dim trees As String
    
    Dim id_site As Integer
    Dim rows As Integer
    Dim mypage As Integer
    Dim id_context As Integer
    Dim responseType As String
    Dim who As String
    Dim tokenC As Integer = 0
    Dim tokenL As Integer = 0
    Dim tokenS As Integer = 0
    Dim postVote As Integer = 0
    
    Sub page_load()
     
        language_id = Request("language_id")
        id_content = Request("id_content")
        id_post = Request("id_post")
        id_related = Request("id_related")
        id_key = Request("id_key")
        id_tree = Request("id_tree")
        trees = Request("trees")
        id_site = Request("id_site")
        rows = Request("rows")
        mypage = Request("page")
        id_context = Request("id_context")
        
        who = Request("who")

        
        If Request("tokenC") <> "" AndAlso CORE_validation.isInteger(Request("tokenC")) Then id_content = CORE_CRYPTOGRAPHY.decrypt(Request("tokenC"))
        If Request("tokenS") <> "" AndAlso CORE_validation.isInteger(Request("tokenC")) Then id_site = CORE_CRYPTOGRAPHY.decrypt(Request("tokenS"))
        If Request("tokenL") <> "" AndAlso CORE_validation.isInteger(Request("tokenC")) Then language_id = CORE_CRYPTOGRAPHY.decrypt(Request("tokenL"))
       
        If Request("postVote") <> "" AndAlso CORE_validation.isInteger(Request("postVote")) AndAlso Convert.ToInt32(Request("postVote")) < 6 Then postVote = Convert.ToInt32(Request("postVote"))
        
        If CORE_CRYPTOGRAPHY.decrypt(who) <> String.Empty Then who = CORE_CRYPTOGRAPHY.decrypt(who)
        
        responseType = CORE.checkResponse()
        
        
     
        Select Case who
    	                
            '#############################################################
            '#############################################################	
            '#############################################################			
            Case "getPosts"
    		
                Dim searcher As CORE_CONTENT_POST_SEARCHER = New CORE_CONTENT_POST_SEARCHER
                Dim cSearcher As CORE_CONTENT_SEARCHER = New CORE_CONTENT_SEARCHER
                
                Try
                                      
                    searcher.id_content = CORE_CRYPTOGRAPHY.decrypt(Request("tokenC"))
                    
                    cSearcher.postSearcher = searcher
                    cSearcher.searchStatus = CORE_CONTENT_SEARCHER.status.all
                    cSearcher.type = CORE_CONTENT.contentType.contentPost
                    If Request("rows") <> String.Empty Then cSearcher.rows = Request("rows")
                    If Request("page") <> String.Empty Then cSearcher.page = Request("page")
                    cSearcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentDateCreationAsc
                                       
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim mycoll As CORE_CONTENT_COLLECTION(Of CORE_CONTENT_HOLDER) = cSearcher.search()
                    Dim re As CORE_CONTENT_HOLDER
                  
        
                    For Each re In mycoll
                        
                        myvalues.Append("<post idPost=""" & re.contentPostData.id_key & """ to=""" & re.contentPostData.post_to & """ idUser=""" & re.contentPostData.id_user & """ author=""" & re.contentPostData.post_author & """ email=""" & re.contentPostData.post_author_email & """ link=""" & re.contentPostData.post_author_link & """  date=""" & re.contentPostData.content_date_creation.ToString("ddd\, d MMMM yyyy \@ HH\:mm") & """ enabled=""" & re.contentPostData.content_enabled & """   subject=""" & Server.HtmlEncode(re.contentPostData.content_title) & """ description=""" & Server.HtmlEncode(re.contentPostData.content_description) & """ />")
                    Next
                                                 
                    returnData("<values>" & myvalues.ToString() & "<error errorId=""0"" errorLabel=""""/></values>")
    			
                    searcher.Dispose()
                    searcher = Nothing
                    cSearcher.Dispose()
                    cSearcher = Nothing
                Catch err As Exception
                    returnData("<values><error errorId=""1000"" errorLabel=""Get Post Values Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not searcher Is Nothing Then searcher.Dispose() : searcher = Nothing
                    If Not cSearcher Is Nothing Then cSearcher.Dispose() : cSearcher = Nothing
                    
                End Try
                
    		
             	
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "insertPost"
    		
                Dim display As Boolean = False
                Dim isAuthor As Boolean = False
                Dim postOption As Integer = CORE_CRYPTOGRAPHY.decrypt(Request("postOption"))
                Dim _captchaSession As String = String.Empty
                Dim _captchaRequest As String = String.Empty
                
                Try
                    
                  
                    _captchaSession = Session("captcha")
                    _captchaRequest = Request("postCaptcha")
                                    
                    If Request("postUsername") <> "" And Request("postPassword") <> "" And CORE_USER.isLogged = False Then
                        Dim userAccess As CORE_USER.userAccess = CORE_USER.userLogin(Request("postUsername"), Request("postPassword"), CORE_USER.userProfile.noProfile, CORE_USER.userRole.noRole, 1)
                        If Not userAccess = CORE_USER.userAccess.userConfirmed Then returnData("<values><error errorId=""9000"" errorLabel=""Credentials not valid!"" errorMsg=""Login credential not valid!""/></values>") : Return
                    End If
                                       
                    If CORE_USER.isLogged = False AndAlso _captchaSession = "" Then returnData("<values><error errorId=""9001"" errorLabel=""Captcha expired!"" errorMsg=""Captcha expired!""/></values>") : Return
                    
                    If CORE_USER.isLogged = False AndAlso _captchaRequest = "" Then returnData("<values><error errorId=""9001"" errorLabel=""Captcha not valid!"" errorMsg=""Captcha code not valid!""/></values>") : Return
                                       
                    If CORE_USER.isLogged = False AndAlso _captchaSession.ToString.ToLower <> _captchaRequest.ToString.ToLower Then returnData("<values><error errorId=""9001"" errorLabel=""Captcha not valid!"" errorMsg=""Captcha code not valid!""/></values>") : Return
                    
                                        
                    'check for post option
                    '---------------------------------------------------------------------------------------
                    If postOption = 0 Then returnData("<values><error errorId=""9002"" errorLabel=""Post disabled"" errorMessage=""No post permission!""/></values>") : Return
                    If postOption = 1 And CORE_USER.isLogged = False Then returnData("<values><error errorId=""9002"" errorLabel=""Post enabled for Logged user under admin control"" errorMsg=""No post permission!""/></values>") : Return
                    If postOption = 3 And CORE_USER.isLogged = False Then returnData("<values><error errorId=""9002"" errorLabel=""Post enabled for Logged user"" errorMsg=""No post permission!""/></values>") : Return
                    If postOption = 3 Or postOption = 4 Then display = True
                    '---------------------------------------------------------------------------------------
                    
                    Dim mycontent As CORE_CONTENT = New CORE_CONTENT()
                    Dim mypost As CORE_CONTENT_POST = New CORE_CONTENT_POST()
                                                          
                    Try
                        
                                              
                        If Request("postAuthor") <> "" Then mypost.post_author = Request("postAuthor")
                        If Request("postEmail") <> "" Then mypost.post_author_email = Request("postEmail")
                        If CORE_CRYPTOGRAPHY.decrypt(Request("tokenC")) > 0 Then mypost.post_id_content = CORE_CRYPTOGRAPHY.decrypt(Request("tokenC"))
                        
                        mycontent.content_title = CORE_formatting.cleanHtml(Request("postSubject"))
                        mycontent.content_description = CORE_formatting.cleanHtml(Request("postDescription"))
                        mycontent.content_date_creation = Date.Now()
                        mycontent.content_type = CORE_CONTENT.contentType.contentPost
                        mycontent.id_site = id_site
                        mycontent.id_language = language_id
                                            
                        If CORE_USER.isLogged Then
                            mycontent.id_user = CORE_USER.getUserId
                            mypost.post_author = CORE_USER.getUserNickname
                            mypost.post_author_link = CORE_USER.getUserHomepage
                            If CORE_USER.isAuthor(id_content, CORE_USER.getUserId) Then display = True : isAuthor = True
                        End If
                        
                        If display = True Then mycontent.content_enabled = True Else mycontent.content_enabled = False
                        Dim id_content_key As Integer = mycontent.content_insert(mycontent)
                        
                        mypost.id_content_key = id_content_key
                        mypost.post_id_content = id_content
                        mypost.post_vote = postVote
                        mypost.insert(mypost)
                        
                        Dim newPost As String = String.Empty
                        
                        If display Then
                            newPost = ("<post id_post=""" & id_content_key & """ id_user=""" & mycontent.id_user & """ author=""" & Server.HtmlEncode(mypost.post_author) & """  link=""" & mypost.post_author_link & """ date=""" & mycontent.content_date_creation.ToString("ddd\, d MMMM yyyy \@ HH\:mm") & """  subject=""" & Server.HtmlEncode(mycontent.content_title) & """ isAuthor=""" & isAuthor.ToString.ToLower & """ description=""" & Server.HtmlEncode(mycontent.content_description) & """ />")
                        Else
                            newPost = ("<post id_post=""" & id_content_key & """ id_user=""" & mycontent.id_user & """ author=""" & Server.HtmlEncode(mypost.post_author) & """  link=""" & mypost.post_author_link & """ date=""" & mycontent.content_date_creation.ToString("ddd\, d MMMM yyyy \@ HH\:mm") & """  subject=""" & Server.HtmlEncode(mycontent.content_title) & """ isAuthor=""false"" description=""This message is waiting for Administrator validation!"" />")
                        End If
                       
                        
                        mypost.Dispose()
                        mypost = Nothing
                        mycontent.Dispose()
                        mycontent = Nothing
                        Session("captcha") = ""
                        returnData("<values>" & newPost & "<error errorId=""0"" errorLabel=""""/></values>")
					                  
                    Catch ex As Exception
                        'CORE.application_error_trace(Err.ToString())
                        returnData("<values><error errorId=""1001"" errorLabel=""Error!"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    End Try
                
                Catch ex As Exception
                 
                    returnData("<values><error errorId=""1002"" errorLabel=""Get Post Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
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