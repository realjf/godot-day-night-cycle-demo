extends CanvasModulate

onready var timebox = get_parent().get_node("HBoxContainer")

func _process(delta):
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
