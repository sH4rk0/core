
function siteMenuToggle()
{
if($("#siteMenu").is(":hidden")){$("#siteMenu").fadeIn();$("#siteMenuSpan").text("-")}else{$("#siteMenu").fadeOut();$("#siteMenuSpan").text("+")}

}

/*
------------------------------------------------------------------------------------------------------------------*/
function siteAdminToggle()
{
if($("#archiveSites").is(":hidden")){$("#archiveSites").fadeIn();$("#archiveSitesSpan").text("-");}else{$("#archiveSites").fadeOut();$("#archiveSitesSpan").text("+");}

}


/*
------------------------------------------------------------------------------------------------------------------*/
function startUpSites(){



if (siteValues.site==undefined){
//$("#gridSites").html(loadingCircle)
	mydata="who=startUp";

$.ajax({
   type: "POST",
   url: engineSite,
   data: mydata,
   dataType: "json",
   success: function(msg){
  
        if (msg.values.error!=undefined){

                if(msg.values.error[0].errorId==0)
                 
                  {siteValues=msg.values;
                  displaySites();
                  }else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
                  
          }
  
   }
 });
 
 }
 else{ 
showForm('archiveSites')
 }

}
/*
------------------------------------------------------------------------------------------------------------------*/		
function displaySites()
{
var treeOption='';
var treeSiteUl='';

  $(".siteItems").remove() 
  
  if (siteValues.site!=undefined){
  
  
  //$(".treeSelectors").remove()
  $("#treeSelector").html("");
  $("#boxIdSite").html("<option value='0'>-- Select Site --</option>");
  $("#treeSelector").unbind("change");
  treeSiteUl+="<ul class='siteItems'>";
  for (i=0;i<siteValues.site.length; i++){
  
  treeSiteUl+="<li class='siteItems'><a href='#' onclick='javascript:newInstance("+ siteValues.site[i].id_unique +")' title='New Instance'><img src='"+ imgPath +"new_istance.gif' alt='New Instance' class='ico'/></a><strong>"+ siteValues.site[i].site_label +"</strong>"
  
  
  if (siteValues.site[i].sites!=undefined){
  treeSiteUl+="<ul class='siteItems'>"
  for (x=0;x<siteValues.site[i].sites.length; x++){
  
  
  $("#treeSelector, #boxIdSite").append("<option class='treeSelectors' value='"+ siteValues.site[i].sites[x].id_key +"'>"+siteValues.site[i].sites[x].site_host+"</option>")
  
  treeOption='';
  if(siteValues.site[i].sites[x].site_order==1){treeOption="<a href='#' onclick='javascript:newClone("+ siteValues.site[i].sites[x].id_unique +")' title='New Domain'><img src='"+ imgPath +"new_domain.gif' alt='New Domain' class='ico'/></a>"}
  
   treeSiteUl+="<li class='siteItems site"+ siteValues.site[i].id_site +"'>"+  treeOption + "<a href='#' onclick='editInstance("+ siteValues.site[i].sites[x].id_unique +")'>" + siteValues.site[i].sites[x].site_host +"</a>"
    
    
    
              if (siteValues.site[i].sites[x].clones!=undefined){
             treeSiteUl+="<ul class='siteItems'>"
              for (y=0;y<siteValues.site[i].sites[x].clones.length; y++){
                           
                treeSiteUl+="<li class='siteItems clones'>"+  siteValues.site[i].sites[x].clones[y].site_host +"</li>"  
                
              
              }
              treeSiteUl+="</ul>"
              }
  }
  
 treeSiteUl+="</li></ul>"
  }
  }
  treeSiteUl+="</li></ul>"
  
  
  $("#treeSelector").change(function(){

           currentKeySite=$(this).val();
           loadTree(languageId);
})

  $("#gridSites").html(treeSiteUl)
 

 if($("#treeSelector .treeSelectors").length>=1){

 $("#sitesSelector").show();
  currentKeySite=$("#treeSelector .treeSelectors").eq(0).val();
 loadTree(languageId);
 }
 
 
  }
  
    else
  {
 
  $("#gridSites").html("<strong>No sites!</strong>")
    
  } 
  
  
   //showForm('archiveSites')
}
/*
------------------------------------------------------------------------------------------------------------------*/	
function newClone(idKey)
	{
	
	openLayer("#siteForm",650,0,true,true,true,"Create new clone domain");
	currentKeySite=idKey;
	siteWho="cloneInstance";
	$(".siteTr").hide();
	$(".clone").show();
	
	}
/*
------------------------------------------------------------------------------------------------------------------*/	
	
	function editInstance(idKey)
	{
	
	currentKeySite=idKey;
	siteWho="editInstance";
	
	$(".siteTr").hide();
	$(".instance").show();
	mydata="who="+ siteWho +"&id_key=" + idKey;
	
	$.ajax({
   type: "POST",
   url: engineSite,
   data: mydata,
   dataType: "json",
   success: function(msg){
  
        if (msg.values.error!=undefined){

                if(msg.values.error[0].errorId==0)
                  {
                  $("#siteDomain").val(msg.values.site[0].domain);
                  $("#siteLabel").val(msg.values.site[0].label);
                  $("#siteFolder").val(msg.values.site[0].folder);
                  $("#siteUsername").val(msg.values.site[0].username);
                  $("#sitePassword").val(msg.values.site[0].password);
                   $("#siteMasterPage").val(msg.values.site[0].masterPage);
                   $("#siteCss").val(msg.values.site[0].css);
                    $("#siteMeta").val(msg.values.site[0].meta);
                    $("#siteStatistics").val(msg.values.site[0].statistics);
                    
                    openLayer("#siteForm",650,0,true,true,true,"Site Admin: "+ msg.values.site[0].label);
                  siteWho="updateInstance"
                  }else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
                  
          }
  
   }
 });
	
	}	
	
	/*
------------------------------------------------------------------------------------------------------------------*/	
	function clearSiteFields()
	{
$("#siteDomain,#siteLabel,#siteUsername,#siteFolder,#sitePassword,#siteMasterPage,#siteCss,#siteMeta,#siteStatistics").val("");
   }
/*
------------------------------------------------------------------------------------------------------------------*/	
	function newInstance(idKey)
	{
	
	openLayer("#siteForm",650,0,true,true,true,"New Istance");
	currentKeySite=idKey;
	siteWho="newInstance";
	$(".siteTr").hide();
	$(".instance").show();
	
	}
/*
------------------------------------------------------------------------------------------------------------------*/	
	function newSite()
	{
	openLayer("#siteForm",650,0,true,true,true,"New Site")
	clearSiteFields();
	siteWho="newSite";
	$(".siteTr").hide();
	$(".instance").show();
	}
/*
------------------------------------------------------------------------------------------------------------------*/	
	
function siteInsert()
    {
	
   mydata="who="+ siteWho +"&id_user="+ id_user +"&id_key=" + currentKeySite+"&"+ $(".siteserialize").serialize();
   $.ajax({
   type: "POST",
   url: engineSite,
   data: mydata,
   dataType: "json",
   success: function(msg){
   

   
   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
    
   openDialog("Site Values correctly updated.",200,100,2000);
   closeLayer("#siteForm");
   siteValues=[];
   startUpSites()
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
  
   }
 });
	
   }
/*
------------------------------------------------------------------------------------------------------------------*/	
	
function siteTree(idKey)
	{
	currentKeySite=idKey;
    loadTree(languageId);
	}
	