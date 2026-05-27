extends Node

#String will be the Squad Country and the Array will be the players of it's squad
var squads : Dictionary[String, Array]

func _init() -> void:
	var json_file := FileAccess.open("res://assets/json/squads.json", FileAccess.READ)
	
	if json_file == null:
		printerr("Could not find or load squads json file")
	
	var json_text := json_file.get_as_text()
	
	var json := JSON.new()
	
	if json.parse(json_text) != OK:
		printerr("Could not parse squads.json")

	for team in json.data:
		var country_name := team["country"] as String
		var players := team["players"] as Array

		#pass the data from file to the squads array
		if not squads.has(country_name):
			squads.set(country_name, [])

		for player in players:
			var fullname := player["name"] as String
			var skin := player["skin"] as Player.SkinColor
			var role := player["role"] as Player.Role
			var speed := player["speed"] as float
			var power := player["power"] as float
			
			#create the player resource based on the data
			var player_resource := PlayerResource.new(fullname, skin, role, speed, power)
			
			#add player to the country name array it belongs to in the squads array
			squads.get(country_name).append(player_resource)
		
		assert(players.size() == 6) #make sure players is 6 if not it will return
	json_file.close() #close the file


#getter function
func get_squad(country: String) -> Array:
	if squads.has(country):
		return squads[country]
	return []


#...
