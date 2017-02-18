<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Page Language="VB" Debug="true" ValidateRequest="false" Trace="false" EnableEventValidation="false"%>
<script runat="server">
    
    Dim id_key As Integer
    Dim id_site As Integer
    Dim id_user As Integer
    Dim responseType As String

    Sub page_load()
     
        If Request("id_key") <> String.Empty Then id_key = Request("id_key")
        If Request("id_site") <> String.Empty Then id_site = Request("id_site")
        If Request("id_user") <> String.Empty Then id_user = Convert.ToInt32(CORE_CRYPTOGRAPHY.decrypt(Request("id_user")))
        responseType = CORE.checkResponse()
     
        If Not CORE_USER.hasRole(CORE_USER.userRole.siteAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMessage=""Your account is not authenticated to execute this action.""/></values>") : Return
            
        Select Case Request("who")
    		
            '#############################################################
            '#############################################################	
            '#############################################################	
    		
            Case "newSite"
                
                Try
                    Dim mysite As CORE_SITE = New CORE_SITE()
                                       
                    mysite.site_host = Request("siteDomain")
                    mysite.site_url = "http://" & Request("siteDomain")
                    mysite.site_label = Request("siteLabel")
                    mysite.site_folder = Request("siteFolder")
                    mysite.site_username = Request("siteUsername")
                    mysite.site_password = Request("sitePassword")
                    mysite.site_master_page = "default"
                    mysite.site_css = "default"
                    mysite.site_default_language_id = 2
                    mysite.site_status = 1
                    mysite.id_site = 0
                    mysite.id_key = 0
                    mysite.site_family = 1
                    mysite.site_order = 1
                    Dim newsitekey As Integer = mysite.site_insert(mysite)
                    
                    mysite = New CORE_SITE(newsitekey)
                    newsitekey = mysite.id_key
                    
                    Dim pro As CORE_PROFILE = New CORE_PROFILE()
                    pro.toUserInsert(1, id_user, newsitekey)
                    pro.Dispose()
                    pro = Nothing
                    
                    Dim myuser As CORE_USER = New CORE_USER()
                    myuser.siteInsert(id_user, newsitekey, 1)
                    myuser.Dispose()
                    myuser = Nothing
                    
                    mysite.Dispose()
                    mysite = Nothing
                    
                    insertRootTree(newsitekey)
                                
                    removeSiteCache()
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                     
                Catch ex As Exception
                
                    returnData("<values><error errorId=""100"" errorLabel=""New Site Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                                       
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "newInstance"
                
                Try
                    Dim mysite As CORE_SITE = New CORE_SITE(id_key)
                    id_site = mysite.id_site
                    
                    mysite.site_host = Request("siteDomain")
                    mysite.site_url = "http://" & Request("siteDomain")
                    mysite.site_label = Request("siteLabel")
                    mysite.site_folder = Request("siteFolder")
                    mysite.site_username = Request("siteUsername")
                    mysite.site_password = Request("sitePassword")
                    mysite.site_master_page = "default"
                    mysite.site_css = "default"
                    mysite.id_key = 0
                    mysite.site_family = 0
                    mysite.site_order = 1
                                        
                    Dim newsitekey As Integer = mysite.site_insert(mysite)
                    
                    mysite = New CORE_SITE(newsitekey)
                    newsitekey = mysite.id_key
                    
                    Dim pro As CORE_PROFILE = New CORE_PROFILE()
                    pro.toUserInsert(1, id_user, newsitekey)
                    pro.Dispose()
                    pro = Nothing
                    
                    mysite.Dispose()
                    mysite = Nothing
                    
                    insertRootTree(newsitekey)
                                
                    removeSiteCache()
                                       
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                Catch ex As Exception
                
                    returnData("<values><error errorId=""101"" errorLabel=""New Instance Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                                                            
                End Try
            
                
                
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "cloneInstance"
                
                Try
                    Dim mysite As CORE_SITE = New CORE_SITE(id_key)
                    id_site = mysite.id_site
                    
                    mysite.site_host = Request("siteDomain")
                    mysite.site_url = "http://" & Request("siteDomain")
                    mysite.site_family = 0
                    mysite.site_order = 0
                    mysite.site_insert(mysite)
                    mysite.Dispose()
                    mysite = Nothing
                            
                    removeSiteCache()
                    
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                Catch ex As Exception
                
                    returnData("<values><error errorId=""102"" errorLabel=""Clone Instance Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "editInstance"
                
                Try
                    Dim mysite As CORE_SITE = New CORE_SITE(id_key)
                    id_site = mysite.id_site
                    
                    Dim siteDomain As String = mysite.site_host
                    Dim siteLabel As String = mysite.site_label
                    Dim siteFolder As String = mysite.site_folder
                    Dim siteUsername As String = mysite.site_username
                    Dim sitePassword As String = mysite.site_password
                    Dim siteMasterPage As String = mysite.site_master_page
                    Dim siteCss As String = mysite.site_css
                    Dim siteMeta As String = mysite.site_meta
                    Dim siteStatistics As String = mysite.site_statistics
                    
                    mysite.Dispose()
                    mysite = Nothing
                           
                                        
                    returnData("<values><site domain=""" & Server.HtmlEncode(siteDomain) & """ label=""" & Server.HtmlEncode(siteLabel) & """ folder=""" & Server.HtmlEncode(siteFolder) & """ username=""" & Server.HtmlEncode(siteUsername) & """ password=""" & Server.HtmlEncode(sitePassword) & """ masterPage=""" & Server.HtmlEncode(siteMasterPage) & """ css=""" & Server.HtmlEncode(siteCss) & """  meta=""" & Server.HtmlEncode(siteMeta) & """  statistics=""" & Server.HtmlEncode(siteStatistics) & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                Catch ex As Exception
                
                    returnData("<values><error errorId=""103"" errorLabel=""Edit Instance Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                End Try
                
                
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "startUp"
    		
                Dim mysite As CORE_SITE_SEARCHER = New CORE_SITE_SEARCHER
                Dim mySiteList As ArrayList = CORE_ROLE.roleSites(CORE_USER.userRole.siteAdministrator, CORE_USER.getUserId)
                
             
                Try
                    
                    
                    mysite.site_order = 1
                    mysite.site_family = "True"
                    Dim mydata As DataTableReader = mysite.search()
                    
                    
                    Dim myvalues As StringBuilder = New StringBuilder
                    Dim families As StringBuilder = New StringBuilder
                    Dim clones As StringBuilder = New StringBuilder
    		
                    While mydata.Read
    		                                   
                        mysite.id_site = Convert.ToInt32(mydata("id_site"))
                        mysite.site_order = 1
                        mysite.id_key = 0
                        mysite.site_family = "all"
                        mysite.order_by = "id_site,site_order"
                        Dim mydataFamily As DataTableReader = mysite.search()
                        
                        Try
                            families = New StringBuilder
                            While mydataFamily.Read
                        
                                If mySiteList.IndexOf(mydataFamily("id_key")) <> -1 Then
                                    
                                    mysite.id_site = 0
                                    mysite.id_key = Convert.ToInt32(mydataFamily("id_key"))
                                    mysite.site_order = 0
                                    mysite.site_family = "False"
                                    Dim mydataClone As DataTableReader = mysite.search()
                         
                                    Try
                                                                        
                                        clones = New StringBuilder
                                        While mydataClone.Read
                                            
                                            clones.Append("<clones id_unique=""" & mydataClone("id_unique") & """ id_key=""" & mydataClone("id_key") & """ id_site=""" & mydataClone("id_site") & """   site_host=""" & mydataClone("site_host") & """ site_order=""" & mydataClone("site_order") & """ site_family=""" & mydataClone("site_family") & """ site_label=""" & mydataClone("site_label") & """/>")
                                                                               
                                        End While
                                        mydataClone.Close()
                                    Catch ex As Exception
                                        mydataClone.Close()
                                    End Try
                            
                                                        
                                    families.Append("<sites id_unique=""" & mydataFamily("id_unique") & """ id_key=""" & mydataFamily("id_key") & """ id_site=""" & mydataFamily("id_site") & """   site_host=""" & mydataFamily("site_host") & """ site_order=""" & mydataFamily("site_order") & """ site_family=""" & mydataFamily("site_family") & """ site_label=""" & mydataFamily("site_label") & """>" & clones.ToString() & "</sites>")
                                    clones = Nothing
                                End If
                                
                            End While
                            mydataFamily.Close()
                        Catch
                            mydataFamily.Close()
                        End Try
                        
                        If families.ToString() <> String.Empty Then myvalues.Append("<site id_unique=""" & mydata("id_unique") & """ id_key=""" & mydata("id_key") & """ id_site=""" & mydata("id_site") & """   site_label=""" & mydata("site_label") & """ >" & families.ToString() & "</site>")
                        
                        families = Nothing
                    End While
                    mydata.Close()
                    
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/>" & myvalues.ToString() & "</values>")
                   
                    
                    mysite.Dispose()
                    mysite = Nothing
                                        
                Catch ex As Exception
    		
                    returnData("<values><error errorId=""104"" errorLabel=""Site SturtUp Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not mysite Is Nothing Then mysite.Dispose() : mysite = Nothing
                End Try
    		  
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
                
            Case "updateInstance"
                
                Try
                    Dim mysite As CORE_SITE = New CORE_SITE(id_key)
                                        
                    mysite.site_host = Request("siteDomain")
                    mysite.site_url = "http://" & Request("siteDomain")
                    mysite.site_label = Request("siteLabel")
                    mysite.site_folder = Request("siteFolder")
                    mysite.site_username = Request("siteUsername")
                    mysite.site_password = Request("sitePassword")
                    mysite.site_master_page = Request("siteMasterPage")
                    mysite.site_css = Request("siteCss")
                    If Request("siteMeta") <> String.Empty Then mysite.site_meta = Request("siteMeta") Else mysite.site_meta = ""
                    If Request("siteStatistics") <> String.Empty Then mysite.site_statistics = Request("siteStatistics") Else mysite.site_statistics = ""
                    mysite.site_update(mysite)
                    
                    mysite.Dispose()
                    mysite = Nothing
                                                    
                    removeSiteCache()
                                       
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                Catch ex As Exception
                
                    returnData("<values><error errorId=""105"" errorLabel=""Update Instance Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                                                            
                End Try
    		
                '#############################################################
                '#############################################################	
                '#############################################################			
   		
    		
        End Select
    		
    		
    End Sub

    
    Sub removeSiteCache()
        
        Dim cacheobj As CORE_CACHE = Nothing
        cacheobj = New CORE_CACHE("site", "sites")
        cacheobj.remove_cache()
        cacheobj.Dispose()
        cacheobj = Nothing
        
    End Sub
    
    Sub insertRootTree(ByVal idkey As Integer)
        
        Dim mytree As CORE_TREE = New CORE_TREE()
        mytree.id_site = idkey
        mytree.tree_title = "Pagina Iniziale"
        mytree.id_tree = 1
        mytree.id_language = 2
        mytree.tree_insert(mytree)
        
        mytree.tree_title = "Home Page"
        mytree.id_language = 1
        mytree.tree_insert(mytree)
        
        mytree.Dispose()
        mytree = Nothing
        
        
        
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