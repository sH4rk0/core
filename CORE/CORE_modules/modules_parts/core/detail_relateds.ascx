<%@ Control Language="VB" %>
<script language="vb" runat="server">

    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private contents As SEARCH_VALUE_COLLECTION(Of Int32)
    Private id_content As Integer = 0
    Private width As Integer = 0
    Private height As Integer = 0
    Public boxOption As New CORE_BOX_OPTIONS
    
    Sub page_load()
                
        Dim mybox As New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        boxTitle = mybox.box_title
        boxDescription = mybox.box_description
        contents = mybox.contentsCollection
        width = mybox.width
        height = mybox.height
        mybox.Dispose()
        mybox = Nothing
        
        If CORE.MyPage(Me).root_mypage.treeObject.id_content > 0 Then id_content = CORE.MyPage(Me).root_mypage.treeObject.id_content
        If CORE.MyPage(Me).root_mypage.id_content > 0 Then id_content = CORE.MyPage(Me).root_mypage.id_content
        If contents.Items > 0 Then id_content = contents.Item(0)
                
       
        
        Dim rSearcher As New CORE_CONTENT_RELATED_SEARCHER
        Dim cSearcher As New CORE_CONTENT_SEARCHER
        rSearcher.contentsCollection.Add(id_content)
        cSearcher.type = CORE_CONTENT.contentType.contentRelated
        cSearcher.searchStatus = CORE_CONTENT_SEARCHER.status.enabled
        
        rSearcher.relatedTypesCollection.Add(CORE_CONTENT_RELATED_SEARCHER.relatedType.links)
        cSearcher.relatedSearcher = rSearcher
        rpLinks.DataSource = cSearcher.search()
        rpLinks.DataBind()
        If rpLinks.Items.Count > 0 Then phRelatedsLinks.Visible = True : phRelatedsLinksFragment.Visible = True
        
        rSearcher.relatedTypesCollection = New SEARCH_RELATED_TYPE_COLLECTION(Of CORE_CONTENT_RELATED_SEARCHER.relatedType)
        rSearcher.relatedTypesCollection.Add(CORE_CONTENT_RELATED_SEARCHER.relatedType.images)
        cSearcher.relatedSearcher = rSearcher
        rpImages.DataSource = cSearcher.search()
        rpImages.DataBind()
        If rpImages.Items.Count > 0 Then phRelatedsImages.Visible = True : phRelatedsImagesFragment.Visible = True
        
        rSearcher.relatedTypesCollection = New SEARCH_RELATED_TYPE_COLLECTION(Of CORE_CONTENT_RELATED_SEARCHER.relatedType)
        rSearcher.relatedTypesCollection.Add(CORE_CONTENT_RELATED_SEARCHER.relatedType.documents)
        cSearcher.relatedSearcher = rSearcher
        rpDocuments.DataSource = cSearcher.search()
        rpDocuments.DataBind()
        If rpDocuments.Items.Count > 0 Then phRelatedsDocuments.Visible = True : phRelatedsDocumentsFragment.Visible = True
        
        rSearcher.relatedTypesCollection = New SEARCH_RELATED_TYPE_COLLECTION(Of CORE_CONTENT_RELATED_SEARCHER.relatedType)
        rSearcher.relatedTypesCollection.Add(CORE_CONTENT_RELATED_SEARCHER.relatedType.video)
        cSearcher.relatedSearcher = rSearcher
        rpVideos.DataSource = cSearcher.search()
        rpVideos.DataBind()
        If rpVideos.Items.Count > 0 Then phRelatedsVideos.Visible = True : phRelatedsVideosFragment.Visible = True
           
     
                
        If phRelatedsLinks.Visible = False And phRelatedsImages.Visible = False And phRelatedsDocuments.Visible = False And phRelatedsVideos.Visible = False Then phRelateds.Visible = False
        
    End Sub
    
    Function relatedTarget(ByVal _target As Boolean) As String
        If _target Then Return "_blank"
        Return "_self"
    End Function
    
       

</script>



<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>
<div class="adminItem">
<asp:PlaceHolder ID="phRelateds" runat="server" Visible="true" EnableViewState="false">

<div id="relatedBox">
<h3><span><%=boxTitle%></span></h3>

	<ul id="relatedTabs">
		<asp:PlaceHolder ID="phRelatedsLinks" runat="server" EnableViewState="false" Visible="false"><li><a href="#" class="relatedTab relatedLink">Link</a></li></asp:PlaceHolder>
		<asp:PlaceHolder ID="phRelatedsImages" runat="server" EnableViewState="false" Visible="false"><li><a href="#" class="relatedTab relatedImages">Images</a></li></asp:PlaceHolder>
		<asp:PlaceHolder ID="phRelatedsDocuments" runat="server" EnableViewState="false" Visible="false"><li><a href="#" class="relatedTab relatedDocuments">Documents</a></li></asp:PlaceHolder>
		<asp:PlaceHolder ID="phRelatedsVideos" runat="server" EnableViewState="false" Visible="false"><li><a href="#" class="relatedTab relatedVideos">Videos</a></li></asp:PlaceHolder>
	</ul>
	
	<asp:PlaceHolder ID="phRelatedsLinksFragment" runat="server" EnableViewState="false" Visible="false">
	<div class="relatedFragment relatedLinks">
		<asp:Repeater ID="rpLinks" runat="server">
		<HeaderTemplate><ul></HeaderTemplate>
		<ItemTemplate>
		<li><div><a href="<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_link%>" target="<%#relatedTarget(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_target)%>"><%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.content_title%></a></div></li>
		</ItemTemplate>
		<FooterTemplate></ul></FooterTemplate>
		</asp:Repeater>
	</div>
	</asp:PlaceHolder>
	
	<asp:PlaceHolder ID="phRelatedsImagesFragment" runat="server" EnableViewState="false" Visible="false">
	<div class="relatedFragment relatedImages">
		
		<asp:Repeater ID="rpImages" runat="server">
		<HeaderTemplate><ul class="gallery clearfix"></HeaderTemplate>
		<ItemTemplate>
		<li>
        
        <%# CORE.displayCover(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.id_content_key, Nothing, CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.content_title, ConfigurationManager.AppSettings("CORE_related_folder").Replace("\", "/") & CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.id_content_key & "/" & CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_link, width, height, "cover", CORE.align.random, CORE.coverType.background, "prettyPhoto[gallery1]")%>
        
        </li>
		</ItemTemplate>
		<FooterTemplate></ul></FooterTemplate>
		</asp:Repeater>
		
	</div>
	</asp:PlaceHolder>
	

	<asp:PlaceHolder ID="phRelatedsDocumentsFragment" runat="server" EnableViewState="false" Visible="false">
	<div class="relatedFragment relatedDocuments">
		<asp:Repeater ID="rpDocuments" runat="server">
		<HeaderTemplate><ul></HeaderTemplate>
		<ItemTemplate>
		<li class="type_<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_tipology%>_<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_type%>" ><a href="/download-<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.id_key%>-<%#CORE_formatting.urlFilter(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.content_title)%>.aspx" target="<%#relatedTarget(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_target)%>"><%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.content_title %></a><span class="size"><%#core_utility.bytesToKbytes(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_size)%> <span>kb</span></span> <span class="download"><%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_downloads%> <span>download</span></span></li>
		</ItemTemplate>
		<FooterTemplate></ul></FooterTemplate>
		</asp:Repeater>
	</div>
	</asp:PlaceHolder>
	
	<asp:PlaceHolder ID="phRelatedsVideosFragment" runat="server" EnableViewState="false" Visible="false">
	<div class="relatedFragment relatedVideos">
		<asp:Repeater ID="rpVideos" runat="server">
		<HeaderTemplate><ul class="gallery clearfix"></HeaderTemplate>
		<ItemTemplate>
	
		<li><a href="/core/core_js/player/player.swf?width=<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_width%>&height=<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_height%>&file=/public/core_related/<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.id_key%>/<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_link%>&image=/public/core_related/<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.id_key%>/<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.id_key%>.jpg" rel="prettyPhoto[flash]"  title="<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.content_title%>" target="<%#relatedTarget(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_target)%>"><%#CORE.displayCover(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.id_content_key, width, height)%></a>
		<strong><%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.content_title%></strong>
		<p>Durata: <%#CORE_utility.secondsToMinutes(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_duration)%> <br /> Width:<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_width%>px Height:<%#CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_height%>px <br /> Dimensione: <%#CORE_utility.bytesToKbytes(CType(Container.DataItem, CORE_CONTENT_HOLDER).contentRelatedData.related_size)%>Kb</p>
		</li>
		</ItemTemplate>
		<FooterTemplate></ul></FooterTemplate>
		</asp:Repeater>
	</div>
	</asp:PlaceHolder>
	
	
</div>
</asp:PlaceHolder>

</div>
</div>
</div>