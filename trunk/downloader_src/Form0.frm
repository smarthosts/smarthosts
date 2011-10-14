VERSION 5.00
Begin VB.Form Form0 
   Caption         =   "Form3"
   ClientHeight    =   924
   ClientLeft      =   5916
   ClientTop       =   6432
   ClientWidth     =   3720
   LinkTopic       =   "Form0"
   ScaleHeight     =   924
   ScaleWidth      =   3720
   Begin VB.CommandButton Command1 
      Caption         =   "取消"
      Height          =   372
      Left            =   1200
      TabIndex        =   1
      Top             =   480
      Width           =   1092
   End
   Begin VB.Label Label1 
      Caption         =   "正在连接服务器更新hosts，请稍候..."
      Height          =   612
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   3252
   End
End
Attribute VB_Name = "Form0"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long
Private Declare Sub InitCommonControls Lib "comctl32.dll" ()
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Sub Command1_Click()
End
End Sub

Private Sub Form_Load()

If Dir(App.Path & "\hostsp_temp", vbDirectory) <> "" Then
CreateObject("scripting.filesystemobject").deletefolder (App.Path & "\hostsp_temp"), True
End If

MkDir (App.Path & "\hostsp_temp")
r = URLDownloadToFile(0, "https://smarthosts.googlecode.com/svn/trunk/lists", "hostsp_temp\lists", 0, 0)
r = URLDownloadToFile(0, "https://smarthosts.googlecode.com/svn/trunk/hosts", "hostsp_temp\hosts", 0, 0)

If Dir(App.Path & "\hostsp_temp\lists") = "" Then
    If Dir(App.Path & "\hostsp_temp\hosts") = "" Then
     MsgBox ("错误：列表文件下载失败。")
     End
    End If
  MsgBox ("错误：hosts文件下载失败")
  End
End If

Form1.Show
Unload Me
End Sub


