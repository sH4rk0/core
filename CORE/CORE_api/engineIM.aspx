    <%@ Import namespace="System.Data"%>
    <%@ Import namespace="System.Data.sqlClient"%>
    <%@ Import Namespace="System.xml" %>
    <%@ Import Namespace="System.io" %>
    <%@ Import Namespace="System.collections.generic" %>

    <script runat="server">
        Dim cIndexString As String = String.Empty
        Dim cUFromString As String = String.Empty
        Dim cUToString As String = String.Empty
        Dim cEvtString As String = String.Empty
        Dim cMsgString As String = String.Empty
        
        Dim cIndex As Integer = 0
        Dim cUFrom As Integer = 0
        Dim cUTo As Integer = 0
       
        Dim responseType As String
        
        
        Sub page_load()
         
            If Request("cIndex") <> "" Then cIndexString = Request("cIndex")
            If Request("cUFrom") <> "" Then cUFromString = Request("cUFrom")
            If Request("cUTo") <> "" Then cUToString = Request("cUTo")
            If Request("cEvt") <> "" Then cEvtString = Request("cEvt")
            If Request("cMsg") <> "" Then cMsgString = Request("cMsg")
           
                
            If CORE_VALIDATION.isInteger(cIndexString) Then cIndex = cIndexString
               
                        
            If cUToString <> "" Then
                
                cUTo = CORE_CRYPTOGRAPHY.decrypt(cUToString)
                If CORE_VALIDATION.isInteger(CORE_CRYPTOGRAPHY.decrypt(cUToString)) Then cUTo = CORE_CRYPTOGRAPHY.decrypt(cUToString)
               
            End If
            
            If cUFromString <> "" Then
                
                If CORE_VALIDATION.isInteger(CORE_CRYPTOGRAPHY.decrypt(cUFromString)) Then cUFrom = CORE_CRYPTOGRAPHY.decrypt(cUFromString)
               
            End If
           
                                 
            responseType = CORE.checkResponse()
         
            Select Case Request("who")
        		
             
                '#############################################################
                '#############################################################	
                '#############################################################	
           	
                Case "checkUpdate"
                   
                    Try
                        
                        Dim update As PortalMsgResult
                        Dim mywatch As System.Diagnostics.Stopwatch = New System.Diagnostics.Stopwatch
                        mywatch.Start()
                        
                        While mywatch.ElapsedMilliseconds < 10000
                           
                            update = checkUpdate(cIndex, cUTo)
                            If update.index <> cIndex Then cIndex = update.index : Exit While
                            
                        End While
                        
                        mywatch.Stop()
                                               
                        returnData("<values><error errorId=""0"" errorLabel="""" errorMsg=""""/>" & update.evts & "<nextCall key=""" & cIndex & """/></values>")
                                              
                    Catch err As Exception
                        returnData("<values><error errorId=""3001"" errorLabel=""checkUpdate Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    Finally
                        
                    
                    End Try
                    
                Case "addEvent"
                    
                    Dim evtValue As String = String.Empty
                    
                    Try
                        
                        
                        Select Case cEvtString
                            
                            
                            Case "login"
                              
                                Dim myuser As New CORE_USER(cUFrom)
                                evtValue = "<evt type=""login"" token=""token" & CORE_CRYPTOGRAPHY.encrypt(myuser.id_user) & """ msg=""" & myuser.user_name & " " & myuser.user_surname & " ha effettuato il login"" />"
                                cUTo = 0
                                myuser.Dispose()
                                myuser = Nothing
                                
                        End Select
                        
                        
                        ASP.global_asax.users.AddEvent(cUFrom, cUTo, evtValue)
                       
                                               
                        returnData("<values><error errorId=""0"" errorLabel="""" errorMsg=""""/></values>")
                                              
                    Catch err As Exception
                        returnData("<values><error errorId=""3002"" errorLabel=""addEvent Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    Finally
                        
                    
                    End Try
              
              
            End Select
        		
        		
        End Sub
        
        
        Function checkUpdate(ByVal _index As Integer, ByVal _user As Integer) As PortalMsgResult
                        
            Dim pSearcher As New PortalMsgSearcher(_index, 0, _user)
            Dim mycoll As List(Of PortalMsg) = ASP.global_asax.users.getEvents(pSearcher)
            
            'Dim randomClass As New Random(Convert.ToInt64(CORE.random_key("1|9,0|9,0|9,0|9,0|9,0|9,0|9,0|9")))

            'Dim ran As Integer = randomClass.Next(1, 1000000)
            'If ran > 999997 Then Return "<msgs><msg idf="""" text=""messaggio di prova""></msg></msgs>"

            'Return ""
             
            Dim msg As PortalMsg
            Dim userStr As StringBuilder = New StringBuilder
            Dim mystring As New StringBuilder
            Dim lastKey As Integer = _index
            
            
            If ASP.global_asax.users.msgCollection.Count > 0 Then
            
                For Each msg In ASP.global_asax.users.msgCollection
                                              
                    userStr.Append(msg.msg)
                    lastKey = msg.key
                Next
                
            End If
            
            Dim myResult As New PortalMsgResult(lastKey, "<evts>" & mystring.ToString & "</evts>")
            
            Return myResult
            
            
        End Function
        
       
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