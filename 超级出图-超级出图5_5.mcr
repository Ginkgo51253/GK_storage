--Date:2021/12/09
--Editor:曹谦
--PS:5.5版本起不再对旧渲染场景进行支持，统一使用较新的渲染场景进行渲染
macroScript 超级出图5_5
Tooltip:"超级出图5.5"
category:"超级出图"(

--在这里修改文件路径
Global filePath = "C:\\Users\\Public\\Documents\\maxChaoJiChuTuTxt.txt"
Global matPath = "C:\\Users\\Public\\Documents\\maxChaoJiChuTuMat.txt"
Global stopPath = "C:\\Users\\Public\\Documents\\maxChaoJiChuTuStopCode.txt"
Global historyPath = "C:\\Users\\Public\\Documents\\maxChaoJiChuTuHistory.txt"

rollout MainUI "超级出图5.5"
(
--UI布局
	--模块1 选择相机
	label 'lbl1' "选择相机" pos:[10,10] align:#left
	
	button 'btn1' "左上" pos:[10,30] width:50 height:30 align:#left
	button 'btn2' "上" pos:[70,30] width:50 height:30 align:#left
	button 'btn3' "右上" pos:[130,30] width:50 height:30 align:#left
	
	button 'btn4' "左" pos:[10,70] width:50 height:30 align:#left
	button 'btn5' "右" pos:[130,70] width:50 height:30 align:#left
	
	button 'btn6' "左下" pos:[10,110] width:50 height:30 align:#left
	button 'btn7' "下" pos:[70,110] width:50 height:30 align:#left
	button 'btn8' "右下" pos:[130,110] width:50 height:30 align:#left	
	
	--模块2 控制与测试
	radioButtons 'rdo1' "动作种类" pos:[200,10] width:153 height:46 labels:#("待机", "攻击", "防御", "疾跑", "受伤", "死亡", "坐下", "挥手","特效" ) columns:3 align:#left
	
	label 'renderDirection' "渲染方向" pos:[360,10] align:#left
	checkbox 'cbxALLORNONE' "全选" pos:[460,10] width:40 height:15 align:#left
	checkbox 'cbxLU' "左上" pos:[360,25] width:40 height:15 align:#left
	checkbox 'cbxU' "上" pos:[410,25] width:40 height:15 align:#left
	checkbox 'cbxRU' "右上" pos:[460,25] width:40 height:15 align:#left
	checkbox 'cbxL' "左" pos:[360,40] width:40 height:15 align:#left
	checkbox 'cbxR' "右" pos:[460,40] width:40 height:15 align:#left
	checkbox 'cbxLD' "左下" pos:[360,55] width:40 height:15 align:#left
	checkbox 'cbxD' "下" pos:[410,55] width:40 height:15 align:#left
	checkbox 'cbxRD' "右下" pos:[460,55] width:40 height:15 align:#left
	
	editText 'edtMat' "材质序列" pos:[200,80] width:145 height:25 align:#left
	editText 'edtUniqueCode' "终止号码" pos:[360,80] width:145 height:25 align:#left
	
	button 'btnMaterialTest' "材质测试" pos:[200,110] width:70 height:30 align:#left
	button 'btnOutputTest' "流程测试" pos:[275,110] width:70 height:30 align:#left
	
	checkbox 'cbxTX' "处理特效(tx)" pos:[360,120] width:90 height:15 align:#left
	button 'btnCustom' "自定义" pos:[455,115] width:50 height:25 align:#left
	
	--模块3 抽帧方案
	label 'lbl3' "输出地址" pos:[10,150] width:150 height:15 align:#left
	editText 'edtAddress' "" pos:[7,170] width:340 height:25 align:#left
	
	label 'lblframe' "抽帧方案" pos:[10,200] width:150 height:15 align:#left
	editText 'edtFangAn' "" pos:[7,220] width:340 height:25 align:#left
	
	label 'lbl2' "动画序列" pos:[10,250] width:150 height:15 align:#left
	editText 'edtXuLie' "" pos:[7,270] width:340 height:25 align:#left
	
	label 'lblTxt' "txt文件地址" pos:[10,300] width:150 height:15 align:#left
	editText 'edtTxtAdd' "" pos:[7,320] width:165 height:25 align:#left
	label 'lblMat' "mat文件地址" pos:[185,300] width:150 height:15 align:#left
	editText 'edtMatAdd' "" pos:[182,320] width:165 height:25 align:#left
	
	--模块4 渲染与进度
	label 'lbl4' "执行进度" pos:[10,350] width:92 height:15 align:#left
    progressBar 'pb1' "渲染进度" color:red pos:[10,370] width:50 height:20 align:#left
	
	button 'btnReadHistory' "读取历史" pos:[70,361] width:65 height:30 align:#left
	button 'btnWrite' "修改序列" pos:[140,361] width:65 height:30 align:#left
	button 'btnAll' "全色渲染" pos:[210,361] width:65 height:30 align:#left
	button 'btnStart' "渲染当前" pos:[280,361] width:65 height:30 align:#left
	
	checkbox 'cbxAutoSave' "渲染前自动保存场景" pos:[360,377] width:180 height:15 align:#left
	
	--模块5 相机方案
	listbox lbCameraSolution "相机方案" pos:[360,150] width:80 height:5 items:#("无修改","默认 35mm", "默认 28mm","低身位 不变焦", "自定义(读下方","读取历史","备用") align:#left 
	button 'btnRCamera' "读取相机" pos:[450,163] width:55 height:30 align:#left
	button 'btnWCamera' "写入相机" pos:[450,201] width:55 height:30 align:#left
	
	spinner spn_scaleU "上  " pos:[360,240] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleD "下  " pos:[435,240] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleL "左  " pos:[360,265] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleR "右  " pos:[435,265] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleLD "左下" pos:[360,290] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleRU "右上" pos:[435,290] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleLU "左上" pos:[360,315] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	spinner spn_scaleRD "右下" pos:[435,315] width:30 height:25 fieldWidth:35 range:[0,90,25] scale:0.1 align:#left
	
	button 'btn35mm' "35mm镜头" pos:[360,340] width:70 height:30 align:#left
	button 'btn28mm' "28mm镜头" pos:[435,340] width:70 height:30 align:#left
	
	--变量
	local cameraDistance = 480.94f
	local emergencyExit = false
	
	--读取配置文件
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
			--输出地址
			str = readLine OldFile
			edtAddress.text = str
			
			case of(
				(state == 1):rdoStr = "待机"
				(state == 2):rdoStr = "攻击"
				(state == 3):rdoStr = "防御"
				(state == 4):rdoStr = "疾跑"
				(state == 5):rdoStr = "受伤"
				(state == 6):rdoStr = "死亡"
				(state == 7):rdoStr = "坐下"
				(state == 8):rdoStr = "挥手"
				(state == 9):rdoStr = "特效"
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
			edtFangAn.text = "读取配置异常"
			edtXuLie.text = "请检查配置文件"
		)
	)
	
	--读取行信息 文件路径 关键字 行数
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
			--读取历史参数
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
			print("读取历史数据错误")
			close theFile
		)
	)
	
	--写入历史数据
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
			str = "#历史记录#\n"+
				"<材质序列>\n"+edtMat.text+"\n\n"+
				"<输出地址>\n"+edtAddress.text+"\n\n"+
				"<抽帧方案>\n"+edtFangAn.text+"\n\n"+
				"<动画序列>\n"+edtXuLie.text+"\n\n"+
				"<txt文件地址>\n"+edtTxtAdd.text+"\n\n"+
				"<mat文件地址>\n"+edtMatAdd.text+"\n\n"+
				"<相机角度>\n"+
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
			print("写入历史数据成功")
			close historyFile
		)catch(
			print("写入历史数据错误")
			close historyFile
		)
	)
	
	--全选渲染方向方法
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
	
	--设置相机位置
	fn setCameraPosition cameraNo cameraAngle = (
		case cameraNo of(
			1:(--下
				$c01.position = [0,-(cos cameraAngle)*cameraDistance,(sin cameraAngle)*cameraDistance]
			)
			2:(--左下
				$c08.position = [(cos cameraAngle)*cameraDistance*0.7071 ,-(cos cameraAngle)*cameraDistance*0.7071,(sin cameraAngle)*cameraDistance]
			)
			3:(--左
				$c07.position = [(cos cameraAngle)*cameraDistance,0,(sin cameraAngle)*cameraDistance]
			)
			4:(--左上
				$c06.position = [(cos cameraAngle)*cameraDistance*0.7071,(cos cameraAngle)*cameraDistance*0.7071,(sin cameraAngle)*cameraDistance]
			)
			5:(--上
				$c05.position = [0,(cos cameraAngle)*cameraDistance,(sin cameraAngle)*cameraDistance]
			)
			6:(--右上
				$c04.position = [-(cos cameraAngle)*cameraDistance*0.7071 ,(cos cameraAngle)*cameraDistance*0.7071,(sin cameraAngle)*cameraDistance]
			)
			7:(--右
				$c03.position = [-(cos cameraAngle)*cameraDistance,0,(sin cameraAngle)*cameraDistance]
			)
			8:(--右下
				$c02.position = [-(cos cameraAngle)*cameraDistance*0.7071,-(cos cameraAngle)*cameraDistance*0.7071,(sin cameraAngle)*cameraDistance]
			)
		)
	)
	
	--将相机位置转换为角度
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
	
	--将角度转换为相机位置
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
	
	--检查紧急停止标识
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
	
--脚本启动时触发
on MainUI open do(
	goFindStopMessage()
	
	edtTxtAdd.text = filePath
	edtMatAdd.text = matPath
	try(
		configFile = openFile filePath mode:"r"
		if configFile == undefined then(
			--创建一份标准格式的txt文件
			configFile = createFile filePath
			str = "请输入图片导出地址\n\n"+
				"待机\n\n\n"+"攻击\n\n\n"+"防御\n\n\n"+
				"疾跑\n\n\n"+"受伤\n\n\n"+"死亡\n\n\n"+
				"坐下\n\n\n"+"挥手\n\n\n"+"特效\n\n\n"
			format str to:configFile
		)
		readTxt(1)--初始化读取配置
		
		matFile = openFile matPath mode:"r"
		if matFile == undefined then(
			--创建一份标准格式的mat文件
			matFile = createFile matPath
			str = "通用\n"+
				"0\n\n"+"正常(待机、防御、疾跑)\n"+"0\n\n"+
				"晕眩(死亡、受击)\n"+"0\n\n"+
				"攻击\n"+"0\n"
			format str to:matFile
		)
		
		stopFile = openFile stopPath mode:"r"
		if stopFile == undefined then(
			--创建一份StopCode文件
			stopFile = createFile stopPath
			str = "！！紧急停止文件！！\n如需在运行时停止，将终止序列填写到本文件中\n12123"
			format str to:stopFile
		)
		
		historyFile =openFile historyPath mode:"r"
		if historyFile == undefined then(
			--创建一份history文件
			historyFile = createFile historyPath
			str = "#历史记录#\n"+
				"<材质序列>\n\n\n"+
				"<输出地址>\n\n\n"+
				"<抽帧方案>\n\n\n"+
				"<动画序列>\n\n\n"+
				"<txt文件地址>\n\n\n"+
				"<mat文件地址>\n\n\n"+
				"<相机角度>\n24.967 24.967 24.967 24.967 24.967 24.967 24.967 24.967\n\n"
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
	
	--随机生成终止号码
	edtUniqueCode.text = (random 10000 99999) as  String
)
	
--选择相机
	on btn1 pressed  do(--左上
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
	on btn2 pressed  do(--上
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
	on btn3 pressed  do(--右上
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
	on btn4 pressed  do(--左
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
	on btn5 pressed  do(--右
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
	on btn6 pressed  do(--左下
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
	on btn7 pressed  do(--下
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
	on btn8 pressed  do(--右下
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

--（空格隔开）字符串转数组(整型)
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

--字符串转数组(浮点型)
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

--写入帧序列文本
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

--旋转特效
fn rotateTX isCome =(
	actionMan.executeAction 0 "40247" --选择摄像机
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

--导出图片
fn outPutImg ARR ViewAngle Action = (
	if ARR[1] == undefined then
	(--单张
		if cbxTX.checked then(
			rotateTX(true)
		)
		render outputFile:(edtAddress.text as string + ViewAngle +Action[rdo1.state] + "\\" + "1000.png") vfb:off
		if cbxTX.checked then(
			rotateTX(false)
		)
	)
	else
	(--多张
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

	--点击更新动画帧序列
	on btnWrite pressed do(
		--初始化参数
		Action = #("待机", "攻击", "防御", "疾跑", "受伤", "死亡", "坐下", "挥手", "特效")
		pb1.value = 0
		outPutTxt("下\\")(Action)
		outPutTxt("左下\\")(Action)
		outPutTxt("左\\")(Action)
		outPutTxt("左上\\")(Action)
		outPutTxt("上\\")(Action)
		outPutTxt("右上\\")(Action)
		outPutTxt("右\\")(Action)
		outPutTxt("右下\\")(Action)
		pb1.value = 100
		
	)

	--读取渲染配置
	on rdo1 changed rdoState do(
		readTxt(rdoState)
	)
	
--渲染流程
fn renderr = (
	--清理一次内存
	gc()
	--初始化灯光
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
	
	--初始化参数
	Action = #("待机", "攻击", "防御", "疾跑", "受伤", "死亡", "坐下", "挥手", "特效")
	ARR = switchStrToInteger edtFangAn.text--读取渲染关键帧
	pb1.value = 0--进度条归零
	pb1.color = color 255 0 0--进度条颜色设为红
	
--下
	goFindStopMessage()
	if emergencyExit then return()
	if cbxD.state then(
		actionMan.executeAction 0 "160"
		$a01.enabled = off
		$b01.enabled = on
		outPutImg(ARR)("下\\")(Action)
		outPutTxt("下\\")(Action)
		$a01.enabled = on
		$b01.enabled = off
		pb1.value = 12
	)
	
--左下
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxLD.state then(
		actionMan.executeAction 0 "167" 
		$a08.enabled = off
		$b08.enabled = on
		outPutImg(ARR)("左下\\")(Action)
		outPutTxt("左下\\")(Action)
		$a08.enabled = on
		$b08.enabled = off
		pb1.value = 25
	)
	
--左
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxL.state then(
		actionMan.executeAction 0 "166"
		$a07.enabled = off
		$b07.enabled = on
		outPutImg(ARR)("左\\")(Action)
		outPutTxt("左\\")(Action)
		$a07.enabled = on
		$b07.enabled = off
		pb1.value = 37
	)
	
--左上
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxLU.state then(
		actionMan.executeAction 0 "165" 
		$a06.enabled = off
		$b06.enabled = on
		outPutImg(ARR)("左上\\")(Action)
		outPutTxt("左上\\")(Action)
		$a06.enabled = on
		$b06.enabled = off
		pb1.value = 50
	)
	
--上
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxU.state then(
		actionMan.executeAction 0 "164"
		$a05.enabled = off
		$b05.enabled = on
		outPutImg(ARR)("上\\")(Action)
		outPutTxt("上\\")(Action)
		$a05.enabled = on
		$b05.enabled = off
		pb1.value = 62
	)
	
--右上
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxRU.state then(
		actionMan.executeAction 0 "163"
		$a04.enabled = off
		$b04.enabled = on
		outPutImg(ARR)("右上\\")(Action)
		outPutTxt("右上\\")(Action)
		$a04.enabled = on
		$b04.enabled = off
		pb1.value = 75
	)
	
--右
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxR.state then(
		actionMan.executeAction 0 "162"
		$a03.enabled = off
		$b03.enabled = on
		outPutImg(ARR)("右\\")(Action)
		outPutTxt("右\\")(Action)
		$a03.enabled = on
		$b03.enabled = off
		pb1.value = 87	
	)

--右下
	goFindStopMessage()
	if emergencyExit then return()
	rotate $g01 (angleaxis 45 [0,0,1])
	if cbxRD.state then(
		actionMan.executeAction 0 "161"
		$a02.enabled = off
		$b02.enabled = on
		outPutImg(ARR)("右下\\")(Action)
		outPutTxt("右下\\")(Action)
	)
	
	pb1.value = 100
	pb1.color = color 0 255 0
)

--修正相机位置
fn normalizeCamera cameraSelection = (
	case cameraSelection of(
		"35mm":(
			print ("切换35mm镜头")
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
			print ("切换28mm镜头")
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
			print ("当前场景方案(不修改镜头参数)")
		)
		2:(
			print ("默认方案 35mm镜头")
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
			print ("默认方案 28mm镜头")
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
			print ("低身位方案(不修改镜头参数)")
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
			print ("自定义方案")
			angleToCameraPosition()
		)
		6:(
			print("读取历史配置")
			--字符串转数字方法待实现
			strArr = switchStrToFloat (myReadTxt historyPath "相机角度" 1)[1]
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
			print ("当前备用方案（需要写入脚本）")
		)
	)
	--刷新相机角度显示参数
	cameraPositionToAngle()
	
	--删除g01的动画
	select $g01
	macros.run "Animation Tools" "DeleteSelectedAnimation"
)
	
--换材质（根节点名）（材质名）（序号）
fn changeMat nodeName matName m =(
	node = getNodeByName(nodeName)
	select node
	macros.run "Scene Explorer" "SESelectChildren"
	$.material = sceneMaterials[(matName + m as string)]
	print (nodeName + "已替换成材质：" + matName + m as string)
)

	--点击开始渲染
	on btnStart pressed do(
		print("执行渲染当前流程")
		set animate off
		max display mode
		--标准化摄像机
		normalizeCamera lbCameraSolution.selection
		--记录当前渲染配置
		writeHistoryTxt()
		--停止标识设置为false
		emergencyExit = false
		--渲染前自动保存(防止渲染中途崩溃)
		if cbxAutoSave.state do max file save
		--渲染流程
		renderr()
		if emergencyExit then(
			print("检测到终止号码,渲染已停止")
			return()
		)
	)
	
	--渲染全部
	on btnAll pressed do(
		print("执行渲染全部流程")
		set animate off
		max display mode
		--标准化摄像机
		normalizeCamera lbCameraSolution.selection
		--记录当前渲染配置
		writeHistoryTxt()
		--停止标识设置为false
		emergencyExit = false
		--渲染前自动保存(防止渲染中途崩溃)
		if cbxAutoSave.state do max file save
		
		--读取mat中的数据
		try(
			matFile = OpenFile edtMatAdd.text mode:"r"
			--通用
			utilArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "通用")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append utilArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--正常
			normalArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "正常")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append normalArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--晕眩
			yunArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "晕眩")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append yunArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--攻击
			attArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "晕眩")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append attArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--特效
			if cbxTX.checked then(
				txArr = #()
				while not eof matFile do(
					str = readLine matFile
					if (findString str "特效")!=undefined  then(
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
			edtMat.text = "读取mat错误"
			close matFile
			return()
		)
		--换材质并逐套渲染
		matARR = switchStrToInteger edtMat.text--读取材质序列
		for	m = 1 to matARR.count do(
			--换材质：通用
			for i = 1 to utilArr.count / 2 do(
				changeMat(utilArr[i * 2 - 1])(utilArr[i * 2])(matARR[m])
			)
			--换材质：攻击
			if rdo1.state == 2 then(
				for i = 1 to attArr.count / 2 do(
					changeMat(attArr[i * 2 - 1])(attArr[i * 2])(matARR[m])
				)
			)
			--换材质：晕眩(死亡、受击)
			if rdo1.state == 5 or rdo1.state == 6 then(
				for i = 1 to yunArr.count / 2 do(
					changeMat(yunArr[i * 2 - 1])(yunArr[i * 2])(matARR[m])
				)
			)
			--换材质：正常(待机、防御、疾跑)
			if rdo1.state == 1 or rdo1.state == 3 or rdo1.state == 4 then(
				for i = 1 to normalArr.count / 2 do(
					changeMat(normalArr[i * 2 - 1])(normalArr[i * 2])(matARR[m])
				)
			)
			--换材质：特效
			if cbxTX.checked then(
				for i = 1 to txArr.count / 2 do(
					changeMat(txArr[i * 2 - 1])(txArr[i * 2])(matARR[m])
				)
			)
			
			--修改地址
			addressOld = edtAddress.text
			if matARR[m] < 10 then(
				edtAddress.text = replace addressOld (addressOld.count - 3)(2)("0" + matARR[m] as string)
			)
			else(
				edtAddress.text = replace addressOld (addressOld.count - 3)(2)(matArr[m] as string)
			)
			
			--渲染当前材质
			renderr()
			--检查停止标识
			if emergencyExit then(
				print("检测到终止号码,渲染已停止")
				return()
			)
		)
		
	)
	
	--全选渲染事件
	on cbxALLORNONE changed theState do(
		cbxAllSelected theState
	)
	
	--切换35mm镜头
	on btn35mm pressed do(
		normalizeCamera "35mm"
	)
	
	--切换28mm镜头
	on btn28mm pressed do(
		normalizeCamera "28mm"
	)
	
	--获取当前摄像机角度
	on btnRCamera pressed do(
		cameraPositionToAngle()
	)
	
	--更新写入镜头位置
	on btnWCamera pressed do(
		angleToCameraPosition()
	)
	
	--更新相机方案
	on lbCameraSolution doubleClicked solutionChoice do(
		normalizeCamera solutionChoice
		cameraPositionToAngle()
	)
	
	--材质测试按钮
	on btnMaterialTest pressed do(
		--切换到右下视角
		actionMan.executeAction 0 "161"
		print("执行材质测试")
		
		--读取mat中的数据
		try(
			matFile = OpenFile edtMatAdd.text mode:"r"
			--通用
			utilArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "通用")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append utilArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--正常
			normalArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "正常")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append normalArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--晕眩
			yunArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "晕眩")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append yunArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--攻击
			attArr = #()
			while not eof matFile do(
				str = readLine matFile
				if (findString str "晕眩")!=undefined  then(
					count = (readLine matFile) as Integer
					for i = 1 to count * 2 do(
						str = readLine matFile
						append attArr str
					)
					exit
				)
			)
			seek matFile 0
			
			--特效
			if cbxTX.checked then(
				txArr = #()
				while not eof matFile do(
					str = readLine matFile
					if (findString str "特效")!=undefined  then(
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
			edtMat.text = "读取mat错误"
			close matFile
			return()
		)
		--换材质并逐套渲染
		matARR = switchStrToInteger edtMat.text--读取材质序列
		for	m = 1 to matARR.count do(
			--换材质：通用
			for i = 1 to utilArr.count / 2 do(
				changeMat(utilArr[i * 2 - 1])(utilArr[i * 2])(matARR[m])
			)
			--换材质：攻击
			if rdo1.state == 2 then(
				for i = 1 to attArr.count / 2 do(
					changeMat(attArr[i * 2 - 1])(attArr[i * 2])(matARR[m])
				)
			)
			--换材质：晕眩(死亡、受击)
			if rdo1.state == 5 or rdo1.state == 6 then(
				for i = 1 to yunArr.count / 2 do(
					changeMat(yunArr[i * 2 - 1])(yunArr[i * 2])(matARR[m])
				)
			)
			--换材质：正常(待机、防御、疾跑)
			if rdo1.state == 1 or rdo1.state == 3 or rdo1.state == 4 then(
				for i = 1 to normalArr.count / 2 do(
					changeMat(normalArr[i * 2 - 1])(normalArr[i * 2])(matARR[m])
				)
			)
			--换材质：特效
			if cbxTX.checked then(
				for i = 1 to txArr.count / 2 do(
					changeMat(txArr[i * 2 - 1])(txArr[i * 2])(matARR[m])
				)
			)
			redrawViews() 
			sleep 2
		)
	)
	
	--流程测试
	on btnOutputTest pressed do(
		print("未完成功能-流程测试")
	)
	
	on btnReadHistory pressed do(
		edtMat.text = (myReadTxt historyPath "材质序列" 1)[1]
		edtAddress.text = (myReadTxt historyPath "输出地址" 1)[1]
		edtFangAn.text = (myReadTxt historyPath "抽帧方案" 1)[1]
		edtXuLie.text = (myReadTxt historyPath "动画序列" 1)[1]
		edtTxtAdd.text = (myReadTxt historyPath "txt文件地址" 1)[1]
		edtMatAdd.text = (myReadTxt historyPath "mat文件地址" 1)[1]
	)
	
----------------------------------------------------------------------------------------------------------------------------------------
	--自定义测试用按钮
	on btnCustom pressed do(
		print("自定义测试按钮被按下")
		
		
	)
----------------------------------------------------------------------------------------------------------------------------------------
)

NewFloater = newRolloutFloater "超级出图5.5" 520 425
addRollout MainUI NewFloater
)