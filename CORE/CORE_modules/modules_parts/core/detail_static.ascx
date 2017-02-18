<%@ Control Language="VB" %>
<script language="vb" runat="server">

    Private boxStyle As String = String.Empty
    Private contents As SEARCH_VALUE_COLLECTION(Of Int32)
    Private id_content As Integer = 0
    Private adminClass As String = String.Empty
    Private mycontent As CORE_CONTENT = Nothing
    Public boxOption As New CORE_BOX_OPTIONS

    '/////////////////////////////////////////////////////////////////////////////////////////

    Sub Page_load()

        Dim mybox As CORE_BOX = New CORE_BOX(boxOption.id_box)
        boxStyle = mybox.style
        contents = mybox.contentsCollection
        mybox.Dispose()
        mybox = Nothing

        If contents.Items > 0 Then
            id_content = contents.Item(0)
            mycontent = New CORE_CONTENT(id_content)
            If mycontent.id_key > 0 Then
                lt_content_description.Text = mycontent.content_description_replaced
                mycontent.Dispose()
                mycontent = Nothing
                lt_content_description.Dispose()
                lt_content_description = Nothing
                phStaticDetail.Visible = True
            End If
        End If

        If CORE_USER.hasProfile(CORE_USER.userProfile.administrator) Then adminClass = " class=""adminItem"" "



    End Sub
</script>

<asp:PlaceHolder ID="phStaticDetail" runat="server" Visible="false" EnableViewState="false">
<div id="box_<%=boxOption.id_box%>" <%=boxOption.serialize_key%> class="template0 draggable">
<div <%=boxStyle%>>
<div <%=adminClass %> idKey="<%=id_content%>">
<asp:literal id="lt_content_description" runat="server" EnableViewState="false"></asp:literal>
</div>
</div>
</div>
</asp:PlaceHolder> 
