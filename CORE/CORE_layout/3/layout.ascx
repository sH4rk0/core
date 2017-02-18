<script language="vb" runat="server">
    '/////////////////////////////////////////////////////////////////////////////////////////
    Dim currentEvent As Integer = 0
    Sub Page_load()
        Try
            
            Dim siteFolder As String = CORE.MyPage(Me).root_mypage.site_folder.replace("/core/", "")
            Dim myobj As CORE_MODULE = New CORE_MODULE("box_manager")
            Dim _module_path As String = CORE.module_path(siteFolder, myobj.module_path)
		
            myBox1.Controls.Add(LoadControl(_module_path))
            myBox2.Controls.Add(LoadControl(_module_path))
            myBox3.Controls.Add(LoadControl(_module_path))
            myBox4.Controls.Add(LoadControl(_module_path))
            myBox5.Controls.Add(LoadControl(_module_path))
            myBox6.Controls.Add(LoadControl(_module_path))
            myBox7.Controls.Add(LoadControl(_module_path))
            
            Dim myPlaceHolder As Object
            myPlaceHolder = myBox1.Controls(0)
            myPlaceHolder.position = 1
            
            myPlaceHolder = myBox2.Controls(0)
            myPlaceHolder.position = 2
		
            myPlaceHolder = myBox3.Controls(0)
            myPlaceHolder.position = 3
		
            myPlaceHolder = myBox4.Controls(0)
            myPlaceHolder.position = 4
		
            myPlaceHolder = myBox5.Controls(0)
            myPlaceHolder.position = 5
		
            myPlaceHolder = myBox6.Controls(0)
            myPlaceHolder.position = 6
            
            myPlaceHolder = myBox7.Controls(0)
            myPlaceHolder.position = 7
		
            myPlaceHolder = Nothing
            myobj.Dispose()
            myobj = Nothing
            myBox1.Dispose()
            myBox1 = Nothing
            currentEvent = CType(CORE.MyPage(Me).root_mypage, CORE_PAGE).id_event
        Catch ex As Exception
            CORE.application_error_trace(ex.ToString)
        End Try
       
    End Sub
'/////////////////////////////////////////////////////////////////////////////////////////
</script>

<div class="container_12 order1 event<%=currentEvent %>">
<div class="grid_12 order1">
<div class="grid_4 alpha order1_1">
<asp:PlaceHolder id="myBox1" runat="server" />
</div>
<div class="grid_8 omega order1_2">
<asp:PlaceHolder id="myBox2" runat="server" />
</div>
</div>
</div>

<div class="container_12 order2 event<%=currentEvent %>">
<div class="grid_12 order2">
<asp:PlaceHolder id="myBox3" runat="server" />
</div>
</div>

<div class="container_12 order3 event<%=currentEvent %>">
<div id="" class="grid_12 order3">
<div id="" class="grid_4 alpha order3_1">
<asp:PlaceHolder id="myBox4" runat="server" />
</div>
<div id="" class="grid_4 order3_2">
<asp:PlaceHolder id="myBox5" runat="server" />
</div>
<div id="" class="grid_4 omega order3_3">
<asp:PlaceHolder id="myBox6" runat="server" />
</div>
</div>
</div>

<div class="container_12 order4 event<%=currentEvent %>">
<div id="" class="grid_12 order4">
<asp:PlaceHolder id="myBox7" runat="server" />
</div>
</div>

