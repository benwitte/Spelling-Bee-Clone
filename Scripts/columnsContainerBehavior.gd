extends HBoxContainer

var width :	float

var children : Array

var newColumn := preload("res://Assets/guessedColumn0.tscn")

var countWords := 13

var columnsCount : int

var columnsNeeded : float

var wordAdded : bool

#var instance = newColumn.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(newColumn.instantiate())
	#add_child(children[0])
	
	fill(self.get_child(0))
	width = get_parent_area_size().x
	wordAdded = true
	columnsCount = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wordAdded == true:
		columnsNeeded = countWords/12.0
		#if columnsNeeded > columnsCount:
		for i in 2:
			add_child(newColumn.instantiate())
			print(self.get_child_count())
			fill(self.get_child(columnsCount))
			columnsCount += 1
		wordAdded = false
	pass

func fill(node):
	node.size.x = width/3
	children = node.get_children()
	for i in children.size():
		children[i].text = "test"
		
		
