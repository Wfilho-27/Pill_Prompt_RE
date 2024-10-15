extends Control

onready var patient_list = $ScrollContainer/VBoxContainer

#logica para reupar os pacientes na lista, caso eu troque de cena
func _ready():
	for user in Global.users:  
		var hbox = HBoxContainer.new()

		var labelname = Label.new()
		labelname.text = user 
		hbox.add_child(labelname)

		var edit_button = Button.new()
		edit_button.text = "Editar"
		edit_button.connect("pressed", self, "_on_edit_patient_pressed", [user])
		hbox.add_child(edit_button)

		var delete_button = Button.new()
		delete_button.text = "Excluir"
		delete_button.connect("pressed", self, "_on_delete_patient_pressed", [hbox])
		hbox.add_child(delete_button)

		patient_list.add_child(hbox)  

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
	Global.patientname = $CanvasLayer/LineEdit.text.strip_edges()
	if patient_name != "":
		_addlabel_and_buttons(patient_name)
		$CanvasLayer/LineEdit.clear()
		$CanvasLayer/LineEdit2.clear()

#logica para sair da cena atual
func _on_Button_exit_pressed():
	TransitionScreen.fade_in("res://cenas/principal.tscn")

#logica para abrir camada da criação do perfil do paciente
func _on_button_create_pressed():
	$CanvasLayer.visible = 1

#logica para quando o botão de adicionar patiente for pressionado
func _on_button_add_pressed():
	if len($CanvasLayer/LineEdit.text) > 3:
		if len($CanvasLayer/LineEdit2.text) > 0:
			_add_user()
			$CanvasLayer.visible = 0

#logica para adicionar label com nome do paciente, botão de editar e botão de excluir
func _addlabel_and_buttons(name: String):
	var hbox = HBoxContainer.new()
	
	var labelname = Label.new()
	labelname.text = name
	Global.users.append(name)
	print(Global.users)
	hbox.add_child(labelname)
	
	var edit_button = Button.new()
	edit_button.text = "Editar"
	edit_button.connect("pressed", self, "_on_edit_patient_pressed", [name])
	hbox.add_child(edit_button)
	
	var delete_button = Button.new()
	delete_button.text = "Excluir"
	delete_button.connect("pressed", self, "_on_delete_patient_pressed", [hbox])
	hbox.add_child(delete_button)
	
	patient_list.add_child(hbox)

#logica para abrir camada de edição para editar o paciente escolhido
func _on_edit_patient_pressed(name: String):
	$CanvasLayer3.visible = 1
	$CanvasLayer3/ColorRect/LineEdit.text = name
	for i in (len(Global.users)):  
		if name == Global.users[i]:
			$CanvasLayer3/ColorRect/LineEdit2.text = Global.rooms[i]
			Global.editname = name
			print (Global.editname)
			Global.editroom = Global.rooms[i]

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
	print("apertei")
	var lineeditname = $CanvasLayer3/ColorRect/LineEdit.text
	var lineeditroom = $CanvasLayer3/ColorRect/LineEdit2.text
	for name in Global.patients.keys(): #verifica cada nome dentro de G.patients
		print("passo1")
		print (Global.patients[name])
		print (Global.patients[name]["sala"])
		print(name)
		print(Global.editname)
		for sala in Global.patients[name].keys(): #verifica cada sala de cada nome dentro de G.patients
			print(Global.editname)
			if Global.editname == name: #se nome para editar for igual a nome verificado
				print("passou2")
				var newroom = lineeditroom
				Global.patients[name].erase(sala)
				Global.patients[name]["sala"] = newroom
				var newname = lineeditname
				Global.patients[newname] = Global.patients[name]
				print (Global.patients[newname])
				print(Global.patients[name])
				Global.patients.erase(name)
				print (Global.users)
				name = lineeditname
				for e in range(len(Global.rooms)): #verificar cada indice de G.rooms
					if Global.rooms[e] == Global.editroom:
						Global.rooms[e] = lineeditroom
						Global.editroom = ""
				for i in range(len(Global.users)): #verificar cada indice de G.users
					if Global.users[i] == Global.editname:
						Global.users[i] = lineeditname
						Global.editname = ""
						get_tree().change_scene("res://cenas/Pacientes.tscn")
						$CanvasLayer3.visible = 0
#						print(Global.patients)
						newname = ""
						newroom = ""
						lineeditname = ""
						lineeditroom = ""
						print (Global.users)
