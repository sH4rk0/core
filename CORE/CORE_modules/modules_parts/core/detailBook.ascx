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
    Private mycontent As CORE_CONTENT_BOOK = Nothing
    Private cover As Integer = 0
        
'/////////////////////////////////////////////////////////////////////////////////////////

    Sub Page_load()
        
        Dim mybox As CORE_BOX = New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        contents = mybox.contentsCollection
        mybox.Dispose()
        mybox = Nothing
        
        currentTreePath = "/" & CORE.MyPage(Me).root_mypage.language & "/1/" & CORE_formatting.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title) & "/"
		
     
        If CORE.MyPage(Me).root_mypage.id_content > 0 Then id_content = CORE.MyPage(Me).root_mypage.id_content
        
            mycontent = New CORE_CONTENT_BOOK(id_content)
            lt_content_title.Text = mycontent.content_title
            lt_content_description.Text = mycontent.content_description_replaced
        lt_content_pages.Text = mycontent.bookPages
        cover = mycontent.content_default_cover
            mycontent.Dispose()
            mycontent = Nothing
        
        Dim searchContent As SEARCH_VALUE_COLLECTION(Of Int32) = New SEARCH_VALUE_COLLECTION(Of Int32)
        searchContent.Add(id_content)
        Dim searchCool As SEARCH_VALUE_COLLECTION(Of Int32) = New SEARCH_VALUE_COLLECTION(Of Int32)
        
        'collana       
        Dim csearch As CORE_CONTEXT_SEARCHER = New CORE_CONTEXT_SEARCHER
        csearch.searchLanguage = CORE_CONTEXT_SEARCHER.language.italian
        csearch.searchOrder = CORE_CONTEXT_SEARCHER.order.contextTitleAsc
        csearch.contents = searchContent
        searchCool = New SEARCH_VALUE_COLLECTION(Of Int32)
        searchCool.Add(53)
        csearch.groups = searchCool
        csearch.searchContentStatus = CORE_CONTEXT_SEARCHER.status.enabled
        rpCollana.DataSource = csearch.search()
        rpCollana.DataBind()
        If rpCollana.Items.Count > 0 Then rpCollana.Visible = True
        
        'autore          
        csearch = New CORE_CONTEXT_SEARCHER
        csearch.searchLanguage = CORE_CONTEXT_SEARCHER.language.italian
        csearch.searchOrder = CORE_CONTEXT_SEARCHER.order.contextTitleAsc
        csearch.contents = searchContent
        searchCool = New SEARCH_VALUE_COLLECTION(Of Int32)
        searchCool.Add(60)
        csearch.groups = searchCool
        csearch.searchContentStatus = CORE_CONTEXT_SEARCHER.status.enabled
        rpAutore.DataSource = csearch.search()
        rpAutore.DataBind()
        If rpAutore.Items.Count > 0 Then rpAutore.Visible = True
                
        'editore      
        csearch = New CORE_CONTEXT_SEARCHER
        csearch.searchLanguage = CORE_CONTEXT_SEARCHER.language.italian
        csearch.searchOrder = CORE_CONTEXT_SEARCHER.order.contextTitleAsc
        csearch.contents = searchContent
        searchCool = New SEARCH_VALUE_COLLECTION(Of Int32)
        searchCool.Add(52)
        csearch.groups = searchCool
        csearch.searchContentStatus = CORE_CONTEXT_SEARCHER.status.enabled
        rpEditore.DataSource = csearch.search()
        rpEditore.DataBind()
        If rpEditore.Items.Count > 0 Then rpEditore.Visible = True
               
        'genere      
        csearch = New CORE_CONTEXT_SEARCHER
        csearch.searchLanguage = CORE_CONTEXT_SEARCHER.language.italian
        csearch.searchOrder = CORE_CONTEXT_SEARCHER.order.contextTitleAsc
        csearch.contents = searchContent
        searchCool = New SEARCH_VALUE_COLLECTION(Of Int32)
        searchCool.Add(61)
        csearch.groups = searchCool
        csearch.searchContentStatus = CORE_CONTEXT_SEARCHER.status.enabled
        rpGenere.DataSource = csearch.search()
        rpGenere.DataBind()
        If rpGenere.Items.Count > 0 Then rpGenere.Visible = True
        
        
        
        csearch.Dispose()
        csearch = Nothing
        
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
<div class="contentDescription"><%=CORE.displayCover(id_content, cover, "", "", 100, 0)%><asp:literal id="lt_content_description" runat="server" EnableViewState="false"></asp:literal></div>

<div>Pagine:<asp:literal id="lt_content_pages" runat="server" EnableViewState="false"></asp:literal></div>


<asp:repeater runat="server" ID="rpAutore"  EnableViewState="false" Visible="false">
<HeaderTemplate><div class="tags"><span>Autore:</span></HeaderTemplate>
<ItemTemplate>
<a href="<%#core.makeLink(currentTreePath,CType(Container.DataItem, CORE_CONTEXT).id_key,CType(Container.DataItem, CORE_CONTEXT).context_title,CORE.pageEvent.searchByTags) %>"><span><%#CType(Container.DataItem, CORE_CONTEXT).context_title%></span></a>
</ItemTemplate>
<SeparatorTemplate><span>,</span></SeparatorTemplate>
<FooterTemplate></div></FooterTemplate>
</asp:repeater>

<asp:repeater runat="server" ID="rpCollana"  EnableViewState="false" Visible="false">
<HeaderTemplate><div class="tags"><span>Collana:</span></HeaderTemplate>
<ItemTemplate>
<a href="<%#core.makeLink(currentTreePath,CType(Container.DataItem, CORE_CONTEXT).id_key,CType(Container.DataItem, CORE_CONTEXT).context_title,CORE.pageEvent.searchByTags) %>"><span><%#CType(Container.DataItem, CORE_CONTEXT).context_title%></span></a>
</ItemTemplate>
<SeparatorTemplate><span>,</span></SeparatorTemplate>
<FooterTemplate></div></FooterTemplate>
</asp:repeater>

<asp:repeater runat="server" ID="rpEditore"  EnableViewState="false" Visible="false">
<HeaderTemplate><div class="tags"><span>Editore:</span></HeaderTemplate>
<ItemTemplate>
<a href="<%#core.makeLink(currentTreePath,CType(Container.DataItem, CORE_CONTEXT).id_key,CType(Container.DataItem, CORE_CONTEXT).context_title,CORE.pageEvent.searchByTags) %>"><span><%#CType(Container.DataItem, CORE_CONTEXT).context_title%></span></a>
</ItemTemplate>
<SeparatorTemplate><span>,</span></SeparatorTemplate>
<FooterTemplate></div></FooterTemplate>
</asp:repeater>

<asp:repeater runat="server" ID="rpGenere"  EnableViewState="false" Visible="false">
<HeaderTemplate><div class="tags"><span>Genere:</span></HeaderTemplate>
<ItemTemplate>
<a href="<%#core.makeLink(currentTreePath,CType(Container.DataItem, CORE_CONTEXT).id_key,CType(Container.DataItem, CORE_CONTEXT).context_title,CORE.pageEvent.searchByTags) %>"><span><%#CType(Container.DataItem, CORE_CONTEXT).context_title%></span></a>
</ItemTemplate>
<SeparatorTemplate><span>,</span></SeparatorTemplate>
<FooterTemplate></div></FooterTemplate>
</asp:repeater>



</div>
</div>
</div>
</div>
