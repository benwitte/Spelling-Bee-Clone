extends AspectRatioContainer

var barSize : Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	barSize = self.size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if barSize != self.size:
		$bar/rTL.sizeChange()
	pass



#
#func updateProgress():
	#var tween := get_tree().create_tween()
	#tween.tween_property($TextureProgressBar, "value", 100, .7).set_trans(Tween.TRANS_QUAD)
#
#func updateScore():
	#$TextureProgressBar/rTL.text  =str(GlobalVars.score)
	#
#func clearScore():
	#$TextureProgressBar/rTL.text = ""
