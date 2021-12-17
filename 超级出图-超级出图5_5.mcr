--Date:2021/12/09
--Editor:��ǫ
--PS:5.5�汾���ٶԾ���Ⱦ��������֧�֣�ͳһʹ�ý��µ���Ⱦ����������Ⱦ
macroScript ������ͼ5_5
Tooltip:"������ͼ5.5"
category:"������ͼ"(

--�������޸��ļ�·��
Global filePath = "C:\\Users\\Public\\Documents\\maxChaoJiChuTuTxt.txt"
Global matPath = "C:\\Users\\Public\\Documents\\maxChaoJiChuTuMat.txt"
Global stopPath = "C:\\Users\\Public\\Documents\\maxChaoJiChuTuStopCode.txt"
Global historyPath = "C:\\Users\\Public\\Documents\\maxChaoJiChuTuHistory.txt"

rollout MainUI "������ͼ5.5"
(
--UI����
	--ģ��1 ѡ�����
	label 'lbl1' "ѡ�����" pos:[10,10] align:#left
	
	button 'btn1' "����" pos:[10,30] width:50 height:30 align:#left
	button 'btn2' "��" pos:[70,30] width:50 height:30 align:#left
	button 'btn3' "����" pos:[130,30] width:50 height:30 align:#left
	
	button 'btn4' "��" pos:[10,70] width:50 height:30 align:#left
	button 'btn5' "��" pos:[130,70] width:50 height:30 align:#left
	
	button 'btn6' "����" pos:[10,110] width:50 height:30 align:#left
	button 'btn7' "��" pos:[70,110] width:50 height:30 align:#left
	button 'btn8' "����" pos:[130,110] width:50 height:30 align:#left	
	
	--ģ��2 ���������
	radioButtons 'rdo1' "��������" pos:[200,10] width:153 height:46 labels:#("����", "����", "����", "����", "����", "����", "����", "����","��Ч" ) columns:3 align:#left
	
	label 'renderDirection' "��Ⱦ����" pos:[360,10] align:#left
	checkbox 'cbxALLORNONE' "ȫѡ" pos:[460,10] width:40 height:15 align:#left
	checkbox 'cbxLU' "����" pos:[360,25] width:40 height:15 align:#left
	checkbox 'cbxU' "��" pos:[410,25] width:40 height:15 align:#left
	checkbox 'cbxRU' "����" pos:[460,25] width:40 height:15 align:#left
	checkbox 'cbxL' "��" pos:[360,40] width:40 height:15 align:#left
	checkbox 'cbxR' "��" pos:[460,40] width:40 height:15 align:#left
	checkbox 'cbxLD' "����" pos:[360,55] width:40 height:15 align:#left
	checkbox 'cbxD' "��" pos:[410,55] width:40 height:15 align:#left
	checkbox 'cbxRD' "����" pos:[460,55] width:40 height:15 align:#left
	
	editText 'edtMat' "��������" pos:[200,80] width:145 height:25 align:#left
	editText 'edtUniqueCode' "��ֹ����" pos:[360,80] width:145 height:25 align:#left
	
	button 'btnMaterialTest' "���ʲ���" pos:[200,110] width:70 height:30 align:#left
	button 'btnOutputTest' "���̲���" pos:[275,110] width:70 height:30 align:#left
	
	checkbox 'cbxTX' "������Ч(tx)" pos:[360,120] width:90 height:15 align:#left
	button 'btnCustom' "�Զ���" pos:[455,115] width:50 height:25 align:#left
	
	--ģ��3 ��֡����
	label 'lbl3' "�����ַ" pos:[10,150] width:150 height:15 align:#left
	editText 'edtAddress' "" pos:[7,170] width:340 height:25 align:#left
	
	label 'lblframe' "��֡����" pos:[10,200] width:150 height:15 align:#left
	editText 'edtFangAn' "" pos:[7,220] width:340 height:25 align:#left
	
	label 'lbl2' "��������" pos:[10,250] width:150 height:15 align:#left
	editText 'edtXuLie' "" pos:[7,270] width:340 height:25 align:#left
	
	label 'lblTxt' "txt�ļ���ַ" pos:[10,300] width:150 height:15 align:#left
	editText 'edtTxtAdd' "" pos:[7,320] width:165 height:25 align:#left
	label 'lblMat' "mat�ļ���ַ" pos:[185,300] width:150 height:15 align:#left
	editText 'edtMatAdd' "" pos:[182,320] width:165 height:25 align:#left
	
	--ģ��4 ��Ⱦ�����
	label 'lbl4' "ִ�н���" pos:[10,350] width:92 height:15 align:#left
    progressBar 'pb1' "��Ⱦ����" color:red pos:[10,370] width:50 height:20 align:#left
	
	button 'btnReadHistory' "��ȡ��ʷ" pos:[70,361] width:65 height:30 align:#left
	button 'btnWrite' "�޸�����" pos:[140,361] width:65 height:30 align:#left
	button 'btnAll' "ȫɫ��Ⱦ" pos:[210,361] width:65 height:30 align:#left
	button 'btnStart' "��Ⱦ��ǰ" pos:[280,361] width:65 height:30 align:#left
	
	checkbox 'cbxAutoSave' "��Ⱦǰ�Զ����泡��" pos:[360,377] width:180 height:15 align:#left
	
	--ģ��5 �������
	listbox lbCameraSolution "�������" pos:[360,150] width:80 height:5 items:#("���޸�","Ĭ�� 35mm", "Ĭ�� 28mm","����λ ���佹", "�Զ���(���·�","��ȡ��ʷ","����") align:#left 
	button 'btnRCamera' "��ȡ���" pos:[450,163] width:55 height:30 align:#left
	button 'btnWCamera' "д�����" pos:[450,201] width:55 height:30 align:#left
	
	spinner spn_scaleU "��  " pos:[360,240] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleD "��  " pos:[435,240] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleL "��  " pos:[360,265] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleR "��  " pos:[435,265] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleLD "����" pos:[360,290] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleRU "����" pos:[435,290] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleLU "����" pos:[360,315] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleRD "����" pos:[435,315] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	
	button 'btn35mm' "35mm��ͷ" pos:[360,340] width:70 height:30 align:#left
	button 'btn28mm' "28mm��ͷ" pos:[435,340] width:70 height:30 align:#left
	
	--����
	local cameraDistance = 480.94f
	local emergencyExit = false
	
	--��ȡ�����ļ�
	fn readTxt state = (
		try(
			filePath = edtTxtAdd.text
			OldFile = openFile filePath mode:"r"
			if OldFile == undefined then(
				close OldFile
				return()
			)
			if eof OldFile then(
				close OldFile
				return()
			)
			--�����ַ
			str = readLine OldFile
			edtAddress.text = str
			
			case of(
				(state == 1):rdoStr = "����"
				(state == 2):rdoStr = "����"
				(state == 3):rdoStr = "����"
				(state == 4):rdoStr = "����"
				(state == 5):rdoStr = "����"
				(state == 6):rdoStr = "����"
				(state == 7):rdoStr = "����"
				(state == 8):rdoStr = "����"
				(state == 9):rdoStr = "��Ч"
			)
			while not eof OldFile do(
				str = readLine OldFile
				if (findString str rdoStr)!=undefined  then(
					str = readLine OldFile
					edtFangAn.text = str
					str = readLine OldFile
					edtXuLie.text = str
					close OldFile
					return()
				)
			)
			edtFangAn.text = ""
			edtXuLie.text = ""
			close OldFile
		)catch(
			edtFangAn.text = "��ȡ�����쳣"
			edtXuLie.text = "���������ļ�"
		)
	)
	
	--��ȡ����Ϣ �ļ�·�� �ؼ��� ����
	fn myReadTxt filePath keyStr lines = (
		try(
			theFile = openFile filePath mode:"r+"
			if theFile == undefined then(
				close theFile
				return()
			)
			if eof theFile then(
				close theFile
				return()
			)
			--��ȡ��ʷ����
			while not eof theFile do(
				str = readLine theFile
				if (findString str keyStr)!=undefined  then(
					result = #()
					for i = 1 to lines do(
						tmp = readLine theFile
						append result tmp
					)
					close theFile
					return result
				)
			)
			close theFile
		)catch(
			print("��ȡ��ʷ���ݴ���")
			close theFile
		)
	)
	
	--д����ʷ����
	fn writeHistoryTxt = (
		try(
			historyFile = openFile historyPath mode:"w"
			if historyFile == undefined then(
				close historyFile
				return()
			)
			if eof historyFile then(
				close historyFile
				return()
			)
			str = "#��ʷ��¼#\n"+
				"<��������>\n"+edtMat.text+"\n\n"+
				"<�����ַ>\n"+edtAddress.text+"\n\n"+
				"<��֡����>\n"+edtFangAn.text+"\n\n"+
				"<��������>\n"+edtXuLie.text+"\n\n"+
				"<txt�ļ���ַ>\n"+edtTxtAdd.text+"\n\n"+
				"<mat�ļ���ַ>\n"+edtMatAdd.text+"\n\n"+
				"<����Ƕ�>\n"+
				(spn_scaleU.value as string)+" "+
				(spn_scaleD.value as string)+" "+
				(spn_scaleL.value as string)+" "+
				(spn_scaleR.value as string)+" "+
				(spn_scaleLD.value as string)+" "+
				(spn_scaleRU.value as string)+" "+
				(spn_scaleLU.value as string)+" "+
				(spn_scaleRD.value as string)+" "+
				"\n\n"
			format str to:historyFile
			print("д����ʷ���ݳɹ�")
			close historyFile
		)catch(
			print("д����ʷ���ݴ���")
			close historyFile
		)
	)
	
	--ȫѡ��Ⱦ���򷽷�
	fn cbxAllSelected theState =(
		case theState of(
			true:(
				cbxD.checked = true
				cbxLD.checked = true
				cbxL.checked = true
				cbxLU.checked = true
				cbxU.checked = true
				cbxRU.checked = true
				cbxR.checked = true
				cbxRD.checked = true
			)
			false:(
				cbxD.checked = false
				cbxLD.checked = false
				cbxL.checked = false
				cbxLU.checked = false
				cbxU.checked = false
				cbxRU.checked = false
				cbxR.checked = false
				cbxRD.checked = false
			)
			
		)
	)
	
	--�������λ��
	fn setCameraPosition cameraNo cameraAngle = (
		case cameraNo of(
			1:(--��
				$c01.position = [0,-(cos cameraAngle)*cameraDistance,(sin cameraAngle)*cameraDistance]
			)
			2:(--����
				$c08.position = [(cos cameraAngle)*cameraDistance*0.7071 ,-(cos cameraAngle)*cameraDistance*0.7071,(sin cameraAngle)*cameraDistance]
			)
			3:(--��
				$c07.position = [(cos cameraAngle)*cameraDistance,0,(sin cameraAngle)*cameraDistance]
			)
			4:(--����
				$c06.position = [(cos cameraAngle)*cameraDistance*0.7071,(cos cameraAngle)*cameraDistance*0.7071,(sin cameraAngle)*cameraDistance]
			)
			5:(--��
				$c05.position = [0,(cos cameraAngle)*cameraDistance,(sin cameraAngle)*cameraDistance]
			)
			6:(--����
				$c04.position = [-(cos cameraAngle)*cameraDistance*0.7071 ,(cos cameraAngle)*cameraDistance*0.7071,(sin cameraAngle)*cameraDistance]
			)
			7:(--��
				$c03.position = [-(cos cameraAngle)*cameraDistance,0,(sin cameraAngle)*cameraDistance]
			)
			8:(--����
				$c02.position = [-(cos cameraAngle)*cameraDistance*0.7071,-(cos cameraAngle)*cameraDistance*0.7071,(sin cameraAngle)*cameraDistance]
			)
		)
	)
	
	--�����λ��ת��Ϊ�Ƕ�
	fn cameraPositionToAngle = (
		spn_scaleD.value = atan ($c01.position.z/sqrt((pow $c01.position.x 2)+(pow $c01.position.y 2)))
		spn_scaleLD.value = atan ($c08.position.z/sqrt((pow $c08.position.x 2)+(pow $c08.position.y 2)))
		spn_scaleL.value = atan ($c07.position.z/sqrt((pow $c07.position.x 2)+(pow $c07.position.y 2)))
		spn_scaleLU.value = atan ($c06.position.z/sqrt((pow $c06.position.x 2)+(pow $c06.position.y 2)))
		spn_scaleU.value = atan ($c05.position.z/sqrt((pow $c05.position.x 2)+(pow $c05.position.y 2)))
		spn_scaleRU.value = atan ($c04.position.z/sqrt((pow $c04.position.x 2)+(pow $c04.position.y 2)))
		spn_scaleR.value = atan ($c03.position.z/sqrt((pow $c03.position.x 2)+(pow $c03.position.y 2)))
		spn_scaleRD.value = atan ($c02.position.z/sqrt((pow $c02.position.x 2)+(pow $c02.position.y 2)))
	)
	
	--���Ƕ�ת��Ϊ���λ��
	fn angleToCameraPosition = (
		setCameraPosition 1 spn_scaleD.value
		setCameraPosition 2 spn_scaleLD.value
		setCameraPosition 3 spn_scaleL.value
		setCameraPosition 4 spn_scaleLU.value
		setCameraPosition 5 spn_scaleU.value
		setCameraPosition 6 spn_scaleRU.value
		setCameraPosition 7 spn_scaleR.value
		setCameraPosition 8 spn_scaleRD.value
	)
	
	--������ֹͣ��ʶ
	fn goFindStopMessage = (
		str = edtUniqueCode.text
		if str != "" then(
			try(
				stopFile = openFile stopPath mode:"r"
				while not eof stopFile do(
					stopMessage = readLine stopFile
					if (findString stopMessage str)!=undefined  then(
						close stopFile
						emergencyExit = true
						return()
					)
				)
				close stopFile
			)catch()
		)
	)
	
--�ű�����ʱ����
on MainUI open do(
	goFindStopMessage()
	
	edtTxtAdd.text = filePath
	edtMatAdd.text = matPath
	try(
		configFile = openFile filePath mode:"r"
		if configFile == undefined then(
			--����һ�ݱ�׼��ʽ��txt�ļ�
			configFile = createFile filePath
			str = "������ͼƬ������ַ\n\n"+
				"����\n\n\n"+"����\n\n\n"+"����\n\n\n"+
				"����\n\n\n"+"����\n\n\n"+"����\n\n\n"+
				"����\n\n\n"+"����\n\n\n"+"��Ч\n\n\n"
			format str to:configFile
		)
		readTxt(1)--��ʼ����ȡ����
		
		matFile = openFile matPath mode:"r"
		if matFile == undefined then(
			--����һ�ݱ�׼��ʽ��mat�ļ�
			matFile = createFile matPath
			str = "ͨ��\n"+
				"0\n\n"+"����(����������������)\n"+"0\n\n"+
				"��ѣ(�������ܻ�)\n"+"0\n\n"+
				"����\n"+"0\n"
			format str to:matFile
		)
		
		stopFile = openFile stopPath mode:"r"
		if stopFile == undefined then(
			--����һ��StopCode�ļ�
			stopFile = createFile stopPath
			str = "��������ֹͣ�ļ�����\n����������ʱֹͣ������ֹ������д�����ļ���\n12123"
			format str to:stopFile
		)
		
		historyFile =openFile historyPath mode:"r"
		if historyFile == undefined then(
			--����һ��history�ļ�
			historyFile = createFile historyPath
			str = "#��ʷ��¼#\n"+
				"<��������>\n\n\n"+
				"<�����ַ>\n\n\n"+
				"<��֡����>\n\n\n"+
				"<��������>\n\n\n"+
				"<txt�ļ���ַ>\n\n\n"+
				"<mat�ļ���ַ>\n\n\n"+
				"<����Ƕ�>\n24.967 24.967 24.967 24.967 24.967 24.967 24.967 24.967\n\n"
			format str to:historyFile
		)
		
		close configFile
		close matFile
		close stopFile
		close historyFile
	)catch()
	
	cbxAllSelected true
	cbxALLORNONE.state = true
	cbxAutoSave.state = true
	
	--���������ֹ����
	edtUniqueCode.text = (random 10000 99999) as  String
)
	
--ѡ�����
	on btn1 pressed  do(--����
		actionMan.executeAction 0 "165"
		$g01.enabled = on
		$g01.rotation = inverse ((eulerToQuat(eulerAngles 50 0 135)) as quat)
			
		$a01.enabled = on	
		$a02.enabled = on
		$a03.enabled = on
		$a04.enabled = on
		$a05.enabled = on
		$a06.enabled = off
		$a07.enabled = on
		$a08.enabled = on	

		$b01.enabled = off	
		$b02.enabled = off
		$b03.enabled = off
		$b04.enabled = off
		$b05.enabled = off
		$b06.enabled = on
		$b07.enabled = off
		$b08.enabled = off
	)
	on btn2 pressed  do(--��
	    actionMan.executeAction 0 "164"
		$g01.enabled = on
		$g01.rotation = inverse ((eulerToQuat(eulerAngles 50 0 180)) as quat)

		$a01.enabled = on	
		$a02.enabled = on
		$a03.enabled = on
		$a04.enabled = on
		$a05.enabled = off
		$a06.enabled = on
		$a07.enabled = on
		$a08.enabled = on	

		$b01.enabled = off	
		$b02.enabled = off
		$b03.enabled = off
		$b04.enabled = off
		$b05.enabled = on
		$b06.enabled = off
		$b07.enabled = off
		$b08.enabled = off
	)
	on btn3 pressed  do(--����
		actionMan.executeAction 0 "163"
		$g01.enabled = on
		$g01.rotation = inverse ((eulerToQuat(eulerAngles 50 0 -135)) as quat)
			
		$a01.enabled = on	
		$a02.enabled = on
		$a03.enabled = on
		$a04.enabled = off
		$a05.enabled = on
		$a06.enabled = on
		$a07.enabled = on
		$a08.enabled = on	

		$b01.enabled = off	
		$b02.enabled = off
		$b03.enabled = off
		$b04.enabled = on
		$b05.enabled = off
		$b06.enabled = off
		$b07.enabled = off
		$b08.enabled = off
	)
	on btn4 pressed  do(--��
		actionMan.executeAction 0 "166"
		$g01.enabled = on
		$g01.rotation = inverse ((eulerToQuat(eulerAngles 50 0 90)) as quat)

		$a01.enabled = on	
		$a02.enabled = on
		$a03.enabled = on
		$a04.enabled = on
		$a05.enabled = on
		$a06.enabled = on
		$a07.enabled = off
		$a08.enabled = on	

		$b01.enabled = off	
		$b02.enabled = off
		$b03.enabled = off
		$b04.enabled = off
		$b05.enabled = off
		$b06.enabled = off
		$b07.enabled = on
		$b08.enabled = off
	)
	on btn5 pressed  do(--��
		actionMan.executeAction 0 "162"
		$g01.enabled = on
		$g01.rotation = inverse ((eulerToQuat(eulerAngles 50 0 -90)) as quat)

		$a01.enabled = on	
		$a02.enabled = on
		$a03.enabled = off
		$a04.enabled = on
		$a05.enabled = on
		$a06.enabled = on
		$a07.enabled = on
		$a08.enabled = on	

		$b01.enabled = off	
		$b02.enabled = off
		$b03.enabled = on
		$b04.enabled = off
		$b05.enabled = off
		$b06.enabled = off
		$b07.enabled = off
		$b08.enabled = off
	)
	on btn6 pressed  do(--����
		actionMan.executeAction 0 "167" 
		$g01.enabled = on
		$g01.rotation = inverse ((eulerToQuat(eulerAngles 50 0 45)) as quat)
			
		$a01.enabled = on	
		$a02.enabled = on
		$a03.enabled = on
		$a04.enabled = on
		$a05.enabled = on
		$a06.enabled = on
		$a07.enabled = on
		$a08.enabled = off	

		$b01.enabled = off	
		$b02.enabled = off
		$b03.enabled = off
		$b04.enabled = off
		$b05.enabled = off
		$b06.enabled = off
		$b07.enabled = off
		$b08.enabled = on
	)
	on btn7 pressed  do(--��
		actionMan.executeAction 0 "160"
		$g01.enabled = on
		$g01.rotation = inverse ((eulerToQuat(eulerAngles 50 0 0)) as quat)
	
		$a01.enabled = off
		$a02.enabled = on
		$a03.enabled = on
		$a04.enabled = on
		$a05.enabled = on
		$a06.enabled = on
		$a07.enabled = on
		$a08.enabled = on	

		$b01.enabled = on	
		$b02.enabled = off
		$b03.enabled = off
		$b04.enabled = off
		$b05.enabled = off
		$b06.enabled = off
		$b07.enabled = off
		$b08.enabled = off
	)
	on btn8 pressed  do(--����
		actionMan.executeAction 0 "161"
		$g01.enabled = on
		$g01.rotation = inverse ((eulerToQuat(eulerAngles 50 0 -45)) as quat)
			
		$a01.enabled = on	
		$a02.enabled = off
		$a03.enabled = on
		$a04.enabled = on
		$a05.enabled = on
		$a06.enabled = on
		$a07.enabled = on
		$a08.enabled = on

		$b01.enabled = off	
		$b02.enabled = on
		$b03.enabled = off
		$b04.enabled = off
		$b05.enabled = off
		$b06.enabled = off
		$b07.enabled = off
		$b08.enabled = off
	)

--���ո�������ַ���ת����(����)
fn switchStrToInteger s = (
	Ary = #()
	temp = 0 as Integer
	for i = 1 to s.count do(
		if s[i] >= "0" and s[i] <= "9" then(
			num = s[i] as Integer
			temp=10 * temp + num
		)
		else(
			append Ary temp
			temp = 0
		)
	)
	if temp != 0 do (
		append Ary temp
	)
	return Ary
)

--�ַ���ת����(������)
fn switchStrToFloat s = (
	Ary = #()
	temp = 0 as Float
	decimalCount = 0 as Integer
	foundPoint = false
	for i = 1 to s.count do(
		if s[i] >= "0" and s[i] <= "9" then(
			num = s[i] as Float
			temp=10 * temp + num
			if foundPoint then(
				decimalCount = decimalCount+1
			)
		)
		else if s[i] == "." then(
			foundPoint = true
		)
		else(
			temp = temp/(pow 10 decimalCount)
			append Ary temp
			temp = 0
			foundPoint = false
			decimalCount = 0
		)
	)
	if temp != 0 do (
		temp = temp/(pow 10 decimalCount)
		append Ary temp
	)
	return Ary
)

--д��֡�����ı�
fn outPutTxt dir AAction = (
	thePath = edtAddress.text as string + dir + AAction[rdo1.state] + "\\" +  "frame.txt"
	NewFile = createFile thePath
	textt = edtXuLie.text as string
	if textt != "" then
	(
	    format "%" textt to:NewFile
	)
	else
	(
		format "100;0" to:NewFile
	)
	close NewFile
)

--��ת��Ч
fn rotateTX isCome =(
	actionMan.executeAction 0 "40247" --ѡ�������
	cameraNow = $
	select $tx
	macros.run "Scene Explorer" "SESelectChildren"
	deselect $tx
	if isCome then(
		in coordsys cameraNow rotate $ (angleaxis 40 [1,0,0])
	)
	else(
		in coordsys cameraNow rotate $ (angleaxis -40 [1,0,0])
	)
)

--����ͼƬ
fn outPutImg ARR ViewAngle Action = (
	if ARR[1] == undefined then
	(--����
		if cbxTX.checked then(
			rotateTX(true)
		)
		render outputFile:(edtAddress.text as string + ViewAngle +Action[rdo1.state] + "\\" + "1000.png") vfb:off
		if cbxTX.checked then(
			rotateTX(false)
		)
	)
	else
	(--����
		i = 1
		for t = animationrange.start to animationrange.end do
		(
			if t == ARR[i] then
			(
				sliderTime = t
				m =  ARR[i] +1000
				i = i + 1
				if cbxTX.checked then(
					rotateTX(true)
				)
				render outputFile:(edtAddress.text as string + ViewAngle + Action[rdo1.state] + "\\" + m as string +".png") vfb:off
				if cbxTX.checked then(
					rotateTX(false)
				)
			)
		)
	)
)

	--������¶���֡����
	on btnWrite pressed do(
		--��ʼ������
		Action = #("����", "����", "����", "����", "����", "����", "����", "����", "��Ч")
		pb1.value = 0
		outPutTxt("��\\")(Action)
		outPutTxt("����\\")(Action)
		outPutTxt("��\\")(Action)
		outPutTxt("����\\")(Action)
		outPutTxt("��\\")(Action)
		outPutTxt("����\\")(Action)
		outPutTxt("��\\")(Action)
		outPutTxt("����\\")(Action)
		pb1.value = 100
		
	)

	--��ȡ��Ⱦ����
	on rdo1 changed rdoState do(
		readTxt(rdoState)
	)
	
--��Ⱦ����
fn renderr = (
	--����һ���ڴ�
	gc()
	--��ʼ���ƹ�
	$a01.enabled = on	
	$a02.enabled = on
	$a03.enabled = on
	$a04.enabled = on
	$a05.enabled = on
	$a06.enabled = on
	$a07.enabled = on
	$a08.enabled = on	

	$b01.enabled = off	
	$b02.enabled = off
	$b03.enabled = off
	$b04.enabled = off
	$b05.enabled = off
	$b06.enabled = off
	$b07.enabled = off
	$b08.enabled = off
	
	$g01.enabled = on
	$g01.rotation = inverse ((eulerToQuat(eulerAngles 50 0 0)) as quat)
	
	--��ʼ������
	Action = #("����", "����", "����", "����", "����", "����", "����", "����", "��Ч")
	ARR = switchStrToInteger edtFangAn.text--��ȡ��Ⱦ�ؼ�֡
	pb1.value = 0--����������
	pb1.color = color 255 0 0--��������ɫ��Ϊ��
	
--��
	goFindStopMessage()
	if emergencyExit then return()
	if cbxD.state then(
		actionMan.executeAction 0 "160"
		$a01.enabled = off
		$b01.enabled = on
		outPutImg(ARR)("��\\")(Action)
		outPutTxt("��\\")(Action)
		$a01.enabled = on
		$b01.enabled = off
		pb1.value = 12
	)
	
--����
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxLD.state then(
		actionMan.executeAction 0 "167" 
		$a08.enabled = off
		$b08.enabled = on
		outPutImg(ARR)("����\\")(Action)
		outPutTxt("����\\")(Action)
		$a08.enabled = on
		$b08.enabled = off
		pb1.value = 25
	)
	
--��
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxL.state then(
		actionMan.executeAction 0 "166"
		$a07.enabled = off
		$b07.enabled = on
		outPutImg(ARR)("��\\")(Action)
		outPutTxt("��\\")(Action)
		$a07.enabled = on
		$b07.enabled = off
		pb1.value = 37
	)
	
--����
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxLU.state then(
		actionMan.executeAction 0 "165" 
		$a06.enabled = off
		$b06.enabled = on
		outPutImg(ARR)("����\\")(Action)
		outPutTxt("����\\")(Action)
		$a06.enabled = on
		$b06.enabled = off
		pb1.value = 50
	)
	
--��
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxU.state then(
		actionMan.executeAction 0 "164"
		$a05.enabled = off
		$b05.enabled = on
		outPutImg(ARR)("��\\")(Action)
		outPutTxt("��\\")(Action)
		$a05.enabled = on
		$b05.enabled = off
		pb1.value = 62
	)
	
--����
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxRU.state then(
		actionMan.executeAction 0 "163"
		$a04.enabled = off
		$b04.enabled = on
		outPutImg(ARR)("����\\")(Action)
		outPutTxt("����\\")(Action)
		$a04.enabled = on
		$b04.enabled = off
		pb1.value = 75
	)
	
--��
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxR.state then(
		actionMan.executeAction 0 "162"
		$a03.enabled = off
		$b03.enabled = on
		outPutImg(ARR)("��\\")(Action)
		outPutTxt("��\\")(Action)
		$a03.enabled = on
		$b03.enabled = off
		pb1.value = 87	
	)

--����
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxRD.state then(
		actionMan.executeAction 0 "161"
		$a02.enabled = off
		$b02.enabled = on
		outPutImg(ARR)("����\\")(Action)
		outPutTxt("����\\")(Action)
	)
	
	pb1.value = 100
	pb1.color = color 0 255 0
)

--�������λ��
fn normalizeCamera cameraSelection = (
	case cameraSelection of(
		"35mm":(
			print ("�л�35mm��ͷ")
			$c01.fov = 54.4322
			$c02.fov = 54.4322
			$c03.fov = 54.4322
			$c04.fov = 54.4322
			$c05.fov = 54.4322
			$c06.fov = 54.4322
			$c07.fov = 54.4322
			$c08.fov = 54.4322
		)
		"28mm":(
			print ("�л�28mm��ͷ")
			$c01.fov = 65.4705
			$c02.fov = 65.4705
			$c03.fov = 65.4705
			$c04.fov = 65.4705
			$c05.fov = 65.4705
			$c06.fov = 65.4705
			$c07.fov = 65.4705
			$c08.fov = 65.4705
		)
		1:(
			print ("��ǰ��������(���޸ľ�ͷ����)")
		)
		2:(
			print ("Ĭ�Ϸ��� 35mm��ͷ")
			$c01.position = [0,-436,203]
			$c02.position = [-308.3,-308.3,203]
			$c03.position = [-436,0,203]
			$c04.position = [-308.3,308.3,203]
			$c05.position = [0,436,203]
			$c06.position = [308.3,308.3,203]
			$c07.position = [436,0,203]
			$c08.position = [308.3,-308.3,203]
			
			$c01.fov = 54.4322
			$c02.fov = 54.4322
			$c03.fov = 54.4322
			$c04.fov = 54.4322
			$c05.fov = 54.4322
			$c06.fov = 54.4322
			$c07.fov = 54.4322
			$c08.fov = 54.4322
		)
		3:(
			print ("Ĭ�Ϸ��� 28mm��ͷ")
			$c01.position = [0,-436,203]
			$c02.position = [-308.3,-308.3,203]
			$c03.position = [-436,0,203]
			$c04.position = [-308.3,308.3,203]
			$c05.position = [0,436,203]
			$c06.position = [308.3,308.3,203]
			$c07.position = [436,0,203]
			$c08.position = [308.3,-308.3,203]
		
			$c01.fov = 65.4705
			$c02.fov = 65.4705
			$c03.fov = 65.4705
			$c04.fov = 65.4705
			$c05.fov = 65.4705
			$c06.fov = 65.4705
			$c07.fov = 65.4705
			$c08.fov = 65.4705
		)
		4:(
			print ("����λ����(���޸ľ�ͷ����)")
			$c01.position = [0,-396,263]
			$c02.position = [-308,-308,323]
			$c03.position = [-386,0,323]
			$c04.position = [-248,248,323]
			$c05.position = [0,320,320]
			$c06.position = [248,248,323]
			$c07.position = [386,0,323]
			$c08.position = [308,-308,203]
		)
		5:(
			print ("�Զ��巽��")
			angleToCameraPosition()
		)
		6:(
			print("��ȡ��ʷ����")
			--�ַ���ת���ַ�����ʵ��
			strArr = switchStrToFloat (myReadTxt historyPath "����Ƕ�" 1)[1]
			spn_scaleU.value= strArr[1] as float
			spn_scaleD.value= strArr[2] as float
			spn_scaleL.value= strArr[3] as float
			spn_scaleR.value= strArr[4] as float
			spn_scaleLD.value= strArr[5] as float
			spn_scaleRU.value= strArr[6] as float
			spn_scaleLU.value= strArr[7] as float
			spn_scaleRD.value= strArr[8] as float
			angleToCameraPosition()
		)
		7:(
			print ("��ǰ���÷�������Ҫд��ű���")
		)
	)
	--ˢ������Ƕ���ʾ����
	cameraPositionToAngle()
	
	--ɾ��g01�Ķ���
	select $g01
	macros.run "Animation Tools" "DeleteSelectedAnimation"
)
	
--�����ʣ����ڵ�������������������ţ�
fn changeMat nodeName matName m =(
	node = getNodeByName(nodeName)
	select node
	macros.run "Scene Explorer" "SESelectChildren"
	$.material = sceneMaterials[(matName + m as string)]
	print (nodeName + "���滻�ɲ��ʣ�" + matName + m as string)
)

	--�����ʼ��Ⱦ
	on btnStart pressed do(
		print("ִ����Ⱦ��ǰ����")
		set animate off
		max display mode
		--��׼�������
		normalizeCamera lbCameraSolution.selection
		--��¼��ǰ��Ⱦ����
		writeHistoryTxt()
		--ֹͣ��ʶ����Ϊfalse
		emergencyExit = false
		--��Ⱦǰ�Զ�����(��ֹ��Ⱦ��;����)
		if cbxAutoSave.state do max file save
		--��Ⱦ����
		renderr()
		if emergencyExit then(
			print("��⵽��ֹ����,��Ⱦ��ֹͣ")
			return()
		)
	)
	
	--��Ⱦȫ��
	on btnAll pressed do(
		print("ִ����Ⱦȫ������")
		set animate off
		max display mode
		--��׼�������
		normalizeCamera lbCameraSolution.selection
		--��¼��ǰ��Ⱦ����
		writeHistoryTxt()
		--ֹͣ��ʶ����Ϊfalse
		emergencyExit = false
		--��Ⱦǰ�Զ�����(��ֹ��Ⱦ��;����)
		if cbxAutoSave.state do max file save
		
		--��ȡmat�е�����
		try(
			matFile = OpenFile edtMatAdd.text mode:"r"
			--ͨ��
			utilArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "ͨ��")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append utilArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--����
			normalArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "����")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append normalArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--��ѣ
			yunArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "��ѣ")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append yunArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--����
			attArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "��ѣ")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append attArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--��Ч
			if cbxTX.checked then(
				txArr = #()
				while not eof matFile do(
					str = readLine matFile
					if (findString str "��Ч")!=undefined  then(
						count = (readLine matFile) as Integer
						for i = 1 to count * 2 do(
							str = readLine matFile
							append txArr str
						)
						exit
					)
				)
			)
			seek matFile 0
			close matFile
		)
		catch(
			edtMat.text = "��ȡmat����"
			close matFile
			return()
		)
		--�����ʲ�������Ⱦ
		matARR = switchStrToInteger edtMat.text--��ȡ��������
		for	m = 1 to matARR.count do(
			--�����ʣ�ͨ��
			for i = 1 to utilArr.count / 2 do(
				changeMat(utilArr[i * 2 - 1])(utilArr[i * 2])(matARR[m])
			)
			--�����ʣ�����
			if rdo1.state == 2 then(
				for i = 1 to attArr.count / 2 do(
					changeMat(attArr[i * 2 - 1])(attArr[i * 2])(matARR[m])
				)
			)
			--�����ʣ���ѣ(�������ܻ�)
			if rdo1.state == 5 or rdo1.state == 6 then(
				for i = 1 to yunArr.count / 2 do(
					changeMat(yunArr[i * 2 - 1])(yunArr[i * 2])(matARR[m])
				)
			)
			--�����ʣ�����(����������������)
			if rdo1.state == 1 or rdo1.state == 3 or rdo1.state == 4 then(
				for i = 1 to normalArr.count / 2 do(
					changeMat(normalArr[i * 2 - 1])(normalArr[i * 2])(matARR[m])
				)
			)
			--�����ʣ���Ч
			if cbxTX.checked then(
				for i = 1 to txArr.count / 2 do(
					changeMat(txArr[i * 2 - 1])(txArr[i * 2])(matARR[m])
				)
			)
			
			--�޸ĵ�ַ
			addressOld = edtAddress.text
			if matARR[m] < 10 then(
				edtAddress.text = replace addressOld (addressOld.count - 3)(2)("0" + matARR[m] as string)
			)
			else(
				edtAddress.text = replace addressOld (addressOld.count - 3)(2)(matArr[m] as string)
			)
			
			--��Ⱦ��ǰ����
			renderr()
			--���ֹͣ��ʶ
			if emergencyExit then(
				print("��⵽��ֹ����,��Ⱦ��ֹͣ")
				return()
			)
		)
		
	)
	
	--ȫѡ��Ⱦ�¼�
	on cbxALLORNONE changed theState do(
		cbxAllSelected theState
	)
	
	--�л�35mm��ͷ
	on btn35mm pressed do(
		normalizeCamera "35mm"
	)
	
	--�л�28mm��ͷ
	on btn28mm pressed do(
		normalizeCamera "28mm"
	)
	
	--��ȡ��ǰ������Ƕ�
	on btnRCamera pressed do(
		cameraPositionToAngle()
	)
	
	--����д�뾵ͷλ��
	on btnWCamera pressed do(
		angleToCameraPosition()
	)
	
	--�����������
	on lbCameraSolution doubleClicked solutionChoice do(
		normalizeCamera solutionChoice
		cameraPositionToAngle()
	)
	
	--���ʲ��԰�ť
	on btnMaterialTest pressed do(
		--�л��������ӽ�
		actionMan.executeAction 0 "161"
		print("ִ�в��ʲ���")
		
		--��ȡmat�е�����
		try(
			matFile = OpenFile edtMatAdd.text mode:"r"
			--ͨ��
			utilArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "ͨ��")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append utilArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--����
			normalArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "����")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append normalArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--��ѣ
			yunArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "��ѣ")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append yunArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--����
			attArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "��ѣ")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append attArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--��Ч
			if cbxTX.checked then(
				txArr = #()
				while not eof matFile do(
					str = readLine matFile
					if (findString str "��Ч")!=undefined  then(
						count = (readLine matFile) as Integer
						for i = 1 to count * 2 do(
							str = readLine matFile
							append txArr str
						)
						exit
					)
				)
			)
			seek matFile 0
			close matFile
		)
		catch(
			edtMat.text = "��ȡmat����"
			close matFile
			return()
		)
		--�����ʲ�������Ⱦ
		matARR = switchStrToInteger edtMat.text--��ȡ��������
		for	m = 1 to matARR.count do(
			--�����ʣ�ͨ��
			for i = 1 to utilArr.count / 2 do(
				changeMat(utilArr[i * 2 - 1])(utilArr[i * 2])(matARR[m])
			)
			--�����ʣ�����
			if rdo1.state == 2 then(
				for i = 1 to attArr.count / 2 do(
					changeMat(attArr[i * 2 - 1])(attArr[i * 2])(matARR[m])
				)
			)
			--�����ʣ���ѣ(�������ܻ�)
			if rdo1.state == 5 or rdo1.state == 6 then(
				for i = 1 to yunArr.count / 2 do(
					changeMat(yunArr[i * 2 - 1])(yunArr[i * 2])(matARR[m])
				)
			)
			--�����ʣ�����(����������������)
			if rdo1.state == 1 or rdo1.state == 3 or rdo1.state == 4 then(
				for i = 1 to normalArr.count / 2 do(
					changeMat(normalArr[i * 2 - 1])(normalArr[i * 2])(matARR[m])
				)
			)
			--�����ʣ���Ч
			if cbxTX.checked then(
				for i = 1 to txArr.count / 2 do(
					changeMat(txArr[i * 2 - 1])(txArr[i * 2])(matARR[m])
				)
			)
			redrawViews() 
			sleep 2
		)
	)
	
	--���̲���
	on btnOutputTest pressed do(
		print("δ��ɹ���-���̲���")
	)
	
	on btnReadHistory pressed do(
		edtMat.text = (myReadTxt historyPath "��������" 1)[1]
		edtAddress.text = (myReadTxt historyPath "�����ַ" 1)[1]
		edtFangAn.text = (myReadTxt historyPath "��֡����" 1)[1]
		edtXuLie.text = (myReadTxt historyPath "��������" 1)[1]
		edtTxtAdd.text = (myReadTxt historyPath "txt�ļ���ַ" 1)[1]
		edtMatAdd.text = (myReadTxt historyPath "mat�ļ���ַ" 1)[1]
	)
	
----------------------------------------------------------------------------------------------------------------------------------------
	--�Զ�������ð�ť
	on btnCustom pressed do(
		print("�Զ�����԰�ť������")
		
		
	)
----------------------------------------------------------------------------------------------------------------------------------------
)

NewFloater = newRolloutFloater "������ͼ5.5" 520 425
addRollout MainUI NewFloater
)