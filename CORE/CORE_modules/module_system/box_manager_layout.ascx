
<script language="vb" runat="server">
    '/////////////////////////////////////////////////////////////////////////////////////////

    
       
    Sub Page_load()
     
    End Sub
    
'/////////////////////////////////////////////////////////////////////////////////////////
</script>



<style type="text/css">
	.ui-sortable-placeholder { border: 1px dotted red; visibility: visible !important; height: 50px !important; }
	.ui-sortable-placeholder * { visibility: hidden; }
</style>
    
<script type="text/javascript">
$(function() {
	$(".draggable").each(function() {$this = $(this);attachDraggable($this);});
	
	
	$(".groupWrapper").sortable({
		
		cancel: "p,img",
		containment: "*",
		connectWith: ["#layoutBox1","#layoutBox2","#layoutBox3","#layoutBox4","#layoutBox5","#layoutBox6","#layoutBox7"],
		distance: 10,
		scroll: false,
		cursor: "move",
		opacity: 0.5,
		handle: '.adminSortableHandle',
		start: function(e,ui) {ui.helper.css("width", ui.item.width());},
		stop:function(e,ui){
		
		$("#"+ ui.item[0].id).attr("position",$("#"+ ui.item[0].id).parent().attr("position"))
		setTimeout("serialize();",100)

		}
		
		 })
});

function attachDraggable(element){
	var idKey = $(element).attr("idKey") ? $(element).attr("idKey") : null;
	var handle = ''; 
	if (idKey!=null) handle = '<div class="adminSortableHandle"><span class="adminEditBox" style="cursor: pointer;"><img src="/core/core_images/admin/cog_edit.png" alt="Edit Box" title="Edit Box Properties" /></span></div>'; $(element).prepend(handle); $(element).find(".adminEditBox").bind('click', function(){boxModify(idKey);});
}
/*
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/
function serialize(s)
{
var url="who=updateLayout&id_event=<%=CType(CORE.MyPage(Me).root_mypage, CORE_PAGE).id_event%>&id_site=<%=CType(CORE.MyPage(Me).root_mypage, CORE_PAGE).id_key%>&id_tree=<%=CType(CORE.MyPage(Me).root_mypage, CORE_PAGE).id_tree%>&id_language=<%=CType(CORE.MyPage(Me).root_mypage, CORE_PAGE).language_id%>"

	var serial=''
	var layout_area=''
	var _firstAmp =''
	
	layout_area=$('#layoutBox1').sortable('serialize',{attribute:'idBox',expression:'(.+)[-](.+)',key:'layoutBox1'})
	if (layout_area!=''){serial+= '' + layout_area; _firstAmp="&"}
	
	layout_area=$('#layoutBox2').sortable('serialize',{attribute:'idBox',expression:'(.+)[-](.+)',key:'layoutBox2'})
	if (layout_area!=''){serial+= '&'+layout_area}
		
	layout_area=$('#layoutBox3').sortable('serialize',{attribute:'idBox',expression:'(.+)[-](.+)',key:'layoutBox3'})
	if (layout_area!=''){serial+= '&'+layout_area}
	
	layout_area=$('#layoutBox4').sortable('serialize',{attribute:'idBox',expression:'(.+)[-](.+)',key:'layoutBox4'})
	if (layout_area!=''){serial+= '&'+layout_area}
	
	layout_area=$('#layoutBox5').sortable('serialize',{attribute:'idBox',expression:'(.+)[-](.+)',key:'layoutBox5'})
	if (layout_area!=''){serial+= '&'+layout_area}
	
	layout_area=$('#layoutBox6').sortable('serialize',{attribute:'idBox',expression:'(.+)[-](.+)',key:'layoutBox6'})
	if (layout_area!=''){serial+= '&'+layout_area}
	
	layout_area=$('#layoutBox7').sortable('serialize',{attribute:'idBox',expression:'(.+)[-](.+)',key:'layoutBox7'})
	if (layout_area!=''){serial+= '&'+layout_area}

	if (serial!=''){
	
		while (serial.indexOf("[]")!=-1)
		{
		serial=serial.replace("[]","");
		}
		url= url +"&" + serial
		
	
	}else{url= url +"&clear=all"}
		

$.ajax({ 
  type: "POST", 
  url: "/api/json/layout/core.aspx", 
  dataType: "json",
  data: url, 
   error: function(msg){alert('Si è verificato un errore!');} ,
   success: function(msg){ 
   
if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
   
   }
   
});

};

</script>
