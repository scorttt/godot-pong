extends Sprite2D

var target = RigidBody2D;

func _ready():
	target = get_parent();

func _process(_delta):
	var gridSize = 8;
	global_position = Vector2(
		snapped(target.global_position.x, gridSize),
		snapped(target.global_position.y, gridSize)
	);
