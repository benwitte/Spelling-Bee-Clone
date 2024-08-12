extends Control

var speed := 0.05

var otherLetters := []






# Called when the node enters the scene tree for the first time.
func _ready():
	
	
# Read Full Dictionary JSON
	filterPangrams(GlobalVars.fullParsedFile, GlobalVars.allPangramsDict)
	
	GlobalVars.pangramMain = getNewPangram(GlobalVars.allPangramsDict)
	
	GlobalVars.keyLetter = getkeyLetter(GlobalVars.pangramMain.uniqueChars)
	
	getOtherLetters(GlobalVars.pangramMain.uniqueChars, GlobalVars.keyLetter, otherLetters)
	
	
	getTodaysDictionary(GlobalVars.fullParsedFile, GlobalVars.pangramMain.uniqueChars, GlobalVars.keyLetter, GlobalVars.todaysWordsArray, GlobalVars.totalPangrams)
	
	GlobalVars.maxScore = calculatePossiblePoints(GlobalVars.todaysWordsArray, GlobalVars.totalPangrams)
	
	
	print("center Letter: " + GlobalVars.keyLetter)
	
	print("pangram: " + GlobalVars.pangramMain.word)
	
	print("total pangrams: " + str(GlobalVars.totalPangrams))
	print("total words: " + str(GlobalVars.todaysWordsArray))
	print("count of words: " + str(GlobalVars.todaysWordsArray.size()))
	print("max score: " + str(GlobalVars.maxScore))
	
	
	
	$hiveControl.setLetters(GlobalVars.keyLetter, otherLetters)
	
	await get_tree().process_frame
	$LineEdit.grab_focus()
	

	
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "value", 10, .7).set_trans(Tween.TRANS_QUAD)

	




func _process(_delta):
	
	
	if Input.is_action_just_pressed("ui_text_submit"):
		var submission := str($LineEdit.text)
		var currentTier : String = getTier(GlobalVars.score, GlobalVars.maxScore)
		tierAssign(currentTier)

		if submission in GlobalVars.todaysWordsArray and not GlobalVars.alreadyGuessed.has(submission):
			print("the submission is in todaysWordsArray")
			GlobalVars.stringLength = submission.length()
			GlobalVars.alreadyGuessed.append(submission)
			$LineEdit.text = ""
			GlobalVars.score += assignPoints(GlobalVars.stringLength, submission)
			print(GlobalVars.score)
			print(float(GlobalVars.score)/float(GlobalVars.maxScore))
			GlobalVars.newTier = getTier(GlobalVars.score, GlobalVars.maxScore)
			if checkTier(currentTier, GlobalVars.newTier) == true:
				var x : int = tierAssign(GlobalVars.newTier)
				$pointsControl/textureProgressBar.progressBar(GlobalVars.arrayBars[x])
			else :
				pass
		elif submission in GlobalVars.alreadyGuessed:
			print("already guessed")
			$LineEdit.text = ""
		else:
			print("the submission is not in todaysWordsArray")
			$LineEdit.text = ""
	
		
		

#func _physics_process(delta):
	##if scoreBar length is less than current tier status, animate bar to fill to new status
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
			print("0" + tier)
		"Good Start":
			print("1" + tier)
			return x
		"Moving Up":
			print("2" + tier)
			x = 1
			return x
		"Good":
			print("3" + tier)
			x = 2
			return x
		"Solid":
			print("4" + tier)
			x = 3
			return x
		"Nice":
			print("5" + tier)
			x = 4
			return x
		"Great":
			print("6" + tier)
			x = 5
			return x
		"Amazing":
			print("7" + tier)
			x = 6
			return x
		"Genius":
			print("8" + tier)
			x = 7
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




# A function designed to create a dictionary of words and their position relative
# to the newly edited array todaysWordsArray
#func getArrayPosition(todaysArray, dictionary):
	#for i in todaysArray.size():
		#dictionary[(todaysArray[i])] = i
	#return


	
# Assigning points, including extra for pangrams
func assignPoints(strLength, word):
	var points := 0
	if strLength == 4:
		points = 1
	elif strLength >= 7 and GlobalVars.totalPangrams.has(word):
		points = strLength + 7
		print("pangram!")
	else :
		points = strLength
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
