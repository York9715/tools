VERSION 5.00
Begin VB.Form main 
   BorderStyle     =   1  '固定(実線)
   Caption         =   "AutoCreate"
   ClientHeight    =   2505
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8925
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2505
   ScaleWidth      =   8925
   StartUpPosition =   2  '画面の中央
   Begin VB.Frame Frame2 
      Caption         =   "Definition file"
      Height          =   855
      Left            =   6000
      TabIndex        =   9
      Top             =   840
      Width           =   2175
      Begin VB.OptionButton optRunType 
         Caption         =   "AutoCreate.ini"
         Height          =   255
         Index           =   1
         Left            =   360
         TabIndex        =   11
         Top             =   480
         Width           =   1575
      End
      Begin VB.OptionButton optRunType 
         Caption         =   "AutoCreate.mdb"
         Height          =   255
         Index           =   0
         Left            =   360
         TabIndex        =   10
         Top             =   240
         Width           =   1575
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "DB Type"
      Height          =   855
      Left            =   4080
      TabIndex        =   6
      Top             =   840
      Width           =   1695
      Begin VB.OptionButton optType 
         Caption         =   "SQL-Server"
         Height          =   180
         Index           =   1
         Left            =   120
         TabIndex        =   8
         Top             =   480
         Width           =   1215
      End
      Begin VB.OptionButton optType 
         Caption         =   "Oracle"
         Height          =   180
         Index           =   0
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access 2000;"
      DatabaseName    =   ""
      DefaultCursorType=   0  '既定値のｶｰｿﾙ
      DefaultType     =   2  'ODBC
      Exclusive       =   0   'False
      Height          =   285
      Left            =   3480
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'ﾀﾞｲﾅｾｯﾄ
      RecordSource    =   ""
      Top             =   2640
      Width           =   1140
   End
   Begin VB.CommandButton btnExit 
      Caption         =   "Exit"
      Height          =   255
      Left            =   8040
      TabIndex        =   5
      Top             =   1920
      Width           =   735
   End
   Begin VB.CommandButton btnRun 
      Caption         =   "Run"
      Height          =   255
      Left            =   6840
      TabIndex        =   4
      Top             =   1920
      Width           =   735
   End
   Begin VB.CommandButton btnExplore 
      Caption         =   "Explore"
      Height          =   255
      Left            =   8040
      TabIndex        =   3
      Top             =   360
      Width           =   735
   End
   Begin VB.DirListBox Dir1 
      Height          =   3660
      Left            =   5520
      TabIndex        =   2
      Top             =   3600
      Width           =   4815
   End
   Begin VB.TextBox txtPath 
      Height          =   270
      Left            =   1440
      TabIndex        =   0
      Top             =   360
      Width           =   6615
   End
   Begin VB.Line Line1 
      X1              =   0
      X2              =   10080
      Y1              =   1800
      Y2              =   1800
   End
   Begin VB.Label Label1 
      Caption         =   "OUTPUT PATH"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   360
      Width           =   1455
   End
End
Attribute VB_Name = "main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim WK_OUT_PATH  As String '= "C:\chen\chenwork\公開\DB\class\out\"
Dim memo_position As Integer '= 35
Dim my_tab_flag As Integer
'if SQL -server ,FUNC_STR="STR";if Oracle,FUNC_STR="TO_CHAR";
Dim FUNC_STR   As String '"TO_CHAR"
Const dbnamestr = "AutoCreate.mdb"
Dim db As Database
Function makeAllTableCls() As Integer
    memo_position = 35
    my_tab_flag = 1
    
    
        MsgBox optType(0).Value
        MsgBox optType(1).Value
    
    Exit Function
    
    Dim tbl As Recordset
    Dim tblname  As String
    Dim claname  As String
    makeAllTableCls = 0
    Set db = OpenDatabase(dbnamestr)
    Set tbl = db.OpenRecordset("SELECT First(tblName) AS mytblName, clsName FROM cls_def_tbl GROUP BY clsName")

    If tbl.BOF Then
        Print #100, "}"
        GoTo exitmakeAllTableCls
    End If

    tbl.MoveFirst
    Do Until tbl.EOF
        makeAllTableCls = makeAllTableCls + 1
        tblname = IIf(IsNull(tbl("mytblName")), "", tbl("mytblName"))
        claname = IIf(IsNull(tbl("clsName")), "", tbl("clsName"))
        MsgBox optType(0).Value
        MsgBox optType(1).Value
        'Call makeTableCls(claname, 1)
        'Debug.Print claname
        tbl.MoveNext
    Loop

exitmakeAllTableCls:

    tbl.Close
    db.Close

End Function

Function makeTableCls(clsName As String, selFiledAsFlg As Integer) As Integer


    Dim tbl As Recordset
    Dim nCount As Integer
    Dim tblid As String
    Dim tblname  As String
    Dim fieldId  As String
    Dim fieldVarName As String
    Dim fieldName As String
    Dim strProperty  As String
    Dim strType As String
    Dim strMemo As String
    Dim strKey As String
    Dim selSQLstr As String
    
    Open WK_OUT_PATH + clsName + ".java" For Output As #100

'Print #100, "package tblclass;"
Print #100, ""
Print #100, "import java.util.Vector;"
Print #100, "import java.io.*;"
Print #100, "import java.util.*;"
Print #100, "import java.sql.*;"
Print #100, "import java.math.*;"
Print #100, ""
Print #100, "public class " + clsName + " implements java.io.Serializable {"

    makeTableCls = -1
    nCount = 0
    'Set db = CurrentDb()
    Set tbl = db.OpenRecordset("select * from cls_def_tbl where clsName='" + clsName + "' order by fieldId")

    If tbl.BOF Then
        Print #100, "}"
        makeTableCls = 0
        GoTo exitFunction
    End If

    'MEMBER　VARIANT　DEFINITIATION
Print #100, ""
    tbl.MoveFirst
    selSQLstr = ""
    Do Until tbl.EOF
        tblname = IIf(IsNull(tbl("tblName")), "", tbl("tblName"))
        fieldId = IIf(IsNull(tbl("fieldId")), "", tbl("fieldId"))
        fieldName = IIf(IsNull(tbl("fieldname")), "", tbl("fieldname"))
        fieldVarName = IIf(IsNull(tbl("fieldVarName")), "", tbl("fieldVarName"))
        strProperty = IIf(IsNull(tbl("property")), "", tbl("property"))
        strType = IIf(IsNull(tbl("type")), "", tbl("type"))
        strMemo = IIf(IsNull(tbl("memo")), "", tbl("memo"))
        If selSQLstr = "" Then
            If LCase(strProperty) = "string" Then
                If selFiledAsFlg > 0 Then
                    selSQLstr = "SELECT " + fieldName + " AS " + fieldVarName + ""
                Else
                    selSQLstr = "SELECT " + fieldName + ""
                End If
            Else
                If selFiledAsFlg > 0 Then
                    selSQLstr = "SELECT " + FUNC_STR + "(" + fieldName + ") AS " + fieldVarName + ""
                Else
                    selSQLstr = "SELECT " + fieldName + ""
                End If
            End If
        Else
            If LCase(strProperty) = "string" Then
                If selFiledAsFlg > 0 Then
                    selSQLstr = selSQLstr + "," + fieldName + " AS " + fieldVarName + ""
                Else
                    selSQLstr = selSQLstr + "," + fieldName + ""
                End If
            Else
                If selFiledAsFlg > 0 Then
                    selSQLstr = selSQLstr + "," + FUNC_STR + "(" + fieldName + ") AS " + fieldVarName + ""
                Else
                    selSQLstr = selSQLstr + "," + fieldName + ""
                End If
            End If
        End If
        
'Print #100, MyTab() + strType + " " + strProperty + " " + fieldVarName + ";"; Tab(memo_position); "//" + strMemo
Print #100, MyTab() + strType + " String " + fieldVarName + ";"; Tab(memo_position); "//" + strMemo

        tbl.MoveNext
    Loop

    If (selSQLstr <> "") Then
        selSQLstr = selSQLstr + " FROM " + tblname
    Else
        selSQLstr = ""
    End If
   'MEMBER　VARIANT　DEFINITIATION for UPDATE FLAG
Print #100, ""
    tbl.MoveFirst
    Do Until tbl.EOF
        tblname = IIf(IsNull(tbl("tblName")), "", tbl("tblName"))
        fieldId = IIf(IsNull(tbl("fieldId")), "", tbl("fieldId"))
        fieldName = IIf(IsNull(tbl("fieldname")), "", tbl("fieldname"))
        fieldVarName = IIf(IsNull(tbl("fieldVarName")), "", tbl("fieldVarName"))
        strProperty = "int" 'IIf(IsNull(tbl("property")), "", tbl("property"))
        strType = IIf(IsNull(tbl("type")), "", tbl("type"))
        strMemo = IIf(IsNull(tbl("memo")), "", tbl("memo"))
        'Print #100, MyTab() + strType + MyTab() + strProperty + MyTab() + fieldVarName + "SetFlg = 0;"; Tab(memo_position + 1); "//" + strMemo
        Print #100, MyTab() + strType + " " + strProperty + " " + fieldVarName + "SetFlg = 0;"; Tab(memo_position + 1); "//" + strMemo
        
        tbl.MoveNext
    Loop

    Print #100, MyTab() + "private static String WHERE;"
    Print #100, MyTab() + "private static String Sel;"
    Print #100, MyTab() + "private static String Upd;"
    Print #100, MyTab() + "private static String Ins;"
    Print #100, MyTab() + "private static String Del;"
    Print #100, MyTab() + "private long rcnt;"
    Print #100, MyTab() + "private Vector rsltvec_;"
    Print #100, MyTab()
    Print #100, MyTab() + "private Connection con = null;"
    'Print #100, MyTab() + "private Statement stmt;"
    Print #100, MyTab()

    'Print #100, MyTab() + "public " + UCase(clsName) + "(){"
    Print #100, MyTab() + "public " + clsName + "(){"

    Dim all_fieldname As String
    all_fieldname = ""
    tbl.MoveFirst
    Do Until tbl.EOF
        tblname = IIf(IsNull(tbl("tblName")), "", tbl("tblName"))
        fieldId = IIf(IsNull(tbl("fieldId")), "", tbl("fieldId"))
        fieldName = IIf(IsNull(tbl("fieldname")), "", tbl("fieldname"))
        fieldVarName = IIf(IsNull(tbl("fieldVarName")), "", tbl("fieldVarName"))
        strProperty = IIf(IsNull(tbl("property")), "", tbl("property"))
        strType = IIf(IsNull(tbl("type")), "", tbl("type"))
        strMemo = IIf(IsNull(tbl("memo")), "", tbl("memo"))
        If all_fieldname = "" Then
            all_fieldname = fieldName
        Else
            all_fieldname = all_fieldname + "," + fieldName
        End If
        
        Print #100, MyTab() + MyTab() + fieldVarName + " = null;"
        tbl.MoveNext
    Loop

Print #100, MyTab()
Print #100, MyTab() + MyTab() + "WHERE = " + Chr$(34) + Chr$(34) + ";"
'Print #100, MyTab() + MyTab() + "Sel = " + Chr$(34) + "SELECT * FROM " + tblname; Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "Sel = " + Chr$(34) + selSQLstr; Chr$(34) + ";"
'Print #100, MyTab() + MyTab() + "Ins = " + Chr$(34) + "INSERT INTO " + tblname; " VALUES(" + Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "Ins = " + Chr$(34) + "INSERT INTO " + tblname + "(" + all_fieldname + ") VALUES(" + Chr$(34) + ";"

Print #100, MyTab() + MyTab() + "Upd = " + Chr$(34) + "UPDATE " + tblname + " SET " + Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "Del = " + Chr$(34) + "DELETE FROM " + tblname; Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "rcnt = 0;"
Print #100, MyTab() + "}"
Print #100, MyTab()

Print #100, MyTab() + "public " + clsName + "(Connection con_){"
Print #100, MyTab() + MyTab() + "con = con_;"
'Print #100, MyTab() + MyTab() + "try{"
'Print #100, MyTab() + MyTab() + MyTab() + "stmt = con.createStatement();"
'Print #100, MyTab() + MyTab() + "}catch (Exception e){"
'Print #100, MyTab() + MyTab() + MyTab() + "stmt = null;"
'Print #100, MyTab() + MyTab() + "}"

    tbl.MoveFirst
    Do Until tbl.EOF
        tblname = IIf(IsNull(tbl("tblName")), "", tbl("tblName"))
        fieldId = IIf(IsNull(tbl("fieldId")), "", tbl("fieldId"))
        fieldName = IIf(IsNull(tbl("fieldname")), "", tbl("fieldname"))
        fieldVarName = IIf(IsNull(tbl("fieldVarName")), "", tbl("fieldVarName"))
        strProperty = IIf(IsNull(tbl("property")), "", tbl("property"))
        strType = IIf(IsNull(tbl("type")), "", tbl("type"))
        strMemo = IIf(IsNull(tbl("memo")), "", tbl("memo"))
        Print #100, MyTab() + MyTab() + fieldVarName + "= """"; "
        tbl.MoveNext
    Loop

Print #100, MyTab() + MyTab() + ""
Print #100, MyTab() + MyTab() + "WHERE = " + Chr$(34) + Chr$(34) + ";"
'Print #100, MyTab() + MyTab() + "Sel = "; Chr$(34) + "SELECT * FROM " + tblname + Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "Sel = " + Chr$(34) + selSQLstr; Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "Ins = " + Chr$(34) + "INSERT INTO " + tblname + " VALUES(" + Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "Upd = " + Chr$(34) + "UPDATE " + tblname + " SET " + Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "Del = " + Chr$(34) + "DELETE FROM " + tblname + Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "rcnt = 0;"
Print #100, MyTab() + "}"
Print #100, MyTab()

Print #100, MyTab() + "public boolean setConnection(Connection con_){"
Print #100, MyTab() + MyTab() + "if (con_ == null) return false;"
Print #100, MyTab() + MyTab() + MyTab() + "con = con_;"
'Print #100, MyTab() + MyTab() + "try{"
'Print #100, MyTab() + MyTab() + MyTab() + "stmt = con.createStatement();"
'Print #100, MyTab() + MyTab() + "}catch (Exception e){"
'Print #100, MyTab() + MyTab() + MyTab() + "System.out.println("setConnection:" + e.getMessage());
'Print #100, MyTab() + MyTab() + MyTab() + "stmt = null;"
'Print #100, MyTab() + MyTab() + MyTab() + "return false;"
'Print #100, MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + "return true;"
Print #100, MyTab() + "}"
Print #100, MyTab()

Print #100, MyTab() + "public void execSetResult(ResultSet rs_ ) throws SQLException {"
Print #100, MyTab() + MyTab() + "rsltvec_ = new Vector();"
Print #100, MyTab() + MyTab() + "try{"
Print #100, MyTab() + MyTab() + MyTab() + "while( rs_.next() ){"
Print #100, MyTab() + MyTab() + MyTab() + MyTab() + clsName + "  rslt_" + clsName; " = new " + clsName + "();"
    nCount = 0
     tbl.MoveFirst
    Do Until tbl.EOF
        nCount = nCount + 1
        fieldName = IIf(IsNull(tbl("fieldname")), "", tbl("fieldname"))
        fieldVarName = IIf(IsNull(tbl("fieldVarName")), "", tbl("fieldVarName"))

        Print #100, MyTab() + MyTab() + MyTab() + MyTab(); "rslt_" + clsName + ".set" + firstUpper(fieldVarName) + "(rs_.getString(" + CStr(nCount) + "));"
        tbl.MoveNext
    Loop

Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "rsltvec_.addElement(rslt_" + clsName + ");"
Print #100, MyTab() + MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + MyTab() + "setResultCnt( rsltvec_.size() );"
Print #100, MyTab() + MyTab() + "}catch( SQLException e ){"
Print #100, MyTab() + MyTab() + MyTab() + "throw e;"
Print #100, MyTab() + MyTab() + "}"
Print #100, MyTab() + "}"
Print #100, ""


Print #100, MyTab() + "public final String getInsSQL(){"
Print #100, MyTab() + MyTab() + "StringBuffer sql_ = new StringBuffer(Ins);"

    tbl.MoveFirst
    Do Until tbl.EOF
        tblname = IIf(IsNull(tbl("tblName")), "", tbl("tblName"))
        fieldId = IIf(IsNull(tbl("fieldId")), "", tbl("fieldId"))
        fieldName = IIf(IsNull(tbl("fieldname")), "", tbl("fieldname"))
        fieldVarName = IIf(IsNull(tbl("fieldVarName")), "", tbl("fieldVarName"))
        strProperty = IIf(IsNull(tbl("property")), "", tbl("property"))
        strType = IIf(IsNull(tbl("type")), "", tbl("type"))
        strMemo = IIf(IsNull(tbl("memo")), "", tbl("memo"))

    tbl.MoveNext

    If tbl.EOF Then
        If (LCase(strProperty) <> "string") Then
            Print #100, MyTab() + MyTab() + "if (( get" + firstUpper(fieldVarName) + "() == null )||(get" + firstUpper(fieldVarName) + "() =="""")){"
        Else
            Print #100, MyTab() + MyTab() + "if( get" + firstUpper(fieldVarName) + "() == null ){"
        End If
        Print #100, MyTab() + MyTab() + MyTab() + "sql_.append(" + Chr$(34) + "null)" + Chr$(34) + ");"
        Print #100, MyTab() + MyTab() + "}else{"
        Print #100, MyTab() + MyTab() + MyTab() + "sql_.append( " + Chr$(34) + getMoji(strProperty) + Chr$(34) + " + get" + firstUpper(fieldVarName) + "() + " + Chr$(34) + getMoji(strProperty) + " )" + Chr$(34) + ");"
        Print #100, MyTab() + MyTab() + "}"
        Print #100, MyTab() + MyTab() + "return sql_.toString();"
        
    Else
       If (LCase(strProperty) <> "string") Then
        Print #100, MyTab() + MyTab() + "if(( get" + firstUpper(fieldVarName) + "() == null )||(get" + firstUpper(fieldVarName) + "() =="""")){"
       Else
        Print #100, MyTab() + MyTab() + "if( get" + firstUpper(fieldVarName) + "() == null ){"
       End If
        Print #100, MyTab() + MyTab() + MyTab() + "sql_.append(" + Chr$(34) + "null," + Chr$(34) + ");"
        Print #100, MyTab() + MyTab() + "}else{"
        Print #100, MyTab() + MyTab() + MyTab() + "sql_.append( " + Chr$(34) + getMoji(strProperty) + Chr$(34) + " + get" + firstUpper(fieldVarName) + "() + " + Chr$(34) + getMoji(strProperty) + "," + Chr$(34) + ");"
        Print #100, MyTab() + MyTab() + "}"
    End If

    Loop
    Print #100, MyTab() + "}"
    Print #100, ""


'getUpdSQL
Print #100, MyTab() + "public final String getUpdSQL(){"
Print #100, MyTab() + MyTab() + "StringBuffer sql_ = new StringBuffer(Upd);"

    tbl.MoveFirst
    Do Until tbl.EOF
        tblname = IIf(IsNull(tbl("tblName")), "", tbl("tblName"))
        fieldId = IIf(IsNull(tbl("fieldId")), "", tbl("fieldId"))
        fieldName = IIf(IsNull(tbl("fieldname")), "", tbl("fieldname"))
        fieldVarName = IIf(IsNull(tbl("fieldVarName")), "", tbl("fieldVarName"))
        strProperty = IIf(IsNull(tbl("property")), "", tbl("property"))
        strType = IIf(IsNull(tbl("type")), "", tbl("type"))
        strMemo = IIf(IsNull(tbl("memo")), "", tbl("memo"))

 tbl.MoveNext
       If tbl.EOF Then
        Print #100, MyTab() + MyTab() + "if (" + fieldVarName + "SetFlg != 0){"
        Print #100, MyTab() + MyTab() + MyTab() + "if( get" + firstUpper(fieldVarName) + "() == null ){"
        Print #100, MyTab() + MyTab() + MyTab() + MyTab(); "sql_.append(" + Chr$(34) + fieldName + " = null " + Chr$(34) + ");"
        Print #100, MyTab() + MyTab() + MyTab() + "}else{"
        Print #100, MyTab() + MyTab() + MyTab() + "sql_.append( " + Chr$(34) + fieldName + " = " + getMoji(strProperty) + Chr$(34) + " + get" + firstUpper(fieldVarName) + "() + " + Chr$(34) + getMoji(strProperty) + Chr$(34) + ");"
        Print #100, MyTab() + MyTab() + MyTab() + "}"
        Print #100, MyTab() + MyTab() + "}"
        Print #100, MyTab() + MyTab()
        Print #100, MyTab() + MyTab() + "String mysql = sql_.toString();"
        Print #100, MyTab() + MyTab() + "if ((mysql.substring(sql_.length()-1,sql_.length()-0)).equals(" + Chr$(34) + "," + Chr$(34) + ")){"
        Print #100, MyTab() + MyTab() + MyTab() + "mysql = mysql.substring(0,sql_.length()-1);"
        Print #100, MyTab() + MyTab() + "}"
        Print #100, MyTab() + MyTab()
         Print #100, MyTab() + MyTab() + "return mysql + getWhere();"
    Else
        Print #100, MyTab() + MyTab() + "if (" + fieldVarName + "SetFlg != 0){"
        Print #100, MyTab() + MyTab() + MyTab() + "if( get" + firstUpper(fieldVarName) + "() == null ){"
        Print #100, MyTab() + MyTab() + MyTab() + MyTab(); "sql_.append(" + Chr$(34) + fieldName; " = null," + Chr$(34) + ");"
        Print #100, MyTab() + MyTab() + MyTab() + "}else{"
        Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "sql_.append( " + Chr$(34) + fieldName + " = " + getMoji(strProperty) + Chr$(34) + " + get" + firstUpper(fieldVarName) + "() + " + Chr$(34) + getMoji(strProperty) + "," + Chr$(34) + ");"
        Print #100, MyTab() + MyTab() + MyTab() + "}"
        Print #100, MyTab() + MyTab() + "}"
End If

    Loop

    Print #100, MyTab() + "}"
    Print #100, ""


Print #100, ""
Print #100, MyTab() + "public final void setWhere( String where_ ){"
Print #100, MyTab() + MyTab() + "if( where_ == null ){"
Print #100, MyTab() + MyTab() + MyTab() + "WHERE = " + Chr$(34) + Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "}else{"
Print #100, MyTab() + MyTab() + MyTab() + "WHERE = " + Chr$(34) + " WHERE " + Chr$(34) + " + where_;"
Print #100, MyTab() + MyTab() + "}"
Print #100, MyTab() + "}"

Print #100, ""
Print #100, MyTab() + "public final String getWhere(){"
Print #100, MyTab() + MyTab() + "return WHERE;"
Print #100, MyTab() + "}"
Print #100, ""
Print #100, MyTab() + "public final String getSelSQL(){"
Print #100, MyTab() + MyTab() + "return Sel + getWhere();"
Print #100, MyTab() + "}"
Print #100, ""
Print #100, MyTab() + "public final String getDelSQL(){"
Print #100, MyTab() + MyTab() + "return Del + getWhere();"
Print #100, MyTab() + "}"
Print #100, ""
Print #100, MyTab() + "public final long getResultCnt(){"
Print #100, MyTab() + MyTab() + "return rcnt;"
Print #100, MyTab() + "}"
Print #100, ""
Print #100, ""


Print #100, MyTab() + "public void setUpdateFlg(){"
    tbl.MoveFirst
    Do Until tbl.EOF
        tblname = IIf(IsNull(tbl("tblName")), "", tbl("tblName"))
        fieldId = IIf(IsNull(tbl("fieldId")), "", tbl("fieldId"))
        fieldName = IIf(IsNull(tbl("fieldname")), "", tbl("fieldname"))
        fieldVarName = IIf(IsNull(tbl("fieldVarName")), "", tbl("fieldVarName"))
        strProperty = "int" 'IIf(IsNull(tbl("property")), "", tbl("property"))
        strType = IIf(IsNull(tbl("type")), "", tbl("type"))
        strMemo = IIf(IsNull(tbl("memo")), "", tbl("memo"))
        'Print #100, MyTab() + strType + MyTab() + strProperty + MyTab() + fieldVarName + "SetFlg = 0;"; Tab(memo_position + 1); "//" + strMemo
        Print #100, MyTab() + MyTab() + fieldVarName + "SetFlg = 0;"; Tab(memo_position + 1); "//" + strMemo
        
        tbl.MoveNext
    Loop
Print #100, MyTab() + "}"

Print #100, ""

Print #100, MyTab() + "public final " + clsName + " exeSelect(String where_){"
Print #100, MyTab() + MyTab() + "where_ = where_.trim();"
Print #100, MyTab() + MyTab() + "if (where_.equals(" + Chr$(34) + Chr$(34) + ")) where_= " + Chr$(34) + " 0 = 0" + Chr$(34) + ";"
Print #100, ""
Print #100, MyTab() + MyTab() + "if (con == null) return null;"
Print #100, MyTab() + MyTab() + "ResultSet rs1;"
Print #100, MyTab() + MyTab() + "Statement stmt=null;"
Print #100, MyTab() + MyTab() + "setWhere(where_);"
Print #100, ""
Print #100, MyTab() + MyTab() + "//System.out.println(" + Chr$(34) + "setWhere(where_)=" + Chr$(34) + "+ where_);"
Print #100, MyTab() + MyTab() + "//System.out.println(" + Chr$(34) + "getWhere(where_)=" + Chr$(34) + "+ getWhere());"
Print #100, ""
Print #100, MyTab() + MyTab() + "//検索実行処理"
Print #100, MyTab() + MyTab() + "String mystr = getSelSQL();"
Print #100, MyTab() + MyTab() + "//System.out.println(" + Chr$(34) + "getSelSQL()="; Chr$(34) + "+ getSelSQL());"
Print #100, MyTab() + MyTab() + "try{"
Print #100, MyTab() + MyTab() + MyTab() + "stmt = con.createStatement();"

Print #100, MyTab() + MyTab() + MyTab() + "if (stmt==null){"
Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "System.out.println(" + Chr$(34) + "検索実行処理 ERROR:stmt is null" + Chr$(34) + ");"
Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "return null;"
Print #100, MyTab() + MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + MyTab() + "rs1 = stmt.executeQuery(getSelSQL());"
Print #100, MyTab() + MyTab() + "}catch(Exception e){"
Print #100, MyTab() + MyTab() + MyTab() + "try{if (stmt!=null)stmt.close();}catch(Exception e_){};"
Print #100, MyTab() + MyTab() + MyTab() + "System.out.println(" + Chr$(34) + "exeSelect1:" + Chr$(34) + "+ e.getMessage());"
Print #100, MyTab() + MyTab() + MyTab() + "return null;"
Print #100, MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + "try{"
Print #100, MyTab() + MyTab() + MyTab() + "execSetResult(rs1);"
Print #100, MyTab() + MyTab() + MyTab() + "if (rs1 != null) {"
Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "rs1.close();"
Print #100, MyTab() + MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + "}catch(Exception e){"
Print #100, MyTab() + MyTab() + MyTab() + "try{if (stmt!=null)stmt.close();}catch(Exception e_){};"
Print #100, MyTab() + MyTab() + MyTab() + "System.out.println(" + Chr$(34) + "exeSelect2:" + Chr$(34) + "+ e.getMessage());"
Print #100, MyTab() + MyTab() + MyTab() + "return null;"
Print #100, MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + MyTab() + "//System.out.println(" + Chr$(34) + "getResultCnt=" + Chr$(34) + "+ getResultCnt());"
Print #100, MyTab() + MyTab() + MyTab() + "try{if (stmt!=null)stmt.close();}catch(Exception e_){};"
Print #100, MyTab() + MyTab() + MyTab() + "return this;"
Print #100, MyTab() + "}"
Print #100, ""

Print #100, MyTab() + "public final boolean execDelete(String where_){"
Print #100, MyTab() + MyTab() + "if (con == null) return false;"
Print #100, MyTab() + MyTab() + "Statement stmt=null;"
Print #100, MyTab() + MyTab() + "if (where_.equals(" + Chr$(34) + Chr$(34) + ")) where_ = " + Chr$(34) + " 0 = 0 " + Chr$(34) + ";"
Print #100, MyTab() + MyTab() + "setWhere(where_);"
Print #100, ""
Print #100, MyTab() + MyTab() + "//削除実行処理"
Print #100, MyTab() + MyTab() + "String mysql = getDelSQL();"
Print #100, MyTab() + MyTab() + "//System.out.println(" + Chr$(34) + "mysql :" + Chr$(34) + "+ mysql);"
Print #100, MyTab() + MyTab() + "try{"
Print #100, MyTab() + MyTab() + MyTab() + "stmt = con.createStatement();"
Print #100, MyTab() + MyTab() + MyTab() + "if (stmt==null){"
Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "System.out.println(" + Chr$(34) + "削除実行処理 ERROR:stmt is null" + Chr$(34) + ");"
Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "return false;"
Print #100, MyTab() + MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + MyTab() + "stmt.executeUpdate(mysql);"
Print #100, MyTab() + MyTab() + "}catch(Exception e){"
Print #100, MyTab() + MyTab() + MyTab() + "System.out.println(" + Chr$(34) + "execDelete :" + Chr$(34) + "+ e.getMessage());"
Print #100, MyTab() + MyTab() + MyTab() + "try{if (stmt!=null)stmt.close();}catch(Exception e_){};"
Print #100, MyTab() + MyTab() + MyTab() + "return false;"
Print #100, MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + MyTab() + "try{if (stmt!=null)stmt.close();}catch(Exception e_){};"
Print #100, MyTab() + MyTab() + "return true;"
Print #100, MyTab() + "}"
Print #100, ""


Print #100, MyTab() + "public final boolean execUpdate(String where_){"
Print #100, MyTab() + MyTab() + "if (con == null) return false;"
Print #100, MyTab() + MyTab() + "Statement stmt=null;"

Print #100, ""
Print #100, MyTab() + MyTab() + "StringBuffer sql = new StringBuffer(" + Chr$(34) + Chr$(34) + ");"
Print #100, MyTab() + MyTab() + "setWhere(where_);"
Print #100, MyTab() + MyTab() + "//System.out.println(" + Chr(34) + "execUpdate:sql=" + Chr$(34) + "+ getUpdSQL());"
Print #100, MyTab() + MyTab() + "//更新実行処理"
Print #100, MyTab() + MyTab() + "try{"
Print #100, MyTab() + MyTab() + MyTab() + "stmt = con.createStatement();"
Print #100, MyTab() + MyTab() + MyTab() + "if (stmt==null){"
Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "System.out.println(" + Chr$(34) + "更新実行処理 ERROR:stmt is null" + Chr$(34) + ");"

Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "return false;"
Print #100, MyTab() + MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + MyTab() + "stmt.executeUpdate(getUpdSQL());"
Print #100, MyTab() + MyTab() + "}catch(Exception e){"
Print #100, MyTab() + MyTab() + MyTab() + "System.out.println(" + Chr$(34) + "execUpdate :" + Chr$(34) + "+ e.getMessage());"
Print #100, MyTab() + MyTab() + MyTab() + "try{if (stmt!=null)stmt.close();}catch(Exception e_){};"
Print #100, MyTab() + MyTab() + MyTab() + "return false;"
Print #100, MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + MyTab() + "try{if (stmt!=null)stmt.close();}catch(Exception e_){};"
Print #100, MyTab() + MyTab() + "return true;"
Print #100, MyTab() + "}"
Print #100, ""

Print #100, MyTab() + "//挿入処理"
Print #100, MyTab() + "public final boolean execInsert(){"
Print #100, MyTab() + MyTab() + "if (con == null) return false;"
Print #100, MyTab() + MyTab() + "Statement stmt=null;"

Print #100, MyTab() + MyTab() + "try{"
Print #100, MyTab() + MyTab() + MyTab() + "stmt = con.createStatement();"
Print #100, MyTab() + MyTab() + MyTab() + "if (stmt==null){"
Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "System.out.println(" + Chr$(34) + "挿入処理 ERROR:stmt is null" + Chr$(34) + ");"

Print #100, MyTab() + MyTab() + MyTab() + MyTab() + "return false;"
Print #100, MyTab() + MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + MyTab() + "stmt.executeUpdate(getInsSQL()); "
Print #100, MyTab() + MyTab() + "}catch(Exception e){"
Print #100, MyTab() + MyTab() + MyTab() + "try{if (stmt!=null)stmt.close();}catch(Exception e_){};"

Print #100, MyTab() + MyTab() + MyTab() + "System.out.println(" + Chr$(34) + "execInsert :" + Chr$(34) + "+ e.getMessage());"
Print #100, MyTab() + MyTab() + MyTab() + "return false;"
Print #100, MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + MyTab() + "try{if (stmt!=null)stmt.close();}catch(Exception e_){};"

Print #100, MyTab() + MyTab() + "return true;"
Print #100, MyTab() + "}"
Print #100, ""

Print #100, MyTab() + "public final Vector getResult(){"
Print #100, MyTab() + MyTab() + "return rsltvec_;"
Print #100, MyTab() + "}"
Print #100, ""

Print #100, MyTab() + "public final Vector getResult( int stcnt_ , int endcnt_ ){"
Print #100, MyTab() + MyTab() + "Vector rtn_ = new Vector();"
Print #100, MyTab() + MyTab() + "int i_;"
Print #100, ""
Print #100, MyTab() + MyTab() + "for(i_ =stcnt_; i_<endcnt_ + 1;i_++){"
Print #100, MyTab() + MyTab() + MyTab() + "rtn_.addElement(rsltvec_.elementAt(i_));"
Print #100, MyTab() + MyTab() + "}"
Print #100, MyTab() + MyTab() + "return rtn_;"
Print #100, MyTab() + "}"
Print #100, ""

Print #100, MyTab() + "public final void setResultCnt( long rcnt_ ){"
Print #100, MyTab() + MyTab() + "rcnt = rcnt_;"
Print #100, MyTab() + "}"
Print #100, ""


'    public final String getJpecPlanNo(){
'        return jpecPlanNo;
'    }
    tbl.MoveFirst
    Do Until tbl.EOF
        tblname = IIf(IsNull(tbl("tblName")), "", tbl("tblName"))
        fieldId = IIf(IsNull(tbl("fieldId")), "", tbl("fieldId"))
        fieldName = IIf(IsNull(tbl("fieldname")), "", tbl("fieldname"))
        fieldVarName = IIf(IsNull(tbl("fieldVarName")), "", tbl("fieldVarName"))
        strProperty = IIf(IsNull(tbl("property")), "", tbl("property"))
        strType = IIf(IsNull(tbl("type")), "", tbl("type"))
        strMemo = IIf(IsNull(tbl("memo")), "", tbl("memo"))

        Print #100, MyTab() + "public final String get" + firstUpper(fieldVarName) + "(){"
        Print #100, MyTab() + MyTab() + "return " + fieldVarName + ";"
        Print #100, MyTab() + "}"
        Print #100, MyTab() + ""
        tbl.MoveNext
    Loop

'    public final void setJpecPlanNo(String jpecPlanNo_ ){
'        jpecPlanNo = jpecPlanNo_ ;
'    }

    tbl.MoveFirst
    Do Until tbl.EOF
        tblname = IIf(IsNull(tbl("tblName")), "", tbl("tblName"))
        fieldId = IIf(IsNull(tbl("fieldId")), "", tbl("fieldId"))
        fieldName = IIf(IsNull(tbl("fieldname")), "", tbl("fieldname"))
        fieldVarName = IIf(IsNull(tbl("fieldVarName")), "", tbl("fieldVarName"))
        strProperty = IIf(IsNull(tbl("property")), "", tbl("property"))
        strType = IIf(IsNull(tbl("type")), "", tbl("type"))
        strMemo = IIf(IsNull(tbl("memo")), "", tbl("memo"))

        Print #100, MyTab() + "public final void set" + firstUpper(fieldVarName) + "(String " + fieldVarName + "_ ){"
        Print #100, MyTab() + MyTab() + fieldVarName + "SetFlg" + " = 1; "
        Print #100, MyTab() + MyTab() + fieldVarName + " = " + fieldVarName + "_ ;"
        Print #100, MyTab() + "}"

        Print #100, ""
        tbl.MoveNext
    Loop
'end if this function
    Print #100, "}"
    Close #100

exitFunction:

    tbl.Close

    makeTableCls = nCount

End Function

Function getMoji(strProperty As String) As String
    If LCase(strProperty) = "string" Then
         getMoji = "'"
    Else
        getMoji = ""
    End If
    
End Function

Function firstUpper(item As String) As String

    Dim wkstr As String
    Dim wkword As String

    wkstr = Trim(item)

    If Len(wkstr) = 0 Then
        firstUpper = ""
        Exit Function
    End If

    wkstr = UCase(Left$(wkstr, 1)) + Right$(wkstr, Len(wkstr) - 1)

    firstUpper = wkstr

End Function


Function MyTab() As String
    If my_tab_flag = 0 Then
        MyTab = Chr$(9)
    Else
        MyTab = Space(4)
    End If

End Function

Private Sub btnExit_Click()
    Call listAllFiles(App.Path)
    Unload Me
End Sub

Private Sub btnExplore_Click()
    dirFrm.Show
    dirFrm.ctrDir = txtPath.Text
    dirFrm.ctrPath = txtPath.Text
    
End Sub

Private Sub btnRun_Click()
    Call Create_Directory(txtPath.Text)
    Dim wkpath As String
    wkpath = txtPath.Text
    If Right(txtPath.Text, 1) = "\" Then
        wkpath = Left(txtPath.Text, Len(txtPath.Text) - 1)
    End If
    
    If (Dir(txtPath.Text) = "") Then
        'MsgBox txtPath.Text + "が存在しません、作成してください。"
        'Exit Sub
    End If
    Dim ret As Integer
    Me.MousePointer = 9
    If (optRunType(1).Value = True) Then
        Call runIniCreate
    Else
        Call runTblCreate
    End If
    Me.MousePointer = 0
End Sub
Private Sub runIniCreate()
    Dim ret As Integer
    If (Dir(App.Path + "\AutoCreate.ini")) = "" Then
        MsgBox "初期設定INIがない。"
    Else
        WK_OUT_PATH = txtPath.Text
        If (Right(WK_OUT_PATH, 1) <> "\") Then
            WK_OUT_PATH = WK_OUT_PATH + "\"
        End If
        If Dir(WK_OUT_PATH) = "" Then
            'MkDir (WK_OUT_PATH)
        End If
        If Dir$(WK_OUT_PATH + "*.*") = "" Then
            'MsgBox WK_OUT_PATH + " is not exist."
            'Exit Sub
        End If
        
        FUNC_STR = "TO_CHAR"
        If (optType(1).Value = True) Then
            FUNC_STR = "STR"
        End If
        ret = MakeOurFile
        MsgBox "Class has been created"
    End If

End Sub
Private Sub runTblCreate()
    Dim ret As Integer
    If (Dir(App.Path + "\AutoCreate.mdb")) = "" Then
        MsgBox "初期設定DBがない。"
    Else
        WK_OUT_PATH = txtPath.Text
        If (Right(WK_OUT_PATH, 1) <> "\") Then
            WK_OUT_PATH = WK_OUT_PATH + "\"
        End If
        If Dir(WK_OUT_PATH) = "" Then
            'MkDir (WK_OUT_PATH)
        End If
        If Dir$(WK_OUT_PATH + "*.*") = "" Then
            'MsgBox WK_OUT_PATH + " is not exist."
            'Exit Sub
        End If
        
        FUNC_STR = "TO_CHAR"
        If (optType(1).Value = True) Then
            FUNC_STR = "STR"
        End If
        ret = makeAllTableCls
        MsgBox CStr(ret) + " classed have been created"
    End If
End Sub

Private Sub Form_Load()
    optRunType(0).Value = True
    optType(0).Value = True
    txtPath.Text = App.Path + "\out\"
    Dir1.Path = App.Path
End Sub

