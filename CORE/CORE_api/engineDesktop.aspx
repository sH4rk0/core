<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Import Namespace="System.io" %>
<%@ Import NameSpace="System.Drawing"%>
<%@ Import NameSpace="System.Drawing.Imaging"%>
<%@ Import NameSpace="System.Drawing.Text"%>
<%@ Import NameSpace="System.Drawing.Drawing2D"%>

<script runat="server">
   
  
    Dim rows As Integer = 0
    Dim mypage As Integer = 0
    Dim mypath As String = String.Empty
    Dim responseType As String = String.Empty
    Dim idContent As String = String.Empty
    Dim tag As Integer = 0
    Dim display As Integer = 0
	
	
    
    Sub page_load()
        rows = Request("rows")
        mypage = Request("page")
        mypath = Request("path")
        idContent = Request("idContent")
        display = Request("display")
        responseType = CORE.checkResponse()
        
        
        
        Select Case Request("who")
    		
            '#############################################################
            '#############################################################	
            '#############################################################	
    		
            Case "getContents"
    		
                          
                Try
                    Dim store As Boolean = True
                    Dim searcher As New CORE_CONTENT_SEARCHER
                    
                    If Request("keyTree") <> "" Then
                        Dim trees As New SEARCH_VALUE_COLLECTION(Of Int32)
                        trees.Add(Request("keyTree"))
                        searcher.treesCollection = trees
                        
                        Dim cSearcher As New CORE_CONTEXT_SEARCHER
                        cSearcher.trees = trees
                        searcher.searchHolder.contextSearcher = cSearcher
                    End If
                    
                    If Request("keyTag") <> "0" And Request("keyTag") <> "" Then
                        Dim tags As New SEARCH_VALUE_COLLECTION(Of Int32)
                        tags.Add(Request("keyTag")) : store = False
                        searcher.contextsCollection = tags
                    End If
                    
                    searcher.searchStatus = CORE_CONTENT_SEARCHER.status.enabled
                    searcher.searchHolder.relateds = True
                    
                    If Request("keySearch") <> "" Then
                        searcher.search_text = Request("keySearch")
                        searcher.search_text_fields = CORE_CONTENT_SEARCHER.searchFields.title
                        searcher.search_text_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
                    End If
                                        
                    Dim types As New SEARCH_VALUE_COLLECTION(Of Integer)
                    types.Add(CORE_CONTENT.contentType.all)
                    searcher.contentsTypeCollection = types
                    
                    searcher.page = mypage
                    searcher.rows = rows
                
                    Dim mycoll As CORE_CONTENT_COLLECTION(Of CORE_CONTENT_HOLDER) = New CORE_CONTENT_COLLECTION(Of CORE_CONTENT_HOLDER)
                    mycoll = searcher.search()
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim co As CORE_CONTENT_HOLDER
                    
                    For Each co In mycoll

                        myvalues.Append("<value title=""" & Server.HtmlEncode(co.contentData.content_title) & """ id_key=""" & co.contentData.id_key.ToString & """  id_language=""" & co.contentData.id_language.ToString & """  date="" " & co.contentData.content_date_publication.ToString & """ link="" " & Server.HtmlEncode(CORE.makeLink(co.contentData.content_path, co.contentData.id_key, co.contentData.content_title, CORE.pageEvent.detail)) & """ abstract=""" & Server.HtmlEncode(co.contentData.content_abstract) & """ image=""" & "" & """/>")

                    Next

                    Dim count As Integer = searcher.searchcount()
                    Dim _path As String = CORE.pagination(mypath, 4, count, display, mypage)
                    returnData("<values store=""" & store.ToString & """>" & myvalues.ToString() & "<pager html=""" & Server.HtmlEncode(_path) & """ to=""" & Request("tree") & """ page=""" & mypage & """/><contents count=""" & count & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""1001"" errorLabel=""getContents Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                                        
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "getContent"
                Try

					'Response.Write(idContent)
					'Response.Write(CORE_CRYPTOGRAPHY.decrypt(idContent))
					'Response.End()

					Dim _idContent As Integer= Convert.ToInt32(CORE_CRYPTOGRAPHY.decrypt(idContent))
					
                    Dim mycontent As CORE_CONTENT = New CORE_CONTENT(_idContent)

                    Dim myc As CORE_COOKIE
                    If Request.Cookies("CORE") Is Nothing Then
                        myc = New CORE_COOKIE("contentPath", idContent, 1)
                    Else
                        myc = New CORE_COOKIE("contentPath", idContent, 1)
                    End If


				    Dim _headers As String = Request.Headers("X-Requested-With")
					Dim co As Object
					
					Dim _js_script As String = String.Empty
					If CORE_filesystem.fileExists(Request("jsPath") & _idContent &".js") Then 
					_js_script = "true" 
					Else
					_js_script = "false" 
					End If
					
 
					
                    returnData("<values><content id_key=""" & mycontent.id_key & """  id_content=""" & mycontent.id_content & """   title=""" & Server.HtmlEncode(mycontent.content_title) & """ date_publication=""" & mycontent.content_date_publication & """ covers=""" & mycontent.content_covers & """ defaultCover=""" & mycontent.content_default_cover & """ headers=""" & _headers & """ js_script=""" & _js_script & """>" & Server.HtmlEncode(mycontent.content_description) & "</content><error errorId=""0"" errorLabel=""""/></values>")



                    mycontent.Dispose()
                    mycontent = Nothing

                Catch ex As Exception

                    returnData("<values><error errorId=""1002"" errorLabel=""Get Content Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")

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