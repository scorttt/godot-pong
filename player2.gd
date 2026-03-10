extends CharacterBody2D

const SPEED = 50.0;
var isAiPlayer: bool = true;
var onRightSide: bool = false;
var paddleSlowRate: float = 0.25;

@onready var ball = %Ball;
@onready var paddle = %Paddle;

func _physics_process(delta):
	var paddleHeight: float = paddle.scale.y / 2;
	var paddleHalf: float = paddleHeight / 2;
	var screenTop: float = paddleHeight;
	var screenBottom: float = get_viewport_rect().size.y - paddleHeight;

	onRightSide = true if ball.global_position.x > get_viewport_rect().size.x / 1.5 else false;

	if Input.is_action_pressed("p2_move_up") || Input.is_action_pressed("p2_move_down"):
		isAiPlayer = false;
	
	if !isAiPlayer:
		if Input.is_action_pressed("p2_move_down"):
			velocity.y += 1;
		if Input.is_action_pressed("p2_move_up"):
			velocity.y -= 1;
	else:
		var t: float = 1.0 - clamp(
								abs(ball.global_position.x - global_position.x) /
								get_viewport_rect().size.x, 0.0, 1.0);

		var rate: float = lerp(0.1, 1.0, t);
		print(rate);

		if ball.global_position.y + paddleHalf < global_position.y:
			velocity.y -= rate;
		elif ball.global_position.y - paddleHalf > global_position.y:
			velocity.y += rate;
		else:
			velocity.y = 0;

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
