Attribute VB_Name = "Module1"
Dim AppDisk As String
Dim Aa As String
Dim i As Integer
Dim a As Integer
Dim FName As String
Dim hosts As String

Private Declare Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long
Private Declare Sub InitCommonControls Lib "comctl32.dll" ()
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Private FirstFile As String



