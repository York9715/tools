/*--------------------------------------------------------------------------*//*  ファイル名 ：                                                           *//*  処理概要   ：                                                           *//*  作成日     ：200X.01.01                                                 *//*  作成者     ：XXXX                                                       *//*  更新日     ：                                                           *//*  更新者     ：                                                           *//*  更新内容   ：                                                           *//*---------------------------------------------------------------------------*/

package tblclass;

import java.util.Vector;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.math.*;

/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
public class GomiCls implements java.io.Serializable {

	private String CMP_CD1;		
	private String NDO_CD1;		
	private String NDO_NM1;		
	private String NDO_STT_YMD1;		
	private String NDO_END_YMD1;		
	private String RECORD_NUM1;		
	private String DISP_ORDER_NUM1;		
	private String UPDATE_DATE1;		
	private String UPDATE_USER_CD1;		
	private int CMP_CD1SetFlg = 0;		
	private int NDO_CD1SetFlg = 0;		
	private int NDO_NM1SetFlg = 0;		
	private int NDO_STT_YMD1SetFlg = 0;		
	private int NDO_END_YMD1SetFlg = 0;		
	private int RECORD_NUM1SetFlg = 0;		
	private int DISP_ORDER_NUM1SetFlg = 0;		
	private int UPDATE_DATE1SetFlg = 0;		
	private int UPDATE_USER_CD1SetFlg = 0;		
	private static String WHERE;
	private static String Sel;
	private long rcnt;
	private Vector rsltvec_;

	private Connection con = null;
	private Statement stmt;

	public GomiCls(){
		CMP_CD1= null;
		NDO_CD1= null;
		NDO_NM1= null;
		NDO_STT_YMD1= null;
		NDO_END_YMD1= null;
		RECORD_NUM1= null;
		DISP_ORDER_NUM1= null;
		UPDATE_DATE1= null;
		UPDATE_USER_CD1= null;

		WHERE = "";
		Sel = "SELECT CMP_CD AS CMP_CD1,NDO_CD AS NDO_CD1,NDO_NM AS NDO_NM1,NDO_STT_YMD AS NDO_STT_YMD1,NDO_END_YMD AS NDO_END_YMD1,RECORD_NUM AS RECORD_NUM1,DISP_ORDER_NUM AS DISP_ORDER_NUM1,UPDATE_DATE AS UPDATE_DATE1,UPDATE_USER_CD AS UPDATE_USER_CD1 FROM HYK_M_NENDO";
		rcnt = 0;
	}

/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public GomiCls(Connection con_){
		con = con_;
		try{
			stmt = con.createStatement();
		}catch (Exception e){
			stmt = null;
		}
		WHERE = "";
		Sel = "SELECT CMP_CD AS CMP_CD1,NDO_CD AS NDO_CD1,NDO_NM AS NDO_NM1,NDO_STT_YMD AS NDO_STT_YMD1,NDO_END_YMD AS NDO_END_YMD1,RECORD_NUM AS RECORD_NUM1,DISP_ORDER_NUM AS DISP_ORDER_NUM1,UPDATE_DATE AS UPDATE_DATE1,UPDATE_USER_CD AS UPDATE_USER_CD1 FROM HYK_M_NENDO";
		rcnt = 0;
	}
	    
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
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
		    
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public void execSetResult(ResultSet rs_ ) throws SQLException {
		rsltvec_ = new Vector();
		try{
			while( rs_.next() ){
				GomiCls  rslt_GomiCls = new GomiCls();
				rslt_GomiCls.setCMP_CD1(rs_.getString(1));
				rslt_GomiCls.setNDO_CD1(rs_.getString(2));
				rslt_GomiCls.setNDO_NM1(rs_.getString(3));
				rslt_GomiCls.setNDO_STT_YMD1(rs_.getString(4));
				rslt_GomiCls.setNDO_END_YMD1(rs_.getString(5));
				rslt_GomiCls.setRECORD_NUM1(rs_.getString(6));
				rslt_GomiCls.setDISP_ORDER_NUM1(rs_.getString(7));
				rslt_GomiCls.setUPDATE_DATE1(rs_.getString(8));
				rslt_GomiCls.setUPDATE_USER_CD1(rs_.getString(9));
				rsltvec_.addElement(rslt_GomiCls);
			}
			setResultCnt( rsltvec_.size() );
		}catch( SQLException e ){
			throw e;
		}
	}
		
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setWhere( String where_ ){
		if( where_ == null ){
			WHERE = " 0=0 ";
		}else{
			WHERE = where_;
		}
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getWhere(){
		return WHERE;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getSelSQL(){
		return Sel +" where " + getWhere();
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final long getResultCnt(){
		return rcnt;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final GomiCls exeSelect(String where_){
		where_ = where_.trim();
		if (where_.equals("")) where_= " 0 = 0";
	
		if ((con == null) || ( stmt == null)) return null;
		setWhere(where_);
	
		//検索実行処理
		return execute();
	}

/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final GomiCls execute(){
		//検索実行処理
		String wkSQL = getSelSQL();
		ResultSet rs1;
		System.out.println("getSelSQL() = "+ wkSQL);

		if ((con == null) || ( stmt == null)) return null;

		try{
			rs1 = stmt.executeQuery(wkSQL);
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

		System.out.println("getResultCnt="+ getResultCnt());
		return this;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final Vector getResult(){
		return rsltvec_;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final Vector getResult( int stcnt_ , int endcnt_ ){
		Vector rtn_ = new Vector();
		int i_;
		
		for(i_ =stcnt_; i_<endcnt_ + 1;i_++){
			rtn_.addElement(rsltvec_.elementAt(i_));
		}
		return rtn_;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setResultCnt( long rcnt_ ){
		rcnt = rcnt_;
	}
	
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getCMP_CD1(){
		return CMP_CD1;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getNDO_CD1(){
		return NDO_CD1;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getNDO_NM1(){
		return NDO_NM1;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getNDO_STT_YMD1(){
		return NDO_STT_YMD1;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getNDO_END_YMD1(){
		return NDO_END_YMD1;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getRECORD_NUM1(){
		return RECORD_NUM1;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getDISP_ORDER_NUM1(){
		return DISP_ORDER_NUM1;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getUPDATE_DATE1(){
		return UPDATE_DATE1;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final String getUPDATE_USER_CD1(){
		return UPDATE_USER_CD1;
	}
	
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setCMP_CD1(String CMP_CD1_ ){
		CMP_CD1SetFlg = 1;
		CMP_CD1 = CMP_CD1_ ;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setNDO_CD1(String NDO_CD1_ ){
		NDO_CD1SetFlg = 1;
		NDO_CD1 = NDO_CD1_ ;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setNDO_NM1(String NDO_NM1_ ){
		NDO_NM1SetFlg = 1;
		NDO_NM1 = NDO_NM1_ ;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setNDO_STT_YMD1(String NDO_STT_YMD1_ ){
		NDO_STT_YMD1SetFlg = 1;
		NDO_STT_YMD1 = NDO_STT_YMD1_ ;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setNDO_END_YMD1(String NDO_END_YMD1_ ){
		NDO_END_YMD1SetFlg = 1;
		NDO_END_YMD1 = NDO_END_YMD1_ ;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setRECORD_NUM1(String RECORD_NUM1_ ){
		RECORD_NUM1SetFlg = 1;
		RECORD_NUM1 = RECORD_NUM1_ ;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setDISP_ORDER_NUM1(String DISP_ORDER_NUM1_ ){
		DISP_ORDER_NUM1SetFlg = 1;
		DISP_ORDER_NUM1 = DISP_ORDER_NUM1_ ;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setUPDATE_DATE1(String UPDATE_DATE1_ ){
		UPDATE_DATE1SetFlg = 1;
		UPDATE_DATE1 = UPDATE_DATE1_ ;
	}
	
/*--------------------------------------------------------------------------*//*  関数名  ：                                                              *//*  機能    ：                                                              *//*  処理概要：                                                              *//*  引数    ：                                                              *//*  復帰値  ：                                                              *//*  作成日  ：200X.01.                                                      *//*  作成者  ：XXXX                                                          *//*  更新日  ：                                                              *//*  更新者  ：                                                              *//*  更新内容：                                                              *//*--------------------------------------------------------------------------*/
	public final void setUPDATE_USER_CD1(String UPDATE_USER_CD1_ ){
		UPDATE_USER_CD1SetFlg = 1;
		UPDATE_USER_CD1 = UPDATE_USER_CD1_ ;
	}

}
