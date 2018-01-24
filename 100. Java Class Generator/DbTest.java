import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import javax.naming.*;

import util.*;

public class DbTest {

		// 接続オブジェクト。
		Connection dbConnection = null;
		// Statement オブジェクト。
		Statement dbStatement = null;

	public static void main(String arg[]){
		System.out.println("start main \n");
		DbTest t = new DbTest();
		t.setConnectin();
/*		
		t.testDelete();
		long ret = t.testSelect();
		ret = t.testInsert();
		ret = t.testSelect();
		t.testUpdate();
		ret = t.testSelect();
		System.out.println (ret);
*/
		t.disconnect();
		System.out.println ("main End!");
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
			DriverManager.getConnection(dbConnectionURL,"sk","sk");
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
		ckdc203.setPay1("20040401");
		ckdc203.setBirthday1("2005/03/31");
		ckdc203.execInsert();
		return 1;
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
		ckdc203.execDelete("INDEX_CD is not null");
		return 1;
	}


}
