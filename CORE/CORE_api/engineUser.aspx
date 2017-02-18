<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>

<script runat="server">
    Dim language_id As Integer
    Dim id_content As Integer
    Dim id_user As Integer
    Dim id_key As Integer
    Dim id_tree As Integer
    Dim id_site As Integer
    Dim rows As Integer
    Dim mypage As Integer
    Dim id_context As Integer
    Dim responseType As String
    Dim orderBy As String
    Dim status As String
    
    Dim user_name As String
    Dim user_surname As String
    Dim user_email As String
    Dim user_username As String
    Dim user_password As String
    Dim user_passwordConfirm As String
    Dim user_gender As Integer
    Dim user_birth_day As String
    Dim user_birth_month As String
    Dim user_birth_year As String
    Dim user_geo_country As Integer
    Dim user_geo_region As Integer
    Dim user_geo_province As Integer
    Dim user_geo_city As String
    Dim user_date_creation As String
    Dim user_date_first_access As String
    Dim user_date_last_access As String
    Dim user_date_activation As String
    Dim user_address As String
    Dim user_zipcode As String
    Dim user_telephone As String
    Dim user_fax As String
    Dim user_sign As String
    Dim user_homepage As String
    Dim user_nickname As String
    
    
    Sub page_load()
     
        If Request("idLanguage") <> "" Then language_id = Convert.ToInt32(Request("idLanguage"))
        If Request("idContent") <> "" Then id_content = Convert.ToInt32(Request("idContent"))
        If Request("idUser") <> "" Then id_user = Convert.ToInt32(Request("idUser"))
        
        If Request("idKey") <> "" Then id_key = Convert.ToInt32(Request("idKey"))
        If Request("idTree") <> "" Then id_tree = Convert.ToInt32(Request("idTree"))
        If Request("idSite") <> "" Then id_site = Convert.ToInt32(Request("idSite"))
        If Request("rows") <> "" Then rows = Convert.ToInt32(Request("rows"))
        If Request("page") <> "" Then mypage = Convert.ToInt32(Request("page"))
        If Request("idLanguage") <> "" Then id_context = Request("idLanguage")
        If Request("orderBy") <> "" Then orderBy = Request("orderBy")
        If Request("status") <> "" Then status = Request("status")
        
        If Request("userName") <> "" Then user_name = Request("userName")
        If Request("userSurname") <> "" Then user_surname = Request("userSurname")
        If Request("userEmail") <> "" Then user_email = Request("userEmail")
        If Request("userUsername") <> "" Then user_username = Request("userUsername")
        If Request("userPassword") <> "" Then user_password = Request("userPassword")
        If Request("userPasswordConfirm") <> "" Then user_passwordConfirm = Request("userPasswordConfirm")
        If Request("userGender") <> "" Then user_gender = Convert.ToInt32(Request("userGender"))
        If Request("userBornDay") <> "" Then user_birth_day = Request("userBornDay")
        If Request("userBornMonth") <> "" Then user_birth_month = Request("userBornMonth")
        If Request("userBornYear") <> "" Then user_birth_year = Request("userBornYear")
        If Request("userGeoCountry") <> "" Then user_geo_country = Convert.ToInt32(Request("userGeoCountry"))
        If Request("userGeoRegion") <> "" Then user_geo_region = Convert.ToInt32(Request("userGeoRegion"))
        If Request("userGeoProvince") <> "" Then user_geo_province = Convert.ToInt32(Request("userGeoProvince"))
        If Request("userGeoCity") <> "" Then user_geo_city = Request("userGeoCity")
        If Request("userDateCreation") <> "" Then user_date_creation = Request("userDateCreation")
        If Request("userDateFirstAccess") <> "" Then user_date_first_access = Request("userDateFirstAccess")
        If Request("userDateLastAccess") <> "" Then user_date_last_access = Request("userDateLastAccess")
        If Request("userDateActivation") <> "" Then user_date_activation = Request("userDateActivation")
        If Request("userAddress") <> "" Then user_address = Request("userAddress")
        If Request("userZipcode") <> "" Then user_zipcode = Request("userZipcode")
        If Request("userTelephone") <> "" Then user_telephone = Request("userTelephone")
        If Request("userFax") <> "" Then user_fax = Request("userFax")
        If Request("userMobile") <> "" Then user_fax = Request("userMobile")
        If Request("userSign") <> "" Then user_sign = Request("userSign")
        If Request("userHomepage") <> "" Then user_homepage = Request("userHomepage")
        If Request("userNickname") <> "" Then user_nickname = Request("userNickname")
        
        responseType = CORE.checkResponse()
        
        If Not CORE_USER.hasRole(CORE_USER.userRole.userAdministrator) Then returnData("<values><error errorId=""666"" errorLabel=""Access Forbidden"" errorMessage=""Your account is not authenticated to execute this action.""/></values>") : Return
            
     
        Select Case Request("who")
    			
    		
            '#############################################################
            '#############################################################	
            '#############################################################	
       	
            Case "removeUser"
                
                Dim user As CORE_USER = New CORE_USER(id_user)
                Try
                   
                    user.removeRelation(id_content, id_user)
                    user.Dispose()
                    user = Nothing
    		
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("contents_user_list_" & id_content.ToString().ToLower(), "contents")
                    cacheobj.remove_cache()
                    cacheobj.Dispose()
                    cacheobj = Nothing
                
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""1100"" errorLabel=""Remove User Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not user Is Nothing Then user.Dispose() : user = Nothing
                End Try
                
              
    		
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "deleteUser"
                
                Dim user As CORE_USER = New CORE_USER(id_user)
                Try
    					
                    user.user_delete(id_user)
                    user.Dispose()
                    user = Nothing
    		
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE("contents_related_list_" & id_content.ToString().ToLower(), "contents")
                    cacheobj.remove_cache()
                    cacheobj.Dispose()
                    cacheobj = Nothing
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""1101"" errorLabel=""Delete User Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not user Is Nothing Then user.Dispose() : user = Nothing
                End Try
              
                '############################################################# 
                '#############################################################	
                '#############################################################			
            Case "getUserValues"
    		
    		
    		
                Dim searcher As CORE_USER_SEARCHER = New CORE_USER_SEARCHER
                
                Try
                   
                    If rows > 0 Then searcher.rows = rows
                    If mypage > 0 Then searcher.page = mypage
                    searcher.sites = CORE_ROLE.roleSites(CORE_USER.userRole.userAdministrator, CORE_USER.getUserId)
                    searcher.sites_search_mode = CORE_USER_SEARCHER.searchType.OrSearch
                    
                    Dim myvalues As StringBuilder = New StringBuilder
                    
                    Dim mycoll As CORE_USER_COLLECTION(Of CORE_USER) = searcher.search()
                    Dim count As Integer = searcher.searchcount()
                    
                    Dim re As CORE_USER
        
                    For Each re In mycoll
                        myvalues.Append("<value name=""" & Server.HtmlEncode(re.user_name) & """  id_user=""" & re.id_user & """  surname=""" & Server.HtmlEncode(re.user_surname) & """ email=""" & Server.HtmlEncode(re.user_email) & """ password=""" & Server.HtmlEncode(re.user_password) & """ date=""" & re.user_date_creation & """ nickname=""" & re.user_nickname & """   />")
                    Next
                        		
                
                    returnData("<values><error errorId=""0"" errorLabel="""" /><count count=""" & count & """/>" & myvalues.ToString() & "</values>")
                    searcher.Dispose()
                    searcher = Nothing
                Catch err As Exception
                    returnData("<values><error errorId=""1102"" errorLabel=""getUserValues Values Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                    
                Finally
                
                    If Not searcher Is Nothing Then searcher.Dispose() : searcher = Nothing
                End Try
                
                
    				
                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "manageUser"
    		
                Dim user As CORE_USER = New CORE_USER
    		
                Try
                    Dim user_name As String = Request("user_name")
                    Dim user_surname As String = Request("user_surname")
                    Dim user_email As String = Request("user_email")
                    Dim user_password As String = Request("user_password")
                        				
    				
                    If id_user > 0 Then
                        user = New CORE_USER(id_user)
                    Else
                        user = New CORE_USER()
                    End If
    				
                    user.user_name = user_name
                    user.user_surname = user_surname
                    user.user_email = user_email
                    user.user_password = user_password
                    user.refreshCache()
                  
    							
                    Dim cacheobj As CORE_CACHE = New CORE_CACHE()
                    
                    
                    If id_content > 0 Then
    					
                        cacheobj = New CORE_CACHE("contents_user_list_" & id_content.ToString().ToLower(), "contents")
                        cacheobj.remove_cache()
                        
                    End If
                    cacheobj.Dispose()
                    cacheobj = Nothing
                    
                    If id_user > 0 Then
                        user.update(user)
                        returnData("<values><related id=""0""/><error errorId=""0"" errorLabel=""""/></values>")
                    Else
                        Dim newId As Integer = user.insert(user)
                        
                        returnData("<values><related id=""" & newId & """/><error errorId=""0"" errorLabel=""""/></values>")
                            						
                    End If
    				
                    user.Dispose()
                    user = Nothing
    				
    				
    				
                Catch err As Exception
                    returnData("<values><error errorId=""1103"" errorLabel=""Manage User Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                Finally
                    If Not user Is Nothing Then user.Dispose() : user = Nothing
                End Try
    		
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "addRelations"
                
                Dim userKeys As String = Request("userKeys")
                Dim contentKeys As String = Request("contentKeys")
                Dim cacheobj As CORE_CACHE = New CORE_CACHE
                Dim user As CORE_USER = New CORE_USER
                Dim uKeys() As String = userKeys.Split("|")
                Dim cKeys() As String = contentKeys.Split("|")
                
                Try
                                      
                    Dim cValue As Integer
                    Dim uValue As Integer
                    
                    For Each cValue In cKeys
                        
                        
                        For Each uValue In uKeys
                        
                            User.newRelation(cValue, uValue)
                        
                        Next
                        cacheobj = New CORE_CACHE("contents_user_list_" & cValue.ToString().ToLower(), "contents")
                        cacheobj.remove_cache()
                        
                    Next
                  
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""1104"" errorLabel=""Add Users"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
                    If Not cacheobj Is Nothing Then cacheobj.Dispose() : cacheobj = Nothing
    		
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "removeAllRelated"
                
               
                Dim cacheobj As CORE_CACHE = New CORE_CACHE
                Dim related As CORE_CONTENT_RELATED = New CORE_CONTENT_RELATED
             
                
                Try
                                      
                  
                    related.removeAllRelated(id_content)
                        
                       
                    cacheobj = New CORE_CACHE("contents_user_list_" & id_content.ToString().ToLower(), "contents")
                    cacheobj.remove_cache()
                               
                
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""1105"" errorLabel=""removeAllRelated Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
                    If Not cacheobj Is Nothing Then cacheobj.Dispose() : cacheobj = Nothing
    		
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
            Case "getUser"
    		
                Try
                    
              
                    Dim re As CORE_USER = New CORE_USER(id_user)
    		
                                       
                    returnData("<values><value id_user=""" & re.id_user & """ id_site=""" & re.id_site & """ name=""" & Server.HtmlEncode(re.user_name) & """  surname=""" & Server.HtmlEncode(re.user_surname) & """ email=""" & Server.HtmlEncode(re.user_email) & """ username=""" & Server.HtmlEncode(re.user_username) & """ nickname=""" & Server.HtmlEncode(re.user_nickname) & """ password=""" & Server.HtmlEncode(re.user_password) & """ address=""" & Server.HtmlEncode(re.user_address) & """ mobile=""" & Server.HtmlEncode(re.user_mobile) & """ telephone=""" & Server.HtmlEncode(re.user_telephone) & """ zipCode=""" & Server.HtmlEncode(re.user_zipcode) & """ sign=""" & Server.HtmlEncode(re.user_sign) & """ dateCreation=""" & re.user_date_creation & """ birthDate=""" & re.user_birth_date & """ gender=""" & re.user_gender & """ city=""" & Server.HtmlEncode(re.user_geo_city) & """ country=""" & re.user_geo_country & """ region=""" & re.user_geo_region & """ province=""" & re.user_geo_province & """ homepage=""" & Server.HtmlEncode(re.user_homepage) & """ fax=""" & Server.HtmlEncode(re.user_fax) & """  /><error errorId=""0"" errorLabel=""""/></values>")
                    re.Dispose()
                    re = Nothing
                
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""1106"" errorLabel=""Get User Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################			
            Case "updateUserField"
                Dim re As CORE_USER = New CORE_USER(id_user)
                
                Try
                                       
                    re.user_update_field(id_user, Request("field"), Request("value"))
                    re.refreshCache()
                    If Not re Is Nothing Then re.Dispose() : re = Nothing
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                              
                Catch ex As Exception
                    
                    returnData("<values><error errorId=""1107"" errorLabel=""Update User Field Error"" errorMsg=""" & Server.HtmlEncode(ex.ToString()) & """/></values>")
                    
                Finally
                    If Not re Is Nothing Then re.Dispose() : re = Nothing
                    
                End Try
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "deleteUsers"
                
                Dim user As CORE_USER = New CORE_USER(id_user)
                Dim users() As String = Request("userss").Split("|")
                
                Try
    					
                    
                    Dim rel As Integer = 0
                    For Each rel In users
                    
                        user = New CORE_USER(rel)
                       
                        user.user_delete(rel)
                        user.Dispose()
                        user = Nothing
                          		
                    Next
                        
                    
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                
                Catch err As Exception
    		
                    returnData("<values><error errorId=""1108"" errorLabel=""Delete Users Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
    		
                Finally
    		
                    If Not user Is Nothing Then user.Dispose() : user = Nothing
                End Try
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "userUpdate"
                
                
                Dim myuser As CORE_USER = New CORE_USER(id_user)
                
                Try
                   
                    myuser.user_name = user_name
                    myuser.user_surname = user_surname
                    myuser.user_username = user_username
                    myuser.user_email = user_email
                    myuser.user_homepage = user_homepage
                    myuser.user_nickname = user_nickname
                    myuser.user_gender = user_gender
                    
                    
                    If user_password <> String.Empty And user_passwordConfirm <> String.Empty And user_password = user_passwordConfirm Then myuser.user_password = user_password
                    
                    
                    If user_birth_day <> String.Empty And user_birth_month <> String.Empty And user_birth_year <> String.Empty Then myuser.user_birth_date = Convert.ToInt64(user_birth_year & user_birth_month & user_birth_day)
                    
                    myuser.update(myuser)
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                Catch err As Exception
                    
                    returnData("<values><error errorId=""1109"" errorLabel=""Update User Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                    
                    If Not myuser Is Nothing Then myuser.Dispose() : myuser = Nothing
                End Try
                
                
                
                '#############################################################
                '#############################################################	
                '#############################################################	
    		
            Case "userInsert"
                
                Dim myuser As CORE_USER = New CORE_USER()
                
                Try
                   
                    myuser.user_name = user_name
                    myuser.user_surname = user_surname
                    myuser.user_username = user_username
                    myuser.user_email = user_email
                    myuser.user_homepage = user_homepage
                    myuser.user_nickname = user_nickname
                    myuser.user_gender = user_gender
                    myuser.user_date_creation = Date.Now
                    myuser.id_site = id_site
                    
                    If user_password <> String.Empty And user_passwordConfirm <> String.Empty And user_password = user_passwordConfirm Then myuser.user_password = user_password
                                        
                    If user_birth_day <> String.Empty And user_birth_month <> String.Empty And user_birth_year <> String.Empty Then myuser.user_birth_date = Convert.ToInt64(user_birth_year & user_birth_month & user_birth_day)
                    
                    id_user = myuser.insert(myuser)
                    myuser.siteInsert(id_user, id_site, 0)
                    
                    returnData("<values><error idUser=""" & id_user & """ errorId=""0"" errorLabel=""""/></values>")
                    
                Catch err As Exception
                    
                    returnData("<values><error errorId=""1110"" errorLabel=""Update User Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")

                Finally
                    
                    If Not myuser Is Nothing Then myuser.Dispose() : myuser = Nothing
                    
                End Try
                
            Case "userStatus"
                
                Dim myuser As CORE_USER = New CORE_USER(id_user)
                Dim mysite As CORE_SITE_SEARCHER = New CORE_SITE_SEARCHER
                Dim searcher As CORE_profile_SEARCHER = New CORE_profile_SEARCHER
                Dim mydataFamily As DataTableReader = Nothing
                Dim mydata As DataTableReader = Nothing
                Dim myvalues As StringBuilder
                Dim families As StringBuilder
                Try
                
                   
                    mysite.site_order = 1
                    mysite.site_family = "True"
                    mydata = mysite.search()
                    myvalues = New StringBuilder
                    Dim status As Integer = -1
                    
                    While mydata.Read
                        
                        
                        mysite.id_site = Convert.ToInt32(mydata("id_site"))
                        mysite.site_order = 1
                        mysite.id_key = 0
                        mysite.site_family = "all"
                        mysite.order_by = "id_site,site_order"
                        mydataFamily = mysite.search()
                        
                       
                        families = New StringBuilder
                        While mydataFamily.Read
                        
                        
                            searcher.id_user = id_user
                            searcher.id_site = mydataFamily("id_key")
                            searcher.rows = 100
                            searcher.page = 1
                            searcher.searchOrder = CORE_profile_SEARCHER.order.profileLabelAsc
                                                              
                            Dim myprofiles As StringBuilder = New StringBuilder
                            Dim mycoll As CORE_PROFILE_COLLECTION(Of CORE_PROFILE) = searcher.search()
                            Dim myprofile As CORE_PROFILE
        
                            For Each myprofile In mycoll
                                myprofiles.Append("<profile id=""" & myprofile.id_profile & """ label=""" & Server.HtmlEncode(myprofile.profile_label) & """  />")
                            Next
                                          
                            status = myuser.getStatusValue(id_user, mydataFamily("id_key"))
                        
                        
                            myvalues.Append("<site id_unique=""" & mydataFamily("id_unique") & """ id_key=""" & mydataFamily("id_key") & """ id_site=""" & mydataFamily("id_site") & """ site_label=""" & mydataFamily("site_host") & """ status=""" & status & """ >" & myprofiles.ToString & "</site>")
                        
                       
                        
                        
                        End While
                        mydataFamily.Close()
                        
                    End While
                    mydata.Close()
                   
                    returnData("<values><error errorId=""0"" errorLabel=""""/>" & myvalues.ToString() & "</values>")
                
                Catch err As Exception
                    
                    returnData("<values><error errorId=""1111"" errorLabel=""Update User Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")

                Finally
                    
                    If Not myuser Is Nothing Then myuser.Dispose() : myuser = Nothing
                    If Not mysite Is Nothing Then mysite.Dispose() : mysite = Nothing
                    
                End Try
                
                
            Case "updateUserStatus"
                
                Dim myuser As CORE_USER = New CORE_USER(id_user)
                
                Try
                    
                    myuser.siteUpdate(id_user, id_site, status)
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")

                Catch err As Exception
                    
                    returnData("<values><error errorId=""1112"" errorLabel=""Update User Status Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                
                    If Not myuser Is Nothing Then myuser.Dispose() : myuser = Nothing
                End Try
                
            Case "insertUserStatus"
                
                Dim myuser As CORE_USER = New CORE_USER(id_user)
                
                Try
                    
                    myuser.siteInsert(id_user, id_site, status)
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")

                Catch err As Exception
                    
                    returnData("<values><error errorId=""1113"" errorLabel=""Insert User Status Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                
                    If Not myuser Is Nothing Then myuser.Dispose() : myuser = Nothing
                End Try
                
            Case "deleteUserStatus"
                
                Dim myuser As CORE_USER = New CORE_USER(id_user)
                
                Try
                    
                    myuser.siteDelete(id_user, id_site)
                    
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")

                Catch err As Exception
                    
                    returnData("<values><error errorId=""1113"" errorLabel=""Delete User Status Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                Finally
                
                    If Not myuser Is Nothing Then myuser.Dispose() : myuser = Nothing
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