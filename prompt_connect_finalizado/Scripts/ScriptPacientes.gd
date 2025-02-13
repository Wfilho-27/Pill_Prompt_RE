extends Control

onready var patient_list = $FundoPacientes/ScrollContainer/VBoxContainer
var client
var connected: bool = false

const ip = "192.168.133.166"
const port = 80

#logica para reupar os pacientes na lista, caso eu troque de cena
func _ready():
	Global.editroom = ""
	Global.editname = ""
	Global.test = ""
	Global.test2 = ""
	Global.viewr_name = ""
	Global.viewname = ""
	Global.indice = ""
	Global.drawer_text = ""
	for user in Global.users:  
		var hbox = HBoxContainer.new()

		var labelname = Label.new()
		labelname.text = user 
		var themelabelname = load("res://Temas/labelkk.tres")
		labelname.theme = themelabelname
		hbox.add_child(labelname)

		var edit_button = Button.new()
		edit_button.text = " Editar "
		var themeedit_button = load("res://Temas/buttonkk.tres")
		edit_button.theme = themeedit_button
		edit_button.connect("pressed", self, "_on_edit_patient_pressed", [user])
		hbox.add_child(edit_button)

		var delete_button = Button.new()
		delete_button.text = " Excluir "
		var themedelete_button = load("res://Temas/buttonkk.tres")
		delete_button.theme = themedelete_button
		delete_button.connect("pressed", self, "_on_delete_patient_pressed", [hbox])
		hbox.add_child(delete_button)

		patient_list.add_child(hbox)  
	client = StreamPeerTCP.new()
	client.connect_to_host(ip, port)
	if(client.is_connected_to_host()):
		connected = true

#logica para adicionar paciente a biblioteca
func _add_user():
	var name = $CanvasLayer/LineEdit.text
	Global.patients[name] = {
	"sala": $CanvasLayer/LineEdit2.text,
	"gaveta": [],
	"horario": [],
	"minuto": [],
	"info": []
	}
	print (Global.patients)
	Global.rooms.append($CanvasLayer/LineEdit2.text)
	var patient_name = $CanvasLayer/LineEdit.text.strip_edges()
	Global.patientname = $CanvasLayer/LineEdit.text
	if patient_name != "":
		_addlabel_and_buttons(patient_name)
		$CanvasLayer/LineEdit.clear()
		$CanvasLayer/LineEdit2.clear()

#logica para abrir camada da criação do perfil do paciente
func _on_button_create_pressed():
	$CanvasLayer.visible = 1

#logica para quando o botão de adicionar patiente for pressionado
func _on_button_add_pressed():
	if len($CanvasLayer/LineEdit.text) > 3:
		if len($CanvasLayer/LineEdit2.text) > 0:
			_add_user()
			$CanvasLayer.visible = 0
		else:
			waittime2()
	else:
		waittime()

#logica para adicionar label com nome do paciente, botão de editar e botão de excluir
func _addlabel_and_buttons(name: String):
	var hbox = HBoxContainer.new()
	
	var labelname = Label.new()
	labelname.text = name
	var themelabelname = load("res://Temas/labelkk.tres")
	labelname.theme = themelabelname
	Global.users.append(name)
	print(Global.users)
	hbox.add_child(labelname)
	
	var edit_button = Button.new()
	edit_button.text = " Editar "
	var themeedit_button = load("res://Temas/buttonkk.tres")
	edit_button.theme = themeedit_button
	edit_button.connect("pressed", self, "_on_edit_patient_pressed", [name])
	hbox.add_child(edit_button)
	
	var delete_button = Button.new()
	delete_button.text = " Excluir "
	var themedelete_button = load("res://Temas/buttonkk.tres")
	delete_button.theme = themedelete_button
	delete_button.connect("pressed", self, "_on_delete_patient_pressed", [hbox])
	hbox.add_child(delete_button)
	
	patient_list.add_child(hbox)

#logica para abrir camada de edição para editar o paciente escolhido
func _on_edit_patient_pressed(name: String):
	$CanvasLayer3.visible = 1
	$CanvasLayer3/ColorRect/LineEdit.text = name
	for i in (len(Global.users)):  
		if name == Global.users[i]:
			print("condicao")
			$CanvasLayer3/ColorRect/LineEdit2.text = Global.rooms[i]
			Global.editname = name
			Global.test = name
			Global.editname = Global.test
			print (Global.editname)
			Global.editroom = Global.rooms[i]
			print(Global.editroom)
			Global.test2 = Global.editroom

func indicesave(index: int):
	Global.indicepat = Global.patients[name]["sala"][index]

#logica do botão de deletar usuario e todas informações dele
func _on_delete_patient_pressed(hbox: HBoxContainer):
	var label1 = hbox.get_child(0)
	var label2 = hbox.get_child(1)
	var labelroom = label2.text
	var labelname = label1.text
	print(str(labelroom))
	for name in Global.patients.keys():
		print("func")
		if name == labelname:
			Global.patients.erase(name)
			print(Global.patients)
		for e in (len(Global.rooms)):
			if labelroom == Global.rooms[e]:
				Global.rooms.erase(e)
		for user in Global.users:
			if user == labelname: 
				Global.users.erase(user)
				print("1", Global.users)
				hbox.queue_free() 

#logica para o botão de confirmar edição de um usuario
func _on_Buttonconfirmedit_pressed():
	if len($CanvasLayer3/ColorRect/LineEdit.text) > 3:
		if len($CanvasLayer3/ColorRect/LineEdit2.text) > 0:
			print("apertei")
			var lineeditname = $CanvasLayer3/ColorRect/LineEdit.text
			var lineeditroom = $CanvasLayer3/ColorRect/LineEdit2.text
			for name in Global.patients.keys(): #verifica cada nome dentro de G.patients
				print("passo1")
				print (Global.patients[name])
				print (Global.patients[name]["sala"])
				print(name)
				print(Global.editname, "oo")
				for sala in Global.patients[name].keys(): #verifica cada sala de cada nome dentro de G.patients
					print(Global.editname)
					if Global.test == name: #se nome para editar for igual a nome verificado
						print("passou2")
						var newroom = lineeditroom
						Global.patients[name].erase(sala)
						Global.patients[name]["sala"] = newroom
						var newname = lineeditname
						Global.auxiliar = Global.patients[name]
						Global.patients.erase(name)
						Global.patients[newname] = Global.auxiliar
						print (Global.patients[newname])
						print (Global.users)
						name = lineeditname
						for e in range(len(Global.rooms)): #verificar cada indice de G.rooms
							if Global.rooms[e] == Global.test2:
								Global.rooms[e] = lineeditroom
								Global.test2 = ""
						for i in range(len(Global.users)): #verificar cada indice de G.users
							if Global.users[i] == Global.test:
								Global.users[i] = lineeditname
								Global.test = ""
								$CanvasLayer3.visible = 0
								newname = ""
								newroom = ""
								lineeditname = ""
								lineeditroom = ""
								print (Global.users)
								get_tree().change_scene("res://Cenas/Patients.tscn")
		else:
			waittime2_canva3()
	else:
		waittime_canva3()
	print (Global.users)

#logica para voltar para o menu principal
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		TransitionScreen.fade_in("res://Cenas/Menu.tscn")

func _process(delta) -> void:
	var _g = 0.80 + sin(Time.get_ticks_msec() / 369.0) * 0.20;
	$LabelGer6.modulate = Color(0.0, _g, 33.0, 1.0);
	$Label.text = str(Global.getHour(),":",Global.getMin(),":",Global.getSec())
	$Label.modulate = Color(0.0, _g, 33.0, 1.0);

#logica para mudar para a cena dos pacientes
func _on_ButtonPatients_pressed():
	TransitionScreen.fade_in("res://Cenas/Patients.tscn")

#logica para mudar para a cena das agendas
func _on_ButtonAgenda_pressed():
	TransitionScreen.fade_in("res://Cenas/Agenda.tscn")

#logica para caso não passe de uma condição mostrar para o usuario 
func waittime():
	if len($CanvasLayer/LineEdit.text) == 0:
		$CanvasLayer/Label4.text = str("Alguma informação não foi preenchida")
		$CanvasLayer/Label4.visible = true
		yield(get_tree().create_timer(3.0), "timeout")
		$CanvasLayer/Label4.visible = false
		$CanvasLayer/Label4.text = str("")
	if len($CanvasLayer/LineEdit.text) <= 3 and len($CanvasLayer/LineEdit.text) > 0:
		$CanvasLayer/Label3.text = str("Nome do Paciente muito curto")
		$CanvasLayer/Label3.visible = true
		yield(get_tree().create_timer(3.0), "timeout")
		$CanvasLayer/Label3.visible = false
		$CanvasLayer/Label3.text = str("")

#logica2 para caso não passe de uma condição mostrar para o usuario 
func waittime2():
	$CanvasLayer/Label4.text = str("Alguma informação não foi preenchida")
	$CanvasLayer/Label4.visible = true
	yield(get_tree().create_timer(3.0), "timeout")
	$CanvasLayer/Label4.visible = false
	$CanvasLayer/Label4.text = str("")

#logica3 para caso não passe de uma condição mostrar para o usuario 
func waittime_canva3():
	if len($CanvasLayer3/ColorRect/LineEdit.text) == 0:
		$CanvasLayer3/ColorRect/Label4.text = str("Alguma informação não foi preenchida")
		$CanvasLayer3/ColorRect/Label4.visible = true
		yield(get_tree().create_timer(3.0), "timeout")
		$CanvasLayer3/ColorRect/Label4.visible = false
		$CanvasLayer3/ColorRect/Label4.text = str("")
	if len($CanvasLayer3/ColorRect/LineEdit.text) <= 3 and len($CanvasLayer3/ColorRect/LineEdit.text) > 0:
		$CanvasLayer3/ColorRect/Label3.text = str("Nome do Paciente muito curto")
		$CanvasLayer3/ColorRect/Label3.visible = true
		yield(get_tree().create_timer(3.0), "timeout")
		$CanvasLayer3/ColorRect/Label3.visible = false
		$CanvasLayer3/ColorRect/Label3.text = str("")

#logica4 para caso não passe de uma condição mostrar para o usuario 
func waittime2_canva3():
	$CanvasLayer3/ColorRect/Label4.text = str("Alguma informação não foi preenchida")
	$CanvasLayer3/ColorRect/Label4.visible = true
	yield(get_tree().create_timer(3.0), "timeout")
	$CanvasLayer3/ColorRect/Label4.visible = false
	$CanvasLayer3/ColorRect/Label4.text = str("")

#logica para sair da tela de criação de um novo paciente
func _on_buttonexitmakepatient_pressed():
	TransitionScreen.fad_in()
	$CanvasLayer.visible = 0
	TransitionScreen.fad_out()
	$CanvasLayer/LineEdit.text = ("")
	$CanvasLayer/LineEdit2.text = ("")

#logica para sair da tela de editar um paciente
func _on_buttonexiteditpatient_pressed():
	Global.editroom = ""
	Global.editname = ""
	TransitionScreen.fad_in()
	$CanvasLayer3.visible = false
	TransitionScreen.fad_out()
	$CanvasLayer3/ColorRect/LineEdit.text = ("")
	$CanvasLayer3/ColorRect/LineEdit2.text = ("")


func _on_Buttonexit_pressed():
	TransitionScreen.fade_in("res://Cenas/Menu.tscn")
