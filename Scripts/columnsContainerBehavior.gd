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
			startPoint += 12
			add_child(newColumn.instantiate())
			setSize(self.get_child(int(columnsCount)))
			fill(self.get_child(int(columnsCount)), startPoint)
			columnsCount += 1.0
		else:
			fill(self.get_child(int(columnsCount-1)), startPoint)
	pass

func setSize(node):
	node.set("custom_minimum_size", Vector2(width/3.1, length))


func fill(node, start):
	children = node.get_children()
	var i : int = start
	while i < GlobalVars.alreadyGuessed.size():
		children[i - start].set("theme_override_font_sizes/font_size", length/(children.size()+4))
		children[i - start].text = GlobalVars.alreadyGuessed[i]
		i += 1
		
	
