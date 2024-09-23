extends Control

var gamepath := preload("res://Scenes/GameScene.tscn")

@onready var new_game = $"UI/New Game"

var gameInstance

var i := 0
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if get_viewport().gui_get_focus_owner() == null and is_instance_valid(gameInstance)== true:
		gameInstance.get_child(1).grab_focus()
	if GlobalVars.newGame == true:
		i = 0
		new_game.visible = false
		GlobalVars.newGame = false
		if is_instance_valid(gameInstance):
			gameInstance.queue_free()
		await get_tree().process_frame
		gameInstance = gamepath.instantiate()
		add_child(gameInstance)
		move_child(gameInstance, 1)
		#print_orphan_nodes()
	#if i < 1:
		#if is_instance_valid(gameInstance)== true and GlobalVars.settingsCheck == false and gameInstance.get_child(1).visible == false:
			#print("not visible")
					##i += 1
	pass
