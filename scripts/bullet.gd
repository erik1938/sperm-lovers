extends Area3D

@export var speed: float = 20.0
@export var lifetime: float = 2.0

var direction := Vector3.FORWARD

func _ready() -> void:
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
	body_entered.connect(_on_body_entered)
	print("Bullet ready, monitoring: ", monitoring)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered(body: Node3D) -> void:
	print("Bullet hit: ", body.name, " Groups: ", body.get_groups())
	if body.is_in_group("enemies"):
		body.take_damage()
		queue_free()
