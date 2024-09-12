extends Control

@onready var new_game = $"../New Game"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_texture_button_pressed():
	GlobalVars.quitClicked = true
	#get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	#get_tree().quit()
	


func _on_settings_button_pressed():
	GlobalVars.settingsCheck = true
	pass # Replace with function body.


func _on_new_game_pressed():
	GlobalVars.newGame = true
	#get_tree().change_scene_to_file("res://Scenes/GameScene.tscn")
	new_game.visible = false
	pass # Replace with function body.
