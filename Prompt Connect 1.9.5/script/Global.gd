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
