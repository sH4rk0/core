    <%@ Import namespace="System.Data"%>
    <%@ Import namespace="System.Data.sqlClient"%>
    <%@ Import Namespace="System.xml" %>
    <%@ Import Namespace="System.io" %>
    <%@ Import Namespace="System.web.configuration" %>
    <script runat="server">
     
        Dim responseType As String
        
        Dim serverName As String = String.Empty
        Dim dbName As String = String.Empty
        Dim dbUser As String = String.Empty
        Dim hostName As String = String.Empty
        
        Dim userId As String = String.Empty
        Dim password As String = String.Empty
        
        Dim myType As String = String.Empty
        Dim myObject As String = String.Empty
        Dim myPath As String = String.Empty
        
        Dim conString As String = String.Empty
    	
        Dim forFunction As String = String.Empty

        Sub page_load()
         
            
            If Request("serverName") <> "" Then serverName = Request("serverName")
            If Request("dbName") <> "" Then dbName = Request("dbName")
            If Request("dbUser") <> "" Then dbUser = Request("dbUser")
            If Request("userId") <> "" Then userId = Request("userId")
            If Request("password") <> "" Then password = Request("password")
            If Request("hostName") <> "" Then hostName = Request("hostName")
            If Request("forFunction") <> "" Then forFunction = Request("forFunction")
            
            responseType = CORE.checkResponse()
            
            conString = "server=" & serverName & ";database=" & dbName & ";uid=" & userId & ";pwd=" & password & ";"
            
            Select Case Request("who")
        		
                Case "checkConnection"
                    Dim conn As SqlConnection = Nothing
                    Try
                        
                        conn = CORE_CONNECTION.open_conn(conString)
                        CORE_CONNECTION.close_conn(conn)
                        
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                        
                    Catch err As Exception
                        returnData("<values><error errorId=""1"" errorLabel=""checkConnection"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    Finally
                        
                        If Not conn Is Nothing Then conn.Close() : conn.Dispose() : conn = Nothing
                        
                    End Try
                    
                    
                    
                Case "drop"
                    
                    myType = Request("myType")
                    myObject = Request("myObject")
                                    
                    Dim sqlString As String = String.Empty
                                    
                    Try
                        
                        Select Case myType
                            
                            Case "tables"
                                sqlString = "if exists (select * from dbo.sysobjects where id = object_id(N'[[dbuserTB]].[" & myObject & "]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) drop table [[dbuserTB]].[" & myObject & "]"
                                     
                            Case "functions"
                                sqlString = "if exists (select * from dbo.sysobjects where id = object_id(N'[[dbuserFN]].[" & myObject & "]') and xtype in (N'FN', N'IF', N'TF')) drop function [[dbuserFN]].[" & myObject & "] "
                               
                            Case "storeds"
                                sqlString = "if exists (select * from dbo.sysobjects where id = object_id(N'[[dbuserST]].[" & myObject & "]') and OBJECTPROPERTY(id, N'IsProcedure') = 1) drop procedure [[dbuserST]].[" & myObject & "]"
                                
                        End Select
                        
                        
                        dim _sql as string = executeSqlString(sqlString)
                        returnData("<values><error errorId=""0"" errorLabel="""" sql="""& Server.HtmlEncode(_sql) &"""/></values>")
                        
                    Catch err As Exception
                        returnData("<values><error errorId=""2"" errorLabel=""Drop " & myType & " " & myObject & """ errorMsg=""" & err.Message.ToString() & """/></values>")
                    Finally
                    End Try
                    
                Case "create"
                    myType = Request("myType")
                    myObject = Request("myObject")
                                    
                    Dim sqlFile As String = "/setup/" & myType & "/" & myObject & ".sql"
                                    
                    Try
                                          
                        
                		 dim _sql as String =  executeSqlFile(sqlFile)
						 
                        returnData("<values><error errorId=""0"" errorLabel="""" sql="""& Server.HtmlEncode(_sql) &"""/></values>")
						
                    
                        
                    Catch err As Exception
                        returnData("<values><error errorId=""3"" errorLabel=""Create " & myType & " " & myObject & """ errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    Finally
                    End Try
                    
                Case "insert"
                    myType = Request("myType")
                                                    
                    Dim sqlFile As String = "/setup/CORE_DEFAULT_DATA.sql"
                                    
                    Try
                                          
                        
                        executeSqlFile(sqlFile)
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                        
                    Catch err As Exception
                        returnData("<values><error errorId=""4"" errorLabel=""Insert Default Data"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    Finally
                    End Try
                   
                Case "getStructure"
                    Dim _type As String = Request("type")
                    Try
                      
                      
                        Dim values As StringBuilder = New StringBuilder
                        Dim files() As String = Directory.GetFiles(Server.MapPath("/setup/" & _type & "/"), "*.sql")
                        Dim file As String
                        For Each file In files
                            
                            values.Append("<" & _type & " name=""" & CORE.getStringValue(file, _type & "\", ".sql") & """ />")
                                                  
                        Next
                       
                        returnData("<values>" & values.ToString() & "<error errorId=""0"" errorLabel=""""/></values>")
    				
    				
                    Catch err As Exception
        		                    
                        returnData("<values><error errorId=""5"" errorLabel=""getStructure " & _type & " Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                        
                    Finally
                   
                        
                    End Try
               
                Case "executeSql"
                    Dim _sqlProcedure As String = Server.HtmlDecode(Request("sqlProcedure"))
                    Try
                      
                      
                                           
                        executeSqlString(_sqlProcedure)
                        
                       
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
    				
    				
                    Catch err As Exception
        		              
                       
                        returnData("<values><error errorId=""6"" errorLabel=""executeSql Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                        
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
        
        
        Function getSql(ByVal filePath As String) As String
            Dim myStream As FileStream = Nothing
            Dim sr As StreamReader = Nothing
            Dim s As String = String.Empty
            
            Try
                myStream = New FileStream(Server.MapPath(filePath), FileMode.Open, FileAccess.Read)
                sr = New StreamReader(myStream)
                s = sr.ReadToEnd()
                
            Catch ex As Exception

                Throw ex
                
            Finally
                If Not myStream Is Nothing Then myStream.Dispose() : myStream.Close() : myStream = Nothing
                If Not sr Is Nothing Then sr.Dispose() : sr.Close() : sr = Nothing
                
            End Try
           
           
            Return s
            
        End Function
       
        
        function executeSqlString(ByVal sqlString As String) as String
            
            Dim conn As SqlConnection = Nothing
           
            Try
               
                Dim cmdGet As SqlCommand
                conn = CORE_CONNECTION.open_conn(conString)
                cmdGet = New SqlCommand(replaceSql(sqlString), conn)
                cmdGet.ExecuteNonQuery()
                CORE_CONNECTION.close_conn(conn)
                
				
				
            Catch ex As Exception
                
                Throw ex
                
            Finally
                If Not conn Is Nothing Then conn.Close() : conn.Dispose() : conn = Nothing
                
            End Try
                   
            return  replaceSql(sqlString)
        End function
        
        Function executeSqlFile(ByVal filePath As String) as String
            
            Dim conn As SqlConnection = Nothing
            
            Try
               
                Dim cmdGet As SqlCommand
                conn = CORE_CONNECTION.open_conn(conString)
                cmdGet = New SqlCommand(replaceSql(getSql(filePath)), conn)
                cmdGet.ExecuteNonQuery()
                CORE_CONNECTION.close_conn(conn)
                
            Catch ex As Exception
                
                Throw ex
                
            Finally
                If Not conn Is Nothing Then conn.Close() : conn.Dispose() : conn = Nothing
                
            End Try
                   
				Return replaceSql(getSql(filePath))
            
        End Function
        
        
        Function replaceSql(ByVal sql As String) As String
            
    		
            Select Case myType
    		
                Case "storeds"
                    If forFunction = String.Empty Then sql = sql.Replace("[[dbuserST]].", "[" & dbUser & "].").Replace("[[dbuserFN]].", "[" & dbUser & "].") Else sql = sql.Replace("[[dbuserST]].", "").Replace("[[dbuserFN]].", "[dbo].")
    		
                Case "tables"
                    If forFunction = String.Empty Then sql = sql.Replace("[[dbuserTB]].", "[" & dbUser & "].") Else sql = sql.Replace("[[dbuserTB]].", "")
                    
                Case "data"
                    If forFunction = String.Empty Then sql = sql.Replace("[[dbuserData]].", "[" & dbUser & "].") Else sql = sql.Replace("[[dbuserData]].", "")
                    
                Case "functions"

                    If forFunction = String.Empty Then sql = sql.Replace("[[dbuserFN]].", "[" & dbUser & "].") Else sql = sql.Replace("[[dbuserFN]].", "")
                    

                Case else
				
				 'sql = sql.Replace("[[dbuserFN]].", "[" & dbUser & "].") 

                 'sql = sql.Replace("[[dbuserFN]].", "") 
				
    		    		
            End Select
    		
           	
            Return sql.Replace("[dbname]", dbName).Replace("[hostName]", hostName)
            
        End Function
     	
            
            </script>