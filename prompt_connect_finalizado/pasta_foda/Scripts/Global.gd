extends Node

var patients = {}
var users = []
var rooms = []
var editname = ""
var editroom = ""
var patientname = []
var drawers_avaliable = ["A1", "A2", "A3", "A4", "A5"]
var viewr_name = ""
var drawer_text = ""
var drawer_edit_text = ""
var indice = ""
var viewname = ""
var test = ""
var test2 = ""
var hour = [01,02,03,04,05,06,07,08,09,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,00,]
var mins = [01,02,03,04,05,06,07,08,09,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,00]
var auxiliar = {}
var indicepat

func _ready():
	pass

func getHour() -> int:
	var _time = Time.get_datetime_dict_from_system()
	var _hour = _time.hour;
	return _hour

func getMin() -> int:
	var _time = Time.get_datetime_dict_from_system()
	var _minute = _time.minute;
	return _minute

func getSec() -> int:
	var _time = Time.get_datetime_dict_from_system()
	var _second = _time.second;
	return _second
