<%@ Control Language="VB" %>
<script language="vb" runat="server">


    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private siteLabel As String = String.Empty
    Private rootPath As String = String.Empty
    Private language As String = String.Empty
    Private currentTree As Integer = 0
    Public boxOption As New CORE_BOX_OPTIONS

    '/////////////////////////////////////////////////////////////////////////////////////////
    Sub Page_load()

        siteLabel = CORE.MyPage(Me).root_mypage.site_label
        language = CORE.MyPage(Me).root_mypage.language
        currentTree = CType(CORE.MyPage(Me).root_mypage, CORE_PAGE).treeObject.id_tree
        rootPath = "/" & language & "/1/" & CORE_formatting.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title) & "/"
        
        Dim mytree As CORE_TREE_SEARCHER = New CORE_TREE_SEARCHER(CORE.MyPage(Me).root_mypage.id_key, 0, CORE.MyPage(Me).root_mypage.language_id)
        mytree.searchStatus = CORE_TREE_SEARCHER.status.enabled
        mytree.levels = 5
        LtSiteTree.Text = makeHtree(mytree.search())

        mytree.Dispose()
        mytree = Nothing

        Dim mybox As New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        boxTitle = mybox.box_title
        boxDescription = mybox.box_description
        mybox.Dispose()
        mybox = Nothing
        
        LtSiteTree.Dispose()
        LtSiteTree = Nothing

    End Sub

    '/////////////////////////////////////////////////////////////////////////////////////////

    Function makeHtree(ByVal tree As System.Data.DataTableReader) As String
        Dim oString = String.Empty
        Try
            oString = CORE_TREE.makeTree(tree, siteLabel, language, currentTree)
        Catch ex As Exception
            CORE.application_error_trace(ex.ToString)
            oString = ""
        End Try
        Return oString
    End Function
</script>
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable"><div <%=boxStyle %>><div class="adminItem"><asp:literal id="LtSiteTree" runat="server" EnableViewState="false" /></div></div></div>
