<%@ Control Language="VB" %>
<script language="vb" runat="server">
    
    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private contents As SEARCH_VALUE_COLLECTION(Of Int32)
    Private contexts As SEARCH_VALUE_COLLECTION(Of Int32)
    Private trees As SEARCH_VALUE_COLLECTION(Of Int32)
    Private relateds As SEARCH_VALUE_COLLECTION(Of Int32)
    Private treeTitle As String = String.Empty
    Private _path As String = String.Empty
    Private mypage As CORE_PAGE
    Private currentTreePath As String = String.Empty
    Private searcher As CORE_CONTENT_SEARCHER = Nothing
    Public boxOption As New CORE_BOX_OPTIONS
    
'/////////////////////////////////////////////////////////////////////////////////////////

    Sub Page_load()
        
        mypage = CORE.MyPage(Me).root_mypage
       
        Dim mybox As CORE_BOX = New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        boxTitle = mybox.box_title
        boxDescription = mybox.box_description
        contents = mybox.contentsCollection
        contexts = mybox.contextsCollection
        trees = mybox.treesCollection
        relateds = mybox.relatedsCollection
        mybox.Dispose()
        mybox = Nothing
		     
        
        'If trees Is Nothing Then
        '    trees.Add(mypage.treeObject.id_key)
        '    treeTitle = mypage.treeObject.tree_title
        'End If


        'If mypage.treeObject.id_key Then currentTreePath = "/" & mypage.id_tree & "/" & CORE_formatting.urlFilter(mypage.treeObject.tree_title) & "/"
        
        currentTreePath = "/" & mypage.language & "/1/" & CORE_formatting.urlFilter(mypage.site_root_tree.tree_title) & "/"
        
        
        Try
            Dim csearch As CORE_CONTEXT_SEARCHER = New CORE_CONTEXT_SEARCHER
            csearch.searchLanguage = CORE_CONTEXT_SEARCHER.language.italian
            csearch.searchOrder = CORE_CONTEXT_SEARCHER.order.contextTitleAsc
            csearch.comparison = CORE_CONTEXT_SEARCHER.comparisonType.greaterThan
            csearch.comparisonValue = 0
            If contents.Items > 0 Then csearch.contents = contents
            If trees.Items > 0 Then csearch.trees = trees
            If contexts.Items > 0 Then csearch.groups = contexts
            csearch.searchContentStatus = CORE_CONTEXT_SEARCHER.status.enabled
            
            rpContexts.DataSource = csearch.search()
            rpContexts.DataBind()
            csearch.Dispose()
            csearch = Nothing
        Catch err As Exception
            CORE.application_error_trace(err.ToString())
            
        End Try
       
        
    End Sub
</script>
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0">
<div <%=boxStyle %>>
<div class="boxContainer">
<div class="box-title"><h3><span><%=boxTitle%> <%=treeTitle%></span></h3></div>
<div class="box-content">
<asp:repeater runat="server" ID="rpContexts"  EnableViewState="false"><HeaderTemplate><ul></HeaderTemplate><ItemTemplate><li><a class="filter" data-filter=".<%#CType(Container.DataItem, CORE_CONTEXT).context_title%>" href="<%#core.makeLink(currentTreePath,CType(Container.DataItem, CORE_CONTEXT).id_key,CType(Container.DataItem, CORE_CONTEXT).context_title,CORE.pageEvent.searchByTags) %>"><%#CType(Container.DataItem, CORE_CONTEXT).context_title%> <span>(<%#CType(Container.DataItem, CORE_CONTEXT).tot%>)</span></a></li></ItemTemplate><FooterTemplate></ul></FooterTemplate></asp:repeater>
</div>
</div>
</div>
</div>


