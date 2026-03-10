extends CharacterBody2D

const SPEED: float = 50.0;

func _physics_process(delta):
	if Input.is_action_pressed("p1_move_down"):
		velocity.y += 1;
	if Input.is_action_pressed("p1_move_up"):
		velocity.y -= 1;

	position += velocity * SPEED * delta;
	
	var paddleHeight: float = %Paddle.scale.y / 2;

	var screenTop: float = paddleHeight;
	var screenBottom: float = get_viewport_rect().size.y - paddleHeight;
	
	position.y = clamp(position.y, screenTop, screenBottom);
	if position.y == screenTop:
		velocity.y = 0;
	if position.y == screenBottom:
		velocity.y = 0;
	
	var paddleSlowRate: float = 0.25;
	if velocity.y != 0:
		if velocity.y > 0:
			velocity.y -= paddleSlowRate;
		elif velocity.y < 0:
			velocity.y += paddleSlowRate;

		if abs(velocity.y) < 0.05:
			velocity.y = 0;
