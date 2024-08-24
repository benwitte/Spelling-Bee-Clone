extends AspectRatioContainer

var barSize : Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	barSize = self.size
	print(self.size.x)
	$bar/rTL.sizeChange(barSize.x, 2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if barSize != self.size:
		barSize = self.size
		$bar/rTL.sizeChange(barSize.x, 2)
	pass
