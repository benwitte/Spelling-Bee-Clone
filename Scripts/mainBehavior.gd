extends Control

var gamepath := preload("res://Scenes/GameScene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GlobalVars.newGame == true:
		add_child(gamepath.instantiate())
		GlobalVars.newGame = false
		self.move_child(get_child(2), 1)
	pass
