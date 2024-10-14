tool
extends Control

func _ready():
	print ((Global.getHour()), ":", (Global.getMin()), ":", (Global.getSec()))
#	print (Global.patients)
	if Global.patients.size() > 0:
		print(Global.patients.keys())

func _on_button_agenda_pressed():
	TransitionScreen.fade_in("res://cenas/Agenda.tscn")

func _on_butao_patients_pressed():
	TransitionScreen.fade_in("res://cenas/Pacientes.tscn")

func _on_Button_test_pressed():
	var meu_dicionario = {
	"chave1": "valor1",
	"chave2": "valor2",
	"chave3": "valor3"
}

	for chave in meu_dicionario.keys():
		print("A chave é:", chave)
		print("O valor correspondente é:", meu_dicionario[chave])
		if chave == "chave1":
			print ("deu certo")
