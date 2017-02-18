

	
function getRelateds(page,orderBy,id_content)
{
checkRelatedOptions()
$(".itemsRelated").remove();
 if(orderBy==undefined){orderBy=0;}
 if(id_content==undefined){id_content=0;}
  
		 mydata="who=getRelatedValues&id_content="+ id_content + "&page="+ page + "&orderBy=" + orderBy + "&rows=" + relatedDisplay; 
		 
		 $.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		   dataType: "json",
		   success: function(msg){
		   
if(msg.values.error!=undefined)
{

 if (msg.values.error[0].errorId==0)
 {  
		   
		   relatedsValues=msg;
			  if (msg.values.count[0].count>0){
			   
			   $("#relatedGridHeader").show()
				 relatedRecords=msg.values.count[0].count;   
				 
				 
				if (relatedRecords<relatedDisplay){$(".relatedPagers").hide()}else{$(".relatedPagers").show()}  
		
			 	relatedPages=parseInt(relatedRecords/relatedDisplay);
			   if ((relatedPages*relatedDisplay)<relatedRecords){relatedPages++;}
			 				   			   
		  

var selected="";
var mypage=0;
var start=1
var end=0;
currentRelatedPage=page;
currentRelatedOrder=orderBy;


$(".relatedPages").html("");
$(".relatedItems").remove();

if (parseInt(page/relatedNumP)==0){start=1}
if (parseInt(page/relatedNumP)>0){start=page-parseInt(relatedNumP/2); $(".relatedPages").prepend("<a href='#' onclick='getRelateds("+(page-+parseInt(relatedNumP/2)-1)+","+ orderBy +");return false;' class='page'>...</a>")}

if ((page+(relatedNumP/2))>=relatedPages){start=relatedPages-(relatedNumP-1)}
end = start+relatedNumP
if (end > relatedPages){end=relatedPages}
if(start<1){start=1;}

for (i=start; i<=end; i++){
if (i==page){selected=" selected";}
$(".relatedPages").append("<a href='#' onclick='getRelateds("+i+","+ orderBy +");return false;' class='page"+ selected +"'>"+i+"</a>")
selected="";
}

if (page+parseInt(relatedNumP/2)<relatedPages){
mypage=page+relatedNumP;
if ((page+relatedNumP)>=relatedPages){mypage=relatedPages}
$(".relatedPages").append("<a href='#' onclick='getRelateds("+ mypage +","+ orderBy +");return false;' class='page'>...</a>")
}
			  
		  
			  
			  
		  		}
				else{
				$(".relatedItems").remove()
				$(".relatedPagers,#relatedGridHeader").hide()
				
				
				}
		displayRelateds()	
		
		 }
 else
 {
 if (msg.values.error[0].errorId==666){ displayActionForbidden()}
 }
 
}
			
		   }
		 });
		 
			
}




function displayRelateds()
{

showForm('relatedArchive');
 $(".relatedItems").remove();
	var selected="";
	
	
		
		if (relatedsValues.values.value!=undefined){
		
		for (i=0; i<relatedsValues.values.value.length; i++)
		{
			
		selected =	isRelatedSelected(i,relatedsValues.values.value[i].id_related);
			
		
		$("#relatedGrid").append("<tr class='relatedItems' id='tr_related_"+ relatedsValues.values.value[i].id_related +"' sequence='"+ i +"'><td valign='top' class='tdChecks'>"+  selected +"</td><td valign='top'>"+relatedsValues.values.value[i].id_related+"</td><td valign='top'>"+ isRelatedEnabled(i) +" <a href='#' onclick='javascript:relatedToClipboard("+ i +");'><img src='/core/CORE_images/admin/copy_to_description.gif' alt=''/></a></td><td valign='top'>"+relatedsValues.values.value[i].date+"</td><td valign='top'><a href='javascript:modRelated("+relatedsValues.values.value[i].id_related+",1);'>"+relatedsValues.values.value[i].title +"</a></td></tr>")	
			
			}
			}
		
}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function relatedToClipboard(index){

copyToClipboard(relatedsValues.values.value[index].title,"<related type='"+ relatedsValues.values.value[index].type +"' tipology='"+ relatedsValues.values.value[index].tipology +"' title='" +relatedsValues.values.value[index].title +"' link='" +relatedsValues.values.value[index].link +"' id='"+ relatedsValues.values.value[index].id_related +"' size='"+  relatedsValues.values.value[index].size +"' duration='"+  relatedsValues.values.value[index].duration +"' width='"+  relatedsValues.values.value[index].width +"' height='"+  relatedsValues.values.value[index].height +"'></related>")


}
/*
-----------------------------------------------------------------------------------------------------------------------------*/	
function isRelatedSelected(x,id_key){
var exist=false;
var i=0;
for (i=0; i<relatedSelected.length; i++)
		{
		if (relatedSelected[i].id_related==id_key){exist=true; break;}
		}
		
if(exist==true){

return "<img src='"+imgPath+"checkedOn.gif' alt='' class='relatedChecked' onclick='javascript:relatedCheckUncheck("+ x +")' id='relatedCheck"+x+"'/>"

}else{


return "<img src='"+imgPath+"checkedOff.gif' alt='' onclick='javascript:relatedCheckUncheck("+ x +")' id='relatedCheck"+x+"'/>"
}


}

function isRelatedEnabled(i)
{

if(relatedsValues.values.value[i].enabled=="True")
{
return "<a href='#' id='linkRelatedStatus"+ i +"' onclick='setRelatedStatus("+i+");return false;' rel='False'><img  id='imgRelatedStatus"+ i +"' src='"+ imgPath + "enabled.gif' alt=''/></a>"
}else
{
return "<a href='#' id='linkRelatedStatus"+ i +"' onclick='setRelatedStatus("+i+");return false;' rel='True'><img id='imgRelatedStatus"+ i +"' src='"+ imgPath + "disabled.gif' alt=''/></a>"
}
}







function goRelatedPage(Go)
{
if (Go=="first") {getRelateds(1,currentRelatedOrder);return;}
if (Go=="prev" && (currentRelatedPage-1)>=1) {getRelateds(currentRelatedPage-1,currentRelatedOrder);return;}
if (Go=="next" && (currentRelatedPage+1)<=relatedPages) {getRelateds(currentRelatedPage+1,currentRelatedOrder);return;}
if (Go=="last") {getRelateds(relatedPages,currentRelatedOrder);return;}
}
	
	
	
	
function relatedCheckUncheck(x)
{
var newSel=relatedsValues.values.value[x].id_related
var exist=false;

if ($("#relatedCheck"+x).hasClass("relatedChecked"))
{
$("#relatedCheck"+x).removeClass("relatedChecked")
$("#relatedCheck"+x).attr("src",imgPath+"checkedOff.gif")
for (i=0; i<relatedSelected.length; i++)
		{
		    if (relatedSelected[i].id_related==newSel)
		    {
		    relatedSelected.splice(i,1);
		    $("#relatedSelected span").text(relatedSelected.length);
    		}
		}


}
else{
$("#relatedCheck"+x).addClass("relatedChecked")
$("#relatedCheck"+x).attr("src",imgPath+"checkedOn.gif").addClass("relatedChecked");
	for (i=0; i<relatedSelected.length; i++)
		{
		if (relatedSelected[i].id_related==newSel){exist=true; break;}
		}
		
		if (exist==false){relatedSelected.push(relatedsValues.values.value[x]);$("#relatedSelected span").text(relatedSelected.length);}

}
checkRelatedOptions()
if(relatedSelected.length>0){$("#relatedSelected").fadeIn();}else{$("#relatedSelected").fadeOut();}
displaySelectedRelated()
}


function setRelatedStatus(i)
{

if ($("#linkRelatedStatus"+i).attr("rel")=="True")
{
$("#linkRelatedStatus"+i+" img").attr("src",imgPath + "enabled.gif");
$("#linkRelatedStatus"+i).attr("rel","False")
updateContentStatus(i,"content_enabled","1")
return false;
}
else
{
$("#linkRelatedStatus"+i+" img").attr("src",imgPath + "disabled.gif")
$("#linkRelatedStatus"+i).attr("rel","True")
updateContentStatus(i,"content_enabled","0")
return false;
}


}

function updateContentStatus(i,field,value,callback)
{

mydata="who=updateContentField&id_content="+ relatedsValues.values.value[i].id_related + "&field="+ field + "&value="+ value;
		
		$.ajax({
		   type: "POST",
		   url: engineContent,
		   data: mydata,
		    dataType: "json",
		   success: function(msg){
		   
		   
		   if(msg.values.error[0].errorId==0){
			   			   
			 
			   }else
			   {
			    if (msg.values.error[0].errorId==666){ displayActionForbidden();}
			  
		  }
		   
		   }
		 });

}

		
	
	
function updateRelatedField(i,field,value,callback)
{

mydata="who=updateRelatedField&idRelated="+ relatedsValues.values.value[i].id_related + "&field="+ field + "&value="+ value;
		
		$.ajax({
		   type: "POST",
		   url: engineRelated,
		   data: mydata,
		    dataType: "json",
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

}