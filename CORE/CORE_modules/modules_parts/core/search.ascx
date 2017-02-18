<%@ Control Language="VB" %>
<script language="vb" runat="server">

    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private siteLabel As String = String.Empty
    Private rootPath As String = String.Empty
    Private language As String = String.Empty
    Public boxOption As New CORE_BOX_OPTIONS
    
    '/////////////////////////////////////////////////////////////////////////////////////////
    Sub Page_load()

        siteLabel = CORE.MyPage(Me).root_mypage.site_label
        language = CORE.MyPage(Me).root_mypage.language
        rootPath = "/" & language & "/1/" & CORE_formatting.urlFilter(CORE.MyPage(Me).root_mypage.site_root_tree.tree_title) & "/"

        Dim mybox As New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        mybox.Dispose()
        mybox = Nothing
        
        
    End Sub

  

</script>

<script type="text/javascript">
var sPath='<%= CORE.makeLink(rootPath, 0, "", CORE.pageEvent.search)%>';
function doSearch(){
if($("#searchText").val()!='')  document.location.href = (sPath + "?" + $("#searchText").serialize())
return false;
}
</script>
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>
<div class="adminItem">
<div class="searchBox">
<div class="indent">

<input type="text" value="" id="searchText" name="search" class="text"/> <input type="button" id="searchBtn" onclick="doSearch();return false;" value="Search" />

</div>
</div>
</div>		
</div>
</div>
