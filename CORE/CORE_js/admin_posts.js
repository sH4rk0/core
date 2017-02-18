

function deletePostsSelected(posts)
{
		if(confirm('Delete posts??')){
		
		mydata="who=deletePosts&posts="+ posts;
		
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		 		  	
		 		  		
		 		  	
		 		  	if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
 	closeLayer('#postSelectedMenu');  
		 		  		openDialog ('Posts removed',200,100,2000);
		 		  		removePostsSelected()
		 		  		getPosts(currentContent,1,currentPostOrder)
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
		 		  	
		 		  		
		   }
		 });}
		 
		 else{return false;}
}
	
	
function selectedPostsSerialize()
	
	{
	
	var postkeys = new Array()
for (i=0; i<postSelected.length; i++)
{
postkeys[i]=postSelected[i].idPost
}

return postkeys.join("|")
	
	}
	
	
	
function getPost(id_post)
{
			mydata="who=getPost&id_post="+ id_post ;
		
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
		   if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {
    currentPost=id_post;
		   postValue=msg;
			  postDisplayData()		
 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
		   
		  
		   }
		 });
}




function postDisplayData()
{
		
		$("#post_subject").val(postValue.values.post[0].subject);
		var oEditor = FCKeditorAPI.GetInstance('post_description')
        oEditor.SetData( normalizeXml(postValue.values.post[0].description ))
	
}
	


function newPost()
{       
$("#id_post").val("");
resetPostForm()
openLayer("#postForm",800);
		
}

function modifyPost(id_post)
{       $("#id_post").val(id_post);
		openLayer("#postForm",800,400);
		getPost(id_post)
		
		
}

function resetPostForm(){
        $(".postSerialize").val("")
		var oEditor = FCKeditorAPI.GetInstance('post_description')
		oEditor.SetData("")
	
	}
	
	
function managePost()
{	
var oEditor = FCKeditorAPI.GetInstance('post_description');
$("#post_description").val(oEditor.GetData());
if($("#id_post").val()==""){insertPost()}else{updatePost()}
}
	
	
function insertPost()
{
	
	closeLayer("#postForm"); 
		mydata="who=insertPost&postType=1&idSite="+ currentKeySite +"&idLanguage="+ languageId +"&id_user="+ id_user +"&id_content="+ currentContent +"&"+$(".postSerialize").serialize();
			
			
							
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
	
		    if(msg.values.error[0].errorId==0){
			   
			   	
				
		getPosts(currentContent,1,currentPostOrder)
			  
			   }else
			   {
			    if (msg.values.error[0].errorId==666){ displayActionForbidden()}
				   alert('Il record non è stato creato');
			
					   
		
		
		  }
		  
		   }
		 });
		
}

function updatePost()
{

	closeLayer("#postForm");  
	

    
	
	if ( $("#trPost_"+postValue.values.post[0].idPost).length ){
		var sequence=parseInt($("#trPost_"+postValue.values.post[0].idPost).attr("sequence"));
		postsValues.values.post[sequence].subject=$("#post_subject").val();
		postsValues.values.post[sequence].description=$("#post_description").val();
			
		}

			
		mydata="who=updatePost&id_content="+ currentContent +"&id_post="+ $("#id_post").val() +"&"+$(".postSerialize").serialize();
		
		
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		    dataType: "json",
		   success: function(msg){
	
	
		
		   if(msg.values.error[0].errorId==0){
			   
			   
			   			
			  if ( $("#trPost_"+postValue.values.post[0].idPost).length ){
				   				updatePostArchive(postValue.values.post[0].idPost,sequence);
																
								}
			   
			   }else
			   {
			    if (msg.values.error[0].errorId==666){ displayActionForbidden()}
			   openDialog (msg.values.error[0].errorLabel,200,100,2000);
			   
			   		                
		 		
		  }
		  
		   }
		 });
		
}


function updatePostArchive(id_key,sequence){


	$(".postItems").removeClass("selected")
	$("#trPost_"+id_key).addClass("selected")
	
	var selected =	isPostSelected(sequence,id_key);
			
		$("#trPost_"+id_key).html("<td valign='top'>"+  selected +"</td><td valign='top'>"+postsValues.values.post[sequence].idPost+"</td><td valign='top'>"+ isPostEnabled(sequence)+"</td><td valign='top'>"+postsValues.values.post[sequence].date+"</td><td valign='top'><a href='javascript:modifyPost("+postsValues.values.post[sequence].idPost+");'>"+postsValues.values.post[sequence].subject+"</a><br/>"+postsValues.values.post[sequence].description+"</td>")	
	
	
	
	}

	
function getPosts(id_content,page,orderBy)
{
	
		 mydata="who=getPosts&postType=1&id_content="+ id_content + "&page="+ page + "&orderBy=" + orderBy + "&rows=" + postDisplay; 
		 
		 $.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
				if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {	   
		   
		   postsValues=msg;
			  if (msg.values.value[0].count>0){
			   
			   $("#postGridHeader").show()
				 postRecords=msg.values.value[0].count;   
				 
				 
				if (postRecords<postDisplay){$(".postPagers").hide()}else{$(".postPagers").show()}  
		
			 	postPages=parseInt(postRecords/postDisplay);
			   if ((postPages*postDisplay)<postRecords){postPages++;}
			 				   			   
		  
 if(orderBy==undefined){orderBy=0;}
var selected="";
var mypage=0;
var start=1
var end=0;
currentPostPage=page;
currentPostOrder=orderBy;


$(".postPages").html("");
$(".postItems").remove();

if (parseInt(page/postNumP)==0){start=1}
if (parseInt(page/postNumP)>0){start=page-parseInt(postNumP/2); $(".postPages").prepend("<a href='#' onclick='getPosts("+(page-+parseInt(postNumP/2)-1)+","+ orderBy +");return false;' class='page'>...</a>")}

if ((page+(postNumP/2))>=postPages){start=postPages-(postNumP-1)}
end = start+postNumP
if (end > postPages){end=postPages}
if(start<1){start=1;}

for (i=start; i<=end; i++){
if (i==page){selected=" selected";}
$(".postPages").append("<a href='#' onclick='getPosts("+ id_content +","+i+","+ orderBy +");return false;' class='page"+ selected +"'>"+i+"</a>")
selected="";
}

if (page+parseInt(postNumP/2)<postPages){
mypage=page+postNumP;
if ((page+postNumP)>=postPages){mypage=postPages}
$(".postPages").append("<a href='#' onclick='getPosts("+ id_content +","+ mypage +","+ orderBy +");return false;' class='page'>...</a>")
}
			  
			  
			  displayPosts()
		  
				}
				else{
				$(".postItems").remove()
				$(".postPagers,#postGridHeader").hide()
				
				
				}
				

 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}	
				
			
				
				
		   }
		 });
		 
			
}




function displayPosts()
{
 $(".postItems").remove();
	var selected="";
	
	
		
		if (postsValues.values.post!=undefined){
		for (i=0; i<postsValues.values.post.length; i++)
		{
			
		selected =	isPostSelected(i,postsValues.values.post[i].idPost);
			
		
		$("#postGrid").append("<tr class='postItems' id='trPost_"+ postsValues.values.post[i].idPost +"' sequence='"+ i +"'><td valign='top'>"+  selected +"</td><td valign='top'>"+postsValues.values.post[i].idPost+"</td><td valign='top'>"+ isPostEnabled(i) +"</td><td valign='top'>"+postsValues.values.post[i].date+"</td><td valign='top'><a href='javascript:modifyPost("+postsValues.values.post[i].idPost+");'>"+postsValues.values.post[i].subject+"</a><br/>"+postsValues.values.post[i].description+"</td></tr>")	
			
			}
			}
		
}

function isPostSelected(x,id_key){
var exist=false;
var i=0;
for (i=0; i<postSelected.length; i++)
		{
		if (postSelected[i].idPost==id_key){exist=true; break;}
		}
		
if(exist==true){

return "<img src='"+imgPath+"checkedOn.gif' alt='' class='checked' onclick='javascript:postCheckUncheck("+ x +")' id='postCheck"+x+"'/>"

}else{


return "<img src='"+imgPath+"checkedOff.gif' alt='' onclick='javascript:postCheckUncheck("+ x +")' id='postCheck"+x+"'/>"
}


}

function isPostEnabled(i)
{

if(postsValues.values.post[i].enabled=="True")
{
return "<a href='#' id='linkPostStatus"+ i +"' onclick='setPostStatus("+i+");return false;' rel='False'><img  src='"+ imgPath + "enabled.gif' alt=''/></a>"
}else
{
return "<a href='#' id='linkPostStatus"+ i +"' onclick='setPostStatus("+i+");return false;' rel='True'><img id='imgPostStatus"+ i +"' src='"+ imgPath + "disabled.gif' alt=''/></a>"
}
}


function updatePostField(i,field,value,callback)
{

mydata="who=updatePostField&id_post="+ postsValues.values.post[i].idPost + "&field="+ field + "&value="+ value;
		
		$.ajax({
		   type: "POST",
		   url: enginePost,
		   data: mydata,
		    dataType: "json",
		   success: function(msg){
		   }
		 });

}

function setPostStatus(i)
{

if ($("#linkPostStatus"+i).attr("rel")=="True")
{
$("#linkPostStatus"+i+" img").attr("src",imgPath + "enabled.gif");
$("#linkPostStatus"+i).attr("rel","False")
updatePostField(i,"content_enabled","1")
return false;
}
else
{
$("#linkPostStatus"+i+" img").attr("src",imgPath + "disabled.gif")
$("#linkPostStatus"+i).attr("rel","True")
updatePostField(i,"content_enabled","0")
return false;
}


}





function displaySelectedPost(){

$("#postSelectedList").html("");

for (i=0; i<postSelected.length; i++)
		{
		
		$("#postSelectedList").append("<li>"+ postSelected[i].subject +"</li>")
	
		}
		openLayer("#postSelectedMenu",400);


}


function postCheckUncheck(x)
{
var newSel=postsValues.values.post[x].idPost
var exist=false;

if ($("#postCheck"+x).hasClass("checked"))
{
$("#postCheck"+x).removeClass("checked")
$("#postCheck"+x).attr("src",imgPath+"checkedOff.gif")
for (i=0; i<postSelected.length; i++)
		{
		    if (postSelected[i].idPost==newSel)
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
		if (postSelected[i].idPost==newSel){exist=true; break;}
		}
		
		if (exist==false){postSelected.push(postsValues.values.post[x]);$("#postSelected span").text(postSelected.length);}

}

if(postSelected.length>0){$("#postSelected").fadeIn();}else{$("#postSelected").fadeOut();}
}


function removePostsSelected(){
postSelected=[];
$("#postSelected").fadeOut();

$(".checked").each(function(){

$(this).removeClass("checked").attr("src",imgPath+"checkedOff.gif")

})

}

function goPostPage(Go)
{
if (Go=="first") {getPosts(currentContent,1,currentPostOrder);return;}
if (Go=="prev" && (currentPostPage-1)>=1) {getPosts(currentContent,currentPostPage-1,currentOrder);return;}
if (Go=="next" && (currentPostPage+1)<=postPages) {getPosts(currentContent,currentPostPage+1,currentOrder);return;}
if (Go=="last") {getPosts(currentContent,postPages,currentPostOrder);return;}
}
	
	


		
	
	