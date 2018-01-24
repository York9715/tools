VERSION 5.00
Begin VB.Form dirFrm 
   Caption         =   "Please search a path"
   ClientHeight    =   3390
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   5535
   Icon            =   "dirFrm.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3390
   ScaleWidth      =   5535
   StartUpPosition =   1  'µ°Å° Ì«°Ñ‚Ì’†‰›
   Begin VB.CommandButton btnExit 
      Caption         =   "EXIT"
      Height          =   255
      Left            =   4680
      TabIndex        =   3
      Top             =   120
      Width           =   615
   End
   Begin VB.CommandButton btnOK 
      Caption         =   "OK"
      Height          =   255
      Left            =   3600
      TabIndex        =   2
      Top             =   120
      Width           =   735
   End
   Begin VB.DriveListBox ctrDir 
      Height          =   300
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   1095
   End
   Begin VB.DirListBox ctrPath 
      Height          =   2610
      Left            =   1320
      TabIndex        =   0
      Top             =   600
      Width           =   4215
   End
   Begin VB.Line lineV 
      X1              =   1200
      X2              =   1200
      Y1              =   480
      Y2              =   3360
   End
   Begin VB.Line lineH 
      X1              =   0
      X2              =   5520
      Y1              =   480
      Y2              =   480
   End
End
Attribute VB_Name = "dirFrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public curDir As String
Public curPath As String

Private Sub btnOK_Click()
    main.txtPath.Text = ctrPath.Path + "\"
    Unload Me
End Sub

Private Sub Form_Load()
    If curPath = "" Then
       curPath = App.Path
    End If
    If curDir = "" Then
       curDir = App.Path
    End If
    ctrDir.Drive = curDir
    ctrPath.Path = curPath
    Call AdjPos
End Sub
Private Sub AdjPos()
    ctrPath.Width = Me.Width - ctrPath.Left - 180
    ctrPath.Height = Me.Height - ctrPath.Top - 500
    lineH.X2 = Me.Width
    lineV.Y2 = Me.Height
    
End Sub

Private Sub Form_Resize()
Call AdjPos
End Sub
