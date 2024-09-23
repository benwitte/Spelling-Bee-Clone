extends HBoxContainer

var width :	float

var length : float

var children : Array

var newColumn := preload("res://Assets/guessedColumn0.tscn")

var countWords := 0

var columnsCount : float

var columnsNeeded : float

var wordAdded : bool

var startPoint : int = 0

#var instance = newColumn.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	

	#add_child(children[0])
	add_child(newColumn.instantiate())
	
	
	width = float(get_parent_area_size().x)
	length = float(get_parent_area_size().y)
	wordAdded = true
	columnsCount = 1.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.get_child(0).get("custom_minimum_size").x == 0:
		self.get_child(0).set("custom_minimum_size", Vector2(width/3.1, length))
	else:
		pass
	if countWords < GlobalVars.alreadyGuessed.size():
		countWords += 1
		columnsNeeded = float(GlobalVars.alreadyGuessed.size())/12.0
		if columnsNeeded > columnsCount:
			#startPoint += 12
			add_child(newColumn.instantiate())
			setSize(self.get_child(int(columnsCount)))
			#fill(self.get_child(int(columnsCount)), startPoint)
			columnsCount += 1.0
		else:
			pass
		for i in self.get_children().size():
			fill(self.get_child(i), startPoint)
			startPoint += 12
	startPoint = 0
	pass

func setSize(node):
	node.set("custom_minimum_size", Vector2(width/3.1, length))


func fill(node, start):
	children = node.get_children()
	for i in children.size():
		children[i].set("theme_override_font_sizes/font_size", length/(children.size()+4))
		if i + start < GlobalVars.alreadyGuessed.size():
			print("i:" + str(i))
			print("array size: " + str(GlobalVars.alreadyGuessed.size()))
			children[i].text = GlobalVars.alreadyGuessed[i+start]
			print("appending this word to the column now: ")
			print(GlobalVars.alreadyGuessed[i])
		
	
