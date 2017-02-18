<%@ Control  %>
<script language="vb" runat="server">
    Dim myOptions As New CORE_TEMPLATE_OPTIONS
    Sub page_init()
        If Not Session("templateOptions") Is Nothing Then myOptions = Session("templateOptions")
    End Sub
    Sub Page_load()
       
    End Sub
</script>

<div class="contentItem template2 adminItem" idKey="<%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key %>">

<%#CORE.displayCover(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_default_cover, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title, CORE.makeLink(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_path, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title, CORE.pageEvent.detail), myOptions.coverWidth, myOptions.coverHeight, "covers", CORE.align.none, CORE.coverType.background, "")%> 

<h3><a href="<%#core.makeLink(CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_path, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.id_key, CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title,core.pageEvent.detail )%>"><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_title%></a></h3>

<p class="contentAbstract"><%#CType(CType(Container, RepeaterItem).DataItem, CORE_CONTENT_HOLDER).contentData.content_abstract%></p>
<div class="contentCloser"></div>
</div>


