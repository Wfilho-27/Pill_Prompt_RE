extends Node

var patients = {}
var users = []
var rooms = []
var editname = ""
var editroom = ""

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
