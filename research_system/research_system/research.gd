class_name Research
extends Resource


signal progressed(current_value: float)
signal started
signal stopped
signal finished


@export var name: String
@export_multiline var description: String
@export var research_points_to_finish: float
var research_points_collected: float

var is_finished: bool = false
var is_current_research: bool = false:
	set(value):
		is_current_research = value
		if is_current_research:
			started.emit()
		else:
			stopped.emit()


func finish() -> void:
	print("%s research finished!" % name)
	is_finished = true
	finished.emit()


func progress(value: float) -> void:
	if is_finished:
		return
	
	research_points_collected += value
	research_points_collected = clampf(research_points_collected, 0.0, research_points_to_finish)
	progressed.emit(research_points_collected)
	
	if research_points_collected >= research_points_to_finish:
		finish()
