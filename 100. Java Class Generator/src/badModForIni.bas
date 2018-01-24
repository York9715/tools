Attribute VB_Name = "basModFile"
Option Explicit
'
'@********************************  INI t@CFORMAT ********************************
'   [FUNC_TITLE]
'   /*------------------------------------------------------------------------------*/
'   /*
'   /*
'   /*
'   /*
'   /*
'   /*
'   /*
'   /*
'   /*
'   /*
'   /*------------------------------------------------------------------------------*/
'
'   [FILE_TITLE]
'   /*------------------------------------------------------------------------------*/
'   /*  t@CΌ F
'   */
'   /*
'   /*
'   /*
'   /*
'   /*
'   /*
'   /*------------------------------------------------------------------------------*/
'
'   [OTHERS]
'
'   [KEY]
'   NUM=1
'   1=NO
'   2=YEAR
'   3=CODE
'
'
'   [SELECT]
'   select NAME,AGE,APT,NO,YEAR,CODE
'
'   [FROM]
'   from gomitabel
'
'   [WHERE]
'   where age<'20'
'   [CLASS_NAME]
'   ID=
'   NAME=GomiCls
'   DATE=
'
'   [MEMBER_VARIANT]
'   NUM=3
'   TYPE=Public
'   1=mem1
'   2=mem2
'   3=Mem3

'
'A********************************   how to create ********************************
'   run MakeOurFile()
'
'
'B********************************   how to use ********************************
'                GomiCls gomi = new GomiCls(dbConnection);
'                gomi.exeSelect("");
'                Vector v = gomi.getResult();
'                String myline="";
'                for(int cnt=0;cnt < v.size();cnt++){
'                    myline +=   ((GomiCls)(v.elementAt(cnt))).getNAME();
'                    System.out.println(myline);
'                }
'
'C********************************   END ********************************
Dim WK_INI_FILE_NAME As String '= "E:\work\Ώ\JAVA\DownLoad\Java\CHENWORK\ONLY1\INI\AutoCreate.ini"
Dim WK_OUT_PATH2  As String '= "E:\work\Ώ\JAVA\DownLoad\Java\CHENWORK\ONLY1\out\"
Private Const memo_position = 35

Public Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long

Public Type FileDefType
        InFileDefName As String
        InFileNum As Integer
        OutFileNameH As String
        OutFileNameCPP As String
        OutFileNum As Integer

        FUNC_TITLE As String
        FILE_TITLE As String
        OTHERS As String
        KEY_NUM As Integer
        KEY() As String

        SELECT As String
        FROM As String
        WHERE As String
        GROUPBY As String
        ORDERBY As String
        CLASS_NAME_ID As String
        CLASS_NAME_NAME As String
        CLASS_NAME_DATE As String

        MEMBER_VARIANT_NUM As Integer
        MEMBER_VARIANT_TYPE As String
        MEMBER_VARIANT() As String

        FIELD_NUM As Integer
        FIELD_MEMBER() As String

End Type

Public wkFileDefData As FileDefType
Dim my_tab_flag As Integer

Private Function MyTab(nIndex As Integer) As String
    MyTab = ""
    Dim nCnt As Integer

    If my_tab_flag = 0 Then
        For nCnt = 1 To nIndex
            MyTab = MyTab + Chr$(9)
        Next
    Else
        For nCnt = 1 To nIndex
            MyTab = MyTab + Space(4)
        Next
    End If

End Function

Private Function LoadDefText() As Integer

    Dim strLine As String
    Dim strAllLine As String
    Dim nFlag As Integer
    Dim nFlag2 As Integer

    wkFileDefData.InFileNum = FreeFile
    wkFileDefData.InFileDefName = WK_INI_FILE_NAME
    strAllLine = ""
    nFlag = 0
    nFlag2 = 0
    Open wkFileDefData.InFileDefName For Input As #wkFileDefData.InFileNum

    Do While Not EOF(wkFileDefData.InFileNum)

        Line Input #wkFileDefData.InFileNum, strLine

        If Trim(strLine) = "" Then
            GoTo nextLinePos
        End If

        If (strLine = "[FUNC_TITLE]") Then
            nFlag = 1
            nFlag2 = 0
        ElseIf (strLine = "[FILE_TITLE]") Then
            nFlag = 2
            nFlag2 = 0
        ElseIf (strLine = "[OTHERS]") Then
            nFlag = 3
            nFlag2 = 0
        ElseIf (strLine = "[KEY]") Then
            nFlag = 4
            nFlag2 = 0
        ElseIf (strLine = "[SELECT]") Then
            nFlag = 5
            nFlag2 = 0
        ElseIf (strLine = "[FROM]") Then
            nFlag = 6
            nFlag2 = 0
        ElseIf (strLine = "[WHERE]") Then
            nFlag = 7
            nFlag2 = 0
        ElseIf (strLine = "[ORDERBY]") Then
            nFlag = 8
            nFlag2 = 0
        ElseIf (strLine = "[CLASS_NAME]") Then
            nFlag = 9
            nFlag2 = 0
        ElseIf (strLine = "[MEMBER_VARIANT]") Then
            nFlag = 10
            nFlag2 = 0
        ElseIf (strLine = "[GROUPBY]") Then
            nFlag = 11
            nFlag2 = 0
        Else
            nFlag2 = 1
        End If

        If nFlag2 = 0 Then
            Select Case nFlag - 1
            Case 1 '[FUNC_TITLE]
                wkFileDefData.FUNC_TITLE = (strAllLine)
            Case 2 '[FILE_TITLE]
                wkFileDefData.FILE_TITLE = strAllLine
            Case 3 '[OTHERS]
                wkFileDefData.OTHERS = strAllLine
            Case 5 '[SELECT]
                wkFileDefData.SELECT = DeleteNextLine(strAllLine)
            Case 6 '[FROM]
                wkFileDefData.FROM = DeleteNextLine(strAllLine)
            Case 7 '[WHERE]
                wkFileDefData.WHERE = DeleteNextLine(strAllLine)
            Case 8 '[ORDERBY]
                wkFileDefData.ORDERBY = DeleteNextLine(strAllLine)
            Case 11 '[GRUOPBY]
                wkFileDefData.GROUPBY = DeleteNextLine(strAllLine)

            Case Else
            End Select
            strAllLine = ""
        Else
            If strAllLine <> "" Then
                strAllLine = strAllLine + Chr$(13) + strLine
            Else
                 strAllLine = strLine
            End If
        End If
nextLinePos:
    Loop
    Close #wkFileDefData.InFileNum

End Function

Private Function LoadDefMember() As Integer

    Dim strLine As String * 1024
    Dim nCount As Integer
    Dim ret As Long
    Dim wkstr As String

    wkFileDefData.InFileDefName = WK_INI_FILE_NAME

    strLine = ""
    nCount = 0
    ret = GetPrivateProfileString("KEY", "NUM", "", strLine, 1024, wkFileDefData.InFileDefName)
    strLine = DeleteNull(Trim(strLine))
    If (ret > 0) Then
        wkFileDefData.KEY_NUM = Val(strLine)
        If wkFileDefData.KEY_NUM > 0 Then
            ReDim wkFileDefData.KEY(wkFileDefData.KEY_NUM)
            For nCount = 1 To wkFileDefData.KEY_NUM
                strLine = ""
                ret = GetPrivateProfileString("KEY", CStr(nCount), "", strLine, 1024, wkFileDefData.InFileDefName)
                strLine = Trim(strLine)
                wkFileDefData.KEY(nCount - 1) = DeleteNull(strLine)                  'Debug.Print wkFileDefData.KEY(nCount - 1)
            Next
        End If
    End If

    strLine = ""
    nCount = 0
    ret = GetPrivateProfileString("MEMBER_VARIANT", "NUM", "", strLine, 1024, wkFileDefData.InFileDefName)
    strLine = DeleteNull(Trim(strLine))
    If (ret > 0) Then
        wkFileDefData.MEMBER_VARIANT_NUM = Val(strLine)
        If wkFileDefData.MEMBER_VARIANT_NUM > 0 Then
            ReDim wkFileDefData.MEMBER_VARIANT(wkFileDefData.MEMBER_VARIANT_NUM)
            For nCount = 1 To wkFileDefData.MEMBER_VARIANT_NUM
                strLine = ""
                ret = GetPrivateProfileString("MEMBER_VARIANT", CStr(nCount), "", strLine, 1024, wkFileDefData.InFileDefName)
                strLine = Trim(strLine)
                wkFileDefData.MEMBER_VARIANT(nCount - 1) = DeleteNull(Trim(strLine))
                'Debug.Print wkFileDefData.MEMBER_VARIANT(nCount - 1)
            Next
        End If
    End If

    strLine = ""
    ret = GetPrivateProfileString("MEMBER_VARIANT", "TYPE", "", strLine, 1024, wkFileDefData.InFileDefName)
    strLine = Trim(strLine)
    If (ret > 0) Then
        wkFileDefData.MEMBER_VARIANT_TYPE = DeleteNull(Trim(strLine))
    Else
        wkFileDefData.MEMBER_VARIANT_TYPE = "Public"
    End If


    strLine = ""
    ret = GetPrivateProfileString("CLASS_NAME", "ID", "", strLine, 1024, wkFileDefData.InFileDefName)
    If (ret > 0) Then
        wkFileDefData.CLASS_NAME_ID = DeleteNull(Trim(strLine))
    Else
        wkFileDefData.CLASS_NAME_ID = ""
    End If

    strLine = ""
    ret = GetPrivateProfileString("CLASS_NAME", "NAME", "", strLine, 1024, wkFileDefData.InFileDefName)
    wkstr = DeleteNull(Left(strLine, ret))
    If (ret > 0) Then
        wkFileDefData.CLASS_NAME_NAME = Trim(wkstr)
    Else
        wkFileDefData.CLASS_NAME_NAME = ""
    End If

    strLine = ""
    ret = GetPrivateProfileString("CLASS_NAME", "DATE", "", strLine, 1024, wkFileDefData.InFileDefName)
    strLine = Trim(strLine)
    If (ret > 0) Then
        wkFileDefData.CLASS_NAME_DATE = DeleteNull(Trim(strLine))
    Else
        wkFileDefData.CLASS_NAME_DATE = ""
    End If

End Function
Function DeleteNull(ByVal strLine As String) As String
    Dim cnt As Integer
    Dim outstrky As String
    Dim nchar As String
    nchar = ""
    outstrky = ""
    For cnt = 1 To Len(strLine)
        nchar = Mid$(strLine, cnt, 1)
        If (Asc(nchar) = 0) Then
            DeleteNull = outstrky
            Exit Function
        End If
        outstrky = outstrky + nchar
    Next
    DeleteNull = outstrky
End Function

Private Function DeleteNextLine(ByVal strLine As String) As String
    Dim cnt As Integer
    Dim outstrky As String
    Dim nchar As String
    nchar = ""
    outstrky = ""
    For cnt = 1 To Len(strLine)
        nchar = Mid$(strLine, cnt, 1)
        If (Asc(nchar) = 10) Or (Asc(nchar) = 13) Or (Asc(nchar) = 9) Then
            nchar = " "
        End If
        outstrky = outstrky + nchar
    Next
    DeleteNextLine = outstrky
End Function

Private Function GetCommaNumber(ByVal instrLine As String, ByVal strChar As String) As Integer
    Dim I As Long
    Dim mychar As String
    GetCommaNumber = 0
    For I = 1 To Len(instrLine)
        mychar = ""
        mychar = Mid(instrLine, I, 1)
        If mychar = strChar Then
            GetCommaNumber = GetCommaNumber + 1
        End If
    Next I
End Function

Private Function GetFieldName(strLine As String) As String
    Dim onechar As String
    Dim strType As String
    Dim nCount As Integer

    GetFieldName = strLine
    If Trim(strLine) = "" Then
        Exit Function
    End If


    onechar = ","
    nCount = 0
    strLine = Trim(strLine)
    Dim I As Integer
    For I = 0 To Len(strLine)
       ' Debug.Print Asc(Mid(strLine, i + 1, 1))
    Next I

    I = InStr(strLine, " AS ")
    If I > 0 Then
        GetFieldName = Trim(Right(strLine, Len(strLine) - I - 3))
        Exit Function
    End If

    I = InStr(strLine, ".")
    If I > 0 Then
        GetFieldName = Trim(Right(strLine, Len(strLine) - I))
        Exit Function
    End If

    GetFieldName = strLine
End Function

Private Function GetTotalFieldString(ByVal strLine As String, nIndex As Integer) As String
    GetTotalFieldString = ""
    Dim onechar As String
    Dim strType As String
    Dim nCount As Integer

    If Trim(strLine) = "" Then
        Exit Function
    End If

    onechar = ","
    nCount = 0
    strLine = Trim(strLine)
    Dim I As Integer
    For I = 0 To Len(strLine)
       ' Debug.Print Asc(Mid(strLine, i + 1, 1))
    Next I

    I = InStr(strLine, onechar)
    If I = 0 Then
        If nIndex = 1 Then GetTotalFieldString = strLine
        Exit Function
    End If

    Do Until I = 0
        nCount = nCount + 1
        If nCount = nIndex Then
            GetTotalFieldString = Left(strLine, I - 1)
            Exit Function
        End If
        strLine = Trim(Right(strLine, Len(strLine) - I))
        I = InStr(strLine, onechar)
    Loop

    If strLine <> "" And nCount = nIndex - 1 Then
        GetTotalFieldString = strLine
    End If

End Function

Private Function ExtractSelect() As Integer
    Dim strSqlSelect As String
    Dim strMember() As String
    Dim nMemCnt As Integer
    Dim strField As String
    Dim cnt As Integer
    Dim wkstr As String

    strSqlSelect = wkFileDefData.SELECT
    If Asc(Left(strSqlSelect, 1)) = 13 Or Asc(Left(strSqlSelect, 1)) = 10 Then
        wkFileDefData.SELECT = Right(strSqlSelect, Len(strSqlSelect) - 1)
    End If
    strSqlSelect = wkFileDefData.SELECT

    If UCase(Left(strSqlSelect, 6)) = "SELECT" Then
        strSqlSelect = Trim(Right(strSqlSelect, Len(strSqlSelect) - 6))
    End If
    nMemCnt = GetCommaNumber(strSqlSelect, ",") + 1
    For cnt = 1 To nMemCnt
        wkstr = strSqlSelect
        strField = (GetTotalFieldString(wkstr, cnt))
        strField = GetFieldName(strField)
        wkFileDefData.FIELD_NUM = cnt
        ReDim Preserve wkFileDefData.FIELD_MEMBER(cnt + 1)
        wkFileDefData.FIELD_MEMBER(cnt - 1) = strField
        'Debug.Print wkFileDefData.FIELD_MEMBER(cnt - 1)
    Next

End Function

Public Function MakeOurFile() As Integer
    WK_INI_FILE_NAME = App.Path + "\AutoCreate.ini"
    WK_OUT_PATH2 = main.txtPath.Text
    Call LoadDefText
    Call LoadDefMember
    Call ExtractSelect

    MakeOurFile = PrintJavaFile
End Function


Private Function PrintJavaFile() As Integer
    Dim strLine As String
    Dim nFlag As Integer
    Dim nFlag2 As Integer

    wkFileDefData.OutFileNum = FreeFile
    wkFileDefData.OutFileNameH = WK_OUT_PATH2 + wkFileDefData.CLASS_NAME_NAME + ".java"

    Open wkFileDefData.OutFileNameH For Output As #wkFileDefData.OutFileNum

    Call PrintTitleText2(wkFileDefData.OutFileNum)
    Call PrintDetail_Java(wkFileDefData.OutFileNum)

    Close #wkFileDefData.OutFileNum

End Function

Private Function PrintTitleText2(nFile As Integer) As Integer
    Print #nFile, wkFileDefData.FILE_TITLE
End Function

Private Function PrintFuncTitleText(nFile As Integer) As Integer
    Print #nFile, wkFileDefData.FUNC_TITLE
End Function


Private Function PrintDetail_Java(nFile As Integer) As Integer
Dim cnt As Integer

Print #nFile, ""
Print #nFile, "package tblclass;"
Print #nFile, ""
Print #nFile, "import java.util.Vector;"
Print #nFile, "import java.io.*;"
Print #nFile, "import java.util.*;"
Print #nFile, "import java.sql.*;"
Print #nFile, "import java.math.*;"
Print #nFile, ""

Call PrintFuncTitleText(nFile)
Print #nFile, "public class " + wkFileDefData.CLASS_NAME_NAME + " implements java.io.Serializable {"
Print #nFile, ""
For cnt = 0 To wkFileDefData.FIELD_NUM - 1
Print #nFile, MyTab(1) + "private String " + wkFileDefData.FIELD_MEMBER(cnt) + ";" + MyTab(2) + ""
Next

For cnt = 0 To wkFileDefData.FIELD_NUM - 1
Print #nFile, MyTab(1) + "private int " + wkFileDefData.FIELD_MEMBER(cnt) + "SetFlg = 0;" + MyTab(2) + ""
Next
Print #nFile, MyTab(1) + "private static String WHERE;"
Print #nFile, MyTab(1) + "private static String Sel;"
Print #nFile, MyTab(1) + "private long rcnt;"
Print #nFile, MyTab(1) + "private Vector rsltvec_;"
Print #nFile, ""
Print #nFile, MyTab(1) + "private Connection con = null;"
'Print #nFile, MyTab(1) + "private Statement stmt;"
Print #nFile, ""
    
Print #nFile, MyTab(1) + "public " + wkFileDefData.CLASS_NAME_NAME + "(){"

For cnt = 0 To wkFileDefData.FIELD_NUM - 1
Print #nFile, MyTab(2) + wkFileDefData.FIELD_MEMBER(cnt) + "= null;"
Next
Print #nFile, ""
    
Print #nFile, MyTab(2) + "WHERE = """ + wkFileDefData.WHERE + """;"
Print #nFile, MyTab(2) + "Sel = """ + wkFileDefData.SELECT + " " + wkFileDefData.FROM + """;"
Print #nFile, MyTab(2) + "rcnt = 0;"
Print #nFile, MyTab(1) + "}"
Print #nFile, ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public " + wkFileDefData.CLASS_NAME_NAME + "(Connection con_){"
Print #nFile, MyTab(2) + "con = con_;"
Print #nFile, MyTab(2) + "try{"
Print #nFile, MyTab(3) + "stmt = con.createStatement();"
Print #nFile, MyTab(2) + "}catch (Exception e){"
Print #nFile, MyTab(3) + "stmt = null;"
Print #nFile, MyTab(2) + "}"
        
Print #nFile, MyTab(2) + "WHERE = """ + wkFileDefData.WHERE + """;"
Print #nFile, MyTab(2) + "Sel = """ + wkFileDefData.SELECT + " " + wkFileDefData.FROM + """;"
Print #nFile, MyTab(2) + "rcnt = 0;"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(1) + "    "
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public boolean setConnection(Connection con_){"
Print #nFile, MyTab(2) + "if (con_ == null) return false;"
Print #nFile, MyTab(2) + "con = con_;"
Print #nFile, MyTab(2) + "try{"
Print #nFile, MyTab(3) + "stmt = con.createStatement();"
Print #nFile, MyTab(2) + "}catch (Exception e){"
Print #nFile, MyTab(3) + "stmt = null;"
Print #nFile, MyTab(3) + "return false;"
Print #nFile, MyTab(2) + "}"
Print #nFile, MyTab(2) + "return true;"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(2) + "    "
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public void execSetResult(ResultSet rs_ ) throws SQLException {"
Print #nFile, MyTab(2) + "rsltvec_ = new Vector();"
Print #nFile, MyTab(2) + "try{"
Print #nFile, MyTab(3) + "while( rs_.next() ){"
Print #nFile, MyTab(4) + wkFileDefData.CLASS_NAME_NAME + "  rslt_" + wkFileDefData.CLASS_NAME_NAME + " = new " + wkFileDefData.CLASS_NAME_NAME + "();"
For cnt = 0 To wkFileDefData.FIELD_NUM - 1
Print #nFile, MyTab(4) + "rslt_" + wkFileDefData.CLASS_NAME_NAME + ".set" + wkFileDefData.FIELD_MEMBER(cnt) + "(rs_.getString(" + CStr(cnt + 1) + "));"
Next
Print #nFile, MyTab(4) + "rsltvec_.addElement(rslt_" + wkFileDefData.CLASS_NAME_NAME + ");"
Print #nFile, MyTab(3) + "}"
Print #nFile, MyTab(3) + "setResultCnt( rsltvec_.size() );"
Print #nFile, MyTab(2) + "}catch( SQLException e ){"
Print #nFile, MyTab(3) + "throw e;"
Print #nFile, MyTab(2) + "}"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(2) + ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final void setWhere( String where_ ){"
Print #nFile, MyTab(2) + "if( where_ == null ){"
Print #nFile, MyTab(3) + "WHERE = "" 0=0 "";"
Print #nFile, MyTab(2) + "}else{"
Print #nFile, MyTab(3) + "WHERE = where_;"
Print #nFile, MyTab(2) + "}"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(1) + ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final String getWhere(){"
Print #nFile, MyTab(2) + "return WHERE;"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(1) + ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final String getSelSQL(){"
Print #nFile, MyTab(2) + "return Sel +"" where "" + getWhere();"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(1) + ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final long getResultCnt(){"
Print #nFile, MyTab(2) + "return rcnt;"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(1) + ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final " + wkFileDefData.CLASS_NAME_NAME + " exeSelect(String where_){"
Print #nFile, MyTab(2) + "where_ = where_.trim();"
Print #nFile, MyTab(2) + "if (where_.equals("""")) where_= "" 0 = 0"";"
Print #nFile, MyTab(1) + ""
Print #nFile, MyTab(2) + "if ((con == null) || ( stmt == null)) return null;"
Print #nFile, MyTab(2) + "setWhere(where_);"
Print #nFile, MyTab(1) + ""
Print #nFile, MyTab(2) + "//υΐs"
Print #nFile, MyTab(2) + "return execute();"
Print #nFile, MyTab(1) + "}"
Print #nFile, ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final " + wkFileDefData.CLASS_NAME_NAME + " execute(){"
Print #nFile, MyTab(2) + "//υΐs"
Print #nFile, MyTab(2) + "String wkSQL = getSelSQL();"
Print #nFile, MyTab(2) + "ResultSet rs1;"
Print #nFile, MyTab(2) + "System.out.println(""getSelSQL() = ""+ wkSQL);"
Print #nFile, ""
Print #nFile, MyTab(2) + "if ((con == null) || ( stmt == null)) return null;"
Print #nFile, ""
Print #nFile, MyTab(2) + "try{"
Print #nFile, MyTab(3) + "rs1 = stmt.executeQuery(wkSQL);"
Print #nFile, MyTab(2) + "}catch(Exception e){"
Print #nFile, MyTab(3) + "System.out.println(""exeSelect1:""+ e.getMessage());"
Print #nFile, MyTab(3) + "return null;"
Print #nFile, MyTab(2) + "}"
Print #nFile, ""
Print #nFile, MyTab(2) + "try{"
Print #nFile, MyTab(3) + "execSetResult(rs1);"
Print #nFile, MyTab(3) + "if (rs1 != null) {"
Print #nFile, MyTab(4) + "rs1.close();"
Print #nFile, MyTab(3) + "}"
Print #nFile, MyTab(2) + "}catch(Exception e){"
Print #nFile, MyTab(3) + "System.out.println(""exeSelect2:""+ e.getMessage());"
Print #nFile, MyTab(3) + "return null;"
Print #nFile, MyTab(2) + "}"
Print #nFile, ""
Print #nFile, MyTab(2) + "System.out.println(""getResultCnt=""+ getResultCnt());"
Print #nFile, MyTab(2) + "return this;"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(1) + ""

Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final Vector getResult(){"
Print #nFile, MyTab(2) + "return rsltvec_;"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(1) + ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final Vector getResult( int stcnt_ , int endcnt_ ){"
Print #nFile, MyTab(2) + "Vector rtn_ = new Vector();"
Print #nFile, MyTab(2) + "int i_;"
Print #nFile, MyTab(2) + ""
Print #nFile, MyTab(2) + "for(i_ =stcnt_; i_<endcnt_ + 1;i_++){"
Print #nFile, MyTab(3) + "rtn_.addElement(rsltvec_.elementAt(i_));"
Print #nFile, MyTab(2) + "}"
Print #nFile, MyTab(2) + "return rtn_;"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(1) + ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final void setResultCnt( long rcnt_ ){"
Print #nFile, MyTab(2) + "rcnt = rcnt_;"
Print #nFile, MyTab(1) + "}"
Print #nFile, MyTab(1) + ""
For cnt = 0 To wkFileDefData.FIELD_NUM - 1
Print #nFile, MyTab(1) + ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final String get" + wkFileDefData.FIELD_MEMBER(cnt) + "(){"
Print #nFile, MyTab(2) + "return " + wkFileDefData.FIELD_MEMBER(cnt) + ";"
Print #nFile, MyTab(1) + "}"
Next
Print #nFile, MyTab(1) + ""

For cnt = 0 To wkFileDefData.FIELD_NUM - 1
Print #nFile, MyTab(1) + ""
Call PrintFuncTitleText(nFile)
Print #nFile, MyTab(1) + "public final void set" + wkFileDefData.FIELD_MEMBER(cnt) + "(String " + wkFileDefData.FIELD_MEMBER(cnt) + "_ ){"
Print #nFile, MyTab(2) + wkFileDefData.FIELD_MEMBER(cnt) + "SetFlg = 1;"
Print #nFile, MyTab(2) + wkFileDefData.FIELD_MEMBER(cnt) + " = " + wkFileDefData.FIELD_MEMBER(cnt) + "_ ;"
Print #nFile, MyTab(1) + "}"
Next
Print #nFile, ""
Print #nFile, "}"

End Function


