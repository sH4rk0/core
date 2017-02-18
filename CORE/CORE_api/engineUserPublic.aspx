    <%@ Import namespace="System.Data"%>
    <%@ Import namespace="System.Data.sqlClient"%>
    <%@ Import Namespace="System.xml" %>
    <%@ Import Namespace="System.io" %>

    <script runat="server">
        Dim language_id As Integer
        Dim id_content As Integer
        Dim id_user As Integer
        Dim id_key As Integer
        Dim id_tree As Integer
        Dim id_site As Integer
        Dim rows As Integer
        Dim mypage As Integer
        Dim id_context As Integer
        Dim responseType As String
        Dim orderBy As String
        Dim status As String
        
        Sub page_load()
         
           
            If Request("idUser") <> "" Then id_user = Convert.ToInt32(Request("idUser"))
          
            
            responseType = CORE.checkResponse()
         
            Select Case Request("who")
        		
               
        		
        		
                '#############################################################
                '#############################################################	
                '#############################################################	
           	
                Case "userInsert"
                    Dim user As New CORE_USER
                    Dim siteToken As String = Request("siteToken")
                    Dim urlToken As String = Request("urlToken")
                    Try
                       
                        Try
                                                                               
                            user.user_nickname = Request("nickname")
                            user.user_email = Request("email")
                            user.user_username = Request("email")
                            user.id_site = CORE_CRYPTOGRAPHY.decrypt(siteToken)
                            user.user_password = Request("user_password")
                            user.user_date_creation = Date.Now
                            Dim idUser As Integer = user.insert(user)
                            user.siteInsert(idUser, user.id_site, 0)
                            Dim code As String = CORE_CRYPTOGRAPHY.decrypt(urlToken) & "?cc=" & CORE_CRYPTOGRAPHY.encrypt(idUser & "|" & user.id_site)
                            
                            Dim userFolder As String = Server.MapPath(ConfigurationManager.AppSettings("CORE_user_folder").ToString() & idUser.ToString() & "/")
                            If Not System.IO.Directory.Exists(userFolder) Then
                            
                                Directory.CreateDirectory(userFolder)
                        
                            End If
                            
                            'Try
                            '    Dim email As CORE_EMAIL = New CORE_EMAIL
                            '    Dim dest As New ArrayList
                            '    dest.Add(Request("email"))
                            '    email.emailsTo = dest
                            '    email.email_from = "admin@zero89.it"
                            '    email.bodyType = CORE_EMAIL.type.text
                            '    email.email_body = "prova"
                            '    email.email_subject = "subject test"
                            '    email.sendmail()
                            'Catch err As Exception
                            '    CORE.application_error_trace(err.ToString)
                            'End Try
                            
                            returnData("<values><user create=""true"" cc=""" & code & """ password=""" & user.user_password & """/><error errorId=""0"" errorLabel=""""/></values>")
                        Catch err As Exception
                            
                            returnData("<values><user create=""false""/><error errorId=""0"" errorLabel="""" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                        End Try
                      
                        
                    
                    Catch err As Exception
        		
                        returnData("<values><error errorId=""2000"" errorLabel=""Insert User Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
        		
                    Finally
        		
                        If Not user Is Nothing Then user.Dispose() : user = Nothing
                    End Try
                    
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
           	
                Case "userUpdate"
                    
                    Dim siteToken As String = Request("siteToken")
                    Dim token As String = Request("token")
                    
                    Try
                       
                        Dim idSite As Integer = CORE_CRYPTOGRAPHY.decrypt(siteToken)
                        Dim idUser As Integer = CORE_CRYPTOGRAPHY.decrypt(token)
                        Dim user As CORE_USER = New CORE_USER(idUser)
                        
                        Dim newPassword As String = Request("user_password_new")
                        Dim oldPassword As String = Request("user_password_old")
                        
                        If (Trim(CORE_CRYPTOGRAPHY.encrypt(oldPassword).ToString) = Trim(user.user_password.ToString)) AndAlso newPassword <> "" Then user.user_password = CORE_CRYPTOGRAPHY.encrypt(newPassword)
                        
                        If Request("user_name") <> "" Then user.user_name = CORE_formatting.cleanHtml(Request("user_name"))
                        If Request("user_surname") <> "" Then user.user_surname = CORE_formatting.cleanHtml(Request("user_surname"))
                        If Request("user_gender") <> "" Then user.user_gender = Request("user_gender")
                        If Request("user_sign") <> "" Then user.user_sign = CORE_formatting.cleanHtml(Request("user_sign"))
                        If Request("user_homepage") <> "" Then user.user_homepage = CORE_formatting.cleanHtml(Request("user_homepage"))
                        
                        user.update(user)
                        user.Dispose()
                        user = Nothing
                                        
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    Catch err As Exception
        		
                        returnData("<values><error errorId=""2001"" errorLabel=""Update User Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
        		
                    Finally
        		
                       
                    End Try
                  
        		
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
        		
                Case "userRecoverData"
                    Dim user As New CORE_USER
                    Dim siteToken As String = Request("siteToken")
                    Dim urlToken As String = Request("urlToken")
                    Dim idUser As Integer = 0
                    Dim code As String = String.Empty
                    Dim password As String = String.Empty
                    
                    Try
                        Dim userIdEmail As Integer = user.emailExist(Request("user_email"))
                        Dim userIdNickname As Integer = user.nicknameExist(Request("user_nickname"))
                        If userIdEmail = userIdNickname Then idUser = userIdEmail
                        
                        
                        If idUser > 0 Then
                            user = New CORE_USER(idUser)
                            password = user.user_password
                            user.Dispose()
                            user = Nothing
                            
                            code = CORE_CRYPTOGRAPHY.decrypt(urlToken) & "?cp=" & password & "&cc=" & CORE_CRYPTOGRAPHY.encrypt(idUser & "|" & CORE_CRYPTOGRAPHY.decrypt(siteToken))
                            
                            '-----------------------------------                  
                            'inserire codice invio mail
                            '-----------------------------------
                            
                        
                            returnData("<values><error errorId=""0"" cc=""" & Server.HtmlEncode(code) & """ errorLabel=""""/></values>")
                        Else
                            
                            returnData("<values><error errorId=""2002"" errorLabel=""Utente inesistente"" errorMsg=""Utente inesistente""/></values>")
                            
                        End If
                       
                                             
                        
                        
                    
                    Catch err As Exception
        		
                        returnData("<values><error errorId=""2002"" errorLabel=""userRecoverData Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
        		
                    Finally
        		
                       
                    End Try
                    
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
                                       
                Case "userChangePassword"
                    Dim user As New CORE_USER
                    Dim checkToken As String = Request("checkToken")
                    Dim idUser As Integer = 0
                    Dim idSite As Integer = 0
                    
                    Try
                                                
                        Dim cc As String = CORE_CRYPTOGRAPHY.decrypt(checkToken)
                        Dim values() As String = cc.Split("|")
                        
                        If IsNumeric(values(0)) AndAlso IsNumeric(values(1)) Then
                            idUser = values(0)
                            idSite = values(1)
                            
                            If idUser > 0 Then
                                user = New CORE_USER(idUser)
                                user.user_password = CORE_CRYPTOGRAPHY.encrypt(Request("password"))
                                user.update(user)
                                user.Dispose()
                                user = Nothing
                            End If
                            
                        End If
                        
                       
                       
                                             
                        
                                                
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    Catch err As Exception
        		
                        returnData("<values><error errorId=""2003"" errorLabel=""userRecoverData Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
        		
                    Finally
        		
                       
                    End Try
                    
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
                    
                Case "checkUserEmail"
                    
                    Dim user As New CORE_USER
                    Dim isUsed As Boolean = False
                    Try
        				                    
                        Dim userId As Integer = user.emailExist(Request("email"))
                        If userId > 0 Then isUsed = True
                                          
                        returnData("<values><email isUsed=""" & isUsed.ToString.ToLower & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                    Catch err As Exception
        		
                        returnData("<values><error errorId=""2004"" errorLabel=""Check User Email Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
        		
                    Finally
        		
                        If Not user Is Nothing Then user.Dispose() : user = Nothing
                    End Try
               
                    
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
        		
                Case "checkUserNickname"
                    Dim user As New CORE_USER
                    Dim isUsed As Boolean = False
                    Try
        				
                        Dim userId As Integer = user.nicknameExist(Request("nickname"))
                        If userId > 0 Then isUsed = True
                        
                        returnData("<values><nickname isUsed=""" & isUsed.ToString.ToLower & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                    Catch err As Exception
        		
                        returnData("<values><error errorId=""2005"" errorLabel=""Check User Nickname Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
        		
                    Finally
        		
                        If Not user Is Nothing Then user.Dispose() : user = Nothing
                    End Try
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
        		
                Case "addUserOnline"
                    
                    Dim nickname As String = Request("nickname")
                    Dim fingerprint As String = Request("fingerprint")
                    Dim userKey As String = Request("userKey")
                    If nickname = String.Empty Or fingerprint = String.Empty Or userKey = String.Empty Then returnData("<values><error errorId=""2006"" errorLabel=""addUserOnline Error"" errorMessage=""nickname and fingerprint requested""/></values>") : Return
                                       
                    Try
                        
                        If ASP.global_asax.users.ContainsKey(nickname) Then returnData("<values><error errorId=""2007"" errorLabel=""addUserOnline Error"" errorMessage=""User nickname already exist""/></values>") : Return
                        
                        
                        Dim newUser As New PortalUser(nickname, fingerprint, userKey, Date.Now)
                        
                        ASP.global_asax.users.Add(nickname, newUser)
                        ASP.global_asax.users.Clean()
                        returnData("<values><error errorId=""0"" errorLabel="""" errorMessage=""""/></values>")
                        
                    Catch err As Exception
                        returnData("<values><error errorId=""2008"" errorLabel=""addUserOnline Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    Finally
                        
                    
                    End Try
                    
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
        		
                Case "getUserOnline"
                    
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim user As System.Collections.Generic.KeyValuePair(Of String, PortalUser)
                   
                    Try
                        'ASP.global_asax.users.Clean()
                        For Each user In ASP.global_asax.users.UsersCollection
                                              
                            myvalues.Append("<users nickname=""" & Server.HtmlEncode(user.Value.Nickname) & """  time=""" & Server.HtmlEncode(user.Value.LogTime) & """ status=""" & Server.HtmlEncode(user.Value.status) & """ userKey=""" & Server.HtmlEncode(user.Value.userKey) & """ fingerprint=""" & Server.HtmlEncode(user.Value.FingerPrint) & """ token=""" & CORE_CRYPTOGRAPHY.encrypt(user.Value.ID) & """ />")
                                            
                        Next
                                
                        returnData("<values><error errorId=""0"" errorLabel="""" /><usersCount count=""" & ASP.global_asax.users.Count & """/>" & myvalues.ToString() & "</values>")
        
                                             
                    Catch err As Exception
                        returnData("<values><error errorId=""2009"" errorLabel=""addUserOnline Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    Finally
                        
                    
                    End Try
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
        		
                Case "refreshUserOnline"
                    
                    Dim nickname As String = Request("nickname")
                    If nickname = String.Empty Then returnData("<values><error errorId=""2010"" errorLabel=""refreshUserOnline Error"" errorMessage=""nickname requested""/></values>") : Return
                   
                    nickname = nickname.ToLower
                    Try
                        
                        If ASP.global_asax.users.ContainsKey(nickname) Then
                            ASP.global_asax.users.Alive(nickname)
                            ASP.global_asax.users.Clean()
                            returnData("<values><error errorId=""0"" errorLabel="""" errorMessage=""""/></values>") : Return
                        Else
                            returnData("<values><error errorId=""2011"" errorLabel=""refreshUserOnline Error"" errorMessage=""User nickname not exist""/></values>") : Return
                                                   
                        End If
                                              
                    Catch err As Exception
                        returnData("<values><error errorId=""2012"" errorLabel=""addUserOnline Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    Finally
                        
                    
                    End Try
                    '#############################################################
                    '#############################################################	
                    '#############################################################	    
                    
                Case "changeUserOnlineStatus"
                    
                    Dim nickname As String = Request("nickname")
                    Dim _status As String = Request("status")
                    Dim status As OnLineUsers.userStatus
                    
                    nickname = nickname.ToLower
                    
                    If nickname = String.Empty Or _status = String.Empty Then returnData("<values><error errorId=""2013"" errorLabel=""refreshUserOnline Error"" errorMessage=""nickname requested""/></values>") : Return
                    
                    If Request("status") <> String.Empty Then status = Convert.ToInt32(Request("status"))
                                       
                    Try
                        
                        If ASP.global_asax.users.ContainsKey(nickname) Then
                            ASP.global_asax.users.Alive(nickname, status)
                            ASP.global_asax.users.Clean()
                            returnData("<values><error errorId=""0"" errorLabel="""" errorMessage=""""/></values>") : Return
                        Else
                            returnData("<values><error errorId=""2014"" errorLabel=""refreshUserOnline Error"" errorMessage=""User nickname not exist""/></values>") : Return
                                                   
                        End If
                                              
                    Catch err As Exception
                        returnData("<values><error errorId=""2015"" errorLabel=""addUserOnline Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    Finally
                        
                    
                    End Try
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
        		
                Case "removeUserOnline"
                    
                    Dim nickname As String = Request("nickname")
                    If nickname = String.Empty Then returnData("<values><error errorId=""2016"" errorLabel=""refreshUserOnline Error"" errorMessage=""nickname requested""/></values>") : Return
                   
                    nickname = nickname.ToLower
                    Try
                        
                        If ASP.global_asax.users.ContainsKey(nickname) Then
                            ASP.global_asax.users.Remove(nickname)
                            ASP.global_asax.users.Clean()
                            returnData("<values><error errorId=""0"" errorLabel="""" errorMessage=""""/></values>") : Return
                        Else
                            returnData("<values><error errorId=""2017"" errorLabel=""refreshUserOnline Error"" errorMessage=""User nickname not exist""/></values>") : Return
                                                   
                        End If
                                              
                    Catch err As Exception
                        returnData("<values><error errorId=""2018"" errorLabel=""addUserOnline Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    Finally
                        
                    
                    End Try
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
        		
                Case "getUserOnlineFingerprint"
                    
                    Dim nickname As String = Request("nickname")
                    If nickname = String.Empty Then returnData("<values><error errorId=""2019"" errorLabel=""getUserOnlineFingerprint Error"" errorMessage=""nickname requested""/></values>") : Return
                   
                    nickname = nickname.ToLower
                    
                    Try
                        
                        If ASP.global_asax.users.ContainsKey(nickname) Then
                           
                            ASP.global_asax.users.Clean()
                            
                            returnData("<values><user fingerprint=""" & ASP.global_asax.users.getFingerPrint(nickname) & """/><error errorId=""0"" errorLabel="""" errorMessage=""""/></values>") : Return
                        Else
                            returnData("<values><error errorId=""2020"" errorLabel=""getUserOnlineFingerprint Error"" errorMessage=""User nickname not exist""/></values>") : Return
                                                   
                        End If
                                              
                    Catch err As Exception
                        returnData("<values><error errorId=""2021"" errorLabel=""getUserOnlineFingerprint Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    Finally
                        
                    
                    End Try
                    
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
        		
                Case "loginUser"
                    
                    Dim site As New CORE_SITE()
                    Dim username As String = Request("username")
                    Dim password As String = Request("password")
                    If username = String.Empty Or password = String.Empty Then returnData("<values><error errorId=""2020"" errorLabel=""loginUser Error"" errorMessage=""username or password requested""/></values>") : Return
                   
                    
                    Try
                        
                        Dim userAccess As CORE_USER.userAccess = CORE_USER.userLogin(username, password, CORE_USER.userProfile.noProfile, CORE_USER.userRole.noRole, site.id_key)
                        
                        If userAccess = CORE_USER.userAccess.userConfirmed Then

                            returnData("<values><user isLogged=""true"" nickname=""" & Server.HtmlEncode(CORE_USER.getUserNickname()) & """ username=""" & CORE_USER.getUserUsername & """ userKey=""" & CORE_USER.getUserRegistrationCode & """ token=""token" & CORE_CRYPTOGRAPHY.encrypt(CORE_USER.getUserId) & """/><error errorId=""0"" errorLabel="""" errorMsg=""""/></values>")

                        Else

                            returnData("<values><user isLogged=""false""/><error errorId=""0"" errorLabel="""" errorMsg=""""/></values>")

                        End If
                        
                        
                       
                                              
                    Catch err As Exception
                        returnData("<values><error errorId=""2021"" errorLabel=""loginUser Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    Finally
                        If Not site Is Nothing Then site.Dispose() : site = Nothing
                    
                    End Try
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
        		      
                Case "logoutUser"
                                      
                    
                    Try
                        
                        CORE_USER.userLogout()
                        
                        returnData("<values><user isLogged=""false""/><error errorId=""0"" errorLabel="""" errorMsg=""""/></values>")
                                              
                    Catch err As Exception
                        returnData("<values><error errorId=""2022"" errorLabel=""logoutUser Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    Finally
                        
                    
                    End Try
                    
                    '#############################################################
                    '#############################################################	
                    '#############################################################	
                Case Else
                    
                    Dim nickname As String = Request("username")
                    Dim fingerprint As String = Request("identity")
                    Dim userKey As String = Request("userKey")
                    Dim myfriend As String = Request("friends")
                    Dim myfriends As String = String.Empty
                    Dim myData As String = String.Empty
                    
                    
                    If myfriend <> String.Empty Then
                        
                        myfriend = myfriend.ToLower
                        If ASP.global_asax.users.ContainsKey(myfriend) Then myfriends = "<friend><user>" & myfriend & "</user><identity>" & ASP.global_asax.users.getFingerPrint(myfriend) & "</identity><userKey>" & ASP.global_asax.users.getUserKey(myfriend) & "</userKey></friend>"
                            
                    Else
                        
                        If nickname = String.Empty Or fingerprint = String.Empty Then returnData("<?xml version=""1.0"" encoding=""utf-8""?><result><update>false</update></result>") : Return
                        
                        nickname = nickname.ToLower
                        If ASP.global_asax.users.ContainsKey(nickname) Then
                        
                            ASP.global_asax.users.Alive(nickname)
                            ASP.global_asax.users.Clean()
                            myData = "<update>true</update>"
                        Else
                        
                            Dim newUser As New PortalUser(nickname, fingerprint, userKey, Date.Now)
                        
                            ASP.global_asax.users.Add(nickname, newUser)
                            ASP.global_asax.users.Clean()
                            myData = "<update>true</update>"
                        
                        End If
                        
                    End If
                    
                    returnData("<?xml version=""1.0"" encoding=""utf-8""?><result>" & myData & myfriends & "</result>") : Return
                  
              
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