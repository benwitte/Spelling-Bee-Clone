extends Button

var barSize : float

# Called when the node enters the scene tree for the first time.
func _ready():
	barSize = 0	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if barSize != self.size.x:
		barSize = self.size.x
		self.set("theme_override_font_sizes/font_size", self.size.x/6)
	pass
