<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.Drawing.Text" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>
<%@ Import Namespace="System.web.configuration" %>
<%@ Import Namespace="System.io" %>

<script runat="server">
    Dim language_id As Integer
    Dim id_content As Integer
    Dim id_related As Integer
    Dim id_key As Integer
    Dim id_tree As Integer
    Dim id_site As Integer
    Dim rows As Integer
    Dim mypage As Integer
    Dim id_context As Integer
    Dim responseType As String

    Sub page_load()
     
        language_id = Request("language_id")
        id_content = Request("id_content")
        id_related = Request("id_related")
        id_key = Request("id_key")
        id_tree = Request("id_tree")
        id_site = Request("id_site")
        rows = Request("rows")
        mypage = Request("page")
        id_context = Request("id_context")
        responseType = CORE.checkResponse()
		
		'httpcontext.current.response.write("aa")
		
		If Request("who")="" then
		
		 returnData("<values><error errorId=""000"" errorLabel=""No input data"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
		End If
		
		
             
        Select Case Request("who")
    		
           
    		
            Case "cacheRemove"
    		
                Dim cacheobj As CORE_CACHE = Nothing
    		
                Try
    		
                    cacheobj = New CORE_CACHE("", "global")
                    cacheobj.remove_cache()
                    
                    cacheobj = New CORE_CACHE("", "contents")
                    cacheobj.remove_cache()
                    
                    cacheobj = New CORE_CACHE("", "relateds")
                    cacheobj.remove_cache()
    		
                    cacheobj = New CORE_CACHE("", "trees")
                    cacheobj.remove_cache()
    		
                    cacheobj = New CORE_CACHE("", "contexts")
                    cacheobj.remove_cache()
    		
                    cacheobj = New CORE_CACHE("", "modules")
                    cacheobj.remove_cache()
                      		
                    cacheobj = New CORE_CACHE("", "sites")
                    cacheobj.remove_cache()
                    
                    cacheobj = New CORE_CACHE("", "users")
                    cacheobj.remove_cache()
                    
                    cacheobj = New CORE_CACHE("", "posts")
                    cacheobj.remove_cache()
    		
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""Cache removing failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                    If Not cacheobj Is Nothing Then cacheobj.Dispose() : cacheobj = Nothing
                 
                End Try
    		
                
                
            Case "sendMail"
    		
                Dim myemail As CORE_EMAIL = Nothing
    		
                Try
    		
                    myemail = New CORE_EMAIL()
                    myemail.email_body = Request("contactMessage")
                    myemail.email_subject = Request("contactSubject")
                    myemail.email_from = Server.UrlDecode(Request("contactEmail"))
                    myemail.email_from_label = Server.UrlDecode(Request("contactEmail"))
                    myemail.email_to = ConfigurationManager.AppSettings("core_contact_email").ToString()
                    myemail.send()
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""901"" errorLabel=""Send Mail Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    
                Finally
                    If Not myemail Is Nothing Then myemail.Dispose() : myemail = Nothing
                End Try
                
                
            Case "contactForm"
                'Dim user As CORE_USER = Nothing
                'Dim contact As CORE_POST = Nothing
                'Dim myemail As CORE_EMAIL = Nothing
                'Try

                '    If CORE_validation.isEmail(Request("contactEmail")) = True Then

                '        user = New CORE_USER()

                '        Dim idUser As Integer = user.emailExist(Request("contactEmail"))
                '        If idUser = 0 Then
                '            user.user_name = Request("contactName")
                '            user.user_surname = Request("contactSurname")
                '            user.user_username = Request("contactEmail")
                '            user.user_email = Request("contactEmail")
                '            user.user_password = CORE.random_key("0|9,2|5,@|@,@|@,a|f,g|m")
                '            user.user_date_creation = Date.Now
                '            idUser = user.insert(user)
                '        End If

                '        contact = New CORE_POST()
                '        contact.id_user = 2
                '        contact.id_user_from = idUser
                '        contact.post_description = Request("contactMessage")
                '        contact.post_subject = Request("contactSubject")
                '        contact.post_author = Request("contactName") & " " & Request("contactSurname")
                '        contact.post_author_email = Server.UrlDecode(Request("contactEmail"))
                '        contact.post_date_creation = Date.Now()
                '        contact.post_type = 3
                '        contact.ip_address = HttpContext.Current.Request.ServerVariables.Item("REMOTE_ADDR")
                '        contact.insert(contact)


                '        myemail = New CORE_EMAIL
                '        myemail.email_from = "info@generalmetalitalia.com"
                '        myemail.email_to = "info@generalmetalitalia.com"
                '        myemail.email_subject = Request("contactSubject")
                '        myemail.email_body = Request("contactName") & " " & Request("contactSurname") & " con email: " & Request("contactEmail") & " ha inviato il seguente messaggio: " & Request("contactMessage")
                '        myemail.sendmail()


                '    End If

                '    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")


                'Catch err As Exception


                '    returnData("<values><error errorId=""902"" errorLabel=""Contact Form Error"" errorMessage=""" & err.Message.ToString() & """/></values>")


                'Finally

                '    If Not contact Is Nothing Then contact.Dispose() : contact = Nothing
                '    If Not user Is Nothing Then user.Dispose() : user = Nothing
                '    If Not myemail Is Nothing Then myemail.Dispose() : myemail = Nothing

                'End Try

         
            Case "getLogList"
    		
                  		
                Try
    		
                    Dim myLog As New StringBuilder
                    Dim log As XmlDocument = New XmlDocument
                    Dim mf As String
                    For Each mf In Directory.GetFiles(Server.MapPath(ConfigurationManager.AppSettings("CORE_logs").ToString()))
                        
                        log.Load(Server.MapPath(ConfigurationManager.AppSettings("CORE_logs").ToString() & System.IO.Path.GetFileName(mf)))
                        myLog.Append("<log name=""" & System.IO.Path.GetFileName(mf) & """ >" & log.InnerXml.ToString.Replace("<?xml version=""1.0"" encoding=""utf-8""?>", "") & "</log>")
                        
                       
                    Next
                    
                  
                    returnData("<values>" & myLog.ToString & "<error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""902"" errorLabel=""getLogList Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    
                Finally
                
                End Try
                
            Case "removeLog"
    		
                  		
                Try
    		
                    Dim logname As String = Request("logname")
                    
                    CORE_filesystem.fileDelete(ConfigurationManager.AppSettings("CORE_logs").ToString() & logname)
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""903"" errorLabel=""removeLog Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    
                Finally
                
                End Try
                
            Case "generateInsertScript"
    		
                  		
                Try
    		
                    
                    Dim values As StringBuilder = New StringBuilder
                    Dim files() As String = Directory.GetFiles(Server.MapPath("/setup/tables/"), "*.sql")
                    Dim file As String
                    Dim script As StringBuilder = New StringBuilder
                    Dim tableName As String = String.Empty
                    For Each file In files
                        tableName = CORE.getStringValue(file, "tables\", ".sql")
                        Dim myScript As New CORE_EXPORT(tableName)
                        Dim mydata As String
                        
                        script.Append("truncate table " & tableName & " ")
                        script.Append("SET IDENTITY_INSERT " & tableName & " ON ")
                        For Each mydata In myScript.getData()
                            script.Append(mydata & " ")
                        Next
                        script.Append("SET IDENTITY_INSERT " & tableName & " OFF ")
                        
                    Next
                    
                    Dim generatedScript As String = String.Empty
                    generatedScript = script.ToString
                    returnData("<values><is data=""" & Server.HtmlEncode(generatedScript) & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""904"" errorLabel=""generateInsertScript Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    
                Finally
                
                End Try
                
            Case "generateSearcherKey"
                
                Dim myKey As String = String.Empty
                Dim rT As String = String.Empty
                Dim rC As String = String.Empty
                Dim rR As String = String.Empty
                Dim rCx As String = String.Empty
                Dim rU As String = String.Empty
                Dim rCt As String = String.Empty
                Dim rD As String = String.Empty
                Dim rW As String = String.Empty
                Dim rH As String = String.Empty
                Dim rL As String = String.Empty
                
                Try
                    
                    If Request("rT") <> String.Empty Then rT = Request("rT")
                    If Request("rC") <> String.Empty Then rC = Request("rC")
                    If Request("rR") <> String.Empty Then rR = Request("rR")
                    If Request("rCx") <> String.Empty Then rCx = Request("rCx")
                    If Request("rU") <> String.Empty Then rU = Request("rU")
                    If Request("rCt") <> String.Empty Then rCt = Request("rCt")
                    If Request("rD") <> String.Empty Then rD = Request("rD")
                    If Request("rW") <> String.Empty Then rW = Request("rW")
                    If Request("rH") <> String.Empty Then rH = Request("rH")
                    If Request("rL") <> String.Empty Then rL = Request("rL")
                                        
                    myKey = "rT=" & rT & "&rC=" & rC & "&rR=" & rR & "&rCx=" & rCx & "&rU=" & rU & "&rCt=" & rCt & "&rD=" & rD & "&rW=" & rW & "&rH=" & rH & "&rL=" & rL & ""
                    
                    
                    myKey = CORE_CRYPTOGRAPHY.encrypt(myKey.ToString)
                    
                    returnData("<values><searcher key=""token=" & Server.HtmlEncode(myKey) & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""905"" errorLabel=""generateSearcherKey Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    
                Finally
                
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