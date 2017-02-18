<script runat="server">


'//////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////
    Dim mypage As CORE_PAGE
    
    Sub page_load()

        mypage = New CORE_PAGE
        
        If CORE_USER.hasRole(CORE_USER.userRole.consoleAdministrator) Then
            
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminImageTools.ascx"))
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminProcessing.ascx"))
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminContentFormNew.ascx"))
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminCoversInfo.ascx"))
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminContentForm.ascx"))
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminContextForm.ascx"))
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminRelatedForm.ascx"))
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminPostForm.ascx"))
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminRelatedPreview.ascx"))
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminBoxForm.ascx"))
            administration.Controls.Add(LoadControl("/core/core_modules/admin/adminDialog.ascx"))
            
         
        End If

    End Sub

</script>

<script type="text/javascript" language="javascript">

$(function(){
$(".adminItem").each(function() {$this = $(this);attachEditLink($this);});

})


function attachEditLink(element){
	$(element).html("<div class='htmlPlaceholder'>"  +  $(element).html() +  "</div>");
	var idKey = $(element).attr("idKey") ? $(element).attr("idKey") : null;
	var handle = ''; 
	if (idKey!=null) handle = '<div class="adminEdit"><span class="adminEditLink"><img src="/core/core_images/admin/page_edit.png" alt="Edit Content" title="Edit Content Data" /></span></div>';$(element).prepend(handle);$(element).find(".adminEditLink").bind('click', function(){getContent(idKey);});
	
}


</script>
<script type="text/javascript" language="javascript">
var coversPath="<%=ConfigurationManager.AppSettings("CORE_related_folder").replace("\","/") %>";
var treePath="<%=ConfigurationManager.AppSettings("CORE_tree_folder").replace("\","/") %>";
var id_user='<%=CORE_CRYPTOGRAPHY.encrypt(core_user.getUserId) %>';
</script>

<link href="/CORE/CORE_css/admin/adminImport.css" rel="stylesheet" type="text/css" />
<link href="/CORE/CORE_css/admin/admin.css" rel="stylesheet" type="text/css" />
<link href="/CORE/Core_js/jquery-ui/css/black-tie/jquery-ui-1.8.custom.css" rel="stylesheet" type="text/css" />	
<link href="/CORE/CORE_js/jquery.Jcrop.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
#layout{display:none;}
.groupWrapper{min-height: 50px; width:100%; width:100%; border: none; padding:0px; }
.adminSortableHandle{cursor: move;background-image:url(/core/CORE_images/admin/buttonBkg.gif); text-align:right; padding:1px}
.adminEditBox{cursor: pointer;}
.adminItem{ position:relative;}
.adminEdit{position:absolute;top:0; right:0;text-align:right; padding:1px}
.adminEditLink{cursor: pointer;}
</style>

<script src="/CORE/Core_js/admin.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_tree.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_contents.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_related.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_related_archive.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_user.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_covers.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_context.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_posts.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_layout.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_site.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_module.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_macroUpload.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_imageTools.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_profile.js" type="text/javascript"></script>
<script src="/CORE/Core_js/admin_role.js" type="text/javascript"></script>
<script src="/CORE/Core_js/checkDate.js" type="text/javascript"></script>
<script src="/CORE/Core_js/checkEmail.js" type="text/javascript"></script>
<script src="/CORE/Core_js/checkNickname.js" type="text/javascript"></script>
<script src="/CORE/Core_js/checkName.js" type="text/javascript"></script>
<script src="/CORE/Core_js/checkUrl.js" type="text/javascript"></script>
<script src="/CORE/Core_js/checkPasswordStrong.js" type="text/javascript"></script>
<script src="/CORE/Core_js/jquery-ui/js/jquery-ui-1.8.custom.min.js"  type="text/javascript"></script>
<script src="/CORE/CORE_js/jquery-ui/js/ui.selectmenu.js" type="text/javascript"></script>
<script src="/CORE/Core_js/jquery.qtip-1.0.0-rc3.min.js" type="text/javascript"></script>
<script src="/CORE/Core_js/jqueryTree/jquery.tree.js" type="text/javascript" ></script>
<script src="/CORE/Core_js/jqueryTree/plugins/jquery.tree.contextmenu.js" type="text/javascript" ></script>
<script src="/CORE/CORE_js/jquery.Jcrop.min.js"type="text/javascript"></script>
<script src="/CORE/Core_js/swfupload.js" type="text/javascript"></script>
<script src="/CORE/Core_js/swfuploadHandlers.js" type="text/javascript"></script>
<script src="/CORE/Core_js/swfuploadImageHandlers.js" type="text/javascript"></script>
<script src="/CORE/Core_js/swfuploadMacroHandlers.js" type="text/javascript"></script>
<script src="/fckeditor/fckeditor.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
function myBoxUpdate()
{
if ($("#boxTitle").val()=="") { alert("Insert Title");$("#boxTitle").focus(); return false;}
if ($("#boxIdModule").val()=="") { alert("Select Module");$("#boxIdModule").focus(); return false;}
mydata="who=boxUpdate&boxId="+ currentBox +"&treeId=" + currentKeyTree + "&" + $(".boxSerialize").serialize();
closeLayer("#box_form");

$.ajax({
   type: "POST",
   url: engineLayout,
   data: mydata,
   dataType:"json",
   success: function(msg){
   
       if(msg.values!=undefined){
            if(msg.values.error[0].errorId==0){
                 openDialog ("Box Updated: F5 to refresh data",200,100,2000);            
            }
             else
             {
             if (msg.values.error[0].errorId==666){ displayActionForbidden(); openDialog (msg.values.error[0].errorLabel,200,100,2000);}
             }
       }
   }
 });

}
/*
-----------------------------------------------------------------------------------------------------------------------------*/
function updateContent()
{

	if ($("#content_title").val()==""){alert('Insert title');$("#content_title").focus();return false; }
	
	if ( $("#tr_"+contentValue.values.content[0].id_key).length ){
		var sequence=parseInt($("#tr_"+contentValue.values.content[0].id_key).attr("sequence"));
		contentsValues.values.value[sequence].title=$("#content_title").val();
		if ($("#content_enabled").is(":checked")){contentsValues.values.value[sequence].enabled="True"}else{contentsValues.values.value[sequence].enabled="False"}
		
		}

		var oEditor = FCKeditorAPI.GetInstance('content_description');
		var content_description=oEditor.GetData();
		
		mydata="who=updateContent&id_content="+ contentValue.values.content[0].id_key + "&language_id="+ languageId + "&" + $(".serialize").serialize() +"&content_description="+escape(content_description);
			
			
		$.ajax({
		   type: "POST",
		   url: engineContent,
		   data: mydata,
		    dataType: "json",
		   success: function(msg){
	
	
		   if(msg.values.error[0].errorId==0){
			   			   
			   openDialog ("Content Updated: F5 to refresh data",200,100,2000);
			  										   
			   }else
			   {
			    if (msg.values.error[0].errorId==666){ displayActionForbidden();}
			   openDialog (msg.values.error[0].errorLabel,200,100,2000);
			    }
		  
		   }
		 });
		
}
</script>
<asp:PlaceHolder id="administration" runat="server" ></asp:PlaceHolder>