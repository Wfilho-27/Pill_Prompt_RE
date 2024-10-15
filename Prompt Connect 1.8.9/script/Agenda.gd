extends Control

onready var patient_list = $ScrollContainer/VBoxContainer
onready var agenda_list = $CanvasLayer2/ColorRect/ScrollContainer/VBoxContainer
onready var optionbutton = $CanvasLayer/ColorRect/OptionButtondrawer
var Hbox 
#logica para sair da cena atual
func _on_Button_exit_pressed():
	TransitionScreen.fade_in("res://cenas/principal.tscn")

func _ready():
	if Global.patientname != "":
		_add_patients_in_screen(Global.patientname)

#logica para adicionar os pacientes na tela, junto com os botões de anexar agenda e de visualizar agenda
func _add_patients_in_screen(name: String):
	for user in Global.users:  
		var hbox = HBoxContainer.new()
		Hbox = hbox

		var labelname = Label.new()
		labelname.text = user 
		hbox.add_child(labelname)

		var view_agenda_button = Button.new()
		view_agenda_button.text = "Visualizar Agenda"
		view_agenda_button.connect("pressed", self, "_on_view_agenda_patient_pressed", [user])
		hbox.add_child(view_agenda_button)

		patient_list.add_child(hbox)  

func _on_view_agenda_patient_pressed(name: String):
	print("apertei")
	var labelname = name
	$CanvasLayer2.visible = 1
	for name in Global.patients:
		if name == labelname:
			print("passo1")
			Global.viewr_name = labelname
			var num_entries = Global.patients[name]["gaveta"].size()
			if num_entries > 0:
				for i in range(num_entries):
					print("passo2")
					var hboxagenda = HBoxContainer.new()

#				for gaveta in Global.patients[name]["gaveta"]:
					var labelgaveta = Label.new()
					labelgaveta.text = "gaveta: " + str(Global.patients[name]["gaveta"][i], str(", "))
					hboxagenda.add_child(labelgaveta)

#				for horario in Global.patients[name]["horario"]:
					var labelhorario = Label.new()
					labelhorario.text = "hora: " + str(Global.patients[name]["horario"][i], str(":"), str(Global.patients[name]["minuto"][i], str(", ")))
					hboxagenda.add_child(labelhorario)

#				for minuto in Global.patients[name]["minuto"]:
#					var labelminuto = Label.new()
#					labelminuto.text = "minuto: " + str(Global.patients[name]["minuto"][i], str(", "))
#					hboxagenda.add_child(labelminuto)

#				for info in Global.patients[name]["info"]:
					var labelinfo = Label.new()
					labelinfo.text = "dosagem e quantidade: " + str(Global.patients[name]["info"][i], str(", "))
					hboxagenda.add_child(labelinfo)

					agenda_list.add_child(hboxagenda)

func _on_Button_add_agenda_pressed():
	$CanvasLayer.visible = 0
	for name in Global.patients:
		print("sla")
		print (Global.viewr_name)
		if name == Global.viewr_name:
			var addhour = $CanvasLayer/ColorRect/LineEdithour.text
			var addminute = $CanvasLayer/ColorRect/LineEditminute.text
			var addinfo = $CanvasLayer/ColorRect/LineEditinfo.text
			var adddrawer = Global.drawer_text
			Global.patients[name]["horario"].append(str(addhour))
			Global.patients[name]["minuto"].append(str(addminute))
			Global.patients[name]["gaveta"].append(str(adddrawer))
			Global.patients[name]["info"].append(str(addinfo))
			print (Global.patients[name])
			get_tree().change_scene("res://cenas/Agenda.tscn")
			Global.drawer_text = ""

func option_button():
	for i in range(len(Global.drawers_avaliable)):
		optionbutton.add_item(Global.drawers_avaliable[i])


func _on_Button_createagenda_pressed():
	$CanvasLayer.visible = 1
	option_button()
	


func _on_OptionButtondrawer_item_selected(index):
	var selected_i = optionbutton.get_selected_id()
	var selected_text = optionbutton.get_item_text(selected_i)
	Global.drawer_text = selected_text


func _on_Button_return_pressed():
	$CanvasLayer2.visible = 0
