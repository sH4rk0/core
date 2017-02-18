
<div id="toolForm" style="display:none;">
<div id="toolTabs">
            
<ul>
<li><a href="#ttabs-1">Info</a></li>
<li><a href="#ttabs-2">Crop</a></li>
<li><a href="#ttabs-3">Resize</a></li>
</ul> 

<div id="ttabs-1">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td>Name:</td><td><span id="infoName"></span></td>
</tr>
<tr>
<td>Path:</td><td><span id="infoPath"></span></td>
</tr>
<tr>
<td>Width:</td><td><span id="infoWidth"></span>px</td>
</tr>
<tr>
<td>Height:</td><td><span id="infoHeight"></span>px</td>
</tr>
<tr>
<td>Size:</td><td><span id="infoSize"></span>Kb</td>
</tr>
</table>
</div>

<div id="ttabs-2">
<label><input type="hidden"  id="cropX" name="cropX" class="cropSerialize"/></label>
<label><input type="hidden"  id="cropY" name="cropY" class="cropSerialize"/></label>
<label><input type="hidden"  id="cropX2" name="cropX2" class="cropSerialize"/></label>
<label><input type="hidden"  id="cropY2" name="cropY2" class="cropSerialize"/></label>
<label>Width:<input type="text" size="4" id="cropW" name="cropW" class="cropSerialize"/></label>
<label>Height: <input type="text" size="4" id="cropH" name="cropH" class="cropSerialize"/></label>
<div style="margin-top:10px;">
<input type="button" class="button" onclick="javascript:crop();" value="Make Crop" />
</div>
</div>

<div id="ttabs-3">
<label>New Width:<input type="text" size="4" id="resizeW" name="resizeW" class="resizeSerialize"/></label>
<label>New Height: <input type="text" size="4" id="resizeH" name="resizeH" class="resizeSerialize"/></label>
<div style="margin-top:10px;">
<input type="button" class="button" onclick="javascript:resize();" value="Make Resize" />
</div>
</div>

</div>
</div>

  <!--
////////////////////////////////////////////////////////////////
-->
<div id="imageTools" class="Forms"><img id="imageToolsSource"  scr="" alt=""/></div>

