VERSION 5.00
Begin VB.Form Form2 
   Caption         =   "关于和反馈"
   ClientHeight    =   1716
   ClientLeft      =   6060
   ClientTop       =   5880
   ClientWidth     =   5196
   LinkTopic       =   "Form2"
   ScaleHeight     =   1716
   ScaleWidth      =   5196
   Begin VB.TextBox Text1 
      Height          =   264
      Left            =   1080
      Locked          =   -1  'True
      TabIndex        =   5
      Text            =   "nappedbird@gmail.com"
      Top             =   840
      Width           =   2652
   End
   Begin VB.CommandButton Command1 
      Caption         =   "确定"
      Height          =   372
      Left            =   2040
      TabIndex        =   4
      Top             =   1200
      Width           =   1092
   End
   Begin VB.Label Label4 
      Caption         =   "联系作者："
      Height          =   252
      Left            =   120
      TabIndex        =   3
      Top             =   840
      Width           =   972
   End
   Begin VB.Label Label3 
      Caption         =   "https://code.google.com/p/smarthosts/"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   252
      Left            =   1080
      TabIndex        =   2
      Top             =   480
      Width           =   3972
   End
   Begin VB.Label Label2 
      Caption         =   "项目主页："
      Height          =   252
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   1212
   End
   Begin VB.Label Label1 
      Caption         =   "SmartHosts 5.1 GUI"
      Height          =   252
      Left            =   1680
      TabIndex        =   0
      Top             =   120
      Width           =   2172
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
  Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private Sub Command1_Click()
Unload Me
End Sub


Private Sub Label3_Click()
ShellExecute Me.hwnd, "open", "https://code.google.com/p/smarthosts/", "", "", 5
End Sub


Private Sub Label5_Click()

End Sub
