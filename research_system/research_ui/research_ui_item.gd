class_name ResearchUiItem
extends Control


signal start_pressed
signal stop_pressed


var research: Research
@onready var name_label: Label = %NameLabel
@onready var cost_label: Label = %CostLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var start_button: Button = %StartButton
@onready var stop_button: Button = %StopButton


func _ready() -> void:
	if research == null:
		queue_free()
		return
	
	start_button.show()
	stop_button.hide()
	start_button.pressed.connect(start_pressed.emit)
	stop_button.pressed.connect(stop_pressed.emit)
	
	research.progressed.connect(_on_research_progressed)
	research.started.connect(_on_research_started)
	research.stopped.connect(_on_research_stopped)
	research.finished.connect(_on_research_finished)
	
	name_label.text = research.name
	name_label.tooltip_text = research.description
	
	cost_label.text = "%d RP" % research.research_points_to_finish
	
	progress_bar.value = research.research_points_collected
	progress_bar.max_value = research.research_points_to_finish


func _on_research_progressed(current_value: float) -> void:
	progress_bar.value = current_value


func _on_research_started() -> void:
	start_button.hide()
	stop_button.show()


func _on_research_stopped() -> void:
	start_button.show()
	stop_button.hide()


func _on_research_finished() -> void:
	start_button.show()
	stop_button.hide()
	start_button.disabled = true
	stop_button.disabled = true
