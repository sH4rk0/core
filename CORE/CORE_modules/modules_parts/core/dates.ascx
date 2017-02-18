<%@ Control Language="VB" %>
<script language="vb" runat="server">
    
    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private contents As SEARCH_VALUE_COLLECTION(Of Int32)
    Private contexts As SEARCH_VALUE_COLLECTION(Of Int32)
    Private trees As SEARCH_VALUE_COLLECTION(Of Int32)
    Private relateds As SEARCH_VALUE_COLLECTION(Of Int32)
    Public boxOption As New CORE_BOX_OPTIONS
    Private treeTitle As String = String.Empty
    Private _path As String = String.Empty
    Private mypage As CORE_PAGE
    Private currentTreePath As String = String.Empty
    
   

    Private searcher As CORE_CONTENT_SEARCHER = Nothing
    
    
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
            Dim csearch As CORE_CONTENT_SEARCHER = New CORE_CONTENT_SEARCHER
            csearch.searchLanguage = CORE_CONTEXT_SEARCHER.language.italian
            
            If contents.Items > 0 Then csearch.contentsCollection = contents
            If trees.Items > 0 Then csearch.treesCollection = trees
            If contexts.Items > 0 Then csearch.contextsCollection = contexts
            If relateds.Items > 0 Then csearch.relatedsCollection = relateds
            csearch.searchStatus = CORE_CONTENT_SEARCHER.status.enabled
            csearch.ordersCollection.Add(CORE_CONTENT_SEARCHER.order.contentYearDesc)
            csearch.ordersCollection.Add(CORE_CONTENT_SEARCHER.order.contentMonthDesc)
            rpDistinctDates.DataSource = csearch.searchDistinctDates()
            rpDistinctDates.DataBind()
            csearch.Dispose()
            csearch = Nothing
        Catch err As Exception
            CORE.application_error_trace(err.ToString())
            
        End Try
        
        
       
        
    End Sub
		

		
		</script>
 
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>
<div class="adminItem">
<div class="boxContainer"><div class="boxWrapper"><div class="box"><div class="corner-left-bot"><div class="corner-right-bot">
<div class="box-title"><div><div><h3><span><%=boxTitle%> <%=treeTitle%></span></h3></div></div></div>
<div class="box-content">
<asp:repeater runat="server" ID="rpDistinctDates"  EnableViewState="false">
    <HeaderTemplate><ul></HeaderTemplate>
    <ItemTemplate>
    <li><a href="<%#core.makeLink(currentTreePath,0,Container.DataItem("year").toString() & "-" & Container.DataItem("month").toString(),CORE.pageEvent.searchByDate) %>"><%#Container.DataItem("year").toString()%>-<%#Container.DataItem("month").toString()%> (<%#Container.DataItem("tot").ToString()%>)</a></li> 
    </ItemTemplate>
    <FooterTemplate></ul></FooterTemplate>
</asp:repeater>
</div></div></div></div></div></div>
</div>
</div>
</div>

