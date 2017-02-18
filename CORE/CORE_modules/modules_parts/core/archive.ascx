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

        searchString = Request("search")

        Dim mybox As CORE_BOX = New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        boxTitle = mybox.box_title
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
        If display = 0 Then display = 10
        Dim idModule As Integer = mybox.id_module
        mybox.Dispose()
        mybox = Nothing
       
        
        '  If CORE.MyPage(Me).root_mypage.treeObject.id_tree > 1 Then trees.Add(CORE.MyPage(Me).root_mypage.treeObject.id_key)
        If CORE.MyPage(Me).root_mypage.treeObject.id_tree > 1 And trees.Items = 0 Then trees.Add(CORE.MyPage(Me).root_mypage.treeObject.id_key)
           
             
        currentTreePath = "/" & CORE.MyPage(Me).root_mypage.language & "/1/" & CORE_formatting.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title) & "/"

        Dim currentPage As Integer = CORE.MyPage(Me).root_mypage.currentPage
        If currentPage = 0 Then currentPage = 1
        
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
            'searcher.treesCollection = New SEARCH_VALUE_COLLECTION(Of Int32)
            searcher.contentsTypeCollection = contentTypes
        End If
        
        searcher.ordersCollection.Add(CORE_CONTENT_SEARCHER.order.contentDatePublicationDesc)
        searcher.searchStatus = CORE_CONTENT_SEARCHER.status.enabled
        searcher.id_language = CORE.MyPage(Me).root_mypage.language_id
        searcher.searchHolder.contexts = True
        searcher.searchHolder.relateds = False
        searcher.searchHolder.users = True

        If searchString <> String.Empty Then
            searcher.search_text = searchString
            searcher.search_text_mode = CORE_CONTENT_SEARCHER.searchType.OrSearch
        End If

        If CORE.MyPage(Me).root_mypage.year_value > 0 Then searcher.year = CORE.MyPage(Me).root_mypage.year_value
        If CORE.MyPage(Me).root_mypage.month_value > 0 Then searcher.month = CORE.MyPage(Me).root_mypage.month_value
        If CORE.MyPage(Me).root_mypage.day_value > 0 Then searcher.day = CORE.MyPage(Me).root_mypage.day_value
        searcher.page = currentPage
        searcher.rows = display
        
        If CORE_USER.hasProfile(CORE_USER.userProfile.administrator) Then
            searcher.searchStatus = CORE_CONTENT_SEARCHER.status.all
            adminClass = " adminItem"
        End If
        
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

        Dim records As Integer = searcher.searchcount()

        searcher.Dispose()
        searcher = Nothing

        Dim _path As String = HttpContext.Current.Request.Path.ToLower()
        If _path = "/default.aspx" Then _path = "/" & CORE.MyPage(Me).root_mypage.language & "/1/" & CORE_FORMATTING.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title) & _path

        ltPaginationTop.Text = CORE.pagination(_path, 4, records, display, currentPage)
        ltPaginationBottom.Text = ltPaginationTop.Text
       
    End Sub


   

</script>

<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>
<asp:Literal ID="ltPaginationTop" runat="server" EnableViewState="false"></asp:Literal>
<asp:Repeater runat="server" id="pages" EnableViewState="false">
<HeaderTemplate><h2><span><%=boxTitle%></span></h2><div class="contentItems"></HeaderTemplate>
<ItemTemplate></ItemTemplate>
<FooterTemplate><div class="clear"></div></div></FooterTemplate>
</asp:Repeater>
<asp:Literal ID="ltPaginationBottom" runat="server" EnableViewState="false"></asp:Literal>
</div>
</div>