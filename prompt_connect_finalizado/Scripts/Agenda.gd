extends Control

onready var patient_list = $ScrollContainer/VBoxContainer
onready var agenda_list = $CanvasLayer2/ColorRect/ScrollContainer/VBoxContainer
onready var optionbutton = $CanvasLayer/ColorRect/OptionButtondrawer
onready var optionbuttonedit = $CanvasLayer3/ColorRect/OptionButtondraweredit
var Hbox 

var client
var connected: bool = false

const ip = "192.168.133.166"
const port = 80

#logica para chamar os pacientes na tela caso exista
func _ready():
	Global.editroom = ""
	Global.editname = ""
	Global.test = ""
	Global.test2 = ""
	Global.viewr_name = ""
	Global.viewname = ""
	Global.indice = ""
	Global.drawer_text = ""
	if len(Global.patientname) > 0:
		_add_patients_in_screen(Global.patientname)
	client = StreamPeerTCP.new()
	client.connect_to_host(ip, port)
	if(client.is_connected_to_host()):
		connected = true

func _process(delta):
	var _g = 0.80 + sin(Time.get_ticks_msec() / 369.0) * 0.20;
	$LabelGer6.modulate = Color(0.0, _g, 33.0, 1.0);
	$Label.text = str(Global.getHour(),":",Global.getMin(),":",Global.getSec())
	if connected and not client.is_connected_to_host():
		connected = false
	else:
		$Label.modulate = Color(0.0, _g, 33.0, 1.0);

#logica para sair da cena atual
func _on_Button_exit_pressed():
	Global.viewr_name = ""
	Global.drawer_text = ""
	Global.drawer_edit_text = ""
	Global.indice = ""
	Global.viewname = ""
	TransitionScreen.fade_in("res://cenas/principal.tscn")

#logica para adicionar os pacientes na tela, junto com o botão de visualizar agenda
func _add_patients_in_screen(name: String):
	for user in Global.users:  
		var hbox = HBoxContainer.new()
		Hbox = hbox

		var labelname = Label.new()
		labelname.text = user 
		var themelabelname = load("res://Temas/labelkk.tres")
		labelname.theme = themelabelname
		hbox.add_child(labelname)

		var view_agenda_button = Button.new()
		view_agenda_button.text = "Visualizar Agenda"
		view_agenda_button.connect("pressed", self, "_on_view_agenda_patient_pressed", [user])
		var themeview_button = load("res://Temas/buttonkk.tres")
		view_agenda_button.theme = themeview_button
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
			Global.viewname = labelname
			Global.viewr_name = labelname
			$CanvasLayer2/ColorRect/Label.text = str("Agenda do ", Global.viewr_name)
			print (Global.viewr_name)
			var num_entries = Global.patients[name]["gaveta"].size()
			if num_entries > 0:
				for i in range(num_entries):
					print("passo2")
					var hboxagenda = HBoxContainer.new()

					var labelgaveta01 = Label.new()
					labelgaveta01.text = "gaveta: "
					hboxagenda.add_child(labelgaveta01)
					var themelabelgaveta01 = load("res://Temas/labelkk.tres")
					labelgaveta01.theme = themelabelgaveta01

					var labelgaveta02 = Label.new()
					labelgaveta02.text = str(Global.patients[name]["gaveta"][i])
					hboxagenda.add_child(labelgaveta02)
					var themelabelgaveta02 = load("res://Temas/labelkk.tres")
					labelgaveta02.theme = themelabelgaveta01

					var labelgaveta03 = Label.new()
					labelgaveta03.text = str(", ")
					hboxagenda.add_child(labelgaveta03)
					var themelabelgaveta03 = load("res://Temas/labelkk.tres")
					labelgaveta03.theme = themelabelgaveta01

					var labelhorario01 = Label.new()
					labelhorario01.text = ", hora: "
					hboxagenda.add_child(labelhorario01)
					var themelabelhorario01 = load("res://Temas/labelkk.tres")
					labelhorario01.theme = themelabelgaveta01

					var labelhorario02 = Label.new()
					labelhorario02.text = str(Global.patients[name]["horario"][i])
					hboxagenda.add_child(labelhorario02)
					var themelabelhorario02 = load("res://Temas/labelkk.tres")
					labelhorario02.theme = themelabelgaveta01

					var labelhorario03 = Label.new()
					labelhorario03.text = str(":")
					hboxagenda.add_child(labelhorario03)
					var themelabelhorario03 = load("res://Temas/labelkk.tres")
					labelhorario03.theme = themelabelgaveta01

					var labelhorario04 = Label.new()
					labelhorario04.text = str(Global.patients[name]["minuto"][i])
					hboxagenda.add_child(labelhorario04)
					var themelabelhorario04 = load("res://Temas/labelkk.tres")
					labelhorario04.theme = themelabelgaveta01

					var labelinfo01 = Label.new()
					labelinfo01.text = ", dosagem e quantidade: "
					hboxagenda.add_child(labelinfo01)
					var themelabelinfo01 = load("res://Temas/labelkk.tres")
					labelinfo01.theme = themelabelgaveta01

					var labelinfo02 = Label.new()
					labelinfo02.text = str(Global.patients[name]["info"][i])
					hboxagenda.add_child(labelinfo02)
					var themelabelinfo02 = load("res://Temas/labelkk.tres")
					labelinfo02.theme = themelabelgaveta01

					var button_edit = Button.new()
					button_edit.text = "editar" 
					button_edit.connect("pressed", self, "_on_edit_agenda_patient_pressed", [i])
					hboxagenda.add_child(button_edit)
					var themebuttonedit = load("res://Temas/buttonkk.tres")
					button_edit.theme = themebuttonedit

					var button_delete = Button.new()
					button_delete.text = "excluir" 
					button_delete.connect("pressed", self, "_on_delete_agenda_patient_pressed", [hboxagenda])
					hboxagenda.add_child(button_delete)
					var themebuttondelete = load("res://Temas/buttonkk.tres")
					button_delete.theme = themebuttondelete


					agenda_list.add_child(hboxagenda)

#logica para excluir agenda selecionada de determinado paciente
func _on_delete_agenda_patient_pressed(hboxagenda: HBoxContainer):
	print ("delete")
	var labeldrawer = hboxagenda.get_child(1)
	var labelhour = hboxagenda.get_child(4)
	var labelmin = hboxagenda.get_child(6)
	var labelinfo = hboxagenda.get_child(8)
	var drawerdelete = labeldrawer.text
	print (drawerdelete)
	var hourdelete = labelhour.text
	var mindelete = labelmin.text
	var infodelete = labelinfo.text
	for name in Global.patients.keys():
		if name == Global.viewr_name:
			for i in range(Global.patients[name]["gaveta"].size()):
				var drawer_value = Global.patients[name]["gaveta"][i]
				if drawerdelete == drawer_value:
					var deletedrawer = str(Global.patients[name]["gaveta"][i])
					var deletehour = str(Global.patients[name]["horario"][i])
					var deletemin = str(Global.patients[name]["minuto"][i])
					var deleteinfo = str(Global.patients[name]["info"][i])
					Global.patients[name]["gaveta"].erase(deletedrawer)
					Global.patients[name]["horario"].erase(deletehour)
					Global.patients[name]["minuto"].erase(deletemin)
					Global.patients[name]["info"].erase(deleteinfo)
					print(Global.patients)
					_on_view_agenda_patient_pressed(Global.viewr_name)

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
	$CanvasLayer3/ColorRect/LineEditinfoedit.text = str(info)
	$CanvasLayer3/ColorRect/LineEdithouredit.text = str(horario)
	$CanvasLayer3/ColorRect/LineEditminuteedit.text = str(minuto)

#logica para pegar os dados das linesedits e substituir no indice dos dados do paciente correto
func _on_Button_confirmedit_agenda_pressed():
	if int($CanvasLayer3/ColorRect/LineEdithouredit.text) in Global.hour:
		if int($CanvasLayer3/ColorRect/LineEditminuteedit.text) in Global.mins:
			if len($CanvasLayer3/ColorRect/LineEdithouredit.text) != 0 and len($CanvasLayer3/ColorRect/LineEditminuteedit.text) != 0 and len($CanvasLayer3/ColorRect/LineEditinfoedit.text) != 0:
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
				_on_view_agenda_patient_pressed(Global.viewr_name)
				$CanvasLayer3/ColorRect/LineEditinfoedit.clear()
				$CanvasLayer3/ColorRect/LineEdithouredit.clear()
				$CanvasLayer3/ColorRect/LineEditminuteedit.clear()
				$CanvasLayer3/ColorRect/OptionButtondraweredit.clear()
				Global.indice = ""
				$CanvasLayer3.visible = 0
			else:
				errototal2()
		else:
			errohour2()
	else:
		errohour2()

#logica para zerar variaves usadas na edição da agenda do paciente e retornar
func _on_Button_exitedit_agenda_pressed():
	Global.indice = ""
	TransitionScreen.fad_in()
	$CanvasLayer3.visible = 0
	TransitionScreen.fad_out()
	$CanvasLayer3/ColorRect/OptionButtondraweredit.clear()

#logica para quando confirmar a adição de uma agenda nova, salvando seus dados e add no scroolcontainer da agenda
func _on_Button_add_agenda_pressed():
	if int($CanvasLayer/ColorRect/LineEdithour.text) in Global.hour:
		if int($CanvasLayer/ColorRect/LineEditminute.text) in Global.mins:
			if len($CanvasLayer/ColorRect/LineEdithour.text) != 0 and len($CanvasLayer/ColorRect/LineEditminute.text) != 0 and len($CanvasLayer/ColorRect/LineEditinfo.text) != 0:
				print (name)
				if Global.viewr_name == Global.viewname:
					for name in Global.patients.keys():
						print("sla")
						print (Global.viewr_name)
						print(name, "11")
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
							_on_view_agenda_patient_pressed(Global.viewr_name)
							Global.drawer_text = ""
							$CanvasLayer/ColorRect/LineEdithour.clear()
							$CanvasLayer/ColorRect/LineEditminute.clear()
							$CanvasLayer/ColorRect/LineEditinfo.clear()
							optionbutton.clear()
							print(Global.patientname)
							$CanvasLayer.visible = 0
			else:
				errototal()
		else:
			errohour()
	else:
		errohour()

func _on_Button_exit_agenda_pressed():
	TransitionScreen.fad_in()
	$CanvasLayer.visible = 0
	TransitionScreen.fad_out()
	Global.drawer_text = ""
	$CanvasLayer/ColorRect/OptionButtondrawer.clear()

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
	TransitionScreen.fad_in()
	$CanvasLayer2.visible = 0
	TransitionScreen.fad_out()
	Global.viewr_name = ""
	Global.viewname = ""

#logica para descobrir a gaveta da agenda editada de determinado paciente
func _on_OptionButtondraweredit_item_selected(index):
	var selected_i = optionbuttonedit.get_selected_id()
	var selected_text = optionbuttonedit.get_item_text(selected_i)
	Global.drawer_edit_text = selected_text
	print(Global.drawer_edit_text)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		TransitionScreen.fade_in("res://Cenas/Menu.tscn")

func _on_ButtonAgenda_pressed():
	TransitionScreen.fade_in("res://Cenas/Agenda.tscn")

func _on_ButtonPatients_pressed():
	TransitionScreen.fade_in("res://Cenas/Patients.tscn")

func errototal():
	$CanvasLayer/ColorRect/Label6.visible = true
	$CanvasLayer/ColorRect/Label6.text = str("Informaçoes não preenchidas")
	yield(get_tree().create_timer(3.0), "timeout")
	$CanvasLayer/ColorRect/Label6.visible = false
	$CanvasLayer/ColorRect/Label6.text = str("")

func errohour():
	$CanvasLayer/ColorRect/Label7.visible = true
	$CanvasLayer/ColorRect/Label7.text = str("Este horario não existe")
	yield(get_tree().create_timer(3.0), "timeout")
	$CanvasLayer/ColorRect/Label7.visible = false
	$CanvasLayer/ColorRect/Label7.text = str("")

func errototal2():
	$CanvasLayer3/ColorRect/Label6.visible = true
	$CanvasLayer3/ColorRect/Label6.text = str("Informaçoes não preenchidas")
	yield(get_tree().create_timer(3.0), "timeout")
	$CanvasLayer3/ColorRect/Label6.visible = false
	$CanvasLayer3/ColorRect/Label6.text = str("")

func errohour2():
	$CanvasLayer3/ColorRect/Label7.visible = true
	$CanvasLayer3/ColorRect/Label7.text = str("Este horario não existe")
	yield(get_tree().create_timer(3.0), "timeout")
	$CanvasLayer3/ColorRect/Label7.visible = false
	$CanvasLayer3/ColorRect/Label7.text = str("")

func _on_Buttonexit_pressed():
	TransitionScreen.fade_in("res://Cenas/Menu.tscn")
