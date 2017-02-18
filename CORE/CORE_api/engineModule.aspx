<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>

    <script runat="server">

        '//////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////
        Dim mycacheobj As CORE_CACHE = New CORE_CACHE
        Dim responseType As String
        
        Dim id_key As Integer = 0
        Dim id_module As Integer = 0
        Dim module_type As Integer = 0
        Dim module_description As String = String.Empty
        Dim module_definition As String = String.Empty
        Dim module_label As String = String.Empty
        Dim module_path As String = String.Empty
        Dim module_name As String = String.Empty
       
  
        '//////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////
        Sub page_load()
            
            If Request("moduleIdKey") <> "" Then id_key = Convert.ToInt32(Request("moduleIdKey"))
            If Request("moduleId") <> "" Then id_module = Convert.ToInt32(Request("moduleId"))
            If Request("moduleType") <> "" Then module_type = Convert.ToInt32(Request("moduleType"))
            If Request("moduleDescription") <> "" Then module_description = Request("moduleDescription")
            If Request("moduleDefinition") <> "" Then module_definition = Request("moduleDefinition")
            If Request("modulePath") <> "" Then module_path = Request("modulePath")
            If Request("moduleName") <> "" Then module_name = Request("moduleName")
            If Request("moduleLabel") <> "" Then module_label = Request("moduleLabel")
            
            
            responseType = CORE.checkResponse()
            
            If Not CORE_USER.hasRole(CORE_USER.userRole.layoutAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMessage=""Your account is not authenticated to execute this action.""/></values>") : Return
            
            Select Case Request("who")
    	
              
                    
                Case "moduleInsert"
                                         
                    Try
                        Dim myModule As CORE_MODULE = New CORE_MODULE
                        myModule.id_module = id_module
                        myModule.module_definition = module_definition
                        myModule.module_description = module_description
                        myModule.module_label = module_label
                        myModule.module_name = module_name
                        myModule.module_path = module_path
                        myModule.module_type = module_type
                        myModule.update(myModule)
                        id_key = myModule.insert(myModule)
                                                
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    Catch ex As Exception

                        returnData("<values><error errorId=""301"" errorLabel=""moduleInsert errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                        
                    End Try
					
					Case "moduleUpdate"
                    
                    Try
                        Dim myModule As CORE_MODULE = New CORE_MODULE(id_key)
                        myModule.id_module = id_module
                        myModule.module_definition = module_definition
                        myModule.module_description = module_description
                        myModule.module_label = module_label
                        myModule.module_name = module_name
                        myModule.module_path = module_path
                        myModule.module_type = module_type
                        myModule.update(myModule)
                        
                        mycacheobj.cache_folder = "modules"
                        mycacheobj.remove_cache("module_" & id_key & ".cache")
                        mycacheobj.remove_cache("module_" & module_name & ".cache")
                        
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    Catch ex As Exception

                        returnData("<values><error errorId=""301"" errorLabel=""moduleUpdate Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                        
                    End Try
                    
                Case "moduleList"
                    
                    Dim mymodule As CORE_MODULE_SEARCHER = New CORE_MODULE_SEARCHER()
                    Dim mystring As StringBuilder
                    Try
                        
                        mystring = New StringBuilder
                        mymodule.module_definition = "Parts"
                        
                        Dim values As SqlDataReader = mymodule.search()
                        
                        While values.Read
                                        
                            mystring.Append("<module idKey=""" & values("id_key") & """ label=""" & Server.HtmlEncode(values("module_label").ToString()) & """ idModule=""" & values("id_module") & """ type=""" & values("module_type") & """  definition=""" & Server.HtmlEncode(values("module_definition").ToString()) & """  description=""" & Server.HtmlEncode(values("module_description").ToString()) & """ name=""" & Server.HtmlEncode(values("module_name").ToString()) & """  path=""" & Server.HtmlEncode(values("module_path").ToString()) & """/>")
                                        
                        End While
                        values.Close()
                        
                
                        returnData("<values>" & mystring.ToString & "<error errorId=""0"" errorLabel=""""/></values>")
                
                    Catch ex As Exception
    		
                        returnData("<values><error errorId=""301"" errorLabel=""moduleList Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
    		
                    Finally
    		
                        If Not mymodule Is Nothing Then mymodule.Dispose() : mymodule = Nothing
                    End Try
                    
					
                                        
                    
               
            End Select
            
            mycacheobj.Dispose()
            mycacheobj = Nothing
           
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



