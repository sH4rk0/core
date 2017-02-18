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
    Dim profiles As String = String.Empty
    Dim roles As String = String.Empty
    Dim id_profile As Integer = 0
    Dim id_role As Integer = 0
    Dim role_label As String = String.Empty
    Dim orderBy As String = String.Empty
    
    Dim responseType As String

    Sub page_load()
     
     
        
        If Request("contents") <> String.Empty Then contents = Request("contents")
        If Request("trees") <> String.Empty Then trees = Request("trees")
        If Request("profiles") <> String.Empty Then profiles = Request("profiles")
        If Request("id_profile") <> String.Empty Then id_profile = Request("id_profile")
        If Request("roles") <> String.Empty Then roles = Request("roles")
        If Request("id_role") <> String.Empty Then id_role = Request("id_role")
        If Request("role_label") <> String.Empty Then role_label = Request("role_label")
        If Request("orderBy") <> String.Empty Then orderBy = Request("orderBy")
        
        responseType = CORE.checkResponse()
             
        
        If Not CORE_USER.hasRole(CORE_USER.userRole.roleAndProfileAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMessage=""Your account is not authenticated to execute this action.""/></values>") : Return
        
        Select Case Request("who")
    		
    		
           
            '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "roleGet"
    		
                Dim pro As CORE_role = Nothing
                Try
                    pro = New CORE_role(id_role)
                    returnData("<values><role id=""" & pro.id_role.ToString() & """ label=""" & Server.HtmlEncode(pro.role_label) & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    returnData("<values><error errorId=""900"" errorLabel=""roleGet failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not pro Is Nothing Then pro.Dispose() : pro = Nothing

                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "roleGetAll"
    		
                Dim searcher As CORE_role_SEARCHER = New CORE_role_SEARCHER
                
                Try
                    searcher.rows = 100
                    searcher.page = 1
                    
                    Select Case orderBy
                        Case "0"
                            searcher.searchOrder = CORE_role_SEARCHER.order.roleIdDesc
                        Case "1"
                            searcher.searchOrder = CORE_role_SEARCHER.order.roleIdAsc
                        Case "2"
                            searcher.searchOrder = CORE_role_SEARCHER.order.roleLabelDesc
                        Case "3"
                            searcher.searchOrder = CORE_role_SEARCHER.order.roleLabelAsc
                        
                    End Select
                                     
                                       
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim mycoll As CORE_role_COLLECTION(Of CORE_role) = searcher.search()
                    
                    Dim myrole As CORE_role
        
                    For Each myrole In mycoll
                        myvalues.Append("<role id=""" & myrole.id_role & """ label=""" & Server.HtmlEncode(myrole.role_label) & """  />")
                    Next
                  
                    
                    returnData("<values>" & myvalues.ToString() & "<error errorId=""0"" errorLabel=""""/></values>")
                    
                                        
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""roleGetAll failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                  
                    If Not searcher Is Nothing Then searcher.Dispose() : searcher = Nothing
                   
                    
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++   
            Case "roleInsert"
    		
                Dim role As CORE_ROLE = New CORE_ROLE()
                Try
    		
                    role.role_label = role_label
                    id_role = role.insert(role)
                    
                    returnData("<values><role id=""" & id_role.ToString() & """ label=""" & Server.HtmlEncode(role.role_label) & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""roleInsert failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not role Is Nothing Then role.Dispose() : role = Nothing
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
            Case "roleUpdate"
                Dim role As CORE_ROLE = New CORE_ROLE(id_role)
                Try
    		
                   
                    role.role_label = role_label
                    role.update(role)
                    
                    returnData("<values><role id=""" & role.id_role.ToString() & """ label=""" & Server.HtmlEncode(role.role_label) & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""roleUpdate failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not role Is Nothing Then role.Dispose() : role = Nothing
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
            Case "roleDelete"
                Dim role As CORE_ROLE = New CORE_ROLE()
                Try
    		
                    role.delete(id_role)
                             
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""roleDelete failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not role Is Nothing Then role.Dispose() : role = Nothing
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "roleToProfileInsert"
    		
                Dim pro As CORE_ROLE = New CORE_ROLE()
                Dim myProfiles() As String
                Dim myroles() As String
                
                Try
                    
                    
                    If roles <> String.Empty Then
                       
                        myroles = roles.Split(",")
                        Dim role As Integer
                        myProfiles = profiles.Split(",")
                        Dim profile As Integer
                        
                        For Each role In myroles
                            For Each profile In myProfiles
                                pro.toProfileInsert(profile, role)
                            Next
                        Next
                       
                    ElseIf id_role > 0 Then
                        
                        myProfiles = profiles.Split(",")
                        Dim profile As Integer
                        For Each profile In myProfiles
                            pro.toProfileInsert(profile, id_role)
                        Next
                        
                    End If
                   
                                        
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""roleToProfileInsert failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                
            Case "roleToProfileDelete"
                
                Dim pro As CORE_ROLE = New CORE_ROLE()
                Dim myProfiles() As String
                Dim myroles() As String
                Try
                    
                    If roles <> String.Empty Then
                        
                        myroles = roles.Split(",")
                        Dim role As Integer
                        myProfiles = profiles.Split(",")
                        Dim profile As Integer
                        
                        For Each role In myroles
                            For Each profile In myProfiles
                                pro.toProfileDelete(profile, role)
                            Next
                        Next
                       
                    ElseIf id_role > 0 Then
                        
                        myProfiles = profiles.Split(",")
                        Dim profile As Integer
                        For Each profile In myProfiles
                            pro.toProfileDelete(profile, id_role)
                            
                        Next
                        
                    End If
                   
                                        
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""roleToUserInsert failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                  
                 
                End Try
                
                
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "roleToProfileDeleteAll"
                Dim pro As CORE_ROLE = New CORE_ROLE()
                Dim myProfiles() As String
                Try
                    myProfiles = profiles.Split(",")
                    Dim profile As Integer
                    For Each profile In myProfiles
                        pro.toProfileDeleteAll(profile)
                    Next
                  
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""roleToUserDeleteAll failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not pro Is Nothing Then pro.Dispose() : pro = Nothing
                  
                 
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "roleToProfileGet"
    		
                Dim searcher As CORE_role_SEARCHER = New CORE_role_SEARCHER
                
                Try
                    searcher.id_profile = id_profile
                    searcher.rows = 100
                    searcher.page = 1
                    
                    Select Case orderBy
                        Case "0"
                            searcher.searchOrder = CORE_role_SEARCHER.order.roleIdDesc
                        Case "1"
                            searcher.searchOrder = CORE_role_SEARCHER.order.roleIdAsc
                        Case "2"
                            searcher.searchOrder = CORE_role_SEARCHER.order.roleLabelDesc
                        Case "3"
                            searcher.searchOrder = CORE_role_SEARCHER.order.roleLabelAsc
                        
                    End Select
                                     
                                       
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim mycoll As CORE_role_COLLECTION(Of CORE_ROLE) = searcher.search()
                    
                    Dim myrole As CORE_ROLE
        
                    For Each myrole In mycoll
                        myvalues.Append("<role id=""" & myrole.id_role & """ label=""" & Server.HtmlEncode(myrole.role_label) & """  />")
                    Next
                  
                    
                    returnData("<values>" & myvalues.ToString() & "<error errorId=""0"" errorLabel=""""/></values>")
                    
                                        
                    
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""900"" errorLabel=""roleToUserGet failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
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