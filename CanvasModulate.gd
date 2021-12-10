extends CanvasModulate

onready var timebox = get_parent().get_node("HBoxContainer")

var time_speed = 60
var time = 0
var time_lapse = 0
var time_on = false

var secs = 1
var mins = 59
var hrs = 12
var dys = 30
var wks = 7
var mnths = 12
var yrs = 2021


var hour_name = ""
var day_name = ""
var week_name = ""
var month_name = ""


var mins_ctr : int
var hrs_ctr : int
var dys_ctr : int
var wks_ctr : int
var mnths_ctr:int
var yrs_ctr : int


func _ready():
	time_on = true



func _process(delta):
	if (time_on):
		time += delta * time_speed
		time_lapse = int(time) % secs
		if time_lapse == (secs - 1):
			mins_ctr = 1
		if time_lapse == 0:
			if mins_ctr != 0:
				mins_ctr = 0
				mins += 1
		if mins == 60:
			mins = 0
			hrs_ctr = 1
		if mins == 0:
			if hrs_ctr != 0:
				hrs_ctr = 0
				hrs += 1
		if hrs == 24:
			hrs = 0
			dys_ctr = 1
		if hrs == 0:
			if dys_ctr != 0:
				dys_ctr = 0
				dys += 1
				wks_ctr +=1
				if dys == 31:
					dys = 1
					mnths_ctr = 1
			if wks_ctr != 0:
				wks_ctr = 0
				wks += 1
				if wks == 8:
					wks = 1
				
		if wks == 1:
			week_name = "星期一"
		elif wks == 2:
			week_name = "星期二"
		elif wks == 3:
			week_name = "星期三"
		elif wks == 4:
			week_name = "星期四"
		elif wks == 5:
			week_name = "星期五"
		elif wks == 6:
			week_name = "星期六"
		else:
			wks = 7
			week_name = "星期日"
			
		if mnths_ctr == dys: # 1月1日
			mnths_ctr = 0
			if mnths == 12:
				mnths = 1
				yrs_ctr = 1
			else:
				mnths += 1
				
		if mnths == 1:
			month_name = "一月"
		elif mnths == 2:
			month_name = "二月"
		elif mnths == 3:
			month_name = "三月"
		elif mnths == 4:
			month_name = "四月"
		elif mnths == 5:
			month_name = "五月"
		elif mnths == 6:
			month_name = "六月"
		elif mnths == 7:
			month_name = "七月"
		elif mnths == 8:
			month_name = "八月"
		elif mnths == 9:
			month_name = "九月"
		elif mnths == 10:
			month_name = "十月"
		elif mnths == 11:
			month_name = "十一月"
		elif mnths == 12:
			month_name = "十二月"
		else:
			month_name = "十二月"
			
		if yrs_ctr == mnths:
			yrs_ctr = 0
			yrs += 1
			
	timebox.get_node("Year").text = str(yrs) + "年"
	timebox.get_node("Month").text = str(mnths) + "月"
	timebox.get_node("Day").text = str(dys) + "日"
	timebox.get_node("Week").text = week_name
	timebox.get_node("Hour").selected = hrs
	timebox.get_node("Minute").selected = mins
	timebox.get_node("Second").selected = time_lapse

	var time = {
		"hour": timebox.get_node("Hour").selected,
		"minute": timebox.get_node("Minute").selected,
		"second": timebox.get_node("Second").selected
	}
	print(time)
	var TimeInSeconds = time.hour * 3600 + time.minute * 60 + time.second
	var CurrentFrame = range_lerp(TimeInSeconds, 0, 86400, 0, 24)
	$AnimationPlayer.play("DayNightCycle")
	$AnimationPlayer.seek(CurrentFrame)


