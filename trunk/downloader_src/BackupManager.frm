VERSION 5.00
Begin VB.Form BackupManager 
   Caption         =   "Hosts备份管理器"
   ClientHeight    =   1884
   ClientLeft      =   5964
   ClientTop       =   4092
   ClientWidth     =   3912
   LinkTopic       =   "Form3"
   ScaleHeight     =   1884
   ScaleWidth      =   3912
   Begin VB.CommandButton Command3 
      Caption         =   "关闭"
      Height          =   372
      Left            =   2760
      TabIndex        =   4
      Top             =   1440
      Width           =   1092
   End
   Begin VB.CommandButton Command2 
      Caption         =   "恢复该备份"
      Height          =   372
      Left            =   2760
      TabIndex        =   3
      Top             =   720
      Width           =   1092
   End
   Begin VB.CommandButton Command1 
      Caption         =   "备份"
      Height          =   372
      Left            =   2760
      TabIndex        =   2
      Top             =   240
      Width           =   1092
   End
   Begin VB.Frame Frame1 
      Caption         =   "备份文件列表"
      Height          =   1692
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2532
      Begin VB.ListBox List1 
         Height          =   1308
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   2292
      End
   End
End
Attribute VB_Name = "BackupManager"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

