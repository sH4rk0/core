var presentations;

function loadPresentations(){

loadData("who=getMMPresentations&page=1&rows=10&order=1&mmId=" + mmId,"displayPresentations(data)")


}


function displayPresentations(data)
{
 presentations=data.data.presentation
$(".trP").remove();
for(i=0; i<=presentations.length-1; i++)
{

$("#presentationGrid").append("<tr id='pId"+ presentations[i].id +"' class='trP'><td></td><td>"+ presentations[i].id +"</td><td class='pStatus'><a href='javascript:void(0);' onclick='javascript:setStatus("+i+");'><span>"+ presentations[i].online +"</span></td><td>"+ presentations[i].pType +"</td><td>"+ presentations[i].title +"</td><td>"+ presentations[i].created +"</td><td>"+ presentations[i].updated +"</td><td>"+ presentations[i].revision +"</td><td>"+ presentations[i].dateStart +"</td><td>"+ presentations[i].dateEnd +"</td></tr>");

}
$("#archive").fadeIn();
}


function goPage(){
openDialog("Coming soon",200,100,2000);
}


function setStatus(index){

loadData("who=setPresentationStatus&mmId=" + mmId+"&pId=" + presentations[index].idKey.replace("key",""),"refreshStatus(data)")

}


function refreshStatus(data){

$("#pId"+ data.data.presentation[0].id +" .pStatus a span").text(data.data.presentation[0].status);

}