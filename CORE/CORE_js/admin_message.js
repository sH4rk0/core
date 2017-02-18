

function deletePostsSelected(posts)
{
		if(confirm('Delete posts??')){
		
		mydata="who=deleteposts&posts="+ posts;
		
				
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		 		  		closeLayer('#postSelectedMenu');  
		 		  		openDialog ('posts removed',200,100,2000);
		 		  		removepostSelected()
		 		  		getposts(currentTree,1)
		 		  		
		 		  		
		   }
		 });}
		 
		 else{return false;}
}
	
	
function selectedPostsSerialize()
	
	{
	
	var postkeys = new Array()
for (i=0; i<postSelected.length; i++)
{
postkeys[i]=postSelected[i].id_key
}

return postkeys.join("|")
	
	}
	
	
	
function getPost(id_post)
{
			mydata="who=getPost&id_post="+ id_post + "&language_id="+ languageId;
		
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   currentpost=id_post;
		   postValue=msg;
		   displaypost()
		   getRelatedValues(id_post)
		   getContextsValues(id_post)
		   getTreesRelated(id_post)
		   getPosts(id_post,1)
		   displayCovers()
		  		  
		   }
		 });
}




function displayPost()
{
		
		showForm('postForm');
		$("#post_title").val(postValue.values.post[0].title);
		$("#post_abstract").val(postValue.values.post[0].abstract);
		$("#post_publication").val(postValue.values.post[0].date_publication);
		if (postValue.values.post[0].enabled=="True"){$("#post_enabled").attr("checked","checked")}else{$("#post_enabled").attr("checked","")}
		var oEditor = FCKeditorAPI.GetInstance('post_description')
    oEditor.SetData( normalizeXml(postValue.values.post[0].value ))
		setUpImageUpload();
		setUpMacroUpload(2);
		
		
}
	


function newPost(idTree)
{
		showForm('postFormNew')
		resetpostForm()
		//currentTree=idTree
}

function resetPostForm(){
        $("#post_title_new").val("")
		$("#post_title").val("")
		$("#post_abstract").val("")
		$("#post_publication").val("")
		$("#post_enabled").attr("checked","")
		var oEditor = FCKeditorAPI.GetInstance('post_description')
		oEditor.SetData("")
	
	}
	
	
function insertPost()
{
	
	
		mydata="who=insertpost&id_site="+ currentKeySite +"&id_tree="+ currentKeyTree +"&language_id="+ languageId + "&post_title="+$("#post_title_new").val();
			
							
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
	
	
	
		    if(msg.values.error[0].errorId==0){
			   
			   	showForm()
				getpost(msg.values.post[0].postId)
		
			   
			   }else
			   {
				   alert('Il record non è stato creato');
			
		showForm()
				   
		
		
		  }
		  
		   }
		 });
		
}

function updatepost()
{

	
	if ( $("#tr_"+postValue.values.post[0].id_key).length ){
		var sequence=parseInt($("#tr_"+postValue.values.post[0].id_key).attr("sequence"));
		postsValues.values.value[sequence].title=$("#post_title").val();
		if ($("#post_enabled").is(":checked")){postsValues.values.value[sequence].enabled="True"}else{postsValues.values.value[sequence].enabled="False"}
		
		}


		var oEditor = FCKeditorAPI.GetInstance('post_description');
		var post_description=oEditor.GetData();
		
		mydata="who=updatepost&id_post="+ postValue.values.post[0].id_key + "&language_id="+ languageId + "&" + $(".serialize").serialize() +"&post_description="+escape(post_description);
			
		showForm('processing')
			
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		    dataType: "json",
		   success: function(msg){
	
	
	$("#processing").hide()
	
		   if(msg.values.error[0].errorId==0){
			   
			   
			   openDialog ("Data Updated",200,100,2000);
			   
			   					if ( $("#tr_"+postValue.values.post[0].id_key).length ){
				   				updateArchive(postValue.values.post[0].id_key,sequence);
								showForm('archive')
								
								}else{
								showForm()
								}
			   
			   }else
			   {
			   
			   openDialog (msg.values.error[0].errorLabel,200,100,2000);
			   
			   		                
		 		showForm()
		  }
		  
		   }
		 });
		
}


function updateArchive(id_key,sequence){
	$(".items").removeClass("selected")
	$("#tr_"+id_key).addClass("selected")
	
	
	var selected =	postIsSelected(sequence,id_key);
			
		
		$("#tr_"+id_key).html("<td>"+  selected +"</td><td>"+postsValues.values.value[sequence].id_key+"</td><td>"+ isEnabled(sequence)+"</td><td><a href='javascript:getpost("+postsValues.values.value[sequence].id_key+");'>"+postsValues.values.value[sequence].title+"</a></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>")	
	
	
	
	
	
	}

	
function getposts(id_tree,orderBy)
{
		
		 currentTree=id_tree;
		 mydata="who=getpostsCount&id_tree="+ id_tree + "&language_id="+ languageId; 
		 
		 $.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
			   if (msg.values.posts[0].count>0){
			   
			   $("#postGridHeader").show()
				 records=msg.values.posts[0].count;   
				 
				 
				if (records<display){$(".pagers").hide()}else{$(".pagers").show()}  
		
			 	pages=parseInt(records/display);
			   if ((pages*display)<records){pages++;}
			   			   
			   			  /* alert(records)
			   			  			   			   
			   			   alert(pages);*/
			   			   
			   displayPages(1,orderBy);
				}
				else{
				$(".items").remove()
				$(".pagers,#postGridHeader").hide()
				
				
				}
				
				
				
				showForm('archive')
				
				
		   }
		 });
		 
			
}

function displayPages(page,orderBy)
{
if(orderBy==undefined){orderBy=0;}
var selected="";
var mypage=0;
var start=1
var end=0;
currentPage=page;
currentOrder=orderBy;


$(".pages").html("");
$(".items").remove();

if (parseInt(page/numP)==0){start=1}
if (parseInt(page/numP)>0){start=page-parseInt(numP/2); $(".pages").prepend("<a href='#' onclick='displayPages("+(page-+parseInt(numP/2)-1)+","+ orderBy +");return false;' class='page'>...</a>")}

if ((page+(numP/2))>=pages){start=pages-(numP-1)}
end = start+numP
if (end > pages){end=pages}
if(start<1){start=1;}

for (i=start; i<=end; i++){
if (i==page){selected=" selected";}
$(".pages").append("<a href='#' onclick='displayPages("+i+","+ orderBy +");return false;' class='page"+ selected +"'>"+i+"</a>")
selected="";
}

if (page+parseInt(numP/2)<pages){
mypage=page+numP;
if ((page+numP)>=pages){mypage=pages}
$(".pages").append("<a href='#' onclick='displayPages("+ mypage +","+ orderBy +");return false;' class='page'>...</a>")
}



mydata="who=getpostsValues&id_tree="+ currentTree + "&language_id="+ languageId + "&rows="+ display +"&page=" + page + "&orderBy="+orderBy;
		
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		    dataType: "json",
		   success: function(msg){
		
		  postsValues=msg;
		  displayposts()
		   }
		 });


}


function displayposts()
{

	var selected="";
	
		//alert(postsValues.values.value.length)
		
		if (postsValues.values.value!=undefined){
		for (i=0; i<postsValues.values.value.length; i++)
		{
			
		selected =	postIsSelected(i,postsValues.values.value[i].id_key);
			
		
		$("#grid").append("<tr class='items' id='tr_"+ postsValues.values.value[i].id_key +"' sequence='"+ i +"'><td>"+  selected +"</td><td>"+postsValues.values.value[i].id_key+"</td><td>"+ isEnabled(i) +"</td><td><a href='javascript:getpost("+postsValues.values.value[i].id_key+");'>"+postsValues.values.value[i].title+"</a></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>")	
			
			}
			}
		
}


function isEnabled(i)
{

if(postsValues.values.value[i].enabled=="True")
{
return "<a href='#' id='linkStatus"+ i +"' onclick='setStatus("+i+")' rel='False'><img  src='"+ imgPath + "enabled.gif' alt=''/></a>"
}else
{
return "<a href='#' id='linkStatus"+ i +"' onclick='setStatus("+i+")' rel='True'><img id='imgStatus"+ i +"' src='"+ imgPath + "disabled.gif' alt=''/></a>"
}
}


function updatepostField(i,field,value,callback)
{

mydata="who=updatepostField&id_post="+ postsValues.values.value[i].id_key + "&field="+ field + "&value="+ value;
		
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		    dataType: "json",
		   success: function(msg){
		   }
		 });

}

function setStatus(i)
{

if ($("#linkStatus"+i).attr("rel")=="True")
{
$("#linkStatus"+i+" img").attr("src",imgPath + "enabled.gif");
$("#linkStatus"+i).attr("rel","False")
updatepostField(i,"post_enabled","1")
}
else
{
$("#linkStatus"+i+" img").attr("src",imgPath + "disabled.gif")
$("#linkStatus"+i).attr("rel","True")
updatepostField(i,"post_enabled","0")
}


}


function postIsSelected(x,id_key){
var exist=false;
var i=0;
for (i=0; i<postSelected.length; i++)
		{
		if (postSelected[i].id_key==id_key){exist=true; break;}
		}
		
if(exist==true){

return "<img src='"+imgPath+"checkedOn.gif' alt='' class='checked' onclick='javascript:postCheckUncheck("+ x +")' id='postCheck"+x+"'/>"

}else{


return "<img src='"+imgPath+"checkedOff.gif' alt='' onclick='javascript:postCheckUncheck("+ x +")' id='postCheck"+x+"'/>"
}


}


function displaySelectedpost(){

$("#postSelectedList").html("");

for (i=0; i<postSelected.length; i++)
		{
		
		$("#postSelectedList").append("<li>"+ postSelected[i].title +"</li>")
	
		}
		openLayer("#postSelectedMenu",400);


}


function postCheckUncheck(x)
{
var newSel=postsValues.values.value[x].id_key
var exist=false;

if ($("#postCheck"+x).hasClass("checked"))
{
$("#postCheck"+x).removeClass("checked")
$("#postCheck"+x).attr("src",imgPath+"checkedOff.gif")
for (i=0; i<postSelected.length; i++)
		{
		    if (postSelected[i].id_key==newSel)
		    {
		    postSelected.splice(i,1);
		    $("#postSelected span").text(postSelected.length);
    		}
		}


}
else{
$("#postCheck"+x).addClass("checked")
$("#postCheck"+x).attr("src",imgPath+"checkedOn.gif").addClass("checked");
	for (i=0; i<postSelected.length; i++)
		{
		if (postSelected[i].id_key==newSel){exist=true; break;}
		}
		
		if (exist==false){postSelected.push(postsValues.values.value[x]);$("#postSelected span").text(postSelected.length);}

}

if(postSelected.length>0){$("#postSelected").fadeIn();}else{$("#postSelected").fadeOut();}
}


function removepostSelected(){postSelected=[];
$("#postSelected").fadeOut();

$(".checked").each(function(){

$(this).removeClass("checked").attr("src",imgPath+"checkedOff.gif")

})

}

function goPage(Go)
{
if (Go=="first") {displayPages(1,currentOrder);return;}
if (Go=="prev" && (currentPage-1)>=1) {displayPages(currentPage-1,currentOrder);return;}
if (Go=="next" && (currentPage+1)<=pages) {displayPages(currentPage+1,currentOrder);return;}
if (Go=="last") {displayPages(pages,currentOrder);return;}
}
	
	


		
	
	