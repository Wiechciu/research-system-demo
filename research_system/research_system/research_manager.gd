class_name ResearchManager
extends Node


@export var current_research: Research
var research_points_per_second: float = 5.0


func _ready() -> void:
	set_process(current_research != null)


func _process(delta: float) -> void:
	progress_current_research(delta)


func progress_current_research(delta: float) -> void:
	current_research.progress(research_points_per_second * delta)


func change_research(research: Research) -> void:
	if current_research:
		current_research.is_current_research = false
	current_research = research
	if current_research:
		current_research.is_current_research = true
	set_process(current_research != null)
