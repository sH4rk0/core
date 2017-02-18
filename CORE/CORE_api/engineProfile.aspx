<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.Drawing.Text" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>
<%@ Import Namespace="System.web.configuration" %>

<script runat="server">
   
    Dim contents As String = String.Empty
    Dim trees As String = String.Empty
    Dim users As String = String.Empty
    Dim profiles As String = String.Empty
    
    Dim id_content As Integer = 0
    Dim id_site As Integer = 0
    Dim id_tree As Integer = 0
    Dim id_user As Integer = 0
    Dim id_profile As Integer = 0
    
    Dim profile_label As String = String.Empty
    Dim orderBy As String = String.Empty
    
    Dim responseType As String

    Sub page_load()
     
        
        If Request("contents") <> String.Empty Then contents = Request("contents")
        If Request("trees") <> String.Empty Then trees = Request("trees")
        If Request("users") <> String.Empty Then users = Request("users")
        If Request("profiles") <> String.Empty Then profiles = Request("profiles")
        If Request("id_content") <> String.Empty Then id_content = Request("id_content")
        If Request("id_site") <> String.Empty Then id_site = Request("id_site")
        If Request("id_tree") <> String.Empty Then id_tree = Request("id_tree")
        If Request("id_user") <> String.Empty Then id_user = Request("id_user")
        If Request("id_profile") <> String.Empty Then id_profile = Request("id_profile")
        If Request("profile_label") <> String.Empty Then profile_label = Request("profile_label")
        If Request("orderBy") <> String.Empty Then orderBy = Request("orderBy")
        
        responseType = CORE.checkResponse()
             
        If Not CORE_USER.hasRole(CORE_USER.userRole.roleAndProfileAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMessage=""Your account is not authenticated to execute this action.""/></values>") : Return
        
        Select Case Request("who")
    		
           
            '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "profileGet"
    		
                Dim pro As CORE_PROFILE = Nothing
                Try
                    pro = New CORE_PROFILE(id_profile)
                    
                    
                    returnData("<values><profile id=""" & pro.id_profile.ToString() & """ label=""" & Server.HtmlEncode(pro.profile_label) & """ isCore=""" & pro.core_profile & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    returnData("<values><error errorId=""900"" errorLabel=""profileGet failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not pro Is Nothing Then pro.Dispose() : pro = Nothing

                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "profileGetAll"
    		
                Dim searcher As CORE_profile_SEARCHER = New CORE_profile_SEARCHER
                Dim roleSearcher As CORE_role_SEARCHER = New CORE_role_SEARCHER
                Try
                    searcher.rows = 100
                    searcher.page = 1
                    searcher.searchOrder = CORE_profile_SEARCHER.order.profileLabelAsc
                                       
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim myroles As StringBuilder = Nothing
                    Dim mycoll As CORE_profile_COLLECTION(Of CORE_PROFILE) = searcher.search()
                    Dim myRolecoll As CORE_role_COLLECTION(Of CORE_ROLE) = Nothing
                    
                    Dim myprofile As CORE_PROFILE
                    Dim myrole As CORE_ROLE
        
                    For Each myprofile In mycoll
                        myroles = New StringBuilder
                        roleSearcher.rows = 100
                        roleSearcher.page = 1
                        roleSearcher.id_profile = myprofile.id_profile
                        roleSearcher.searchOrder = CORE_ROLE_SEARCHER.order.roleLabelAsc
                        myRolecoll = roleSearcher.search()
                        
                        For Each myrole In myRolecoll
                            myroles.Append("<role id=""" & myrole.id_role & """ label=""" & Server.HtmlEncode(myrole.role_label) & """ />")
                        Next
                        
                        
                        myvalues.Append("<profile id=""" & myprofile.id_profile & """ label=""" & Server.HtmlEncode(myprofile.profile_label) & """ isCore=""" & myprofile.core_profile & """>" & myroles.ToString() & "</profile>")
                    Next
                  
                    
                    returnData("<values>" & myvalues.ToString() & "<error errorId=""0"" errorLabel=""""/></values>")
                    
                                        
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileGetAll failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                  
                    If Not searcher Is Nothing Then searcher.Dispose() : searcher = Nothing
                    If Not roleSearcher Is Nothing Then roleSearcher.Dispose() : roleSearcher = Nothing
                   
                    
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++   
            Case "profileInsert"
    		
                Dim pro As CORE_PROFILE = New CORE_PROFILE()
                Try
    		
                    pro.profile_label = profile_label
                    id_profile = pro.insert(pro)
                    
                    returnData("<values><profile id=""" & id_profile.ToString() & """ label=""" & Server.HtmlEncode(pro.profile_label) & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileInsert failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not pro Is Nothing Then pro.Dispose() : pro = Nothing
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
            Case "profileUpdate"
                Dim pro As CORE_PROFILE = New CORE_PROFILE(id_profile)
                Try
    		
                   
                    pro.profile_label = profile_label
                    pro.update(pro)
                    
                    returnData("<values><profile id=""" & pro.id_profile.ToString() & """ label=""" & Server.HtmlEncode(pro.profile_label) & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileUpdate failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not pro Is Nothing Then pro.Dispose() : pro = Nothing
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
            Case "profileDelete"
                Dim profile As CORE_PROFILE = New CORE_PROFILE()
                Try
    		
                    profile.delete(id_profile)
                             
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileDelete failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not profile Is Nothing Then profile.Dispose() : profile = Nothing
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "profileToUserInsert"
    		
                Dim pro As CORE_PROFILE = New CORE_PROFILE()
                Dim myUsers() As String
                Dim myProfiles() As String
                Try
                    
                    
                    If profiles <> String.Empty Then
                        
                        myProfiles = profiles.Split(",")
                        Dim profile As Integer
                        myUsers = users.Split(",")
                        Dim user As Integer
                        
                        For Each profile In myProfiles
                            For Each user In myUsers
                                pro.toUserInsert(profile, user, id_site)
                            Next
                        Next
                       
                    ElseIf id_profile > 0 Then
                        
                        myUsers = users.Split(",")
                        Dim user As Integer
                        For Each user In myUsers
                            pro.toUserInsert(id_profile, user, id_site)
                        Next
                        
                    End If
                   
                                        
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileToUserInsert failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                
            Case "profileToUserDelete"
                Dim pro As CORE_PROFILE = New CORE_PROFILE()
                Dim myUsers() As String
                Dim myProfiles() As String
                Try
    		
                    If profiles <> String.Empty Then
                        
                        myProfiles = profiles.Split(",")
                        Dim profile As Integer
                        myUsers = users.Split(",")
                        Dim user As Integer
                        
                        For Each profile In myProfiles
                            For Each user In myUsers
                                pro.toUserDelete(profile, user, id_site)
                            Next
                        Next
                       
                    ElseIf id_profile > 0 Then
                        
                        myUsers = users.Split(",")
                        Dim user As Integer
                        For Each user In myUsers
                            pro.toUserDelete(id_profile, user, id_site)
                        Next
                        
                    End If
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileToUserDelete failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not pro Is Nothing Then pro.Dispose() : pro = Nothing
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "profileToUserDeleteAll"
                Dim pro As CORE_PROFILE = New CORE_PROFILE()
                Dim myUsers() As String
                Try
                    myUsers = users.Split(",")
                    Dim user As Integer
                    For Each user In myUsers
                        pro.toUserDeleteAll(user, id_site)
                    Next
                  
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileToUserDeleteAll failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not pro Is Nothing Then pro.Dispose() : pro = Nothing
                  
                 
                End Try
                
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "profileToTreeInsert"
    		
                Dim pro As CORE_PROFILE = New CORE_PROFILE()
                Dim myTrees() As String
                Dim myProfiles() As String
                Try
                    
                    
                    If profiles <> String.Empty Then
                        
                        myProfiles = profiles.Split(",")
                        Dim profile As Integer
                        myTrees = trees.Split(",")
                        Dim tree As Integer
                        
                        For Each profile In myProfiles
                            For Each tree In myTrees
                                pro.toTreeInsert(profile, tree)
                            Next
                        Next
                       
                    ElseIf id_profile > 0 Then
                        
                        myTrees = trees.Split(",")
                        Dim tree As Integer
                        For Each tree In myTrees
                            pro.toTreeInsert(id_profile, tree)
                        Next
                        
                    End If
                   
                                        
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileToTreeInsert failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                
            Case "profileToTreeDelete"
                Dim pro As CORE_PROFILE = New CORE_PROFILE()
                Dim myTrees() As String
                Dim myProfiles() As String
                Try
    		
                    If profiles <> String.Empty Then
                        
                        myProfiles = profiles.Split(",")
                        Dim profile As Integer
                        myTrees = trees.Split(",")
                        Dim tree As Integer
                        
                        For Each profile In myProfiles
                            For Each tree In myTrees
                                pro.toTreeDelete(profile, tree)
                            Next
                        Next
                       
                    ElseIf id_profile > 0 Then
                        
                        myTrees = trees.Split(",")
                        Dim tree As Integer
                        For Each tree In myTrees
                            pro.toTreeDelete(id_profile, tree)
                        Next
                        
                    End If
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileToTreeDelete failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not pro Is Nothing Then pro.Dispose() : pro = Nothing
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "profileToTreeDeleteAll"
                Dim pro As CORE_PROFILE = New CORE_PROFILE()
                Dim myTrees() As String
                Try
                    myTrees = trees.Split(",")
                    Dim tree As Integer
                    For Each tree In myTrees
                        pro.toTreeDeleteAll(tree)
                    Next
                  
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileToTreeDeleteAll failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not pro Is Nothing Then pro.Dispose() : pro = Nothing
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "profileToUserGet"
    		
                Dim searcher As CORE_profile_SEARCHER = New CORE_profile_SEARCHER
                
                Try
                    searcher.id_user = id_user
                    searcher.rows = 100
                    searcher.page = 1
                    
                    Select Case orderBy
                        Case "0"
                            searcher.searchOrder = CORE_profile_SEARCHER.order.profileIdDesc
                        Case "1"
                            searcher.searchOrder = CORE_profile_SEARCHER.order.profileIdAsc
                        Case "2"
                            searcher.searchOrder = CORE_profile_SEARCHER.order.profileLabelDesc
                        Case "3"
                            searcher.searchOrder = CORE_profile_SEARCHER.order.profileLabelAsc
                        
                    End Select
                                     
                                       
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim mycoll As CORE_profile_COLLECTION(Of CORE_PROFILE) = searcher.search()
                    
                    Dim myprofile As CORE_PROFILE
        
                    For Each myprofile In mycoll
                        myvalues.Append("<profile id=""" & myprofile.id_profile & """ label=""" & Server.HtmlEncode(myprofile.profile_label) & """  />")
                    Next
                  
                    
                    returnData("<values>" & myvalues.ToString() & "<error errorId=""0"" errorLabel=""""/></values>")
                    
                                        
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""profileToUserGet failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                  
                    If Not searcher Is Nothing Then searcher.Dispose() : searcher = Nothing
                   
                    
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