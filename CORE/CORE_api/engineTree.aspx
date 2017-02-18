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
    Dim id_site As Integer
    Dim id_father As Integer
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
        id_father = Request("id_father")
        rows = Request("rows")
        mypage = Request("page")
        id_context = Request("id_context")
        responseType = CORE.checkResponse()
        If Not CORE_USER.hasRole(CORE_USER.userRole.treeAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMessage=""Your account is not authenticated to execute this action.""/></values>") : Return
            
     
        Select Case Request("who")
    		
            '#############################################################
            '#############################################################	
            '#############################################################	
    		
            Case "newBranch"
    		
                Dim tree_title As String = Request("tree_title")
                Dim newtree As CORE_TREE = New CORE_TREE()
                Dim mycacheobj As CORE_CACHE = New CORE_CACHE("tree_branches_" & id_site, "trees")
                
                Try
                    
                    newtree.id_site = id_site
                    newtree.id_language = language_id
                    newtree.id_father = id_tree
                    newtree.tree_title = tree_title
                    Dim newID As Integer = newtree.tree_insert(newtree)
                    newtree.Dispose()
                    newtree = Nothing
                    
                    
                    mycacheobj.remove_cache()
                    mycacheobj.Dispose()
                    mycacheobj = Nothing
                    
                    returnData("<values><tree id=""" & newID & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""400"" errorLabel=""New Branch Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                    If Not newtree Is Nothing Then newtree.Dispose() : newtree = Nothing
                    If Not mycacheobj Is Nothing Then mycacheobj.Dispose() : mycacheobj = Nothing
                    
                End Try
                
                
                
                
    		
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "getTree"
    		
                Dim mytree As CORE_TREE_SEARCHER = New CORE_TREE_SEARCHER(id_site, 0, language_id)
                Try
                    
                    
                    'Response.Write(makeSimpleTree(mytree.search()))
                    
                    returnData("<values><tree html=""" & Server.HtmlEncode(makeHtree(mytree.search())) & Server.HtmlEncode(makeSimpleTree(mytree.search())) & """ /><error errorId=""0"" errorLabel="""" errorMessage=""""/></values>")
                    
                    mytree.Dispose()
                    mytree = Nothing
                                 
                Catch Err As Exception
                    returnData("<values><error errorId=""411"" errorLabel=""Get Tree Values Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                Finally
                    
                    If Not mytree Is Nothing Then mytree.Dispose() : mytree = Nothing
                    
                    
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "getTreeValues"
                
                Dim mytree As CORE_TREE_SEARCHER = New CORE_TREE_SEARCHER(id_site, 0, language_id)
                Try
                        		
                    Dim mydata As DataTableReader = mytree.search()
                    Dim myvalues As StringBuilder = New StringBuilder
    		
                    While mydata.Read
    		
                        myvalues.Append("<tree id_key=""" & mydata("id_key").ToString() & """  level=""" & mydata("tree_level").ToString() & """ id_language=""" & language_id.ToString() & """ id_content=""" & mydata("id_content").ToString() & """ id_tree=""" & mydata("id_tree").ToString() & """  id_site=""" & id_site.ToString() & """ enabled=""" & mydata("tree_enabled").ToString() & """ title=""" & Server.HtmlEncode(mydata("tree_title").ToString()) & """ meta=""" & Server.HtmlEncode(mydata("tree_meta").ToString()) & """ description=""" & Server.HtmlEncode(mydata("tree_description").ToString()) & """ keywords=""" & Server.HtmlEncode(mydata("tree_keywords").ToString()) & """ />")
                        
    		
                    End While
                    mydata.Close()
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/>" & myvalues.ToString() & "</values>")
                                
                    mytree.Dispose()
                    mytree = Nothing
                Catch err As Exception
                    returnData("<values><error errorId=""410"" errorLabel=""Get Trees Values Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    If Not mytree Is Nothing Then mytree.Dispose() : mytree = Nothing
                End Try
    		
                 				
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "getTreeValue"
    		
                ' Dim tree As CORE_TREE = New CORE_TREE(id_site, id_tree, language_id)
                Dim tree As CORE_TREE = New CORE_TREE(id_tree)
                
                
                Try
                    Dim tree_description As String = string.empty
    		
                    If tree.id_content > 0 Then
                        Dim mycontent As CORE_CONTENT = New CORE_CONTENT(tree.id_content)
                        tree_description = mycontent.content_description
                        mycontent.Dispose()
                        mycontent = Nothing
						if tree_description<>string.empty then tree_description=server.HtmlEncode(tree_description)
                    End If
    			
                      		
                    returnData("<values><tree id_key=""" & tree.id_key.ToString() & """  id_language=""" & language_id.ToString() & """ id_content=""" & tree.id_content.ToString() & """ id_tree=""" & tree.id_tree.ToString() & """ enabled=""" & tree.tree_enabled.ToString() & """ title=""" & Server.HtmlEncode(tree.tree_title.ToString()) & """ description=""" & Server.HtmlEncode(tree.tree_description.ToString()) & """ keywords=""" & Server.HtmlEncode(tree.tree_keywords) & """ link=""" & Server.HtmlEncode(tree.tree_link) & """  meta=""" & Server.HtmlEncode(tree.tree_meta) & """ linkType=""" & tree.tree_link_type & """>" & tree_description & "</tree><error errorId=""0"" errorLabel=""""/></values>")
                    
                    tree.Dispose()
                    tree = Nothing
                
                    
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""401"" errorLabel=""Get Tree Value Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                    If Not tree Is Nothing Then tree.Dispose() : tree = Nothing
                    
                    
                End Try
    		
              
        
    		
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "updateTree"
    		
                Try

    	
                    Dim tree_title As String = Request("tree_title")
                    Dim tree_keywords As String = Request("tree_keywords")
                    Dim tree_description As String = Request("tree_description")
                    Dim tree_enabled As String = Request("tree_enabled")
                    If tree_enabled = "" Then tree_enabled = "false"
                    Dim tree_link As String = Request("tree_link")
                    Dim tree_meta As String = Request("tree_meta")
                    Dim tree_link_type As Integer = Request("tree_link_type")
                    Dim tree_content As Integer = 0
                    If Request("tree_content") <> "" Then tree_content = Request("tree_content") Else tree_content = 0
                    
                    'Dim tree As CORE_TREE = New CORE_TREE(id_site, id_tree, language_id)
                    Dim tree As CORE_TREE = New CORE_TREE(id_tree)
    				
                    If tree_title <> "" Then tree.tree_title = tree_title
                    If tree_keywords <> "" Then tree.tree_keywords = tree_keywords Else tree.tree_keywords = ""
                    If tree_description <> "" Then tree.tree_description = tree_description Else tree.tree_description = ""
                    If tree_meta <> "" Then tree.tree_meta = tree_meta Else tree.tree_meta = ""
                    If tree_link <> "" Then tree.tree_link = tree_link
                    If tree_enabled <> "" Then tree.tree_enabled = Convert.ToBoolean(tree_enabled)
                    tree.id_content = tree_content
                    tree.tree_link_type = returnLinkType(tree_link_type)
                    tree.tree_update(tree)
    				
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("tree_" & id_site & "_", "trees")
                    cacheobj.remove_cache()
    				
                    cacheobj = New CORE_CACHE("tree_branches_" & id_site & "_", "trees")
                    cacheobj.remove_cache()
                    
                    cacheobj = New CORE_CACHE("tree_branches_0_" & language_id, "trees")
                    cacheobj.remove_cache()
    				
    			
                    tree.Dispose()
                    tree = Nothing
                    cacheobj.Dispose()
                    cacheobj = Nothing
    				
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
    		
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""402"" errorLabel=""Update Tree Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
    		
                End Try
                
                '############################################################# 
                '#############################################################	
                '#############################################################			
            Case "getTreesRelated"
    		
                Try
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("trees_related_" & id_content & "_" & language_id.ToString(), "trees")
                    cacheobj.remove_cache()
                    cacheobj.Dispose()
                    cacheobj = Nothing
    		
                    Dim tree As CORE_TREE = New CORE_TREE()
                    Dim mydata As DataTableReader = tree.getRelations(id_content)
                    Dim myvalues As StringBuilder = New StringBuilder
    		
                    While mydata.Read
    		
                        myvalues.Append("<value site_host=""" & mydata("site_host") & """ tree_title=""" & mydata("tree_title") & """   id_relation=""" & mydata("id_key") & """ path=""" & mydata("content_path") & """ />")
    		
                    End While
                    mydata.Close()
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/>" & myvalues.ToString() & "</values>")
                                
                    tree.Dispose()
                    tree = Nothing
                Catch
                    returnData("<values><error errorId=""403"" errorLabel=""Get Trees Related Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                
                End Try
                
                	
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "removeTreeRelation"
    		
               
                Dim newtree As CORE_TREE = New CORE_TREE()
                Dim mycacheobj As CORE_CACHE = New CORE_CACHE("trees_related_" & id_content, "trees")
                
                Try
                    
                    newtree.removeRelation(id_key)
                    
                   
                    newtree.Dispose()
                    newtree = Nothing
                    
                    
                    mycacheobj.remove_cache()
                    mycacheobj.Dispose()
                    mycacheobj = Nothing
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""404"" errorLabel=""Remove Tree Relation Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                    If Not newtree Is Nothing Then newtree.Dispose() : newtree = Nothing
                    If Not mycacheobj Is Nothing Then mycacheobj.Dispose() : mycacheobj = Nothing
                    
                End Try
                
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "newTreeRelation"
    		
               
                Dim newtree As CORE_TREE = New CORE_TREE()
                Dim mycacheobj As CORE_CACHE = New CORE_CACHE("trees_related_" & id_content, "trees")
                
                Try
                    
                    newtree.newRelation(id_content, id_key, id_site)
                    
                   
                    newtree.Dispose()
                    newtree = Nothing
                    
                    
                    mycacheobj.remove_cache()
                    mycacheobj.Dispose()
                    mycacheobj = Nothing
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""405"" errorLabel=""New Tree Relation Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                    If Not newtree Is Nothing Then newtree.Dispose() : newtree = Nothing
                    If Not mycacheobj Is Nothing Then mycacheobj.Dispose() : mycacheobj = Nothing
                    
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "contentToTree"
    		
               
                Dim newtree As CORE_TREE = New CORE_TREE(id_site, Convert.ToInt32(Request("keyTree")), language_id)
                Dim mycacheobj As CORE_CACHE = New CORE_CACHE("tree_" & id_site.ToString() & "_" & Request("keyTree") & "_" & language_id.ToString() & ".cache", "trees")
                
                Try
                    newtree.id_content = Convert.ToInt32(Request("contentKey"))
                    newtree.tree_update(newtree)
                    
                    mycacheobj.remove_cache()
                    mycacheobj = New CORE_CACHE("tree_branches_" & id_site.ToString() & "_", "trees")
                    mycacheobj.remove_cache()
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""406"" errorLabel=""Content To Tree Relation Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                    If Not newtree Is Nothing Then newtree.Dispose() : newtree = Nothing
                    If Not mycacheobj Is Nothing Then mycacheobj.Dispose() : mycacheobj = Nothing
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "removeContentFromTree"
    		
               
                Dim newtree As CORE_TREE = New CORE_TREE(id_site, Convert.ToInt32(Request("keyTree")), language_id)
                Dim mycacheobj As CORE_CACHE = New CORE_CACHE("tree_" & id_site.ToString() & "_" & Request("keyTree") & "_" & language_id.ToString() & ".cache", "trees")
                               
                Try
                    newtree.id_content = 0
                    newtree.tree_update(newtree)
                    
                    mycacheobj.remove_cache()
                    mycacheobj = New CORE_CACHE("tree_branches_" & id_site.ToString() & "_", "trees")
                    mycacheobj.remove_cache()
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""407"" errorLabel=""Content To Tree Relation Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                    If Not newtree Is Nothing Then newtree.Dispose() : newtree = Nothing
                    If Not mycacheobj Is Nothing Then mycacheobj.Dispose() : mycacheobj = Nothing
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "treeImageExist"
    		
               
                Dim exist As String = "false"
                               
                Try
                   
                    If CORE_filesystem.fileExists(Request("imgPath")) Then exist = "true"
                    
                    returnData("<values><image exist=""" & exist & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""408"" errorLabel=""tree Image Exist"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                   
                End Try
                 
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "treeImageRemove"
    		
                Dim myTree As CORE_TREE = Nothing
                Try
                    
                    myTree = New CORE_TREE(id_tree)
                    
                    myTree.deleteImages()
                    myTree.Dispose()
                    myTree = Nothing
                    
                   
                                   
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""409"" errorLabel=""tree Image Remove"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    If Not myTree Is Nothing Then myTree.Dispose() : myTree = Nothing
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "treeUpdateOrder"
    		
                Dim mycacheobj As CORE_CACHE = Nothing
                Dim order() As String = Request("treeOrder").Split("|")
                Dim treeKey As String
                Dim counter As Integer = 0
                Dim myTree As CORE_TREE = Nothing
                              
                Try
                        
                    
                    mycacheobj = New CORE_CACHE("tree_" & id_key, "trees")
                    mycacheobj.remove_cache()
                    myTree = New CORE_TREE(id_key)
                    myTree.id_father = id_father
                    myTree.tree_update(myTree)
                    myTree.Dispose()
                    myTree = Nothing
                    
                    
                    
                    For Each treeKey In order
                        
                        CORE.update_field(treeKey, "core_tree", "id_key", "tree_order", counter)
                        counter = counter + 1
                        
                    Next
                                      
                    mycacheobj = New CORE_CACHE("tree_branches_" & id_site, "trees")
                    mycacheobj.remove_cache()
                    mycacheobj.Dispose()
                    mycacheobj = Nothing
                    
                    
                    
                    Dim mytreeS As CORE_TREE_SEARCHER = New CORE_TREE_SEARCHER(id_site, 0, language_id)
                                                                      
                    returnData("<values><tree html=""" & Server.HtmlEncode(makeHtree(mytreeS.search())) & Server.HtmlEncode(makeSimpleTree(mytreeS.search())) & """ /><error errorId=""0"" errorLabel=""" & id_father & "-" & id_key & """/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""410"" errorLabel=""tree Update Order"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    If Not myTree Is Nothing Then myTree.Dispose() : myTree = Nothing
                    If Not mycacheobj Is Nothing Then mycacheobj.Dispose() : mycacheobj = Nothing
                    
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "treeDelete"
    		
                Dim mycacheobj As CORE_CACHE = Nothing
                Dim myTree As CORE_TREE = Nothing
                Try
            
                    
                    myTree = New CORE_TREE(id_key)
                    myTree.delete()
                    myTree.Dispose()
                    myTree = Nothing
                
                                                  
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""411"" errorLabel=""tree Delete"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                   
                    If Not mycacheobj Is Nothing Then mycacheobj.Dispose() : mycacheobj = Nothing
                    If Not myTree Is Nothing Then myTree.Dispose() : myTree = Nothing
                    
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "treeDeleteRecursive"
    		
                Dim myTree As CORE_TREE = Nothing
                
                Try
                                           
                    myTree = New CORE_TREE(id_key)
                    myTree.deleteRecursive()
                    myTree.Dispose()
                    myTree = Nothing
                                       
                  
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""412"" errorLabel=""tree Delete Recursive"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                   
                    If Not myTree Is Nothing Then myTree.Dispose() : myTree = Nothing
                    
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "renameBranch"
    		
                Dim tree_title As String = Request("tree_title")
                Dim newtree As CORE_TREE = New CORE_TREE(id_tree)
                Dim mycacheobj As CORE_CACHE = New CORE_CACHE("tree_branches_" & id_site, "trees")
                
                Try
                    
                    newtree.tree_title = tree_title
                    newtree.tree_update(newtree)
                    newtree.Dispose()
                    newtree = Nothing
                    
                    
                    mycacheobj.remove_cache()
                    mycacheobj.Dispose()
                    mycacheobj = Nothing
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                
                Catch Err As Exception
                    
                    returnData("<values><error errorId=""413"" errorLabel=""Rename Branch Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                    
                    
                Finally
                    
                    If Not newtree Is Nothing Then newtree.Dispose() : newtree = Nothing
                    If Not mycacheobj Is Nothing Then mycacheobj.Dispose() : mycacheobj = Nothing
                    
                End Try
                
    		
        End Select
    		
    		
    End Sub
              
    		
    		
  
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    Function normalizeXml(ByVal myText As String) As String
    	
        If myText <> "" Then myText = myText.Replace("<", "#lt#").Replace(">", "#gt#")
    	
        Return myText
    	
    End Function
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    Function makeHtree(ByVal tree As DataTableReader) As String
    	
        Dim Jstring As String = "<ul>"
        Dim level As Integer
        Dim i As Integer
        Dim temp_level As Integer = 0
        Dim context_id As String
        Dim context_descrizione As String
        Dim a As Integer = 1
        Dim id_opt As String = ""
        Do While tree.Read()
                
            context_descrizione = tree("tree_title")
            context_id = tree("id_tree")
            level = tree("tree_level")
            If level < temp_level Then Jstring = Jstring & "</li></ul></li>"
            If level = temp_level Then Jstring = Jstring & "</li>"
            If level > 1 And level <> temp_level And level > temp_level Then Jstring = Jstring & "<ul>"
            If tree("id_father") = "0" Then id_opt = "0" Else id_opt = tree("id_key")
    			
            If tree("id_tree") = "1" Then
                Jstring = Jstring & "<li><img src=""/core/core_images/admin/layout_ico.png"" border=""0"" alt=""Customize Layout"" class=""imgLayout"" rel=""" & tree("id_tree") & """/><img src=""/core/core_images/admin/add_tree_child.gif"" border=""0"" alt=""Add child Layout"" class=""imgChild"" rel=""" & tree("id_tree") & """/><a href='#' onclick='javascript:treeModify(" & tree("id_tree") & ")' id=""opt_" & id_opt & """ ><span>" & tree("tree_title") & "</span></a>"
            
            ElseIf tree("id_content") <> "0" Then
                Jstring = Jstring & "<li><img src=""/core/core_images/admin/layout_ico.png"" border=""0"" alt=""Customize Layout"" class=""imgLayout"" rel=""" & tree("id_tree") & """/><img src=""/core/core_images/admin/add_tree_child.gif"" border=""0"" alt=""Add child Layout"" class=""imgChild"" rel=""" & tree("id_tree") & """/><a href='#' onclick='javascript:treeModify(" & tree("id_tree") & ")' id=""opt_" & id_opt & """ ><span>" & tree("tree_title") & "</span></a> <a href='javascript:removeContentFromTree(" & tree("id_tree") & ")' >[<]</a>"
    				
            Else
                Jstring = Jstring & "<li><img src=""/core/core_images/admin/layout_ico.png"" border=""0"" alt=""Customize Layout"" class=""imgLayout"" rel=""" & tree("id_tree") & """/><img src=""/core/core_images/admin/add_tree_child.gif"" border=""0"" alt=""Add child Layout"" class=""imgChild"" rel=""" & tree("id_tree") & """/><a href='#' onclick='javascript:treeModify(" & tree("id_tree") & ")' id=""opt_" & id_opt & """ ><span>" & tree("tree_title") & "</span></a>  <a href='javascript:getContents(" & tree("id_key") & ")' id=""opt_" & id_opt & """ ><span>[c]</span></a> <a href='javascript:newTreeRelation(" & tree("id_key") & ")'>[r]</a> <a href='javascript:setContentToTree(" & tree("id_tree") & ")' style='display:none;' class='toTree'>[>]</a> "
    							
            End If
                
            temp_level = level
            a = a + 1
        Loop
        tree.Close()
        For i = 1 To level
            Jstring = Jstring & "</li></ul>"
        Next
            
        Return ""
        Return Jstring
            
           
    End Function
    
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    Function makeSimpleTree(ByVal tree As DataTableReader) As String
    	
        
        Dim Jstring As String = "<ul class=""simpleTree"">"
        Dim level As Integer
        Dim i As Integer
        Dim temp_level As Integer = 0
        Dim context_id As String
        Dim context_descrizione As String
        Dim a As Integer = 1
        Dim id_opt As String = ""
        Dim startClass As String = String.Empty
        Do While tree.Read()
                
            context_descrizione = tree("tree_title")
            context_id = tree("id_tree")
            level = tree("tree_level")
            
            If level < temp_level Then
                
                Dim diff As Integer = temp_level - level
                'Response.Write(diff & "<br>")
                Dim x As Integer = 1
                For x = 1 To diff
                    Jstring = Jstring & "</li></ul></li>"
                    
                Next
                
            End If
           
            'Response.Write(level & ":" & temp_level & "<br>")
            
            
            
            If level = temp_level Then Jstring = Jstring & "</li>"
            If level > 1 And level <> temp_level And level > temp_level Then Jstring = Jstring & "<ul>"
            
            
            
            If tree("id_father") = "0" Then id_opt = "0" : startClass = "root" Else id_opt = tree("id_key") : startClass = ""
    			
           
            Jstring = Jstring & "<li id_key=""" & tree("id_key") & """ id=""" & tree("id_tree") & """ rel=""" & startClass & """><a href='#'><ins>&nbsp;</ins>" & tree("tree_title") & "</a>"
           
                
            temp_level = level
            a = a + 1
        Loop
        tree.Close()
        For i = 1 To level
            Jstring = Jstring & "</li></ul>"
        Next
            
        
        Return Jstring
            
           
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
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////
    Function returnLinkType(ByVal linkType As Integer) As CORE_TREE.linkType
 
        If linkType = 0 Then Return CORE_TREE.linkType.none
        If linkType = 1 Then Return CORE_TREE.linkType.toLink
        If linkType = 2 Then Return CORE_TREE.linkType.toFunction
        If linkType = 3 Then Return CORE_TREE.linkType.toMail
        
    End Function
        </script>