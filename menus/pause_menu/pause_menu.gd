extends Control

var paused = false

@export var start_nav_element : Control = null

@export_category("Buttons")
@export var continue_button : TextureButton = null
@export var restart_button : TextureButton = null
@export var options_button : TextureButton = null
@export var main_menu_button : TextureButton = null

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
	print(continue_button)
	continue_button.pressed.connect(unpause)
	options_button.pressed.connect(open_options)
	main_menu_button.pressed.connect(return_to_main_menu)
	restart_button.pressed.connect(restart_from_checkpoint)
	unpause()

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
	AudioSystem.play_sound("ui_click")
	pause_menu.visible = false
	options_menu.visible = true

func close_options():
	AudioSystem.play_sound("ui_click")
	options_menu.visible = false
	pause_menu.visible = true

func return_to_main_menu():
	AudioSystem.play_sound("ui_click")
	unpause()
	GameManager.return_to_main_menu()

func restart_from_checkpoint():
	AudioSystem.play_sound("ui_click")
	unpause()
	var player = get_tree().get_first_node_in_group("player")
	GameManager.player_died(player)
