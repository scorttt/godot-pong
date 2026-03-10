extends CharacterBody2D

const SPEED: float = 50.0;
var paddleSlowRate: float = 0.25;

@onready var paddle = %Paddle;

func _physics_process(delta):
	var paddleHeight: float = paddle.scale.y / 2;
	var screenTop: float = paddleHeight;
	var screenBottom: float = get_viewport_rect().size.y - paddleHeight;
	
	if Input.is_action_pressed("p1_move_down"):
		velocity.y += 1;
	if Input.is_action_pressed("p1_move_up"):
		velocity.y -= 1;

	position += velocity * SPEED * delta;
	position.y = clamp(position.y, screenTop, screenBottom);

	if abs(position.y - screenTop) < 0.5:
		velocity.y = max(velocity.y, 0);
	if abs(position.y - screenBottom) < 0.5:
		velocity.y = min(velocity.y, 0);
		
	if velocity.y != 0:
		if velocity.y > 0:
			velocity.y -= paddleSlowRate;
		elif velocity.y < 0:
			velocity.y += paddleSlowRate;
		if abs(velocity.y) < 0.05:
			velocity.y = 0;
