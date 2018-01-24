import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import javax.naming.*;

import util.*;

public class autoClsTst {

		// 接続オブジェクト。
		Connection dbConnection = null;
		// Statement オブジェクト。
		Statement dbStatement = null;

	public static void main(String arg[]){
		System.out.println("start main \n");
		autoClsTst t = new autoClsTst();
		autoClsTst tIns = new autoClsTst();
		long ret;
		t.setConnectin();
		//t.testDelete();
		//long ret = t.testSelect();
		System.out.println(" testInsert starat");
		ret = t.testInsert();
		//ret = t.testSelect();
		t.testUpdate();
		ret = t.testSelect();
		t.testDelete();
		//ret = t.testSelect();
		//System.out.println (ret);
		t.disconnect();

	}

	public void disconnect(){
		// クリーン アップ。
		try {
			if (dbStatement != null) {
					dbStatement.close();
			}
			if (dbConnection != null) {
					dbConnection.close();
			}
		}catch (SQLException sqlex) {
			System.out.println("<p>SQL exception in finally block");
		}
	}

	public void setConnectin(){
		// JDBC ドライバ。
		String dbDriverName = "oracle.jdbc.driver.OracleDriver";
		// 接続 URL。
		String dbConnectionURL = "jdbc:oracle:thin:@172.22.144.200:1521:thunder";
		// 結果セット オブジェクト
		ResultSet dbResultSet = null;

		// db アクセス コードの開始。
		try {
			// JDBC ドライバ インスタンスの作成。
			Class.forName(dbDriverName).newInstance();

			//接続の作成
			dbConnection = 
			DriverManager.getConnection(dbConnectionURL,"skb","skb");
			if (dbConnection==null){
				System.out.println("接続の作成 error");
			}
		}catch (Exception e){
			System.out.println("<p>Exception in main try block");
			System.out.println(e.getMessage());
		}

	}

	public long testSelect(){
		sgsu_temp_gomi ckdc203 = new sgsu_temp_gomi(dbConnection);
		ckdc203.exeSelect(" age is not null");
		Vector chen = ckdc203.getResult();
		for(int cnt=0;cnt < chen.size();cnt++){
			String myline="";
			myline += 	((sgsu_temp_gomi)(chen.elementAt(cnt))).getName1();
			System.out.println(myline);
		}

		System.out.println(chen.size());
		return chen.size();
	}

	public long testInsert(){
		sgsu_temp_gomi ckdc203 = new sgsu_temp_gomi(dbConnection);
		ckdc203.setINDEX_CD1("12");
		ckdc203.setAge1("23");
		ckdc203.setName1("なめえ１年度");
		ckdc203.setPay1("200.041");
		ckdc203.setBirthday1("2005/03/31");
		if (ckdc203.execInsert()){
			System.out.println("execInsert OK");
			return 1;
		}else{
			System.out.println("execInsert NG");
			return 0;
		}
		
	}

	public long testUpdate(){
		sgsu_temp_gomi ckdc203 = new sgsu_temp_gomi(dbConnection);
		//ckdc203.setINDEX_CD1("12");
		ckdc203.setAge1("33");
		ckdc203.setName1("めえ年度");
		ckdc203.setPay1("4444401");
		ckdc203.setBirthday1("2005/07/31");
		ckdc203.execUpdate("INDEX_CD=12");
		return 1;
	}

	public long testDelete(){
		sgsu_temp_gomi ckdc203 = new sgsu_temp_gomi(dbConnection);
		ckdc203.execDelete("INDEX_CD=12");
		return 1;
	}

	public String []getTag(String strSELECT_) {
		String wkstr=strSELECT_.replace('	', ' ');
		String []a = wkstr.split(",");
		for (int i=0;i<a.length;i++){
			a[i]=a[i].trim();
			a[i]=a[i].toUpperCase();
			int idx=a[i].lastIndexOf(" AS ");
			if (idx>0) {
					a[i]=a[i].substring(idx + 4,a[i].length());
			}
		}
		return a;
	}

	public int getColCount(String strSELECT_){
		String wkstr=strSELECT_.replace('	', ' ');
		String []a = wkstr.split(",");
		return a.length;
	}

}
