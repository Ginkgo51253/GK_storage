linux服务端
linux server pack.
开启后只有两条主要命令
there are two essential commands.

wait		@用于开启一个测试用基于控制台的服务
		@open a test based on terminal
daemon		@用于开启后台持续执行的服务
		@open the main server

或者exit用于程序正常退出，开启服务后无法向程序输入指令
or input 'exit' to exit.

workroute为开启服务后的工作目录路径，文件中需要填写工作目录的具体路径（建议填写绝对路径）
'workroute' contains the path of the working files. best to fill in the absolute path.
user存放用户基础信息
'user' contains users' basic message.
conf存放端口开启信息（初始为0.0.0.0 9999即本机广播地址9999号端口）
'conf' contains the ip&port message that the program is using.

