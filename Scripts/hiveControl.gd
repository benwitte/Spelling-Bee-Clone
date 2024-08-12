extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# make each child node a variable to reduce visual confusion
	var centerHex : TextureButton = $centerHex
	var hex0 : TextureButton = $hex0
	var hex1 : TextureButton = $hex1
	var hex2 : TextureButton = $hex2
	var hex3 : TextureButton = $hex3
	var hex4 : TextureButton = $hex4
	var hex5 : TextureButton = $hex5
	
	# put them in an array
	var hexes := [centerHex, hex0, hex1, hex2, hex3, hex4, hex5]
	
	# define offset value and get the heigh and width of the root control
	var offset := .9
	var hiveHeight := self.size.y 
	var hiveWidth := self.size.x
	
	# define offsets from center
	var verticalOffset : Vector2 = Vector2(0, hiveHeight/3)
	var diagonalOffsetLeftRight : Vector2 = Vector2(hiveHeight/3.5, hiveHeight/6)
	var diagonalOffsetRightLeft : Vector2 = Vector2(hiveHeight/-3.5, hiveHeight/6)
	
	var hexSize : Vector2 = Vector2(offset * hiveWidth/3, offset * hiveHeight/3)
	
	for i in hexes.size():
		hexes[i].size = hexSize

	# set the position of each hex relative to the center hex
	centerHex.position = Vector2(hiveWidth/2, hiveHeight/2) - $centerHex.size/2
	hex0.position = centerHex.position - verticalOffset
	hex1.position = centerHex.position - diagonalOffsetRightLeft
	hex2.position = centerHex.position + diagonalOffsetLeftRight
	hex3.position = centerHex.position + verticalOffset
	hex4.position = centerHex.position - diagonalOffsetLeftRight
	hex5.position = centerHex.position + diagonalOffsetRightLeft
	
	
	
	# set letters in hive
	#await GlobalVars.pangramChosen
	#centerHex.get_child(0).text = GlobalVars.keyLetter
	pass
	

func setLetters(centerLetter, arrOtherLetters):
	arrOtherLetters.append(centerLetter)
	for i in self.get_child_count():
		self.get_child(i).setLetter(arrOtherLetters[i])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#var centerHex : TextureButton = $centerHex
	#var hex0 : TextureButton = $hex0
	#var hex1 : TextureButton = $hex1
	#var hex2 : TextureButton = $hex2
	#var hex3 : TextureButton = $hex3
	#var hex4 : TextureButton = $hex4
	#var hex5 : TextureButton = $hex5
	#var hexes := [centerHex, hex0, hex1, hex2, hex3, hex4, hex5]
	#var offset := .9
	#var hiveHeight := self.size.y 
	#var hiveWidth := self.size.x
	#
	#var verticalOffset : Vector2 = Vector2(0, hiveHeight/3)

	#var diagonalOffsetLeftRight : Vector2 = Vector2(hiveHeight/3.5, hiveHeight/6)
	#var diagonalOffsetRightLeft : Vector2 = Vector2(hiveHeight/-3.5, hiveHeight/6)
	#
	#var hexSize : Vector2 = Vector2(offset * hiveWidth/3, offset * hiveHeight/3)
	#
	#for i in hexes.size():
		#hexes[i].size = hexSize
	##$centerHex.size = hexSize
	#centerHex.position = Vector2(hiveWidth/2, hiveHeight/2) - $centerHex.size/2
	#hex0.position = centerHex.position - verticalOffset
	#hex1.position = centerHex.position - diagonalOffsetRightLeft
	#hex2.position = centerHex.position + diagonalOffsetLeftRight
	#hex3.position = centerHex.position + verticalOffset
	#hex4.position = centerHex.position - diagonalOffsetLeftRight
	#hex5.position = centerHex.position + diagonalOffsetRightLeft
	
	pass
