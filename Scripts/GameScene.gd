extends Control

var speed := 0.05

var otherLetters := []

var ourSize : Vector2 = self.size




@onready var unaccepted_guess = $unacceptedGuess
@onready var hive_control = $hiveControl
@onready var points_popup = $pointsPopup
@onready var line_edit = $LineEdit
@onready var texture_progress_bar = $textureProgressBar




# Called when the node enters the scene tree for the first time.
func _ready():
	
	hive_control.hiveSizeChange()
	resizeLineEditText()

	
# Reset all relevant  Variables
	otherLetters = []
	GlobalVars.pangramMain = {}
	GlobalVars.keyLetter = ""
	GlobalVars.todaysWordsArray = []
	GlobalVars.totalPangrams = []
	GlobalVars.score = 0
	GlobalVars.newTier = ""
	GlobalVars.currentTier = "Beginner"
	GlobalVars.alreadyGuessed = []

	
	
# Read Full Dictionary JSON
	filterPangrams(GlobalVars.fullParsedFile, GlobalVars.allPangramsDict)
# set the pangram
	GlobalVars.pangramMain = getNewPangram(GlobalVars.allPangramsDict)
	
# set the center letter
	GlobalVars.keyLetter = getkeyLetter(GlobalVars.pangramMain.uniqueChars)

# put the 6 other letters in an array called otherLetters
	getOtherLetters(GlobalVars.pangramMain.uniqueChars, GlobalVars.keyLetter, otherLetters)
	
# gets all words that can be spelled with today's uniqueChars
# returns all pangrams to array called totalPangrams
# returns all non-pangrams to array called todaysWordsArray
	getTodaysDictionary(GlobalVars.fullParsedFile, GlobalVars.pangramMain.uniqueChars, GlobalVars.keyLetter, GlobalVars.todaysWordsArray, GlobalVars.totalPangrams)
	
# calculate the max possible score for today
	GlobalVars.maxScore = calculatePossiblePoints(GlobalVars.todaysWordsArray, GlobalVars.totalPangrams)
	
	
	print("center Letter: " + GlobalVars.keyLetter)
	
	
	print("total pangrams: " + str(GlobalVars.totalPangrams))
	print("total words: " + str(GlobalVars.todaysWordsArray))

	
	
# assign the center letter to the center hex in hiveControl
# assign the other 6 letters to the other 6 hexagons
	hive_control.setLetters(GlobalVars.keyLetter, otherLetters)
	
	# at some point this await function was useful. now i'm not sure if it is anymore...
	#await get_tree().process_frame
	line_edit.grab_focus()
	





func _process(_delta):
	
	if GlobalVars.shuffle == true:
		otherLetters.shuffle()
		print(otherLetters)
		print(GlobalVars.keyLetter)
		hive_control.setLetters(GlobalVars.keyLetter, otherLetters)
		GlobalVars.shuffle = false
	

	
	if self.size != ourSize:
		ourSize = self.size
		hive_control.hiveSizeChange()
		#resizeLineEditText()
		
	
	# when player clicks enter
	if Input.is_action_just_pressed("ui_text_submit"):
		var submission := str(line_edit.text)
		# assign a string to currentTier based on getTier function.
		# getTier calculates score as a percentage and assigns a tier
		# as a string
		GlobalVars.currentTier = getTier(GlobalVars.score, GlobalVars.maxScore)
		
		# tierAssign is a matching function, where each possible tier string is
		# associated with an integer. These integers are then used in the 
		#textureProgressBar array to determine which progress bar to fill
		tierAssign(GlobalVars.currentTier)
		
		# new word check
		if submission in GlobalVars.todaysWordsArray and not GlobalVars.alreadyGuessed.has(submission):
			
			GlobalVars.stringLength = submission.length()
			
			# add the word to alreadyGuessed array of strings
			GlobalVars.alreadyGuessed.append(submission)
			print("appended submission, here is array: ")
			print(GlobalVars.alreadyGuessed)
			GlobalVars.alreadyGuessed.sort()
			print("resorted array: ")
			print(GlobalVars.alreadyGuessed)
			
			# reset LineEdit to empty
			line_edit.text = ""
			
			# adds points based on the length of the word. also checks if the
			# submission is a pangram
			GlobalVars.wordScore = assignPoints(GlobalVars.stringLength, submission)
			GlobalVars.score += GlobalVars.wordScore
			
			
			# gets the tier string based on updated score percentage
			GlobalVars.newTier = getTier(GlobalVars.score, GlobalVars.maxScore)
			
			points_popup.display()
			
			# checking if our tier string has changed. returns bool
			if checkTier(GlobalVars.currentTier, GlobalVars.newTier) == true:
				
				# assigns the new tier as integer x. this is used in arrayBars 
				var x : int = tierAssign(GlobalVars.newTier) 
				print(GlobalVars.arrayBars)
				
				# since we're changing tiers (and textrureProgressBars), 
				# we need to clear the score from the old progress tier.
				texture_progress_bar.clearOldScore(GlobalVars.arrayBars[x-1])
				
				# in the unusual cases where a score results in multiple tier
				# increases, this logic tells the app to fill the progress bars
				# between the old tier and the new tier. it does this by making
				# sure each tier's value is 100 (aka progress bar is yellow)
				# if it isn't, it fills it in. If it is already filled in,
				# then it skips that tier
				for i in x:
					if GlobalVars.arrayBars[i].value != 100:
						texture_progress_bar.quickUpdate(GlobalVars.arrayBars[i])
						texture_progress_bar.clearOldScore(GlobalVars.arrayBars[i])
						await get_tree().create_timer(.1).timeout
					else:
						pass
						
				#texture_progress_bar.clearOldScore(GlobalVars.arrayBars[x-1])
				texture_progress_bar.progressBar(GlobalVars.arrayBars[x])
				await get_tree().create_timer(.6).timeout
				
				# now time to add the new score to the new tier
				texture_progress_bar.updateNewScore(GlobalVars.arrayBars[x])
				$Label.updateTierText()
				
			else :
				
				
				var x : int = tierAssign(GlobalVars.newTier) 
				texture_progress_bar.updateNewScore(GlobalVars.arrayBars[x])
				pass
		elif submission in GlobalVars.alreadyGuessed:
			unaccepted_guess.visible = true
			unaccepted_guess.fillLabel("Already Guessed")
			line_edit.text = ""
			await get_tree().create_timer(.6).timeout
			unaccepted_guess.visible = false
			
		else:
			unaccepted_guess.visible = true
			unaccepted_guess.fillLabel("Word Not Recognized")
			line_edit.text = ""
			await get_tree().create_timer(.6).timeout
			unaccepted_guess.visible = false
			
	if GlobalVars.newTier == "Genius":
		print("win")
		
		
		

#func _physics_process(delta):
	##if textureProgressBar length is less than current tier status, animate bar to fill to new status
	#pass

############## FUNCTIONS ###############


func getTier(currentScore, possibleScore):
	var scorePercent : float = float(currentScore)/float(possibleScore)
	var tier := ""
	if scorePercent < .02:
		tier = "Beginner"
	elif scorePercent < .05:
		tier = "Good Start"
	elif scorePercent < .08:
		tier = "Moving Up"
	elif scorePercent < .15:
		tier = "Good"
	elif scorePercent < .25:
		tier = "Solid"
	elif scorePercent < .40:
		tier = "Nice"
	elif scorePercent < .5:
		tier = "Great"
	elif scorePercent < .7:
		tier = "Amazing"
	else:
		tier = "Genius"
	return tier

func checkTier(currTier, _newTier):
	if currTier != _newTier:
		return true
	else:
		return false
		
	

# Determines how close player is to winning

func tierAssign(tier):
	var x := 0
	match tier:
		"Beginner":
			return x
		"Good Start":
			x = 1
			return x
		"Moving Up":
			x = 2
			return x
		"Good":
			x = 3
			return x
		"Solid":
			x = 4
			return x
		"Nice":
			x = 5
			return x
		"Great":
			x = 6
			return x
		"Amazing":
			x = 7
			return x
		"Genius":
			x = 8
			return x



# Filter Pangrams out from the array of all words and append them to another array
func filterPangrams(jsonArray, newArray):
	for i in jsonArray.size():
		if jsonArray[i].pangram == true:
			newArray.append(jsonArray[i])
		else:
			pass
	return newArray



# Randomly picks a pangram from the array
func getNewPangram(jsonArray):
	return jsonArray[randi() % jsonArray.size()]



# Randomly picks the keyLetter from the chosen pangram
func getkeyLetter(pangramCharsArray):
	return pangramCharsArray[randi() % pangramCharsArray.size()]
	
func getOtherLetters(pangramCharsArray, _keyLetter, emptyArray):
	for i in pangramCharsArray.size():
		if pangramCharsArray[i] != _keyLetter:
			emptyArray.append(pangramCharsArray[i])
		else:
			pass




# A function that filters through the array of all words and returns ONLY
# words whose uniqueChars are included in the uniqueChars of the pangramMain
func getTodaysDictionary(fullJsonArray, pangramChars, mainLetter, wordsArray, pangramArray):
	for i in fullJsonArray.size():
		if fullJsonArray[i].uniqueChars.has(mainLetter):
			if fullJsonArray[i].uniqueChars.all(func(value: String): return value in pangramChars):
				#dictArray.append(fullJsonArray[i])
				wordsArray.append(fullJsonArray[i].word)
				if fullJsonArray[i].uniqueChars == pangramChars:
					pangramArray.append(fullJsonArray[i].word)
			else :
				pass
		else :
			pass
	return


	
# Assigning points, including extra for pangrams
func assignPoints(strLength, word):
	var points := 0
	if strLength == 4:
		points = 1
		GlobalVars.isPangram = false
	elif strLength >= 7 and GlobalVars.totalPangrams.has(word):
		points = strLength + 7
		GlobalVars.isPangram = true
	else :
		points = strLength
		GlobalVars.isPangram = false
	return points

func calculatePossiblePoints(array, pangramArray):
	var total : int = pangramArray.size() * 7
	for i in array.size():
		if array[i].length() > 4:
			total += array[i].length()
		else:
			total += 1
	return total


# Spelling Bee ranking tiers from Words Rated website
# https://wordsrated.com/nyt-spelling-bee-game-rules-and-help/
#Rank	Percentage of points needed
#Beginner	0%
#Good start	2%
#Moving up	5%
#Good	8%
#Solid	15%
#Nice	25%
#Great	40%
#Amazing	50%
#Genius	70%
#Queen Bee (hidden rank)	100%

func resizeLineEditText():
	var height : int = line_edit.size.y
	line_edit.set("theme_override_font_sizes/font_size", height - 10)
