<%@ Control   %>
<script language="vb" runat="server">
    Dim myOptions As New CORE_TEMPLATE_OPTIONS
    Sub page_init()
        If Not Session("templateOptions") Is Nothing Then myOptions = Session("templateOptions")
    End Sub
    Sub page_load()
       
    End Sub
</script>

<div class="panel">
<div class="projectImage"><%#CORE.displayCover(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_default_cover, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title, CORE.makeLink(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_path, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title, CORE.pageEvent.detail), myOptions.coverWidth, myOptions.coverHeight)%></div>
<div class="projectDescription">
<h2><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title%></h2>
<p><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_abstract%></p>
<p class="Desc"><span class="site"><a href="<%#core.makeLink(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_path, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title,core.pageEvent.detail )%>" title="<%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title%>">Leggi</a></span></p>
</div>
</div>
