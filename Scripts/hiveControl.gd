extends Control

	# make each child node a variable to reduce visual confusion
@onready var centerHex : TextureButton = $centerHex
@onready var hex0 : TextureButton = $hex0
@onready var hex1 : TextureButton = $hex1
@onready var hex2 : TextureButton = $hex2
@onready var hex3 : TextureButton = $hex3
@onready var hex4 : TextureButton = $hex4
@onready var hex5 : TextureButton = $hex5


var verticalOffset : Vector2 = Vector2(0, 0)
var diagonalOffsetLeftRight : Vector2 = Vector2(0,0)
var diagonalOffsetRightLeft : Vector2 = Vector2(0,0)

func hiveSizeChange():
	
	# put them in an array
	var hexes := [centerHex, hex0, hex1, hex2, hex3, hex4, hex5]


	
	# define offset value and get the heigh and width of the root control
	var offset := .9
	var hiveHeight := self.size.y 
	var hiveWidth := self.size.x
	
	if hiveHeight <= hiveWidth:
	# define offsets from center
		verticalOffset = Vector2(0, hiveHeight/3)
		diagonalOffsetLeftRight = Vector2(hiveHeight/3.5, hiveHeight/6)
		diagonalOffsetRightLeft = Vector2(hiveHeight/-3.5, hiveHeight/6)
	else:
		verticalOffset = Vector2(0, hiveHeight/4)
		diagonalOffsetLeftRight = Vector2(hiveHeight/5, hiveHeight/8.5)
		diagonalOffsetRightLeft = Vector2(hiveHeight/-5, hiveHeight/8.5)
	
	var hexSize : Vector2 = Vector2(offset * hiveWidth/3, offset * hiveHeight/3)
	
	for i in hexes.size():
		hexes[i].size = hexSize
		# also changes label font size within each hex
		hexes[i].get_child(0).sizeChange(hiveWidth, 20)

	# set the position of each hex relative to the center hex
	centerHex.position = Vector2(hiveWidth/2, hiveHeight/2) - $centerHex.size/2
	hex0.position = centerHex.position - verticalOffset
	hex1.position = centerHex.position - diagonalOffsetRightLeft
	hex2.position = centerHex.position + diagonalOffsetLeftRight
	hex3.position = centerHex.position + verticalOffset
	hex4.position = centerHex.position - diagonalOffsetLeftRight
	hex5.position = centerHex.position + diagonalOffsetRightLeft
	
	# also update letter size
	

	pass
	

func setLetters(centerLetter, arrOtherLetters):
	self.get_child(6).setLetter(centerLetter)
	for i in self.get_child_count()-1:
		self.get_child(i).setLetter(arrOtherLetters[i])
