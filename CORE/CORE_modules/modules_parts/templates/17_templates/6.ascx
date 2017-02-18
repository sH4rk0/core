<%@ Control   %>
<script language="vb" runat="server">
    Dim myOptions As New CORE_TEMPLATE_OPTIONS
    Sub page_init()
        If Not Session("templateOptions") Is Nothing Then myOptions = Session("templateOptions")
    End Sub
    Sub page_load()
      
    End Sub
</script>





<asp:repeater runat="server" ID="relateds" DataSource='<%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentRelateds%>' EnableViewState="false">

<ItemTemplate>

<%# CORE.displayCover(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentRelatedData.id_key, Nothing, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentRelatedData.content_title, CORE.makeLink(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentRelatedData.content_path, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentRelatedData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentRelatedData.content_title, CORE.pageEvent.detail), myOptions.coverWidth, myOptions.coverHeight, "cover", CORE.align.random, CORE.coverType.image, "")%>
</ItemTemplate>

</asp:repeater>

