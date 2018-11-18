extends Panel

export (int) var points = 10

var bar

var max_points
var alive = true

func _ready():
    bar = get_node('ProgressBar')
    max_points = points
    
    bar.max_value = max_points
    bar.value = points

func decrease(amount):
    points -= amount
    
    if points <= 0:
        points = 0
        death()
        
    bar.value = points
    
    logger.write("Player taken damage for: " + String(amount))
    
func increase(amount):
    points += amount
    
    if points > max_points:
        points = max_points
        
    bar.value = points
    
    logger.write("Player healed for: " + String(amount))
    
func death():
    alive = false
    
    logger.write("Player is dead!")
    
    game_manager.gameover()