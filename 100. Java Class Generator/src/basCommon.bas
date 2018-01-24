Attribute VB_Name = "basCommon"
Option Explicit
Global TotalFileList() As String

Public Function listAllFiles(path_ As String) As Integer
    Dim cnt As Integer
    Dim temp As String
    
    cnt = 0
    temp = Dir(path_ & "\*.*")
    Do Until temp = ""
        cnt = cnt + 1
        ReDim Preserve TotalFileList(cnt)
        TotalFileList(cnt - 1) = temp
        'MsgBox wklist(cnt - 1)
        temp = Dir
    Loop
    listAllFiles = cnt
End Function

