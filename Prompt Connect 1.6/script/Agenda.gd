extends Control

onready var patient_list = $ScrollContainer/VBoxContainer

#logica para sair da cena atual
func _on_Button_exit_pressed():
	TransitionScreen.fade_in("res://cenas/principal.tscn")

#logica para adicionar os pacientes na tela, junto com os botões de anexar agenda e de visualizar agenda
func _ready():
	for user in Global.users:  
		var hbox = HBoxContainer.new()

		var labelname = Label.new()
		labelname.text = user 
		hbox.add_child(labelname)

		var add_agenda_button = Button.new()
		add_agenda_button.text = "Anexar Agenda"
		add_agenda_button.connect("pressed", self, "_on_add_agenda_patient_pressed", [user])
		hbox.add_child(add_agenda_button)

		var view_agenda_button = Button.new()
		view_agenda_button.text = "Visualizar Agenda"
		view_agenda_button.connect("pressed", self, "_on_view_agenda_patient_pressed", [hbox])
		hbox.add_child(view_agenda_button)

		patient_list.add_child(hbox)  

func _on_add_agenda_patient_pressed():
	pass

func _on_view_agenda_patient_pressed():
	pass

func _on_Button_add_agenda_pressed():
	pass 
