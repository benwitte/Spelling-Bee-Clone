extends AspectRatioContainer

var barSize : float
@onready var r_tl = $bar/rTL

# Called when the node enters the scene tree for the first time.
func _ready():
	barSize = self.size.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if barSize != self.size.x:
		barSize = self.size.x
		r_tl.sizeChange(barSize, 2)

	pass
