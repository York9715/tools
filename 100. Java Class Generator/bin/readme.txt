1.�e�[�u���N���X�̋��ʃN���X�̍쐬���@�F
���܂̏�Ԃ�SELECT�����g����B
DELETE�AUPDATE�AINSERT�Ȃǂ�B���삪�ł��Ă���B
�@q_output.xls�̓��e�Ńe�[�u�����`����B
�Aq_output.xls�̓��e��TABLE�ucls_def_tbl�v��IMPORT����B
�BMODULE��makeTblClsFrmDb�̊֐��umakeAllTableCls()�v�����s���A�S�e�[�u���̃f�[�^�N���X���쐬����B

�e�X�g���@�F
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


�Q�DDB��`������CSV�쐬.xls�e�[�u���̒�`����CSV�t�@�C�����쐬����B
CSV�̓��e��Access�̃e�[�u���ɃR�s�[����B

\bin\��BINARY�t�@�C���ł��B�����[�X������̂ł��B
\out\�͍쐬���ꂽCLASS�t�@�C���ł��B
\test\�̓e�X�g���邽�߁A������e�X�g�T���v���ł��B
