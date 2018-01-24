
import java.util.Vector;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.math.*;

public class sgsu_temp_gomi implements java.io.Serializable {

    private String INDEX_CD1;     //INDEX_CD
    private String age1;          //age
    private String name1;         //name
    private String pay1;          //pay
    private String birthday1;     //birthday

    private int INDEX_CD1SetFlg = 0;
                                   //INDEX_CD
    private int age1SetFlg = 0;    //age
    private int name1SetFlg = 0;   //name
    private int pay1SetFlg = 0;    //pay
    private int birthday1SetFlg = 0;
                                   //birthday
    private static String WHERE;
    private static String Sel;
    private static String Upd;
    private static String Ins;
    private static String Del;
    private long rcnt;
    private Vector rsltvec_;
    
    private Connection con = null;
    private Statement stmt;
    
    public sgsu_temp_gomi(){
        INDEX_CD1 = null;
        age1 = null;
        name1 = null;
        pay1 = null;
        birthday1 = null;
    
        WHERE = "";
        Sel = "SELECT TO_CHAR(INDEX_CD) AS INDEX_CD1,TO_CHAR(age) AS age1,name AS name1,TO_CHAR(pay) AS pay1,birthday AS birthday1 FROM sgsu_temp_gomi";
        Ins = "INSERT INTO sgsu_temp_gomi(INDEX_CD,age,name,pay,birthday) VALUES(";
        Upd = "UPDATE sgsu_temp_gomi SET ";
        Del = "DELETE FROM sgsu_temp_gomi";
        rcnt = 0;
    }
    
    public sgsu_temp_gomi(Connection con_){
        con = con_;
        try{
            stmt = con.createStatement();
        }catch (Exception e){
            stmt = null;
        }
        INDEX_CD1= ""; 
        age1= ""; 
        name1= ""; 
        pay1= ""; 
        birthday1= ""; 
        
        WHERE = "";
        Sel = "SELECT TO_CHAR(INDEX_CD) AS INDEX_CD1,TO_CHAR(age) AS age1,name AS name1,TO_CHAR(pay) AS pay1,birthday AS birthday1 FROM sgsu_temp_gomi";
        Ins = "INSERT INTO sgsu_temp_gomi VALUES(";
        Upd = "UPDATE sgsu_temp_gomi SET ";
        Del = "DELETE FROM sgsu_temp_gomi";
        rcnt = 0;
    }
    
    public boolean setConnection(Connection con_){
        if (con_ == null) return false;
            con = con_;
        try{
            stmt = con.createStatement();
        }catch (Exception e){
            stmt = null;
            return false;
        }
        return true;
    }
    
    public void execSetResult(ResultSet rs_ ) throws SQLException {
        rsltvec_ = new Vector();
        try{
            while( rs_.next() ){
                sgsu_temp_gomi  rslt_sgsu_temp_gomi = new sgsu_temp_gomi();
                rslt_sgsu_temp_gomi.setINDEX_CD1(rs_.getString(1));
                rslt_sgsu_temp_gomi.setAge1(rs_.getString(2));
                rslt_sgsu_temp_gomi.setName1(rs_.getString(3));
                rslt_sgsu_temp_gomi.setPay1(rs_.getString(4));
                rslt_sgsu_temp_gomi.setBirthday1(rs_.getString(5));
                rsltvec_.addElement(rslt_sgsu_temp_gomi);
            }
            setResultCnt( rsltvec_.size() );
        }catch( SQLException e ){
            throw e;
        }
    }

    public final String getInsSQL(){
        StringBuffer sql_ = new StringBuffer(Ins);
        if(( getINDEX_CD1() == null )||(getINDEX_CD1() =="")){
            sql_.append("null,");
        }else{
            sql_.append( "" + getINDEX_CD1() + ",");
        }
        if(( getAge1() == null )||(getAge1() =="")){
            sql_.append("null,");
        }else{
            sql_.append( "" + getAge1() + ",");
        }
        if( getName1() == null ){
            sql_.append("null,");
        }else{
            sql_.append( "'" + getName1() + "',");
        }
        if(( getPay1() == null )||(getPay1() =="")){
            sql_.append("null,");
        }else{
            sql_.append( "" + getPay1() + ",");
        }
        if( getBirthday1() == null ){
            sql_.append("null)");
        }else{
            sql_.append( "'" + getBirthday1() + "' )");
        }
        return sql_.toString();
    }

    public final String getUpdSQL(){
        StringBuffer sql_ = new StringBuffer(Upd);
        if (INDEX_CD1SetFlg != 0){
            if( getINDEX_CD1() == null ){
                sql_.append("INDEX_CD = null,");
            }else{
                sql_.append( "INDEX_CD = " + getINDEX_CD1() + ",");
            }
        }
        if (age1SetFlg != 0){
            if( getAge1() == null ){
                sql_.append("age = null,");
            }else{
                sql_.append( "age = " + getAge1() + ",");
            }
        }
        if (name1SetFlg != 0){
            if( getName1() == null ){
                sql_.append("name = null,");
            }else{
                sql_.append( "name = '" + getName1() + "',");
            }
        }
        if (pay1SetFlg != 0){
            if( getPay1() == null ){
                sql_.append("pay = null,");
            }else{
                sql_.append( "pay = " + getPay1() + ",");
            }
        }
        if (birthday1SetFlg != 0){
            if( getBirthday1() == null ){
                sql_.append("birthday = null ");
            }else{
            sql_.append( "birthday = '" + getBirthday1() + "'");
            }
        }
        
        String mysql = sql_.toString();
        if ((mysql.substring(sql_.length()-1,sql_.length()-0)).equals(",")){
            mysql = mysql.substring(0,sql_.length()-1);
        }
        
        return mysql + getWhere();
    }


    public final void setWhere( String where_ ){
        if( where_ == null ){
            WHERE = "";
        }else{
            WHERE = " WHERE " + where_;
        }
    }

    public final String getWhere(){
        return WHERE;
    }

    public final String getSelSQL(){
        return Sel + getWhere();
    }

    public final String getDelSQL(){
        return Del + getWhere();
    }

    public final long getResultCnt(){
        return rcnt;
    }


    public void setUpdateFlg(){
        INDEX_CD1SetFlg = 0;       //INDEX_CD
        age1SetFlg = 0;            //age
        name1SetFlg = 0;           //name
        pay1SetFlg = 0;            //pay
        birthday1SetFlg = 0;       //birthday
    }

    public final sgsu_temp_gomi exeSelect(String where_){
        where_ = where_.trim();
        if (where_.equals("")) where_= " 0 = 0";

        if ((con == null) || ( stmt == null)) return null;
        ResultSet rs1;
        setWhere(where_);

        //System.out.println("setWhere(where_)="+ where_);
        //System.out.println("getWhere(where_)="+ getWhere());

        //検索実行処理
        String mystr = getSelSQL();
        //System.out.println("getSelSQL()="+ getSelSQL());
        try{
            rs1 = stmt.executeQuery(getSelSQL());
        }catch(Exception e){
            System.out.println("exeSelect1:"+ e.getMessage());
            return null;
        }
        try{
            execSetResult(rs1);
            if (rs1 != null) {
                rs1.close();
            }
        }catch(Exception e){
            System.out.println("exeSelect2:"+ e.getMessage());
            return null;
        }
            //System.out.println("getResultCnt="+ getResultCnt());
            return this;
    }

    public final boolean execDelete(String where_){
        if ((con == null) || ( stmt == null)) return false;
        if (where_.equals("")) where_ = " 0 = 0 ";
        setWhere(where_);

        //削除実行処理
        String mysql = getDelSQL();
        //System.out.println("mysql :"+ mysql);
        try{
            stmt.executeUpdate(mysql);
        }catch(Exception e){
            System.out.println("execDelete :"+ e.getMessage());
            return false;
        }
        return true;
    }

    public final boolean execUpdate(String where_){
        if ((con == null) || ( stmt == null)) return false;

        StringBuffer sql = new StringBuffer("");
        setWhere(where_);
        //System.out.println("execUpdate:sql="+ getUpdSQL());
        //更新実行処理
        try{
            stmt.executeUpdate(getUpdSQL());
        }catch(Exception e){
            System.out.println("execUpdate :"+ e.getMessage());
            return false;
        }
        return true;
    }

    //挿入処理
    public final boolean execInsert(){
        if ((con == null) || ( stmt == null)) return false;
        try{
            stmt.executeUpdate(getInsSQL()); 
        }catch(Exception e){
            System.out.println("execInsert :"+ e.getMessage());
            return false;
        }
        return true;
    }

    public final Vector getResult(){
        return rsltvec_;
    }

    public final Vector getResult( int stcnt_ , int endcnt_ ){
        Vector rtn_ = new Vector();
        int i_;

        for(i_ =stcnt_; i_<endcnt_ + 1;i_++){
            rtn_.addElement(rsltvec_.elementAt(i_));
        }
        return rtn_;
    }

    public final void setResultCnt( long rcnt_ ){
        rcnt = rcnt_;
    }

    public final String getINDEX_CD1(){
        return INDEX_CD1;
    }
    
    public final String getAge1(){
        return age1;
    }
    
    public final String getName1(){
        return name1;
    }
    
    public final String getPay1(){
        return pay1;
    }
    
    public final String getBirthday1(){
        return birthday1;
    }
    
    public final void setINDEX_CD1(String INDEX_CD1_ ){
        INDEX_CD1SetFlg = 1; 
        INDEX_CD1 = INDEX_CD1_ ;
    }

    public final void setAge1(String age1_ ){
        age1SetFlg = 1; 
        age1 = age1_ ;
    }

    public final void setName1(String name1_ ){
        name1SetFlg = 1; 
        name1 = name1_ ;
    }

    public final void setPay1(String pay1_ ){
        pay1SetFlg = 1; 
        pay1 = pay1_ ;
    }

    public final void setBirthday1(String birthday1_ ){
        birthday1SetFlg = 1; 
        birthday1 = birthday1_ ;
    }

}
