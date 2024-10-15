extends Control

onready var patient_list = $ScrollContainer/VBoxContainer
onready var agenda_list = $CanvasLayer2/ColorRect/ScrollContainer/VBoxContainer
onready var optionbutton = $CanvasLayer/ColorRect/OptionButtondrawer
onready var optionbuttonedit = $CanvasLayer3/ColorRect/OptionButtondraweredit
var Hbox 
#logica para sair da cena atual
func _on_Button_exit_pressed():
	TransitionScreen.fade_in("res://cenas/principal.tscn")

#logica para chamar os pacientes na tela
func _ready():
	if Global.patientname != "":
		_add_patients_in_screen(Global.patientname)

#logica para adicionar os pacientes na tela, junto com o botão de visualizar agenda
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

#logica para quando apertar o botão de visualizar a agenda do paciente, para add todos os dados na tela
func _on_view_agenda_patient_pressed(name: String):
	var vbox = $CanvasLayer2/ColorRect/ScrollContainer/VBoxContainer
	if vbox.get_child_count() > 0 :
		for child in vbox.get_children():
			child.queue_free()
	print("apertei")
	var labelname = name
	print ("name", name)
	$CanvasLayer2.visible = 1
	for nname in Global.patients.keys():
		print ("Gname", name)
		if nname == labelname:
			print (labelname)
			print("passo1")
			Global.viewr_name = labelname
			print (Global.viewr_name)
			var num_entries = Global.patients[name]["gaveta"].size()
			if num_entries > 0:
				for i in range(num_entries):
					print("passo2")
					var hboxagenda = HBoxContainer.new()

					var labelgaveta01 = Label.new()
					labelgaveta01.text = "gaveta: "
					hboxagenda.add_child(labelgaveta01)

					var labelgaveta02 = Label.new()
					labelgaveta02.text = str(Global.patients[name]["gaveta"][i])
					hboxagenda.add_child(labelgaveta02)

					var labelgaveta03 = Label.new()
					labelgaveta03.text = str(", ")
					hboxagenda.add_child(labelgaveta03)

					var labelhorario = Label.new()
					labelhorario.text = "hora: " + str(Global.patients[name]["horario"][i], str(":"), str(Global.patients[name]["minuto"][i], str(", ")))
					hboxagenda.add_child(labelhorario)

					var labelinfo = Label.new()
					labelinfo.text = "dosagem e quantidade: " + str(Global.patients[name]["info"][i], str(", "))
					hboxagenda.add_child(labelinfo)

					var button_edit = Button.new()
					button_edit.text = "editar" 
					button_edit.connect("pressed", self, "_on_edit_agenda_patient_pressed", [i])
					hboxagenda.add_child(button_edit)

					var button_delete = Button.new()
					button_delete.text = "excluir" 
					button_delete.connect("pressed", self, "_on_delete_agenda_patient_pressed", [hboxagenda])
					hboxagenda.add_child(button_delete)


					agenda_list.add_child(hboxagenda)

#logica para excluir agenda  #### não finalizada ####
func _on_delete_agenda_patient_pressed(hboxagenda: HBoxContainer):
	print ("delete")
	print (name)

#logica para abrir tela de edição da agenda selecionada e add os dados da agenda selecionada
func _on_edit_agenda_patient_pressed(index: int):
	print("edit")
	$CanvasLayer3.visible = 1
	var patient_name = Global.viewr_name
	var gaveta = Global.patients[patient_name]["gaveta"][index]
	var horario = Global.patients[patient_name]["horario"][index]
	var minuto = Global.patients[patient_name]["minuto"][index]
	var info = Global.patients[patient_name]["info"][index]
	Global.indice = index
	option_button_edit()
	$CanvasLayer3/ColorRect/LineEditinfoedit.text = info
	$CanvasLayer3/ColorRect/LineEdithouredit.text = horario
	$CanvasLayer3/ColorRect/LineEditminuteedit.text = minuto

#logica para pegar os dados das linesedits e substituir no indice dos dados do paciente correto
func _on_Button_confirmedit_agenda_pressed():
	$CanvasLayer3.visible = 0
	var patient_name = Global.viewr_name
	var gavetaedit = Global.drawer_edit_text
	var horarioedit = $CanvasLayer3/ColorRect/LineEdithouredit.text
	var minutoedit = $CanvasLayer3/ColorRect/LineEditminuteedit.text
	var infoedit = $CanvasLayer3/ColorRect/LineEditinfoedit.text
	if gavetaedit == "":
		gavetaedit = "A1"
	Global.patients[patient_name]["gaveta"][Global.indice] = gavetaedit
	Global.patients[patient_name]["horario"][Global.indice] = horarioedit
	Global.patients[patient_name]["minuto"][Global.indice] = minutoedit
	Global.patients[patient_name]["info"][Global.indice] = infoedit
	var vbox = $CanvasLayer2/ColorRect/ScrollContainer/VBoxContainer
	if vbox.get_child_count() > 0 :
		for child in vbox.get_children():
			child.queue_free()
	_on_view_agenda_patient_pressed(Global.patientname)
	$CanvasLayer3/ColorRect/LineEditinfoedit.clear()
	$CanvasLayer3/ColorRect/LineEdithouredit.clear()
	$CanvasLayer3/ColorRect/LineEditminuteedit.clear()
	$CanvasLayer3/ColorRect/OptionButtondraweredit.clear()

#logica para quando confirmar a adição de uma agenda nova, salvando seus dados e add no scroolcontainer da agenda
func _on_Button_add_agenda_pressed():
	$CanvasLayer.visible = 0
	for name in Global.patients.keys():
		print("sla")
		print (Global.viewr_name)
		if name == Global.viewr_name:
			var addhour = $CanvasLayer/ColorRect/LineEdithour.text
			var addminute = $CanvasLayer/ColorRect/LineEditminute.text
			var addinfo = $CanvasLayer/ColorRect/LineEditinfo.text
			var adddrawer = Global.drawer_text
			if adddrawer == "":
				adddrawer = "A1"
			Global.patients[name]["horario"].append(str(addhour))
			Global.patients[name]["minuto"].append(str(addminute))
			Global.patients[name]["gaveta"].append(str(adddrawer))
			Global.patients[name]["info"].append(str(addinfo))
			print (Global.patients[name])
			var vbox = $CanvasLayer2/ColorRect/ScrollContainer/VBoxContainer
			if vbox.get_child_count() > 0 :
				for child in vbox.get_children():
					child.queue_free()
			_on_view_agenda_patient_pressed(Global.patientname)
			Global.drawer_text = ""
			$CanvasLayer/ColorRect/LineEdithour.clear()
			$CanvasLayer/ColorRect/LineEditminute.clear()
			$CanvasLayer/ColorRect/LineEditinfo.clear()
			optionbutton.clear()
			print(Global.patientname)

#logica para adicionar as gavetas no optionbutton
func option_button():
	for i in range(len(Global.drawers_avaliable)):
		optionbutton.add_item(Global.drawers_avaliable[i])

#logica para adicionar as gavetas no optionbutton de edição
func option_button_edit():
	for i in range(len(Global.drawers_avaliable)):
		optionbuttonedit.add_item(Global.drawers_avaliable[i])

#logica para abrir canva de criação de uma agenda nova
func _on_Button_createagenda_pressed():
	$CanvasLayer.visible = 1
	option_button()

#logica para descobrir gaveta selecionada no option button
func _on_OptionButtondrawer_item_selected(index):
	var selected_i = optionbutton.get_selected_id()
	var selected_text = optionbutton.get_item_text(selected_i)
	Global.drawer_text = selected_text
	print (Global.drawer_text)

#logica para sair do canva das agenda de determinado paciente
func _on_Button_return_pressed():
	$CanvasLayer2.visible = 0

#logica para descobrir a gaveta da agenda editada de determinado paciente
func _on_OptionButtondraweredit_item_selected(index):
	var selected_i = optionbuttonedit.get_selected_id()
	var selected_text = optionbuttonedit.get_item_text(selected_i)
	Global.drawer_edit_text = selected_text
	print(Global.drawer_edit_text)



