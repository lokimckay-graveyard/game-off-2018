extends Node

# This can be transferred to a weapons json file
var weapons = \
[{
	"weapon": "Pistol",
	"specs": {
		"damage": 1,
		"fire_rate": 0.1,
		"bullet_spread": 0,
		"reload_time": 3,
		"weapon_range": -1,
		"max_ammo": 10
	}
}]

func get_weapon_specs(weapon):
	for i in weapons.size():
		if weapons[i].weapon == weapon:
			logger.write(weapon)
			return weapons[i].specs