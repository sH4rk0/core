<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Import Namespace="System.io" %>

<script runat="server">
    Dim language_id As Integer
    Dim id_content As Integer
    Dim id_related As Integer
    Dim id_key As Integer
    Dim id_tree As Integer
    Dim id_user As Integer
    Dim trees As String
    Dim relateds As String
    Dim users As String
    Dim contexts As String
    Dim sites As String

    Dim treesSearch As String
    Dim relatedsSearch As String
    Dim usersSearch As String
    Dim contextsSearch As String
    Dim sitesSearch As String
    Dim typeSearch As Integer
    
    Dim searchMyText As String

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
        If Request("id_user") <> "" Then id_user = Convert.ToInt32(CORE_CRYPTOGRAPHY.decrypt(Request("id_user")))
        trees = Request("trees")
        relateds = Request("relateds")
        users = Request("users")
        contexts = Request("contexts")
        sites = Request("sites")
        
        If Request("searchText") <> String.Empty Then searchMyText = Request("searchText")
        
        treesSearch = Request("treesSearch")
        relatedsSearch = Request("relatedsSearch")
        usersSearch = Request("usersSearch")
        contextsSearch = Request("contextsSearch")
        sitesSearch = Request("sitesSearch")
        If Request("searchTypeContent") = "" Then typeSearch = 0 Else typeSearch = Request("searchTypeContent")
                
        id_site = Request("id_site")
        rows = Request("rows")
        mypage = Request("page")
        id_context = Request("id_context")
        responseType = CORE.checkResponse()


        If Not CORE_USER.hasRole(CORE_USER.userRole.contentAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMessage=""Your account is not authenticated to execute this action.""/></values>") : Return


        Select Case Request("who")


            '#############################################################
            '#############################################################	
            '#############################################################	
            Case "getContent"

                Try


                    Dim mycontent As CORE_CONTENT = New CORE_CONTENT(id_content)

                    Dim myc As CORE_COOKIE
                    If Request.Cookies("CORE") Is Nothing Then
                        myc = New CORE_COOKIE("contentPath", id_content, 1)
                    Else
                        myc = New CORE_COOKIE("contentPath", id_content, 1)
                    End If


                    returnData("<values><content id_key=""" & mycontent.id_key & """ id_language=""" & language_id & """ id_content=""" & mycontent.id_content & """  enabled=""" & mycontent.content_enabled & """ title=""" & normalizeXml(mycontent.content_title) & """ abstract=""" & normalizeXml(mycontent.content_abstract) & """  date_publication=""" & mycontent.content_date_publication & """ covers=""" & mycontent.content_covers & """ contentViews=""" & mycontent.content_views & """ postOption=""" & mycontent.post_option & """ defaultCover=""" & mycontent.content_default_cover & """ type=""" & mycontent.content_type & """>" & normalizeXml(mycontent.content_description) & "</content><error errorId=""0"" errorLabel=""""/></values>")



                    mycontent.Dispose()
                    mycontent = Nothing

                Catch ex As Exception

                    returnData("<values><error errorId=""200"" errorLabel=""Get Content Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")

                End Try

                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "getContentsCount"
                Try
                    Dim searcher As CORE_CONTENT_SEARCHER = New CORE_CONTENT_SEARCHER
                    searcher.id_language = language_id
                    Dim myTrees() As String
                    
                    If trees <> "" Then

                        myTrees = trees.Split(",")
                        Dim val As Integer
                        For Each val In myTrees
                            searcher.treesCollection.Add(val)
                        Next

                    ElseIf id_tree > 0 Then

                        searcher.treesCollection.Add(id_tree)
                                               
                    End If
                


                    returnData("<values><contents count=""" & searcher.searchcount() & """/><error errorId=""0"" errorLabel=""""/></values>")


                    searcher.Dispose()
                    searcher = Nothing

                Catch ex As Exception

                    returnData("<values><error errorId=""201"" errorLabel=""Get Contents Count Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")

                End Try

                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "getContentsValues"

                Dim searcher As CORE_CONTENT_SEARCHER = New CORE_CONTENT_SEARCHER


                Try
                    searcher.id_language = language_id
               
                    If sites <> String.Empty Then
                        searcher.sitesCollection = CORE_UTILITY.stringToCollection(sites, "|", New SEARCH_VALUE_COLLECTION(Of Int32))
                    Else
                        searcher.sitesCollection = CORE_UTILITY.arrayListToCollection(CORE_ROLE.roleSites(CORE_USER.userRole.contentAdministrator, CORE_USER.getUserId), New SEARCH_VALUE_COLLECTION(Of Int32))
                    End If

                    If sitesSearch = String.Empty Then
                        searcher.site_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
                    Else
                        searcher.site_search_mode = CORE_CONTENT_SEARCHER.searchType.AndSearch
                    End If

                   
                    If trees <> String.Empty Then
                        searcher.treesCollection = CORE_UTILITY.stringToCollection(trees, "|", New SEARCH_VALUE_COLLECTION(Of Int32))
                        If treesSearch = String.Empty Then
                            searcher.tree_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
                        Else
                            searcher.tree_search_mode = CORE_CONTENT_SEARCHER.searchType.AndSearch
                        End If
                    End If
                                                 
                    If users <> String.Empty Then
                        searcher.usersCollection = CORE_UTILITY.stringToCollection(users, "|", New SEARCH_VALUE_COLLECTION(Of Int32))
                        If usersSearch = String.Empty Then
                            searcher.user_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
                        Else
                            searcher.user_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
                        End If
                    End If

                    If relateds <> String.Empty Then
                        searcher.relatedsCollection = CORE_UTILITY.stringToCollection(relateds, "|", New SEARCH_VALUE_COLLECTION(Of Int32))
                        If relatedsSearch = String.Empty Then
                            searcher.related_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
                        Else
                            searcher.related_search_mode = CORE_CONTENT_SEARCHER.searchType.AndSearch
                        End If
                    End If

                    If contexts <> String.Empty Then
                        searcher.contextsCollection = CORE_UTILITY.stringToCollection(contexts, "|", New SEARCH_VALUE_COLLECTION(Of Int32))
                        If contextsSearch = String.Empty Then
                            searcher.context_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
                        Else
                            searcher.context_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
                        End If
                    End If

                    If searchMyText <> String.Empty Then searcher.search_text = searchMyText
                    searcher.rows = rows
                    searcher.page = mypage
                    
                    
                    searcher.contentsTypeCollection.Add(typeSearch)
                    'searcher.contentsTypeCollection.Add(CORE_CONTENT.contentType.contentStatic)

                    Select Case Request("orderBy")
                        Case "0"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentIdDesc
                        Case "1"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentIdAsc
                        Case "2"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentDatePublicationDesc
                        Case "3"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentDatePublicationAsc
                        Case "4"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentEnabledDesc
                        Case "5"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentEnabledAsc
                        Case "6"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentTitleDesc
                        Case "7"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentTitleAsc
                        Case "8"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentDateCreationDesc
                        Case "9"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentDateCreationAsc
                        Case "10"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentYearDesc
                        Case "11"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentYearAsc
                        Case "12"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentMonthDesc
                        Case "13"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentMonthAsc
                        Case "14"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentDayDesc
                        Case "15"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentDayAsc
                        Case "16"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentRankDesc
                        Case "17"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentRankAsc
                        Case "18"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentTypeDesc
                        Case "19"
                            searcher.searchOrder = CORE_CONTENT_SEARCHER.order.contentTypeAsc
                    End Select

                
                    Dim mycoll As CORE_CONTENT_COLLECTION(Of CORE_CONTENT_HOLDER) = searcher.search()
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim co As CORE_CONTENT_HOLDER

                    
                    For Each co In mycoll

                        myvalues.Append("<value title=""" & co.contentData.content_title & """ id_content=""" & co.contentData.id_content.ToString & """  id_key=""" & co.contentData.id_key.ToString & """  id_language=""" & co.contentData.id_language.ToString & """ enabled=""" & Convert.ToBoolean(co.contentData.content_enabled).ToString & """ type=""" & co.contentData.content_type & """ date="" " & co.contentData.content_date_publication.ToString & """ dateCreation="" " & co.contentData.content_date_creation.ToString & """ />")

                    Next

                     
                    returnData("<values>" & myvalues.ToString() & "<contents count=""" & searcher.searchcount() & """/><error errorId=""0"" errorLabel=""""/></values>")

                    searcher.Dispose()
                    searcher = Nothing
                Catch ex As Exception
                    returnData("<values><error errorId=""202"" errorLabel=""Get Contents Values Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                Finally
                    If Not searcher Is Nothing Then searcher.Dispose() : searcher = Nothing

                End Try


                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "insertContent"

                Dim content As CORE_CONTENT = New CORE_CONTENT()
                Dim tree As CORE_TREE = New CORE_TREE()
                Dim author As CORE_USER = New CORE_USER
                Try
                    Dim content_title As String = Request("content_title")
                    Dim content_type As String = Request("content_type")

                    content.content_title = content_title
                    content.content_type = content_type
                    content.id_language = language_id
                    content.id_site = id_site
                    content.id_user = id_user
                    content.content_type = CORE_CONTENT.contentType.content
                    Dim newId As Integer = content.content_insert(content)
                    content.Dispose()
                    content = Nothing

                    author.newRelation(newId, CORE_USER.getUserId())

                    If id_tree > 0 Then
                        tree.newRelation(newId, id_tree, id_site)
                        tree.Dispose()
                        tree = Nothing
                    End If

                    Dim contentFolder As String = Server.MapPath(ConfigurationManager.AppSettings("CORE_related_folder").ToString() & newId.ToString() & "/")
                    If Not System.IO.Directory.Exists(contentFolder) Then

                        Directory.CreateDirectory(contentFolder)

                    End If



                    returnData("<values><content contentId=""" & newId & """ id_tree=""" & id_tree & """/><error errorId=""0"" errorLabel=""""/></values>")


                Catch err As Exception

                    returnData("<values><error errorId=""203"" errorLabel=""Insert Content Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")

                Finally
                    If Not content Is Nothing Then content.Dispose() : content = Nothing
                    If Not tree Is Nothing Then tree.Dispose() : tree = Nothing
                    If Not author Is Nothing Then author.Dispose() : author = Nothing

                End Try

                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "updateContent"

                Dim content As CORE_CONTENT = New CORE_CONTENT(id_content)
                Try

                    Dim contentFolder As String = Server.MapPath(ConfigurationManager.AppSettings("CORE_related_folder").ToString() & id_content.ToString() & "/")
                    If Not System.IO.Directory.Exists(contentFolder) Then

                        Directory.CreateDirectory(contentFolder)

                    End If

                    Dim content_title As String = Request("content_title")
                    Dim content_abstract As String = Request("content_abstract")
                    Dim content_description As String = Request("content_description")
                    Dim content_publication As String = Request("content_publication")
                    Dim content_enabled As String = Request("content_enabled")
                    Dim post_option As String = Request("post_option")
                    Dim content_type As String = Request("content_type")
                    If content_type <> "" Then content.content_type = Convert.ToInt32(content_type)
                    If content_enabled = "" Then content_enabled = "false"
                    If content_title <> "" Then content.content_title = content_title Else content.content_title = "Title for " & content.id_key
                    If content_abstract <> "" Then content.content_abstract = content_abstract Else content.content_abstract = ""
                    If content_description <> "" Then content.content_description = content_description Else content.content_description = ""
                    If content_publication <> "" Then content.content_date_publication = content_publication
                    If content_enabled <> "" Then content.content_enabled = Convert.ToBoolean(content_enabled)
                    If post_option <> "" Then content.post_option = Convert.ToInt32(post_option)

                    content.content_update(content)
                    content.refreshCache()

                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("content_detail_" & id_content & ".cache".ToLower(), "contents")
                    cacheobj.remove_cache()

                    cacheobj = New CORE_CACHE("contents_" & language_id, "contents")
                    cacheobj.remove_cache()

                    content.Dispose()
                    content = Nothing
                    cacheobj.Dispose()
                    cacheobj = Nothing

                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")

                Catch err As Exception
                    returnData("<values><error errorId=""204"" errorLabel=""Update Content Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")

                Finally
                    If Not content Is Nothing Then content.Dispose() : content = Nothing

                End Try

                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "deleteContents"
                Dim content As CORE_CONTENT = New CORE_CONTENT

                Try

                    Dim contents() As String = Request("contents").Split("|")

                    Dim id As Integer = 0
                    Dim contentFolder As String


                    For Each id In contents
                        content = New CORE_CONTENT(id)
                        content.content_delete(id)
                        content.refreshCache()

                        contentFolder = Server.MapPath(ConfigurationManager.AppSettings("CORE_related_folder").ToString() & id.ToString() & "/")
                        If System.IO.Directory.Exists(contentFolder) Then Directory.Delete(contentFolder)



                    Next
                    If Not content Is Nothing Then content.Dispose() : content = Nothing

                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")

      
                Catch ex As Exception

                    returnData("<values><error errorId=""205"" errorLabel=""Delete Contents Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")

                Finally
                    If Not content Is Nothing Then content.Dispose() : content = Nothing

                End Try

                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "updateContentField"
                Dim content As CORE_CONTENT = New CORE_CONTENT(id_content)

                Try


                    content.update_field(id_content, Request("field"), Request("value"))
                    content.refreshCache()
                    If Not content Is Nothing Then content.Dispose() : content = Nothing

                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")

      
                Catch ex As Exception

                    returnData("<values><error errorId=""206"" errorLabel=""Update Content Field Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")

                Finally
                    If Not content Is Nothing Then content.Dispose() : content = Nothing

                End Try


        End Select


    End Sub


    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    Function normalizeXml(ByVal myText As String) As String


        If myText <> "" Then
            myText = Server.HtmlEncode(myText)
            myText = myText.Replace("<", "#lt#").Replace(">", "#gt#")
        End If
        Return myText

    End Function
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