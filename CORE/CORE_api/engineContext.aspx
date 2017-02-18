<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>

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
     
        language_id = Request("idLanguage")
        id_content = Request("idContent")
        id_related = Request("idRelated")
        id_key = Request("idKey")
        id_tree = Request("idTree")
        id_site = Request("idSite")
        rows = Request("rows")
        mypage = Request("page")
        id_context = Request("idContext")
        responseType = CORE.checkResponse()
        
          
        If Not CORE_USER.hasRole(CORE_USER.userRole.contextAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMessage=""Your account is not authenticated to execute this action.""/></values>") : Return
     
        Select Case Request("who")
    		
            '#############################################################
            '#############################################################	
            '#############################################################	
    		
            Case "manageTags"
    		
                Dim mycontext As CORE_CONTEXT = New CORE_CONTEXT
                Dim tagsValues As String = Request("tagsValues")
    		
                Try
    	
                    If tagsValues <> "" And language_id > 0 Then
    		
                        Dim _arr() As String = tagsValues.Split(",")
                        Dim i As Integer = 0
    		
                        For i = 0 To UBound(_arr)
    		
                            Dim _values() As String = _arr(i).Split("_")
    		
                            id_context = Convert.ToInt32(_values(0))
    		
                            If id_context = 0 Then
    			    			
                                mycontext = New CORE_CONTEXT()
                                mycontext.id_language = language_id
                                mycontext.context_title = _values(1)
                                mycontext.context_type = Convert.ToInt32(Request("contextType"))
                                id_context = mycontext.context_insert(mycontext)
                                  					
                            End If
                            
                            If id_content > 0 Then mycontext.newRelation(id_content, id_context)
    		
                        Next
    				
                    End If
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("context_all_" & language_id.ToString().ToLower(), "contexts")
                    cacheobj.remove_cache()
                    cacheobj.Dispose()
                    cacheobj = Nothing
    		
    		
    		
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                Catch err As Exception
    		
                    returnData("<values><error errorId=""300"" errorLabel=""Manage Tags Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not mycontext Is Nothing Then mycontext.Dispose() : mycontext = Nothing
                End Try
    		
    		
    				
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "removeContext"
    		
                
                Dim context As CORE_CONTEXT = New CORE_CONTEXT()
                Try
                    
                    context.removeRelation(id_key, id_content)
                    context.Dispose()
                    context = Nothing
    		
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("contexts_" & id_content.ToString().ToLower(), "contexts")
                    cacheobj.remove_cache()
                    cacheobj.Dispose()
                    cacheobj = Nothing
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""301"" errorLabel=""Remove Context Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not context Is Nothing Then context.Dispose() : context = Nothing
                End Try
    				
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "removeAllContext"
    		
    					
                Dim context As CORE_CONTEXT = New CORE_CONTEXT()
                
                Try
                    
                    context.removeAllRelation(id_content)
                    context.Dispose()
                    context = Nothing
    		
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("contexts_" & id_content.ToString().ToLower(), "contexts")
                    cacheobj.remove_cache()
                    cacheobj.Dispose()
                    cacheobj = Nothing
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                Catch err As Exception
    		
                    returnData("<values><error errorId=""302"" errorLabel=""Remove All Context Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not context Is Nothing Then context.Dispose() : context = Nothing
                End Try
    		    				
                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "getContextsAll"
    		
                Try
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("contexts_0_" & language_id.ToString(), "contexts")
                    cacheobj.remove_cache()
                    cacheobj.Dispose()
                    cacheobj = Nothing
    		
                    Dim searcher As CORE_CONTEXT_SEARCHER = New CORE_CONTEXT_SEARCHER()
                    searcher.id_language = language_id
                    searcher.searchOrder = CORE_CONTEXT_SEARCHER.order.contextTitleAsc
                    searcher.comparison = CORE_CONTEXT_SEARCHER.comparisonType.greaterThanOrEqual
                    searcher.comparisonValue = 0
                    Dim mycoll As CORE_CONTEXT_COLLECTION(Of CORE_CONTEXT) = searcher.search()
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim co As CORE_CONTEXT
        
                    For Each co In mycoll
                        myvalues.Append("<value title=""" & co.context_title.ToString & """ id_context=""" & co.id_context & """   tot=""" & co.tot.ToString & """  id_key=""" & co.id_key & """  type=""" & co.context_type & """ />")
    		        Next
                    
              
                                
                    returnData("<values><error errorId=""0"" errorLabel=""""/>" & myvalues.ToString() & "</values>")
                             
                    searcher.Dispose()
                    searcher = Nothing
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""303"" errorLabel=""Get Context All Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                End Try
                
                
               
                '############################################################# 
                '#############################################################	
                '#############################################################			
            Case "getContextsValues"
               
                Try
                    
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("contexts_" & id_content, "contexts")
                    cacheobj.remove_cache()
                    cacheobj.Dispose()
                    cacheobj = Nothing
                    Dim searcher As CORE_CONTEXT_SEARCHER = New CORE_CONTEXT_SEARCHER()
                    searcher.id_language = language_id
                    searcher.id_content = id_content
                    If Request("types") <> String.Empty Then searcher.types = CORE_utility.stringToCollection(Request("types"), "|", New SEARCH_VALUE_COLLECTION(Of Int32))
                    
                    
                    Dim mycoll As CORE_CONTEXT_COLLECTION(Of CORE_CONTEXT) = searcher.search()
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim co As CORE_CONTEXT
        
                    For Each co In mycoll
                        myvalues.Append("<value title=""" & co.context_title.ToString & """ id_context=""" & co.id_context & """   tot=""" & co.tot.ToString & """ id_key=""" & co.id_key & """ type=""" & co.context_type & """ />")
                    Next
                    
                    
                                 
                    returnData("<values><error errorId=""0"" errorLabel=""""/>" & myvalues.ToString() & "</values>")
                                
                    searcher.Dispose()
                    searcher = Nothing
                Catch
                    returnData("<values><error errorId=""304"" errorLabel=""Get Context Values Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "contextUpdate"
    		
    					
                Dim context As CORE_CONTEXT = New CORE_CONTEXT()
                Dim idContext As Integer = 0
                Dim contextTitle As String = String.Empty
                If Request("idContext") <> String.Empty Then idContext = Convert.ToInt32(Request("idContext"))
                If Request("contextTitle") <> String.Empty Then contextTitle = Request("contextTitle")
                
                Try
                    
                    context = New CORE_CONTEXT(idContext)
                    context.context_title = contextTitle
                    context.context_update(context)
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                Catch err As Exception
    		
                    returnData("<values><error errorId=""305"" errorLabel=""Context Update Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not context Is Nothing Then context.Dispose() : context = Nothing
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
    			
                
            Case "deleteContexts"
    		
                Dim contexts As String = Request("contexts")
                Dim myContexts() As String
                
                Dim context As CORE_CONTEXT = New CORE_CONTEXT()
                               
                Try
                    
                 
                    
                    If contexts <> String.Empty Then
                        myContexts = contexts.Split("|")
                        Dim contextId As Integer
                                               
                        For Each contextId In myContexts
                            context.delete_context(contextId)
                        Next
                    End If
                    
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                Catch err As Exception
    		
                    returnData("<values><error errorId=""306"" errorLabel=""Delete Contexts Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not context Is Nothing Then context.Dispose() : context = Nothing
                End Try
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "contextsToGroups"
                Dim contexts As String = Request("contexts")
                Dim groups As String = Request("groups")
                Dim context As CORE_CONTEXT = New CORE_CONTEXT()
                Dim myContexts() As String
                Dim myGroups() As String
                
                Try
                    
                    If contexts <> String.Empty Then
                        myContexts = contexts.Split("|")
                        Dim tag As Integer
                        myGroups = groups.Split("|")
                        Dim group As Integer
                        
                        For Each tag In myContexts
                            For Each group In myGroups
                                context.toContextInsert(group, tag)
                            Next
                        Next
                    End If
                                        
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                   
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""307"" errorLabel=""contextsToGroups failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                    If Not context Is Nothing Then context.Dispose() : context = Nothing
                 
                End Try
                
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "contextGetContexts"
              
                Dim context As String = Request("context")
                Dim myContext As CORE_CONTEXT_SEARCHER = New CORE_CONTEXT_SEARCHER
                Try
                    Dim groups As New SEARCH_VALUE_COLLECTION(Of Int32)
                    groups.Add(context)
                    myContext.id_language = CORE_CONTEXT_SEARCHER.language.italian
                    myContext.groups = groups
                                        
                    Dim mycoll As CORE_CONTEXT_COLLECTION(Of CORE_CONTEXT) = myContext.search()
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim co As CORE_CONTEXT
        
                    For Each co In mycoll
                        myvalues.Append("<value title=""" & co.context_title.ToString & """ id_context=""" & co.id_context & """   tot=""" & co.tot.ToString & """ id_key=""" & co.id_key & """ type=""" & co.context_type & """ />")
                    Next
                                        
                            
                    returnData("<values><error errorId=""0"" errorLabel=""""/>" & myvalues.ToString() & "</values>")
                    
                    myContext.Dispose()
                    myContext = Nothing
                   
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""308"" errorLabel=""groupGetContexts failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                  
                 
                End Try
                
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "contextGetContents"
              
                Dim context As String = Request("context")
                
                Try
                    
                    
                    
                            
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                   
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""309"" errorLabel=""contextGetContents failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                  
                 
                End Try
                
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            Case "removeFromGroup"
              
                Dim context As String = Request("context")
                Dim group As String = Request("group")
                
                Try
                    
                    Dim mc As New CORE_CONTEXT
                    mc.removeRelationFromGroup(group, context)
                    mc.Dispose()
                    mc = Nothing
                            
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                   
                Catch err As Exception
    		
                    
                    returnData("<values><error errorId=""310"" errorLabel=""removeFromGroup failed"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
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