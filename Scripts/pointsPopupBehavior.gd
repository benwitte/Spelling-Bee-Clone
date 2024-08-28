## a popup that appears when player scores points
## texture is chosen based on whether the word is a pangram or not
## dynamic text sizing based on container size

extends TextureRect

var isPangram = true

var width : float = 0.0

var startPosition : Vector2 = Vector2(0,0)

# negative velo because lower numbers are up
var velocity : float = - 200.0

var friction : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	startPosition = self.position
	self.visible = false
	width = self.size.x
	sizeChange()
	chooseTexture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if width != self.size.x:
		width = self.size.x
		sizeChange()
		
func _physics_process(delta):
	if self.visible == true:
		velocity += friction
		self.position.y += velocity * delta
	#if self.visible == true:
		#movement(delta)
	#else:
	if self.visibility_changed and self.visible == false:
		self.position = startPosition
	pass

func chooseTexture():
	if isPangram == true:
		self.texture = load("res://Assets/textures/pangram_pts_texture.svg")
	else:
		pass

func display():
	$pointsLabel.text = "+ " + str(GlobalVars.stringLength)
	self.visible = true
	await get_tree().create_timer(.5).timeout
	self.visible = false
	pass

#func movement(norm):
	#while self.visible == true:
		#velocity += friction
		#self.position.y += velocity * norm
	#pass


func sizeChange():
	var fontSize = int(self.size.x/6)
	$pointsLabel.add_theme_font_size_override("font_size", fontSize)
