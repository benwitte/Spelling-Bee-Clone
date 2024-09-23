extends AspectRatioContainer

var barSize : Vector2 = Vector2(0,0)
@onready var r_tl = $bar/rTL

# Called when the node enters the scene tree for the first time.
func _ready():
	barSize = self.size
	r_tl.sizeChange(barSize.x, 6)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if barSize != self.size:
		#print("size change")
		barSize = self.size
		r_tl.sizeChange(barSize.x, 6)
	pass
