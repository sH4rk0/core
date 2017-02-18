<%@ Control   %>
<script language="vb" runat="server">
    Dim myOptions As New CORE_TEMPLATE_OPTIONS
    Sub page_init()
        If Not Session("templateOptions") Is Nothing Then myOptions = Session("templateOptions")
    End Sub
    Sub page_load()
      
    End Sub
</script>

<div class="contentItem template1 adminItem" idKey="<%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key %>">

<%#CORE.displayCover(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_default_cover, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title, CORE.makeLink(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_path, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title, CORE.pageEvent.detail), myOptions.coverWidth, myOptions.coverHeight)%> 

<h3><a href="<%#core.makeLink(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_path, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title,core.pageEvent.detail )%>"><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title%></a></h3>
<p class="contentAbstract"><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_abstract%></p>
<p class="contentDate">Created <%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_date_publication.ToString("ddd\, d MMMM yyyy \@ HH\:mm")%> by
<asp:repeater runat="server" ID="users" DataSource='<%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentUsers%>' EnableViewState="false">
<HeaderTemplate></HeaderTemplate>
<ItemTemplate><strong><%#CType(CType(Container, RepeaterItem).DataItem, CORE_USER).user_nickname()%></strong></ItemTemplate>
<SeparatorTemplate><span>,</span></SeparatorTemplate>
</asp:repeater>
<span class="contentComments"> - Comments: <%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.post_count%></span>
</p>
<asp:repeater runat="server" ID="contexts" DataSource='<%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentContexts%>' EnableViewState="false">
<HeaderTemplate><div class="contentTags"><span>Tags:</span></HeaderTemplate>
<ItemTemplate>
<a href="<%#core.makeLink(CORE.MyPage(Me).root_mypage.rootPath,CType(CType(Container, RepeaterItem).DataItem, CORE_CONTEXT).id_context,CType(CType(Container, RepeaterItem).DataItem, CORE_CONTEXT).context_title,CORE.pageEvent.searchByTags) %>"><span><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTEXT).context_title%></span></a>
</ItemTemplate>
<SeparatorTemplate><span>,</span></SeparatorTemplate>
<FooterTemplate></div></FooterTemplate>
</asp:repeater>

<asp:repeater runat="server" ID="relateds" DataSource='<%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentRelateds%>' EnableViewState="false">
<HeaderTemplate><ul class="contentRelated"></HeaderTemplate>
<ItemTemplate>
<li><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentRelatedData.content_title%></li>
</ItemTemplate>
<FooterTemplate></ul></FooterTemplate>
</asp:repeater>
<div class="clear"></div>
</div>
<div class="clear"></div>

