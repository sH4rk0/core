<%@ Control   %>

<script language="vb" runat="server">
    
    '/////////////////////////////////////////////////////////////////////////////////////////
    Dim myOptions As New CORE_TEMPLATE_OPTIONS
    Dim currentTreePath As String = String.Empty
    Sub page_init()
        If Not Session("templateOptions") Is Nothing Then myOptions = Session("templateOptions")
    End Sub
    
    Sub Page_load()
        
      currentTreePath = "/" & CORE.MyPage(Me).root_mypage.language & "/1/" & CORE_formatting.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title) & "/"
               
    End Sub
    
   
    
</script>
<div class="contentItem template7 mix <asp:repeater runat="server" ID="contexts" DataSource='<%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentContexts%>' EnableViewState="false"><HeaderTemplate></HeaderTemplate><ItemTemplate><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTEXT).context_title%></ItemTemplate><SeparatorTemplate> </SeparatorTemplate><FooterTemplate></FooterTemplate></asp:repeater>" idKey="<%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key%>">
<%#CORE.displayCover(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_default_cover, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title, "", myOptions.coverWidth, myOptions.coverHeight)%> 
<div><h3><a href="<%#core.makeLink(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_path, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title,core.pageEvent.detail )%>" idKey="<%#CORE_CRYPTOGRAPHY.encrypt(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key )%>"><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title%></a></h3>
<p class="contentDescription"><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_abstract%></p></div></div>


