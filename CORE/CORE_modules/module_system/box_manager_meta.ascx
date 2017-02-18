
<script language="vb" runat="server">

'/////////////////////////////////////////////////////////////////////////////////////////

    Sub Page_load()
        
        Dim meta As New HtmlMeta()
        meta.Name = "Keywords"
        meta.Content = CORE.MyPage(Me).root_mypage.treeObject.tree_keywords
        CType(Me.Page, Object).Header.Controls.Add(meta)

        meta = New HtmlMeta()
        meta.Name = "Description"
        meta.Content = CORE.MyPage(Me).root_mypage.treeObject.tree_description
        CType(Me.Page, Object).Header.Controls.Add(meta)
        meta.Dispose()
        meta = Nothing
        
        
        If Not CORE.MyPage(Me).root_mypage.contentObject Is Nothing Then
            CType(Me.Page, Object).Header.title = CORE.MyPage(Me).root_mypage.site_label & " - " & CORE.MyPage(Me).root_mypage.treeObject.tree_title & " - " & CORE.MyPage(Me).root_mypage.contentObject.content_title
        Else
            CType(Me.Page, Object).Header.title = CORE.MyPage(Me).root_mypage.site_label & " - " & CORE.MyPage(Me).root_mypage.treeObject.tree_title
        End If
        
        
        Dim myHtmlLink As HtmlLink = New HtmlLink()
        myHtmlLink.Attributes.Add("rel", "stylesheet")
        myHtmlLink.Attributes.Add("type", "text/css")
        myHtmlLink.Attributes.Add("media", "screen")
        myHtmlLink.Href = CORE.MyPage(Me).root_mypage.site_folder & "_css/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/default.css"
        CType(Me.Page, Object).Header.Controls.Add(myHtmlLink)

        If CORE_filesystem.fileExists(CORE.MyPage(Me).root_mypage.site_folder & "_css/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_trees/" & CORE.MyPage(Me).root_mypage.id_tree & ".css") Then

            myHtmlLink = New HtmlLink()
            myHtmlLink.Attributes.Add("rel", "stylesheet")
            myHtmlLink.Attributes.Add("type", "text/css")
            myHtmlLink.Attributes.Add("media", "screen")
            myHtmlLink.Href = CORE.MyPage(Me).root_mypage.site_folder & "_css/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_trees/" & CORE.MyPage(Me).root_mypage.id_tree & ".css"
            CType(Me.Page, Object).Header.Controls.Add(myHtmlLink)

        End If

        If CORE_filesystem.fileExists(CORE.MyPage(Me).root_mypage.site_folder & "_css/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_events/" & CORE.MyPage(Me).root_mypage.id_event & ".css") Then

            myHtmlLink = New HtmlLink()
            myHtmlLink.Attributes.Add("rel", "stylesheet")
            myHtmlLink.Attributes.Add("type", "text/css")
            myHtmlLink.Attributes.Add("media", "screen")
            myHtmlLink.Href = CORE.MyPage(Me).root_mypage.site_folder & "_css/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_events/" & CORE.MyPage(Me).root_mypage.id_event & ".css"
            CType(Me.Page, Object).Header.Controls.Add(myHtmlLink)

        End If

        If CORE_filesystem.fileExists(CORE.MyPage(Me).root_mypage.site_folder & "_css/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_contents/" & CORE.MyPage(Me).root_mypage.id_content & ".css") Then

            myHtmlLink = New HtmlLink()
            myHtmlLink.Attributes.Add("rel", "stylesheet")
            myHtmlLink.Attributes.Add("type", "text/css")
            myHtmlLink.Attributes.Add("media", "screen")
            myHtmlLink.Href = CORE.MyPage(Me).root_mypage.site_folder & "_css/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_contents/" & CORE.MyPage(Me).root_mypage.id_content & ".css"
            CType(Me.Page, Object).Header.Controls.Add(myHtmlLink)

        End If


        CType(Me.Page, Object).Header.Controls.Add(myHtmlLink)
        myHtmlLink.Dispose()
        myHtmlLink = Nothing
		
		
		Dim myHtmlScript As HtmlGenericControl = New HtmlGenericControl("script")
		
		 If CORE_filesystem.fileExists(CORE.MyPage(Me).root_mypage.site_folder & "_js/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/default.js") Then
        myHtmlScript.Attributes.Add("type", "text/javascript")
        myHtmlScript.Attributes.Add("src", CORE.MyPage(Me).root_mypage.site_folder & "_js/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/default.js") 
        CType(Me.Page, Object).Header.Controls.Add(myHtmlScript)
		 End If
		
		 If CORE_filesystem.fileExists(CORE.MyPage(Me).root_mypage.site_folder & "_js/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_trees/" & CORE.MyPage(Me).root_mypage.id_tree & ".js") Then

           myHtmlScript = New HtmlGenericControl("script")
           myHtmlScript.Attributes.Add("type", "text/javascript")
		   myHtmlScript.Attributes.Add("src",  CORE.MyPage(Me).root_mypage.site_folder & "_js/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_trees/" & CORE.MyPage(Me).root_mypage.id_tree & ".js") 
       
            CType(Me.Page, Object).Header.Controls.Add(myHtmlScript)

        End If
		
		

        If CORE_filesystem.fileExists(CORE.MyPage(Me).root_mypage.site_folder & "_js/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_events/" & CORE.MyPage(Me).root_mypage.id_event & ".js") Then

           myHtmlScript = New HtmlGenericControl("script")
           myHtmlScript.Attributes.Add("type", "text/javascript")
		   myHtmlScript.Attributes.Add("src",  CORE.MyPage(Me).root_mypage.site_folder & "_js/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_events/" & CORE.MyPage(Me).root_mypage.id_event & ".js") 
       
            CType(Me.Page, Object).Header.Controls.Add(myHtmlScript)

        End If
		
		
		
        If CORE_filesystem.fileExists(CORE.MyPage(Me).root_mypage.site_folder & "_js/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_trees/_events/" & CORE.MyPage(Me).root_mypage.id_tree & "_" & CORE.MyPage(Me).root_mypage.id_event & ".js") Then

           myHtmlScript = New HtmlGenericControl("script")
           myHtmlScript.Attributes.Add("type", "text/javascript")
		   myHtmlScript.Attributes.Add("src",  CORE.MyPage(Me).root_mypage.site_folder & "_js/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_trees/_events/" & CORE.MyPage(Me).root_mypage.id_tree & "_" & CORE.MyPage(Me).root_mypage.id_event & ".js") 
       
            CType(Me.Page, Object).Header.Controls.Add(myHtmlScript)

        End If
		
		

        If CORE_filesystem.fileExists(CORE.MyPage(Me).root_mypage.site_folder & "_js/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_contents/" & CORE.MyPage(Me).root_mypage.id_content & ".js") Then

           myHtmlScript = New HtmlGenericControl("script")
           myHtmlScript.Attributes.Add("type", "text/javascript")
		   myHtmlScript.Attributes.Add("src",  CORE.MyPage(Me).root_mypage.site_folder & "_js/_" & CORE.MyPage(Me).root_mypage.language & "/_" & CORE.MyPage(Me).root_mypage.site_css & "/_contents/" & CORE.MyPage(Me).root_mypage.id_content & ".js") 
       
            CType(Me.Page, Object).Header.Controls.Add(myHtmlScript)

        End If
		
	
 		myHtmlScript.Dispose()
        myHtmlScript = Nothing
		
		
		
		
		
		
        
    End Sub
'/////////////////////////////////////////////////////////////////////////////////////////
</script>
