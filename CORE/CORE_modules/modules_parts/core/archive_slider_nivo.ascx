<%@ Control Language="VB" %>
<script language="vb" runat="server">

    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private currentTreePath As String = String.Empty
    Private searcher As CORE_CONTENT_SEARCHER = Nothing
    Private searchString As String = String.Empty
    Private adminClass As String = String.Empty
    Public boxOption As New CORE_BOX_OPTIONS
    '/////////////////////////////////////////////////////////////////////////////////////////

    Sub Page_load()

                
        Dim mybox As CORE_BOX = New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        Dim contents As SEARCH_VALUE_COLLECTION(Of Int32) = mybox.contentsCollection
        Dim trees As SEARCH_VALUE_COLLECTION(Of Int32) = mybox.treesCollection
        Dim relateds As SEARCH_VALUE_COLLECTION(Of Int32) = mybox.relatedsCollection
        Dim contexts As SEARCH_VALUE_COLLECTION(Of Int32) = mybox.contextsCollection
        Dim users As SEARCH_VALUE_COLLECTION(Of Int32) = mybox.usersCollection
        Dim contentTypes As SEARCH_VALUE_COLLECTION(Of Int32) = mybox.contentTypesCollection
        Dim display As Integer = mybox.box_rows
        Dim template As Integer = mybox.id_template
        Dim width As Integer = mybox.width
        Dim height As Integer = mybox.height
        If display = 0 Then display = 1
        Dim idModule As Integer = mybox.id_module
        mybox.Dispose()
        mybox = Nothing
        
        If CORE.MyPage(Me).root_mypage.treeObject.id_tree > 1 Then trees.Add(CORE.MyPage(Me).root_mypage.treeObject.id_key)
              
                    
        searcher = New CORE_CONTENT_SEARCHER()

        If trees.Items > 0 Then
            searcher.treesCollection = trees
            searcher.tree_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
        End If

        If contents.Items > 0 Then
            searcher.contentsCollection = contents
            searcher.content_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
        End If

        If relateds.Items > 0 Then
            searcher.relatedsCollection = relateds
            searcher.related_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
        End If

        If CORE.MyPage(Me).root_mypage.id_context > 0 Then contexts.Add(CORE.MyPage(Me).root_mypage.id_context)
        If contexts.Items > 0 Then
            searcher.contextsCollection = contexts
            searcher.related_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
        End If

        If users.Items > 0 Then
            searcher.usersCollection = users
            searcher.user_search_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
        End If
        
        If contentTypes.Items > 0 Then
            searcher.contentsTypeCollection = contentTypes
        End If
        
        searcher.ordersCollection.Add(CORE_CONTENT_SEARCHER.order.contentDatePublicationDesc)
        searcher.id_language = CORE.MyPage(Me).root_mypage.language_id
        searcher.searchHolder.contexts = True
        searcher.searchHolder.relateds = False
        searcher.searchHolder.users = True
        searcher.page = 1
        searcher.rows = display
        searcher.searchStatus = CORE_CONTENT_SEARCHER.status.enabled
        
        Try
            
            pages.ItemTemplate = Page.LoadTemplate("/core/core_modules/modules_parts/templates/" & idModule & "_templates/" & template & ".ascx")
           
            Dim options As CORE_TEMPLATE_OPTIONS = New CORE_TEMPLATE_OPTIONS
            options.coverHeight = height
            options.coverWidth = width
            Session("templateOptions") = options
            
        Catch ex As Exception
            CORE.application_error_trace(ex.ToString)
        End Try
        
            
        pages.DataSource = searcher.search()
        pages.DataBind()
        pages.Dispose()
        pages = Nothing
        searcher.Dispose()
        searcher = Nothing

       
             
    End Sub



</script>


<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>

<script type="text/javascript">
$(window).load(function() {
	$('#nivoSlider<%=boxOption.id_box%>').nivoSlider();
});

</script>

<asp:Repeater runat="server" id="pages" EnableViewState="false" >
<HeaderTemplate>
<div id="nivoSlider<%=boxOption.id_box%>" class="nivoSliderMain">
</HeaderTemplate>
<ItemTemplate></ItemTemplate>
<FooterTemplate>
</div>
</FooterTemplate>
</asp:Repeater>

</div>
</div>