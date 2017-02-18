<%@ Import namespace="System.Data"%>
<%@ Import namespace="System.Data.sqlClient"%>
<%@ Import Namespace="System.xml" %>
<%@ Import Namespace="System.io" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.Drawing.Text" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>
<%@ Import Namespace="System.web.configuration" %>

<script runat="server">

    Dim responseType As String
    Dim imagePath As String
    
    Sub page_load()
        
        imagePath = Request("imagePath")
     
        responseType = CORE.checkResponse()
             
        Select Case Request("who")
    		
           
            
            Case "imageInfo"
    	          		
                Try
                    
                    Dim img As System.Drawing.Image = New Bitmap(Server.MapPath(imagePath))
                    Dim bmpImage As Bitmap = New Bitmap(img)
                    Dim imgWidth As Integer = bmpImage.Width
                    Dim imgHeight As Integer = bmpImage.Height
                    bmpImage.Dispose()
                    img.Dispose()
                    
                    Dim myfile As FileInfo = New FileInfo(Server.MapPath(imagePath))
                    Dim fName As String = myfile.Name
                    Dim fSize As String = myfile.Length
                    myfile = Nothing
                    
                    returnData("<values><imageInfo path=""" & imagePath & """ width=""" & imgWidth & """ height=""" & imgHeight & """ size=""" & Convert.ToInt32(fSize / 1024) & """ name=""" & fName & """/><error errorId=""0"" errorLabel=""""/></values>")
                    
                Catch err As Exception
    		                    
                    returnData("<values><error errorId=""1000"" errorLabel=""resizeImage Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                Finally
               
                    
                End Try
            
    	               
            Case "cropImage"
    	          		
                Try
                    
                    
                    Dim img As System.Drawing.Image = New Bitmap(Server.MapPath(imagePath))
                    Dim bmpImage As Bitmap = New Bitmap(img)
                    img.Dispose()
                    bmpImage = CORE.cropImage(bmpImage, New Point(Convert.ToInt32(Request("cropW")), Convert.ToInt32(Request("cropH"))), New Point(Convert.ToInt32(Request("cropX")), Convert.ToInt32(Request("cropY"))), New Point(Convert.ToInt32(Request("cropX2")), Convert.ToInt32(Request("cropY2"))))
                    bmpImage.Save(Server.MapPath(imagePath), System.Drawing.Imaging.ImageFormat.Jpeg)
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                Catch err As Exception
    		                    
                    returnData("<values><error errorId=""1001"" errorLabel=""cropImage Error"" eerrorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                Finally
               
                    
                End Try
    		
                
            Case "resizeImage"
    	          		
                Try
    		        
                    Dim img As System.Drawing.Image = New Bitmap(Server.MapPath(imagePath))
                    Dim bmpImage As Bitmap = New Bitmap(img)
                    img.Dispose()
                    bmpImage = CORE.resizeImage(bmpImage, Convert.ToInt32(Request("resizeW")), Convert.ToInt32(Request("resizeH")))
                    bmpImage.Save(Server.MapPath(imagePath), System.Drawing.Imaging.ImageFormat.Jpeg)
                    returnData("<values><error errorId=""0"" errorLabel=""""/></values>")
                    
                Catch err As Exception
    		                    
                    returnData("<values><error errorId=""1002"" errorLabel=""resizeImage Error"" errorMsg=""" & Server.HtmlEncode(err.ToString()) & """/></values>")
                    
                Finally
               
                    
                End Try
    		
    		

			
			
        End Select
    		
    		
    End Sub
 
    Sub returnData(ByVal myData As String)
        If responseType = "json" Then
            Dim Doc As New XmlDocument()
            Doc.LoadXml(myData)
            Response.ContentType = "text/plain"
            Response.Write(JSON.XmlToJSON(Doc))
            Doc = Nothing
        ElseIf responseType = "jsonp" Then
            Dim Doc As New XmlDocument()
            Doc.LoadXml(myData)
            Response.ContentType = "text/plain"
            Response.Write(Request("callback") & "(" & JSON.XmlToJSON(Doc) & ")")
            Doc = Nothing
        ElseIf responseType = "xml" Then
            Response.ContentType = "text/xml"
            Response.Write(myData)
        End If

     		
    End Sub
 	
        
        </script>