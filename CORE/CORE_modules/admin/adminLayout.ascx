
<div id="layoutsContainer" style="display:none;">
<div>
<a href="#" onclick="javascript:changeLayout(0),closeLayer('#layoutsContainer');return false;"><img class="imgLayout"  src="/core/CORE_layout/0/layout.gif" alt="Layout 0"/></a>
<a href="#" onclick="javascript:changeLayout(1),closeLayer('#layoutsContainer');return false;"><img class="imgLayout" src="/core/CORE_layout/1/layout.gif" alt="Layout 1"/></a>
<a href="#" onclick="javascript:changeLayout(2),closeLayer('#layoutsContainer');return false;"><img  class="imgLayout" src="/core/CORE_layout/2/layout.gif" alt="Layout 2"/></a>
<a href="#" onclick="javascript:changeLayout(3),closeLayer('#layoutsContainer');return false;"><img  class="imgLayout" src="/core/CORE_layout/3/layout.gif" alt="Layout 3"/></a>
<a href="#" onclick="javascript:changeLayout(4),closeLayer('#layoutsContainer');return false;"><img  class="imgLayout" src="/core/CORE_layout/4/layout.gif" alt="Layout 4"/></a>
<a href="#" onclick="javascript:changeLayout(5),closeLayer('#layoutsContainer');return false;"><img  class="imgLayout" src="/core/CORE_layout/5/layout.gif" alt="Layout 5"/></a>
<a href="#" onclick="javascript:changeLayout(6),closeLayer('#layoutsContainer');return false;"><img  class="imgLayout" src="/core/CORE_layout/6/layout.gif" alt="Layout 6"/></a>
</div>
</div>

 <div id="layoutContainer" class="Forms">

  <div style="margin-bottom:10px;">
  <table cellpadding="5px" cellspacing="0" >
  <tr>
  <td>  <!--<a href="#" onclick="javascript:openLayer('#layoutsContainer',400,0,false,true,false,'Select Layout');return false;"><img id="imgCurrentLayout" src="" alt=""/></a>--> 
  <input type="button" class="button"  onclick="javascript:openLayer('#layoutsContainer',400,0,false,true,false,'Select Layout');return false;" value="Change Layout" />
  </td>
  <td><input type="button" class="button" onclick="javascript:openLayer('#boxWindow',310,0,false,true,true,'Box Selector');return false;" value="Open Box List" /></td><td>
  <select id="eventList" name="eventList" onchange="javascript:changeEvent()" >
	<option value="0">Home</option>
    <option value="1">Archive</option>
    <option value="2">Detail</option>
    <option value="3">Join us</option>
    <option value="4">Login</option>
    <option value="5">Search</option>
    <option value="6">Modify data</option>
    <option value="7">Recover data</option>
	</select></td>
  </tr>
  
  </table>
  </div>
  
     <div id="layout"></div>   
 </div> 