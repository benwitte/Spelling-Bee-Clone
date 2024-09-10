extends AspectRatioContainer

var barSize : float

# Called when the node enters the scene tree for the first time.
func _ready():
	print($bar/rTL.get("theme_override_font_sizes/font_size"))
	barSize = self.size.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if barSize != self.size.x:
		barSize = self.size.x
		$bar/rTL.sizeChange(barSize, 2)

	pass
