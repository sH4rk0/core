<%@ Control Language="VB" %>
<script language="vb" runat="server">
    
    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private contents As SEARCH_VALUE_COLLECTION(Of Int32)
    Private id_content As Integer = 0
    Private currentTreePath As String = String.Empty
    Private adminClass As String = String.Empty
    Public boxOption As New CORE_BOX_OPTIONS
    Private mycontent As CORE_CONTENT = Nothing
    Private usersHolder As CORE_USER_COLLECTION(Of CORE_USER)
    Private contextHolder As CORE_CONTEXT_COLLECTION(Of CORE_CONTEXT)
    
'/////////////////////////////////////////////////////////////////////////////////////////

    Sub Page_load()
        
        Dim mybox As CORE_BOX = New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        contents = mybox.contentsCollection
        mybox.Dispose()
        mybox = Nothing
        
        currentTreePath = "/" & CORE.MyPage(Me).root_mypage.language & "/1/" & CORE_formatting.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title) & "/"
		
        If CORE.MyPage(Me).root_mypage.treeObject.id_content > 0 Then id_content = CORE.MyPage(Me).root_mypage.treeObject.id_content
        If CORE.MyPage(Me).root_mypage.id_content > 0 Then id_content = CORE.MyPage(Me).root_mypage.id_content
        If contents.Items > 0 Then id_content = contents.Item(0)
        
        Dim user2content As ArrayList = New ArrayList
        Dim myusersearcher = New CORE_USER_SEARCHER
        user2content.Add(id_content)
        myusersearcher.contents = user2content
        usersHolder = myusersearcher.search()
        users.DataSource = usersHolder
        users.DataBind()
        
        Dim mycontextsearcher = New CORE_CONTEXT_SEARCHER
        mycontextsearcher = New CORE_CONTEXT_SEARCHER
        mycontextsearcher.id_content = id_content
        mycontextsearcher.id_language = CORE.MyPage(Me).root_mypage.language_id
        contextHolder = mycontextsearcher.search()
        contexts.DataSource = contextHolder
        contexts.DataBind()
        If contexts.Items.Count > 0 Then contexts.Visible = True
        
           
        If CORE.MyPage(Me).root_mypage.id_content > 0 And id_content = 0 Then
            
            Try
                lt_content_title.Text = CORE.MyPage(Me).root_mypage.contentObject.content_title
                lt_content_description.Text = CORE.MyPage(Me).root_mypage.contentObject.content_description
                lt_content_date.Text = CORE.MyPage(Me).root_mypage.contentObject.content_date_publication.ToString("ddd\, d MMMM yyyy \@ HH\:mm")
                CORE.MyPage(Me).root_mypage.contentObject.dispose()
            Catch err As Exception
                
                CORE.application_error_trace(err.ToString)
            End Try
            
        ElseIf id_content > 0 Then
            
            mycontent = New CORE_CONTENT(id_content)
            lt_content_title.Text = mycontent.content_title
            lt_content_description.Text = mycontent.content_description_replaced
            lt_content_date.Text = mycontent.content_date_publication.ToString("ddd\, d MMMM yyyy \@ HH\:mm")
            mycontent.Dispose()
            mycontent = Nothing
            
        End If
        
       
		
        lt_content_title.Dispose()
        lt_content_title = Nothing
		
        lt_content_description.Dispose()
        lt_content_description = Nothing
        If CORE_USER.hasProfile(CORE_USER.userProfile.administrator) Then adminClass = " class=""adminItem"" "
		
    End Sub
		
		
		</script>
 
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle%>>
<div <%=adminClass %> idKey="<%=id_content%>">

<div class="contentDetail">
<h2 class="contentTitle"><span><asp:literal id="lt_content_title" runat="server" EnableViewState="false"></asp:literal></span></h2>
<div class="contentDescription"><asp:literal id="lt_content_description" runat="server" EnableViewState="false"></asp:literal></div>
<p class="contentDate">Created <asp:literal id="lt_content_date" runat="server" EnableViewState="false"></asp:literal> by
<asp:repeater runat="server" ID="users" EnableViewState="false">
<ItemTemplate><strong><%#CType(Container.DataItem, CORE_USER).user_nickname()%></strong></ItemTemplate>
<SeparatorTemplate><span>,</span></SeparatorTemplate>
</asp:repeater>
</p>

<asp:repeater runat="server" ID="contexts"  EnableViewState="false" Visible="false">
<HeaderTemplate><div class="tags"><span>Tags:</span></HeaderTemplate>
<ItemTemplate>
<a href="<%#core.makeLink(currentTreePath,CType(Container.DataItem, CORE_CONTEXT).id_context,CType(Container.DataItem, CORE_CONTEXT).context_title,CORE.pageEvent.searchByTags) %>"><span><%#CType(Container.DataItem, CORE_CONTEXT).context_title%></span></a>
</ItemTemplate>
<SeparatorTemplate><span>,</span></SeparatorTemplate>
<FooterTemplate></div></FooterTemplate>
</asp:repeater>

</div>
</div>
</div>
</div>
