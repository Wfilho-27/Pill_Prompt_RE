extends Control

onready var patient_list = $ScrollContainer/VBoxContainer
var Hbox
var client
var connected: bool = false

var ip = "192.168.133.166"
const port = 80

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
		Hbox = hbox

		var labelname = Label.new()
		labelname.text = user 
		var themelabelname = load("res://Temas/labelkk.tres")
		labelname.theme = themelabelname
		hbox.add_child(labelname)

		patient_list.add_child(hbox)  
	client = StreamPeerTCP.new()
	client.connect_to_host(ip, port)
	if(client.is_connected_to_host()):
		connected = true
#	$LabelGer5.visible = false
#	var label = Label.new()
#	add_child(label)
#	label.text = str("ai dento")
#	label.rect_position.x = 960
#	label.rect_position.y = 540

func _process(delta):
	var _g = 0.80 + sin(Time.get_ticks_msec() / 369.0) * 0.20;
	$LabelGer6.modulate = Color(0.0, _g, 33.0, 1.0);
	if len(Global.patients) > 0:
		$LabelGer2.visible = false
		$pass.visible = false
		$LabelGer3.rect_position.y = 452
		$pass2.rect_position.y = 533
	$Label.text = str(Global.getHour(),":",Global.getMin(),":",Global.getSec())
	$Label.modulate = Color(0.0, _g, 33.0, 1.0);

func _on_ButtonAgenda_pressed():
	TransitionScreen.fade_in("res://Cenas/Agenda.tscn")

func _on_ButtonPatients_pressed():
	TransitionScreen.fade_in("res://Cenas/Patients.tscn")

func _on_pass_pressed():
	TransitionScreen.fade_in("res://Cenas/Patients.tscn")

func _on_ButtonIP_pressed():
	TransitionScreen.fad_in()
	$CanvasLayer.visible = true

func _on_Buttonconfirm_pressed():
	var ipkk = str($CanvasLayer/ColorRect/LineEdit.text)
	Conexaowifi.ip = "\""+ipkk+"\""
	print(Conexaowifi.ip)
	TransitionScreen.fad_out()
	$CanvasLayer.visible = false

func _on_Buttonreturn_pressed():
	TransitionScreen.fad_out()
	$CanvasLayer.visible = false
