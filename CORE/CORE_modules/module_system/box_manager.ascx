
<script language="vb" runat="server">

   
    Dim _position As Integer = 0

    Public Property position() As Integer

        Get
            Return _position
        End Get

        Set(ByVal value As Integer)
            _position = Value
        End Set
    End Property

    Private _module_path As String = String.Empty
    Private _admin As Boolean = False
'/////////////////////////////////////////////////////////////////////////////////////////

    Sub Page_load()
        Try 
		
        Dim mymodule As CORE_BOX = New CORE_BOX
        If CORE_USER.hasProfile(CORE_USER.userProfile.administrator) Then _admin = True
	       
        Dim MyBox As System.Data.DataTableReader = mymodule.get_box(CORE.MyPage(Me).root_mypage.id_key, CORE.MyPage(Me).root_mypage.id_tree, CORE.MyPage(Me).root_mypage.language_id, position, CORE.MyPage(Me).root_mypage.id_event, 0).CreateDataReader()
        
        Dim i As Integer = 0
		
		
        Dim myPlaceHolder As Object = Nothing
        
        Do While MyBox.Read()
            
            If (Convert.ToBoolean(MyBox("enabledFlag").ToString()) And Convert.ToBoolean(MyBox("box_enabled").ToString())) Or _admin Then
               
                _module_path = CORE.module_path(CORE.MyPage(Me).root_mypage.site_folder, MyBox("module_path"))
            
           
		 '  httpcontext.current.response.write(_module_path)
		   
                Ph_box.Controls.Add(LoadControl(_module_path))
           
                myPlaceHolder = Ph_box.Controls(i)
                CType(myPlaceHolder.boxOption, CORE_BOX_OPTIONS).box_position = MyBox("box_position")
                CType(myPlaceHolder.boxOption, CORE_BOX_OPTIONS).id_box = MyBox("id_box")
                CType(myPlaceHolder.boxOption, CORE_BOX_OPTIONS).id_box_tree = MyBox("id_key")
                
                'If _admin Then CType(myPlaceHolder.boxOption, CORE_BOX_OPTIONS).serialize_key = "idKey=""" & MyBox("id_box") & """ idBox=""module_" & MyBox("id_key") & "_" & CORE.random_key("0|9,0|9,0|9,0|9,0|9") & "-value"""
                
                i = i + 1
            
            End If
            
        Loop
        
        myPlaceHolder = Nothing
   
        MyBox.Close()
        MyBox = Nothing
        mymodule.Dispose()
        mymodule = Nothing
        Ph_box.Dispose()
		
		  Catch err As Exception

            httpcontext.current.response.write(err.ToString())

        End Try
        
    End Sub
'/////////////////////////////////////////////////////////////////////////////////////////
</script>
<asp:placeholder id="Ph_box" runat="server" Visible="true"/>
