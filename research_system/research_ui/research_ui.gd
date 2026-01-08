class_name ResearchUi
extends Control


const RESEARCH_UI_ITEM = preload("uid://cbqikw7txtm3e")


@export var research_manager: ResearchManager
@onready var research_container: VBoxContainer = %ResearchContainer


func _ready() -> void:
	for child in research_container.get_children():
		child.queue_free()
	load_researches_from_folder("res://research_system/research_system/")


func load_researches_from_folder(folder_path: String) -> void:
	for file_name in ResourceLoader.list_directory(folder_path):
		if file_name.get_extension() == "tres":
			var resource = ResourceLoader.load(folder_path + file_name)
			if resource is Research:
				load_research(resource)


func load_research(research: Research) -> void:
	var research_ui_item: ResearchUiItem = RESEARCH_UI_ITEM.instantiate()
	research_ui_item.research = research
	research_ui_item.start_pressed.connect(research_manager.change_research.bind(research))
	research_ui_item.stop_pressed.connect(research_manager.change_research.bind(null))
	research_container.add_child(research_ui_item)
