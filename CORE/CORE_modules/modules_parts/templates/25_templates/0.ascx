<%@ Control  %>
<script language="vb" runat="server">
    Dim myOptions As New CORE_TEMPLATE_OPTIONS
    
    Sub page_init()
        If Not Session("templateOptions") Is Nothing Then myOptions = Session("templateOptions")
    End Sub
    
    
    Sub Page_load()
     
    End Sub
    

</script>

<li class="treeItem template0" idKey="">
<a href="<%#CORE_TREE.makeLinkNoHref(CORE.makeLink("/" & CORE.MyPage(Me).root_mypage.language & "/" & CType(CType(Container, RepeaterItem).DataItem, CORE_TREE).id_tree & "/" & CORE_FORMATTING.urlFilter(CType(CType(Container, RepeaterItem).DataItem, CORE_TREE).tree_title), 0, "", CORE.pageEvent.tree), CType(CType(Container, RepeaterItem).DataItem, CORE_TREE).tree_link, CType(CType(Container, RepeaterItem).DataItem, CORE_TREE).tree_link_type)%>"><%#CType(CType(Container, RepeaterItem).DataItem, CORE_TREE).tree_title%></a>




</li>

