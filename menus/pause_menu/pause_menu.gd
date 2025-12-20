extends Control

var paused = false

@export var start_nav_element : Control = null

@export_category("Buttons")
@export var continue_button : Button = null
@export var options_button : Button = null
@export var main_menu_button : Button = null
@export var restart_button : Button = null

@export_category("Menus")
@export var options_menu : Control = null
@export var pause_menu : Control = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if options_menu.visible:
			close_options()
			return
		
		if paused:
			unpause()
		else:
			pause()

func _ready() -> void:
	continue_button.pressed.connect(unpause)
	options_button.pressed.connect(open_options)
	main_menu_button.pressed.connect(return_to_main_menu)
	restart_button.pressed.connect(restart_from_checkpoint)

func pause():
	visible = true
	paused = true
	GameManager.pause_game()
	
	if start_nav_element:
		start_nav_element.grab_focus.call_deferred()

func unpause():
	visible = false
	paused = false
	GameManager.unpause_game()

func open_options():
	pause_menu.visible = false
	options_menu.visible = true

func close_options():
	options_menu.visible = false
	pause_menu.visible = true

func return_to_main_menu():
	unpause()
	GameManager.return_to_main_menu()

func restart_from_checkpoint():
	unpause()
	var player = get_tree().get_first_node_in_group("player")
	print(player)
	GameManager.player_died(player)
