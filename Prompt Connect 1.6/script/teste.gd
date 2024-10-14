extends Control

# Referência ao VBoxContainer onde os pacientes serão listados
onready var patient_list = $ScrollContainer/VBoxContainer
onready var patient_name_input = $PatientNameInput
onready var add_patient_button = $AddPatientButton
var labels = []

func _ready():
	add_patient_button.connect("pressed", self, "_on_add_patient_pressed")

func _on_add_patient_pressed():
	var patient_name = patient_name_input.text.strip_edges()
	if patient_name != "":
		_add_patient(patient_name)
		patient_name_input.clear()  # Limpa o campo de entrada

func _add_patient(name: String):
	# Criar um container horizontal para o paciente
	var hbox = HBoxContainer.new()
	
	# Criar e adicionar o Label
	var label = Label.new()
	label.text = name
	hbox.add_child(label)
	
	# Criar e adicionar o botão de Editar
	var edit_button = Button.new()
	edit_button.text = "Editar"
	edit_button.connect("pressed", self, "_on_edit_patient_pressed", [name])
	hbox.add_child(edit_button)
	
	# Criar e adicionar o botão de Excluir
	var delete_button = Button.new()
	delete_button.text = "Excluir"
	delete_button.connect("pressed", self, "_on_delete_patient_pressed", [hbox])
	hbox.add_child(delete_button)
	
	# Adicionar o container do paciente à lista
	patient_list.add_child(hbox)

func _on_edit_patient_pressed(name: String):
	print("Editar paciente: " + name)
	# Aqui você pode implementar a lógica de edição

func _on_delete_patient_pressed(hbox: HBoxContainer):
#	# Acessar o Label que está dentro do HBoxContainer
#	var label = hbox.get_child(0)  # Assume que o primeiro filho é sempre o Label
#	if label:
#		var patient_name = label.text  # Obtém o texto do Label
#		print("Paciente removido: " + patient_name)  # Imprime o nome do paciente removido
#
#	hbox.queue_free()  # Remove o container do paciente da lista
	var label = hbox.get_child(0)
	var name = label.text
	hbox.queue_free() 
