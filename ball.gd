extends RigidBody2D

const BALL_INIT_SPEED:   float = 600.0;
const SPEED_INCREASE:    float = 75.0;
var initialBallPosition: Vector2 = Vector2(640.0, 384.0);
var initialBallVelocity: Vector2 = Vector2.ZERO;
var speed:               float = BALL_INIT_SPEED;
var reset:               bool = false;

func _ready():
	randomizeServeDirection();

func _physics_process(_delta):
	linear_velocity = linear_velocity.normalized() * speed;

func _integrate_forces(state):
	if reset:
		var nextTransform = state.get_transform();
		nextTransform.origin = initialBallPosition;
		state.set_transform(nextTransform);
		state.linear_velocity = Vector2.ZERO;
		reset = false;
		randomizeServeDirection();

func randomizeServeDirection():
	linear_velocity = initialBallVelocity;
	var randomY = randf_range(-0.5, 0.5);
	if randi_range(1, 2) == 1:
		linear_velocity = Vector2(-1, randomY) * speed;
	else:
		linear_velocity = Vector2(1, randomY) * speed;

	initialBallVelocity = get_linear_velocity();
	
func resetBall():
	reset = true;
	speed = BALL_INIT_SPEED

func _on_body_entered(body):
	if body.has_node("Paddle"):
		speed += SPEED_INCREASE;
		
		var randomY = randf_range(-0.5, 0.5);
		var currentVelocity = linear_velocity.normalized();
		linear_velocity = Vector2(currentVelocity.x, currentVelocity.y + randomY) * speed;
