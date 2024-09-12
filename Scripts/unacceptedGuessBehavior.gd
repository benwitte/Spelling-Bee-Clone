extends TextureRect

var barSize : float

@onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready():
	barSize = self.size.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if barSize != self.size.x:
		barSize = self.size.x
		label.set("theme_override_font_sizes/font_size", self.size.x/3)
	pass

func fillLabel(inputString):
	label.text = inputString
