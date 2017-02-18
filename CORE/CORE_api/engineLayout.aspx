<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>

    <script runat="server">

        '//////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////
        Dim id_site As Integer = 0
        Dim id_tree As Integer = 0
        Dim id_event As Integer = 0
        Dim id_language As Integer = 0
        Dim position As Integer = 0
        Dim id_box As Integer = 0
        Dim mycacheobj As CORE_CACHE = New CORE_CACHE
        Dim _search As String = ""
        Dim responseType As String
        Dim id_key As Integer = 0
  
       
      
        '//////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////   
        Function update_module(ByVal _request As String, ByVal _position As Integer, ByVal _id_event As Integer) As String
                        
                   
            Dim _arr() As String = Nothing
            Dim i As Integer = 0
            Dim mybox As CORE_BOX2TREE = New CORE_BOX2TREE
           
             
            Dim module_value As String = ""
            Dim pos As Integer = 0
            Dim _return_values As String = ""
            Dim _box2tree_key As Integer = 0
            
            If _request <> "" Then
                
               
                    
                
                _arr = _request.Split(",")
                For i = 0 To UBound(_arr)
                 
                    module_value = _arr(i)
                    module_value = module_value.Replace("module_", "")
                    pos = module_value.LastIndexOf("_")
                    module_value = Left(module_value, pos)
                    _box2tree_key = Convert.ToInt32(module_value)
                    
                    Dim cache As String = "Box2tree_" & _box2tree_key.ToString() & ".cache"
                    mycacheobj.cache_folder = "modules"
                    mycacheobj.remove_cache(cache)
                    
                    mybox = New CORE_BOX2TREE(_box2tree_key)
                   
                    mybox.box_position = _position
                    mybox.id_event = _id_event
                    mybox.box_order = i
                    mybox.update(mybox)
                    
                    '_return_values = _return_values & " key:" & _box2tree_key & " pos:" & _position & " eve:" & _id_event & " ord:" & i & " req:" & _request & " cache:" & cache & "|"
                
                Next
                    
                
            End If
            _arr = Nothing
            mybox.Dispose()
            mybox = Nothing
            mycacheobj.cache_folder = "modules"
            mycacheobj.remove_cache("module_box_values_" & id_site & "_" & id_tree & "_" & id_language & "_" & _position & "_" & _id_event & "_0.cache")
           
            Return _return_values
            
        End Function
        '//////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////
        Sub page_load()
            

            id_site = Convert.ToInt32(Request("id_site"))
            If Request("id_box") <> "" Then id_box = Convert.ToInt32(Request("id_box"))
            id_tree = Convert.ToInt32(Request("id_tree"))
            id_event = Convert.ToInt32(Request("id_event"))
            id_language = Convert.ToInt32(Request("id_language"))
            position = Convert.ToInt32(Request("position"))
            id_key = Convert.ToInt32(Request("id_key"))
            responseType = CORE.checkResponse()
            
            If Not CORE_USER.hasRole(CORE_USER.userRole.layoutAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMsg=""Your account is not authenticated to execute this action.""/></values>") : Return
            
            
            Select Case Request("who")
                
                Case "copyLayout"
                
                    Try
                       
                        Dim b2tree As CORE_BOX2TREE = New CORE_BOX2TREE
                        b2tree.id_language = id_language
                        b2tree.id_site = id_site
                        b2tree.id_tree = Request("to")
                        b2tree.delete()
                        b2tree.id_tree = Request("from")
                        
                        Dim reader As DataTableReader = b2tree.search()
                        Dim mybox As CORE_BOX2TREE = New CORE_BOX2TREE
                        While reader.Read
                            
                            mybox.id_site = reader("id_site")
                            mybox.id_tree = Request("to")
                            mybox.id_box = reader("id_box")
                            mybox.id_language = reader("id_language")
                            mybox.id_event = reader("id_event")
                            mybox.box_position = reader("box_position")
                            mybox.box_order = reader("box_order")
                            mybox.box_enabled = reader("box_enabled")
                            mybox.insert(mybox)
                            
                        End While
                        mybox.Dispose()
                        mybox = Nothing
                        
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    Catch ex As Exception

                        returnData("<values><error errorId=""301"" errorLabel=""copyLayout Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                        
                    End Try
    	
                Case "updateLayout"
                    
                    Dim layoutBox1 As String = Request("layoutBox1")
                    Dim layoutBox2 As String = Request("layoutBox2")
                    Dim layoutBox3 As String = Request("layoutBox3")
                    Dim layoutBox4 As String = Request("layoutBox4")
                    Dim layoutBox5 As String = Request("layoutBox5")
                    Dim layoutBox6 As String = Request("layoutBox6")
                    Dim layoutBox7 As String = Request("layoutBox7")
                    
                    layoutBox1 = update_module(layoutBox1, 1, id_event)
                    layoutBox2 = update_module(layoutBox2, 2, id_event)
                    layoutBox3 = update_module(layoutBox3, 3, id_event)
                    layoutBox4 = update_module(layoutBox4, 4, id_event)
                    layoutBox5 = update_module(layoutBox5, 5, id_event)
                    layoutBox6 = update_module(layoutBox6, 6, id_event)
                    layoutBox7 = update_module(layoutBox7, 7, id_event)
                    
                    
                    Dim values As String = layoutBox1 & layoutBox2 & layoutBox3 & layoutBox4 & layoutBox5 & layoutBox6 & layoutBox7
                                        
                    Dim respo As String = String.Empty
                    If values <> "" Then respo = Left(values, values.Length - 1)
                    
                    returnData("<values><update value='" & respo & "'/><error errorId=""0"" errorLabel=""""/></values>")
                    
                   
                    'Response.ContentType = "text/html"
                    
                Case "insertBox2Tree"
                    
                    
                    Dim id_box As Integer = Request("id_box")
                    
                    Try
                        Dim mybox As CORE_BOX2TREE = New CORE_BOX2TREE
                        mybox.id_site = id_site
                        mybox.id_tree = id_tree
                        mybox.id_box = id_box
                        mybox.id_language = id_language
                        mybox.box_position = position
                        mybox.id_event = id_event
                        mybox.box_order = 0
                        mybox.box_enabled = 0
                        Dim idboxkey As Integer = mybox.insert(mybox)
                        
                        mycacheobj.cache_folder = "modules"
                        mycacheobj.remove_cache("module_box_values_" & id_site & "_" & id_tree & "_" & id_language & "_" & position & "_" & id_event & "_0.cache")
                        
                        returnData("<values><box id_key=""" & idboxkey & """ id_box=""" & id_box & """ boxPosition=""" & position & """/><error errorId=""0"" errorLabel=""""/></values>")
                    Catch ex As Exception

                        returnData("<values><error errorId=""302"" errorLabel=""insertBox2Tree Error"" errorMsg=""" & Server.HtmlEncode(Err.ToString()) & """/></values>")
                        
                    End Try
            		   
                Case "deleteBox2Tree"
                    
                    Dim box As CORE_BOX2TREE = New CORE_BOX2TREE
                    Try
                        box.id_key = id_key
                        box.delete()
                        box.Dispose()
                        box = Nothing
                        mycacheobj.cache_folder = "modules"
                        mycacheobj.remove_cache("Box2tree_" & id_key & ".cache")
                        mycacheobj.remove_cache("module_box_values_" & id_site & "_" & id_tree & "_" & id_language & "_" & position & "_" & id_event & "_0.cache")
                        
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                        
                    Catch ex As Exception

                        returnData("<values><error errorId=""303"" errorLabel=""deleteBox2Tree Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                        
                    End Try
                    
                    
                Case "enableBox2Tree"
                    mycacheobj.cache_folder = "modules"
                    mycacheobj.remove_cache("Box2tree_" & id_key & ".cache")
                    Dim box As CORE_BOX2TREE = New CORE_BOX2TREE(id_key)
                    Try
                        
                        If box.box_enabled = True Then box.box_enabled = False Else box.box_enabled = True
                        box.update(box)
                        box.Dispose()
                        box = Nothing
                        mycacheobj.cache_folder = "modules"
                        mycacheobj.remove_cache("Box2tree_" & id_key & ".cache")
                        mycacheobj.remove_cache("module_box_values_" & id_site & "_" & id_tree & "_" & id_language & "_" & position & "_" & id_event & "_0.cache")
                        
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                        
                    Catch ex As Exception

                        returnData("<values><error errorId=""304"" errorLabel=""enableBox2Tree Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                        
                    End Try
                    
                Case "boxUpdate"
                    
                    Dim boxId As String = Request("boxId")
                    Dim boxTitle As String = Request("boxTitle")
                    Dim boxDescription As String = Request("boxDescription")
                    Dim boxIdModule As String = Request("boxIdModule")
                    Dim boxIdSite As String = Request("boxIdSite")
                    Dim boxIdTemplate As String = Request("boxIdTemplate")
                    Dim boxWidth As String = Request("boxWidth")
                    Dim boxHeight As String = Request("boxHeight")
                    Dim boxCache As String = Request("boxCache")
                    Dim boxStyle As String = Request("boxStyle")
                    Dim boxRows As String = Request("boxRows")
                    Dim treeId As String = Request("treeId")
                    Dim contents As String = Request("boxContents")
                    Dim contexts As String = Request("boxContexts")
                    Dim trees As String = Request("boxTrees")
                    Dim relateds As String = Request("boxRelateds")
                    Dim users As String = Request("boxUsers")
                    Dim contentTypes As String = Request("boxContentTypes")
                    Dim boxEnabled As String = Request("boxEnabled")
                    Dim boxDateStart As String = Request("boxDateStart")
                    Dim boxDateEnd As String = Request("boxDateEnd")
                    Dim myBox As CORE_BOX = New CORE_BOX(boxId)
                    
                    Try
                   
                        If boxTitle <> String.Empty Then myBox.box_title = boxTitle
                        If boxDescription <> String.Empty Then myBox.box_description = boxDescription
                        If boxIdModule <> String.Empty Then myBox.id_module = Convert.ToInt32(boxIdModule)
                        If boxIdSite <> String.Empty Then myBox.id_key_site = Convert.ToInt32(boxIdSite)
                        If boxIdTemplate <> String.Empty Then myBox.id_template = Convert.ToInt32(boxIdTemplate)
                        If boxWidth <> String.Empty Then myBox.width = Convert.ToInt32(boxWidth)
                        If boxHeight <> String.Empty Then myBox.height = Convert.ToInt32(boxHeight)
                        If boxCache <> String.Empty Then myBox.cache = boxCache
                        If boxStyle <> String.Empty Then myBox.style = boxStyle
                        If boxRows <> String.Empty Then myBox.box_rows = Convert.ToInt32(boxRows)
                        
                        If boxEnabled <> String.Empty Then myBox.box_enabled = True Else myBox.box_enabled = False
                        If boxDateStart <> String.Empty Then myBox.box_date_start = Convert.ToDateTime(boxDateStart) Else myBox.box_date_start = Nothing
                        If boxDateEnd <> String.Empty Then myBox.box_date_end = Convert.ToDateTime(boxDateEnd) Else myBox.box_date_end = Nothing
                        
                        If contents <> String.Empty Then myBox.contentsCollection = CORE_utility.stringToCollection(contents, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.contentsCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        If contexts <> String.Empty Then myBox.contextsCollection = CORE_utility.stringToCollection(contexts, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.contextsCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        If trees <> String.Empty Then myBox.treesCollection = CORE_utility.stringToCollection(trees, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.treesCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        If relateds <> String.Empty Then myBox.relatedsCollection = CORE_utility.stringToCollection(relateds, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.relatedsCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        If users <> String.Empty Then myBox.usersCollection = CORE_utility.stringToCollection(users, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.usersCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        If contentTypes <> String.Empty Then myBox.contentTypesCollection = CORE_utility.stringToCollection(contentTypes, ",", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.contentTypesCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                                                
                        myBox.update(myBox)
                    
                        mycacheobj.cache_folder = "modules"
                        mycacheobj.remove_cache("box_value_" & boxId & ".cache")
                        mycacheobj.remove_cache("module_box_values_" & treeId)
                        mycacheobj.remove_cache("box_list.cache")
                    
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    Catch ex As Exception

                        returnData("<values><error errorId=""305"" errorLabel=""boxUpdate Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                        
                    End Try
                    
                                   
                Case "boxInsert"
                    
                    Dim boxTitle As String = Request("boxTitle")
                    Dim boxDescription As String = Request("boxDescription")
                    Dim boxIdModule As String = Request("boxIdModule")
                    Dim boxIdTemplate As String = Request("boxIdTemplate")
                    Dim boxIdSite As String = Request("boxIdSite")
                    Dim boxWidth As String = Request("boxWidth")
                    Dim boxHeight As String = Request("boxHeight")
                    Dim boxCache As String = Request("boxCache")
                    Dim boxStyle As String = Request("boxStyle")
                    Dim contents As String = Request("boxContents")
                    Dim contexts As String = Request("boxContexts")
                    Dim trees As String = Request("boxTrees")
                    Dim relateds As String = Request("boxRelateds")
                    Dim users As String = Request("boxUsers")
                    Dim contentTypes As String = Request("boxContentTypes")
                    Dim boxRows As String = Request("boxRows")
                    Dim boxEnabled As String = Request("boxEnabled")
                    Dim boxDateStart As String = Request("boxDateStart")
                    Dim boxDateEnd As String = Request("boxDateEnd")
                    Dim myBox As CORE_BOX = New CORE_BOX
                    
                    Try
                        
                   
                        myBox.box_title = boxTitle
                        myBox.box_description = boxDescription
                        If boxIdModule <> String.Empty Then myBox.id_module = Convert.ToInt32(boxIdModule)
                        If boxIdSite <> String.Empty Then myBox.id_key_site = Convert.ToInt32(boxIdSite)
                        If boxWidth <> String.Empty Then myBox.width = Convert.ToInt32(boxWidth)
                        If boxHeight <> String.Empty Then myBox.height = Convert.ToInt32(boxHeight)
                        If boxEnabled <> String.Empty Then myBox.box_enabled = True Else myBox.box_enabled = False
                        If boxDateStart <> String.Empty Then myBox.box_date_start = Convert.ToDateTime(boxDateStart)
                        If boxDateEnd <> String.Empty Then myBox.box_date_end = Convert.ToDateTime(boxDateEnd)
                        If boxIdTemplate <> String.Empty Then myBox.id_template = Convert.ToInt32(boxIdTemplate)
                        If contents <> String.Empty Then myBox.contentsCollection = CORE_utility.stringToCollection(contents, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.contentsCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        If contexts <> String.Empty Then myBox.contextsCollection = CORE_utility.stringToCollection(contexts, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.contextsCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        If trees <> String.Empty Then myBox.treesCollection = CORE_utility.stringToCollection(trees, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.treesCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        If relateds <> String.Empty Then myBox.relatedsCollection = CORE_utility.stringToCollection(relateds, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.relatedsCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        If users <> String.Empty Then myBox.usersCollection = CORE_utility.stringToCollection(users, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.usersCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        If contentTypes <> String.Empty Then myBox.contentTypesCollection = CORE_utility.stringToCollection(contentTypes, "|", New SEARCH_VALUE_COLLECTION(Of Int32)) Else myBox.contentTypesCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
                        
                        myBox.cache = boxCache
                        myBox.style = boxStyle
                        If boxRows <> String.Empty Then myBox.box_rows = Convert.ToInt32(boxRows)
                        
                        id_box = myBox.insert(myBox)
                        mycacheobj.cache_folder = "modules"
                        mycacheobj.remove_cache("box_list.cache")
                    
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                    Catch ex As Exception

                        returnData("<values><error errorId=""306"" errorLabel=""boxInsert Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                        
                    End Try
                    
                    
                    
                Case "getBoxList"
                    
                    Dim mybox As CORE_BOX = New CORE_BOX()
                    Dim mystring As StringBuilder
                    Dim id_key_site As Integer = Convert.ToInt32(Request("id_key_site"))
                    
                    Try
                        
                        mystring = New StringBuilder
                        Dim values As DataTableReader = mybox.box_get_list(id_key_site)
                        
                        While values.Read
                                        
                            mystring.Append("<box title=""" & Server.HtmlEncode(values("box_title")) & """ description=""" & Server.HtmlEncode(values("box_description")) & """ id=""" & values("id_box") & """ />")
                                        
                        End While
                        values.Close()
                        
                
                        returnData("<values>" & mystring.ToString & "<error errorId=""0"" errorLabel=""""/></values>")
                
                    Catch ex As Exception
    		
                        returnData("<values><error errorId=""307"" errorLabel=""getBoxList Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
    		
                    Finally
    		
                        If Not mybox Is Nothing Then mybox.Dispose() : mybox = Nothing
                    End Try
                    
                Case "getBox"
                    
                    Dim boxId As Integer = Request("boxId")
                    Dim mybox As CORE_BOX = New CORE_BOX(boxId)
                   
                    Try
                        
                        
                        Dim contents As String = String.Empty
                        Dim trees As String = String.Empty
                        Dim relateds As String = String.Empty
                        Dim contexts As String = String.Empty
                        Dim users As String = String.Empty
                        Dim contentTypes As String = String.Empty
                        
                        If mybox.contentsCollection.Items > 0 Then contents = CORE_utility.collectionJoin(mybox.contentsCollection, "|")
                        If mybox.treesCollection.Items > 0 Then trees = CORE_utility.collectionJoin(mybox.treesCollection, "|")
                        If mybox.relatedsCollection.Items > 0 Then relateds = CORE_utility.collectionJoin(mybox.relatedsCollection, "|")
                        If mybox.contextsCollection.Items > 0 Then contexts = CORE_utility.collectionJoin(mybox.contextsCollection, "|")
                        If mybox.usersCollection.Items > 0 Then users = CORE_utility.collectionJoin(mybox.usersCollection, "|")
                        If mybox.contentTypesCollection.Items > 0 Then contentTypes = CORE_utility.collectionJoin(mybox.contentTypesCollection, "|")
                        Dim Dstart As String = String.Empty
                        Dim Dend As String = String.Empty
                        Dim templateDataString As String = String.Empty
                        
                        If CORE_filesystem.fileExists("/core/core_modules/modules_parts/templates/" & mybox.id_module & "_templates/templates.xml") Then
                            Dim templateData As New XmlDocument
                            templateData.Load(Server.MapPath("/core/core_modules/modules_parts/templates/" & mybox.id_module & "_templates/templates.xml"))
                            templateDataString = templateData.InnerXml
                        End If
                        
                        If Not mybox.box_date_end = Nothing Then Dend = mybox.box_date_end.ToString()
                        If Not mybox.box_date_start = Nothing Then Dstart = mybox.box_date_start.ToString()
                        
                        returnData("<values><box id=""" & boxId.ToString() & """  idSite=""" & mybox.id_key_site.ToString() & """ idModule=""" & mybox.id_module.ToString() & """ boxTitle=""" & Server.HtmlEncode(mybox.box_title) & """ boxDescription=""" & Server.HtmlEncode(mybox.box_description) & """  cache=""" & mybox.cache & """  style=""" & Server.HtmlEncode(mybox.style) & """  width=""" & mybox.width & """  height=""" & mybox.height & """ contents=""" & contents & """ trees=""" & trees & """ relateds=""" & relateds & """ contexts=""" & contexts & """ users=""" & users & """ contentTypes=""" & contentTypes & """ boxEnabled=""" & mybox.box_enabled & """ boxDateStart=""" & Dstart & """  boxDateEnd=""" & Dend & """ rows=""" & mybox.box_rows & """ template=""" & mybox.id_template & """>" & templateDataString & "</box><error errorId=""0"" errorLabel=""""/></values>")
                
                    Catch ex As Exception
    		
                        returnData("<values><error errorId=""308"" errorLabel=""getBox Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
    		
                    Finally
    		
                        If Not mybox Is Nothing Then mybox.Dispose() : mybox = Nothing
                    End Try
                    
                
                Case "getTreeModules"
                                    
                    
                    Try
                        Dim mytree As New CORE_TREE(id_site, id_tree, id_language)
                        Dim treeKey As Integer = mytree.id_key
                        Dim layout As Integer = 0
                        
                        If Request("id_layout") <> "" Then
                            layout = Convert.ToInt32(Request("id_layout"))
                            CORE_TREE.Tree2LayoutManage(treeKey, id_event, layout)
                        Else
                            layout = CORE_TREE.treeGetLayout(treeKey, id_event)
                        End If
                       
                        Dim gLayout As String = String.Empty
                        
                        Dim layoutTxt As New System.IO.StreamReader(Server.MapPath("/core/core_layout/" & layout & "/layout.txt"))
                        gLayout = layoutTxt.ReadToEnd().ToString()
                        layoutTxt.Close()
                        layoutTxt.Dispose()
                        
                        Dim boxLength As Integer = CORE.getIntValue(gLayout, "<!--box:", "-->")
                        Dim mybox As CORE_BOX = New CORE_BOX
                        Dim boxString As New StringBuilder
                        Dim myBoxData As DataTableReader = Nothing
                        
                        For i = 1 To boxLength
                        
                            boxString = New StringBuilder
                            myBoxData = mybox.get_box(id_site, id_tree, id_language, i, id_event, id_box).CreateDataReader()
                        
                            While myBoxData.Read
                            
                                Dim _id_key As String = myBoxData("id_key") & "_" & CORE.random_key("0|9,0|9,0|9,0|9,0|9") & "-value"

                                Dim _onoff As String = ""
                                If myBoxData("box_enabled") Then _onoff = "on" Else _onoff = "off"

                                boxString.Append("<div id='module_" & _id_key & "' id_box='" & myBoxData("id_box") & "' id_key='" & myBoxData("id_key") & "' class='groupItem' position='" & myBoxData("box_position") & "'><div class='itemHeader'>" & myBoxData("box_title") & "<div class=""itemOptions""><a href=""#"" class=""btn_enabled"" onclick=""javascript:box_enable('module_" & _id_key & "','" & myBoxData("id_key") & "');""><img src=""/core/core_images/admin/window_enabled_" & _onoff & ".jpg""/></a> <a href=""#"" class=""btn_modify"" onclick=""javascript:boxModify(" & myBoxData("id_box") & ");return false;""><img src=""/core/core_images/admin/window_max.jpg""/></a> <a href=""#"" onclick=""javascript:box_delete('module_" & _id_key & "','" & myBoxData("id_key") & "');""><img src=""/core/core_images/admin/window_close.jpg""/></a></div></div><div class='itemContent'>" & myBoxData("box_description") & "</div></div>")
                            
                            End While
                            myBoxData.Close()
                            gLayout = gLayout.Replace("[box" & i & "]", boxString.ToString)
                            boxString = Nothing
                        Next
                                               
                        mybox.Dispose()
                        mybox = Nothing
                                                
                        returnData("<values><layout html=""" & Server.HtmlEncode(gLayout) & """ layout=""" & layout & """ treeKey=""" & treeKey & """ /><error errorId=""0"" errorLabel=""""/></values>")
    		
                        
                        
                    Catch ex As Exception
                        returnData("<values><error errorId=""309"" errorLabel=""getBox Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    End Try
                  
                Case "deleteBox"
                    Dim box As New CORE_BOX
                    
                    Try
                        box = New CORE_BOX(id_box)
                        box.delete()
                        
                        returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                    Catch ex As Exception
    		
                        returnData("<values><error errorId=""310"" errorLabel=""deleteBox Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
    		
                    Finally
                        If Not box Is Nothing Then box.dispose() : box = Nothing
                        
                    End Try
                    
                    
               
            End Select
            
            mycacheobj.Dispose()
            mycacheobj = Nothing
           
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
