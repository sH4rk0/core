<%@ Control Language="VB" %>
<script language="vb" runat="server">

    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private searcher As CORE_TREE_SEARCHER = Nothing
    Public boxOption As New CORE_BOX_OPTIONS
    '/////////////////////////////////////////////////////////////////////////////////////////

    Sub Page_load()
        Try
           
            Dim mybox As CORE_BOX = New CORE_BOX(boxOption.id_box)
            boxStyle = mybox.style
            boxTitle = mybox.box_title
            Dim trees As SEARCH_VALUE_COLLECTION(Of Int32) = mybox.treesCollection
            Dim display As Integer = mybox.box_rows
            Dim template As Integer = mybox.id_template
            Dim width As Integer = mybox.width
            Dim height As Integer = mybox.height
            If display = 0 Then display = 1
            Dim idModule As Integer = mybox.id_module
            mybox.Dispose()
            mybox = Nothing
   
            Dim id_tree As Integer = 0
            id_tree = CType(CORE.MyPage(Me).root_mypage, CORE_PAGE).treeObject.id_tree
                     
            searcher = New CORE_TREE_SEARCHER(CORE.MyPage(Me).root_mypage.id_key, id_tree, CORE.MyPage(Me).root_mypage.language_id)
            searcher.searchStatus = CORE_TREE_SEARCHER.status.enabled
            searcher.levels = 1
        
                        
            childs.ItemTemplate = Page.LoadTemplate("/core/core_modules/modules_parts/templates/" & idModule & "_templates/" & template & ".ascx")
           
            Dim options As CORE_TEMPLATE_OPTIONS = New CORE_TEMPLATE_OPTIONS
            options.coverHeight = height
            options.coverWidth = width
            Session("templateOptions") = options
            
            childs.DataSource = searcher.searchCollection()
            childs.DataBind()
            childs.Dispose()
            childs = Nothing
            searcher.Dispose()
            searcher = Nothing

        Catch ex As Exception
            CORE.application_error_trace(ex.ToString)
        End Try
             
    End Sub



</script>


<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>

<asp:Repeater runat="server" id="childs" EnableViewState="false">
<HeaderTemplate><h2><span><%=boxTitle%></span></h2><ul class="treeItems"></HeaderTemplate>
<ItemTemplate></ItemTemplate>
<FooterTemplate><div class="clear"></div></ul></FooterTemplate>
</asp:Repeater>

</div>
</div>