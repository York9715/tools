1.テーブルクラスの共通クラスの作成方法：
いまの状態はSELECTだけ使える。
DELETE、UPDATE、INSERTなどのB操作ができている。
①q_output.xlsの内容でテーブルを定義する。
②q_output.xlsの内容をTABLE「cls_def_tbl」にIMPORTする。
③MODULEのmakeTblClsFrmDbの関数「makeAllTableCls()」を実行し、全テーブルのデータクラスを作成する。

テスト方法：
		public long testSelect(){
				KikenD ckdc203 = new KikenD(dbConnection);
				ckdc203.exeSelect("Shape_ID=123");
				Vector gomi = ckdc203.getResult();
				for(int cnt=0;cnt < gomi.size();cnt++){
					String myline="";
					myline +=((KikenD)(gomi.elementAt(cnt))).getShpID();
					myline +="," + ((KikenD)(gomi.elementAt(cnt))).getNo1();
					myline +="," + ((KikenD)(gomi.elementAt(cnt))).getNo2();
					myline +="," + ((KikenD)(gomi.elementAt(cnt))).getDistrict();
					myline +="," + ((KikenD)(gomi.elementAt(cnt))).getKokumin();
					myline +="," + ((KikenD)(gomi.elementAt(cnt))).getCity();
					myline +="," + ((KikenD)(gomi.elementAt(cnt))).getDaji();
					myline +="," + ((KikenD)(gomi.elementAt(cnt))).getJi();
					myline +="," + ((KikenD)(gomi.elementAt(cnt))).getLinhan();
					System.out.println(myline);
				}
				System.out.println(gomi.size());
				return gomi.size();
	}


２．DB定義書からCSV作成.xlsテーブルの定義からCSVファイルを作成する。
CSVの内容をAccessのテーブルにコピーする。

\bin\はBINARYファイルです。リリースするものです。
\out\は作成されたCLASSファイルです。
\test\はテストするため、作ったテストサンプルです。
