extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	GlobalVars.startGame = true
	#get_tree().change_scene_to_file("res://Scenes/GameScene.tscn")
	self.visible = false
	pass # Replace with function body.
