extends Node

var txt = ""

var client
var connected: bool = false

var ip = "192.168.133.166"
const port = 80



func _ready():
	client = StreamPeerTCP.new()
	client.connect_to_host(ip, port)
	if(client.is_connected_to_host()):
		connected = true
		print("Conectado - GD")

func _process(delta):
	if connected and not client.is_connected_to_host():
		connected = false
	else:
		var label = Label.new()
		add_child(label)
		label.text = str("ai dento")
		label.rect_position.x = 960
		label.rect_position.y = 540
		_readWebSocket()
		_mandarbag()

func _mandarbag():
	for name in Global.patients.keys():#entrar nas variaveis dos pacientes de um por um
		for e in range(len(Global.patients[name]["horario"])):#verificar as variaveis de horario do pacientede um por um 
			if int(Global.patients[name]["horario"][e]) == Global.getHour():#caso ordem de hora verificada for a atual
				print("hora")
				if int(Global.patients[name]["minuto"][e]) == Global.getMin() and Global.getSec() == 3:#caso ordem de hora verificada for a atual
					print("minuto")
					var draweralert = str(Global.patients[name]["gaveta"][e])#guardar gaveta que tem a hora e minuto de agora
					print (draweralert)
					if draweralert == str("A1"):
						print("A111")
						_writeWebsocket("0\n")
					elif draweralert == str("A2"):
						_writeWebsocket("1\n")
					elif draweralert == str("A3"):
						_writeWebsocket("2\n")
					elif draweralert == str("A4"):
						_writeWebsocket("3\n")
					elif draweralert == str("A5"):
						_writeWebsocket("4\n")

#func _mandarbag():
#	for i in range(len(Global.horas)):
#		print("222222")
#		if int(Global.horas[i]) == Global.getHour() and int(Global.mins[i]) == Global.getMins() and int (Global.getSecs() == 0):
#			var opcao = Global.opcao[i]
#			for e in range(len(Global.possgav)):
#				if (Global.possgav[e]) == opcao:
#					print("444444")
#					print(Global.horas[i],":",Global.mins[i],opcao,Global.possgav[e], e+1)
#					if e == 0:
#						_writeWebsocket("0\n")
#					elif e == 1:
#						_writeWebsocket("1\n")
#					elif e == 2:
#						_writeWebsocket("2\n")
#					elif e == 3:
#						_writeWebsocket("3\n")
#					elif e == 4:
#						_writeWebsocket("4\n")

# Lê mensagens enquanto estiver conectado
func _readWebSocket():
	while client.get_available_bytes()>0:
		var message = client.get_utf8_string(client.get_available_bytes())
		# Evitar bugs e mensagens vazias
		if message == null:
			continue
			# Recebe as mensagens e manda interpretar
		elif message.length() > 0:
			print(message)
			for i in message:
				if i =='\n':
					# Mensagem recebida por completo.
					_messageInterpreter(txt)
					txt = "";
				else:
					txt += i

func _writeWebsocket(txt):
	if connected and client.is_connected_to_host():
		client.put_data(txt.to_ascii())

func _messageInterpreter(txt):
	var command = txt.split('')
	
	if command.size() == 2:
		print("tamanho 2")
		if command[0] == "rav":
			print("recebi")
