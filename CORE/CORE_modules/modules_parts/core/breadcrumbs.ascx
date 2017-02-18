<%@ Control Language="VB" %>
<script language="vb" runat="server">
    Private boxStyle As String = String.Empty
    Private boxTitle As String = String.Empty
    Private boxDescription As String = String.Empty
    Private mypage As CORE_PAGE = Nothing
    Private siteLabel As String = String.Empty
    Private contentTitle As String = String.Empty
    Public boxOption As New CORE_BOX_OPTIONS
    
    
    Sub page_load()
        
        Dim mybox As New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        boxTitle = mybox.box_title
        boxDescription = mybox.box_description
        mybox.Dispose()
        mybox = Nothing
        
        mypage = CORE.MyPage(Me).root_mypage
        siteLabel = mypage.site_label
        If mypage.id_content > 0 Then contentTitle = mypage.contentObject.content_title
        
        
        
    End Sub
    

  </script>


<script language="javascript" type="text/javascript">


$(document).ready(function(){
var selected = '#branch<%=CORE.MyPage(Me).root_mypage.id_tree%>';
var id_content=<%=CORE.MyPage(Me).root_mypage.id_content%>;
var id_event=<%=CORE.MyPage(Me).root_mypage.id_event%>;
var eventTitle='<%=CORE.MyPage(Me).root_mypage.eventLabel%>';
var $treeSite=$("#treeSite a.selected");
var $breadCrumbs=$("#breadCrumbs");

$(selected).parents().map(function(){if (this.tagName=='LI'){ $(this).find("a").eq(0).addClass("selected")}})

var aSize=$treeSite.length-1;
                        
						
$breadCrumbs.append("<a href='/'>"+ $("#branch1").html() +"</a>")					
$treeSite.each(function(i){
if (id_content==0){

if (id_event==0){
if (i<aSize){$breadCrumbs.append("<a href='"+ $(this).attr("href") +"'>"+ $(this).html() +"</a>")
}
else
{$breadCrumbs.append($(this).html())}

}else{

$breadCrumbs.append("<a href='"+ $(this).attr("href") +"'>"+ $(this).html() +"</a>")
if(i==aSize){$breadCrumbs.append(eventTitle)
}


}
}
else{
$breadCrumbs.append("<a href='"+ $(this).attr("href") +"'>"+ $(this).html() +"</a>")
if(i==aSize){$breadCrumbs.append("<%=contentTitle %>")}
}

})

 });
 

</script>

<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle %>>
<div class="adminItem">
<div id="breadCrumbs"></div>
</div>
</div>
</div>

