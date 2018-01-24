
import java.util.Vector;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.math.*;

public class MyTable implements java.io.Serializable {

	LONG String id;
//
	VARCHAR2 String name;
//
	DATE String date;
//
	TIMESTAMP String time;
//
	NUMBER String age;
//
	nvarchar2(4086) String address;
//
	BLOB String ;
//
	rowid String rowid;
//
	long String serialID;
//
	float String money;
//
	 String memo;
//

	LONG LONG idSetFlg = 0;
//
	VARCHAR2 VARCHAR2 nameSetFlg = 0;
//
	DATE DATE dateSetFlg = 0;
//
	TIMESTAMP TIMESTAMP timeSetFlg = 0;
//
	NUMBER NUMBER ageSetFlg = 0;
//
	nvarchar2(4086) nvarchar2(4086) addressSetFlg = 0;
//
	BLOB BLOB SetFlg = 0;
//
	rowid rowid rowidSetFlg = 0;
//
	long long serialIDSetFlg = 0;
//
	float float moneySetFlg = 0;
//
	  memoSetFlg = 0;
//
	private static String WHERE;
	private static String Sel;
	private static String Upd;
	private static String Ins;
	private static String Del;
	private long rcnt;
	private Vector rsltvec_;
	
	private Connection con = null;
	private Statement stmt;
	
	public MyTable(){
		id = null;
		name = null;
		date = null;
		time = null;
		age = null;
		address = null;
		 = null;
		rowid = null;
		serialID = null;
		money = null;
		memo = null;
	
		WHERE = "";
		Sel = "SELECT (id) AS id,(name) AS name,(date) AS date,(time) AS time,(age) AS age,(address) AS address,() AS ,(rowid) AS rowid,(serialID) AS serialID,(money) AS money,(memo) AS memo FROM MyTable";
		Ins = "INSERT INTO MyTable(id,name,date,time,age,address,,rowid,serialID,money,memo) VALUES(";
		Upd = "UPDATE MyTable SET ";
		Del = "DELETE FROM MyTable";
		rcnt = 0;
	}
	
	public MyTable(Connection con_){
		con = con_;
		try{
			stmt = con.createStatement();
		}catch (Exception e){
			stmt = null;
		}
		id= ""; 
		name= ""; 
		date= ""; 
		time= ""; 
		age= ""; 
		address= ""; 
		= ""; 
		rowid= ""; 
		serialID= ""; 
		money= ""; 
		memo= ""; 
		
		WHERE = "";
		Sel = "SELECT (id) AS id,(name) AS name,(date) AS date,(time) AS time,(age) AS age,(address) AS address,() AS ,(rowid) AS rowid,(serialID) AS serialID,(money) AS money,(memo) AS memo FROM MyTable";
		Ins = "INSERT INTO MyTable VALUES(";
		Upd = "UPDATE MyTable SET ";
		Del = "DELETE FROM MyTable";
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
				MyTable  rslt_MyTable = new MyTable();
				rslt_MyTable.setId(rs_.getString(1));
				rslt_MyTable.setName(rs_.getString(2));
				rslt_MyTable.setDate(rs_.getString(3));
				rslt_MyTable.setTime(rs_.getString(4));
				rslt_MyTable.setAge(rs_.getString(5));
				rslt_MyTable.setAddress(rs_.getString(6));
				rslt_MyTable.set(rs_.getString(7));
				rslt_MyTable.setRowid(rs_.getString(8));
				rslt_MyTable.setSerialID(rs_.getString(9));
				rslt_MyTable.setMoney(rs_.getString(10));
				rslt_MyTable.setMemo(rs_.getString(11));
				rsltvec_.addElement(rslt_MyTable);
			}
			setResultCnt( rsltvec_.size() );
		}catch( SQLException e ){
			throw e;
		}
	}

	public final String getInsSQL(){
		StringBuffer sql_ = new StringBuffer(Ins);
		if(( getId() == null )||(getId() =="")){
			sql_.append("null,");
		}else{
			sql_.append( "" + getId() + ",");
		}
		if(( getName() == null )||(getName() =="")){
			sql_.append("null,");
		}else{
			sql_.append( "" + getName() + ",");
		}
		if(( getDate() == null )||(getDate() =="")){
			sql_.append("null,");
		}else{
			sql_.append( "" + getDate() + ",");
		}
		if(( getTime() == null )||(getTime() =="")){
			sql_.append("null,");
		}else{
			sql_.append( "" + getTime() + ",");
		}
		if(( getAge() == null )||(getAge() =="")){
			sql_.append("null,");
		}else{
			sql_.append( "" + getAge() + ",");
		}
		if(( getAddress() == null )||(getAddress() =="")){
			sql_.append("null,");
		}else{
			sql_.append( "" + getAddress() + ",");
		}
		if(( get() == null )||(get() =="")){
			sql_.append("null,");
		}else{
			sql_.append( "" + get() + ",");
		}
		if(( getRowid() == null )||(getRowid() =="")){
			sql_.append("null,");
		}else{
			sql_.append( "" + getRowid() + ",");
		}
		if(( getSerialID() == null )||(getSerialID() =="")){
			sql_.append("null,");
		}else{
			sql_.append( "" + getSerialID() + ",");
		}
		if(( getMoney() == null )||(getMoney() =="")){
			sql_.append("null,");
		}else{
			sql_.append( "" + getMoney() + ",");
		}
		if (( getMemo() == null )||(getMemo() =="")){
			sql_.append("null)");
		}else{
			sql_.append( "" + getMemo() + " )");
		}
		return sql_.toString();
	}

	public final String getUpdSQL(){
		StringBuffer sql_ = new StringBuffer(Upd);
		if (idSetFlg != 0){
			if( getId() == null ){
				sql_.append("id = null,");
			}else{
				sql_.append( "id = " + getId() + ",");
			}
		}
		if (nameSetFlg != 0){
			if( getName() == null ){
				sql_.append("name = null,");
			}else{
				sql_.append( "name = " + getName() + ",");
			}
		}
		if (dateSetFlg != 0){
			if( getDate() == null ){
				sql_.append("date = null,");
			}else{
				sql_.append( "date = " + getDate() + ",");
			}
		}
		if (timeSetFlg != 0){
			if( getTime() == null ){
				sql_.append("time = null,");
			}else{
				sql_.append( "time = " + getTime() + ",");
			}
		}
		if (ageSetFlg != 0){
			if( getAge() == null ){
				sql_.append("age = null,");
			}else{
				sql_.append( "age = " + getAge() + ",");
			}
		}
		if (addressSetFlg != 0){
			if( getAddress() == null ){
				sql_.append("address = null,");
			}else{
				sql_.append( "address = " + getAddress() + ",");
			}
		}
		if (SetFlg != 0){
			if( get() == null ){
				sql_.append(" = null,");
			}else{
				sql_.append( " = " + get() + ",");
			}
		}
		if (rowidSetFlg != 0){
			if( getRowid() == null ){
				sql_.append("rowid = null,");
			}else{
				sql_.append( "rowid = " + getRowid() + ",");
			}
		}
		if (serialIDSetFlg != 0){
			if( getSerialID() == null ){
				sql_.append("serialID = null,");
			}else{
				sql_.append( "serialID = " + getSerialID() + ",");
			}
		}
		if (moneySetFlg != 0){
			if( getMoney() == null ){
				sql_.append("money = null,");
			}else{
				sql_.append( "money = " + getMoney() + ",");
			}
		}
		if (memoSetFlg != 0){
			if( getMemo() == null ){
				sql_.append("memo = null ");
			}else{
			sql_.append( "memo = " + getMemo() + "");
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
		idSetFlg = 0;
//
		nameSetFlg = 0;
//
		dateSetFlg = 0;
//
		timeSetFlg = 0;
//
		ageSetFlg = 0;
//
		addressSetFlg = 0;
//
		SetFlg = 0;
//
		rowidSetFlg = 0;
//
		serialIDSetFlg = 0;
//
		moneySetFlg = 0;
//
		memoSetFlg = 0;
//
	}

	public final MyTable exeSelect(String where_){
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

	public final String getId(){
		return id;
	}
	
	public final String getName(){
		return name;
	}
	
	public final String getDate(){
		return date;
	}
	
	public final String getTime(){
		return time;
	}
	
	public final String getAge(){
		return age;
	}
	
	public final String getAddress(){
		return address;
	}
	
	public final String get(){
		return ;
	}
	
	public final String getRowid(){
		return rowid;
	}
	
	public final String getSerialID(){
		return serialID;
	}
	
	public final String getMoney(){
		return money;
	}
	
	public final String getMemo(){
		return memo;
	}
	
	public final void setId(String id_ ){
		idSetFlg = 1; 
		id = id_ ;
	}

	public final void setName(String name_ ){
		nameSetFlg = 1; 
		name = name_ ;
	}

	public final void setDate(String date_ ){
		dateSetFlg = 1; 
		date = date_ ;
	}

	public final void setTime(String time_ ){
		timeSetFlg = 1; 
		time = time_ ;
	}

	public final void setAge(String age_ ){
		ageSetFlg = 1; 
		age = age_ ;
	}

	public final void setAddress(String address_ ){
		addressSetFlg = 1; 
		address = address_ ;
	}

	public final void set(String _ ){
		SetFlg = 1; 
		 = _ ;
	}

	public final void setRowid(String rowid_ ){
		rowidSetFlg = 1; 
		rowid = rowid_ ;
	}

	public final void setSerialID(String serialID_ ){
		serialIDSetFlg = 1; 
		serialID = serialID_ ;
	}

	public final void setMoney(String money_ ){
		moneySetFlg = 1; 
		money = money_ ;
	}

	public final void setMemo(String memo_ ){
		memoSetFlg = 1; 
		memo = memo_ ;
	}

}
