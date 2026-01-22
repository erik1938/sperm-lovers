extends CharacterBody3D

@export var move_speed: float = 2.0
@export var wander_range: float = 5.0
@export var health: int = 2
@export var chase_speed: float = 3.0
@export var aggro_alert_range: float = 5.0

var wander_target: Vector3
var home_position: Vector3
var is_aggro: bool = false
var target: Node3D = null


func _ready() -> void:
	home_position = global_position
	add_to_group("enemies")
	pick_new_wander_target()
	print("Sibling spawned onaa layers: ", collision_layer, " groups: ", get_groups())


func _physics_process(_delta: float) -> void:
	if is_aggro and is_instance_valid(target):
		# AGGRO state: chase the target
		var direction = (target.global_position - global_position).normalized()
		direction.y = 0
		velocity = direction * chase_speed
	else:
		# WANDER state: move toward wander target
		var direction = (wander_target - global_position).normalized()
		direction.y = 0
		velocity = direction * move_speed

		# Pick new target when close
		if global_position.distance_to(wander_target) < 0.5:
			pick_new_wander_target()

	move_and_slide()

	# Face movement direction
	if velocity.length() > 0.1:
		rotation.y = atan2(velocity.x, velocity.z)


func pick_new_wander_target() -> void:
	wander_target = Vector3(
		home_position.x + randf_range(-wander_range, wander_range),
		global_position.y,
		home_position.z + randf_range(-wander_range, wander_range)
	)


func take_damage(amount: int) -> void:
	health -= amount
	print("Sibling took ", amount, " damage! Health: ", health)

	# Become aggro and target the player
	if not is_aggro:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			become_aggro(player)
			alert_nearby_siblings(player)

	if health <= 0:
		print("Sibling died!")
		queue_free()


func become_aggro(new_target: Node3D) -> void:
	is_aggro = true
	target = new_target
	print("Sibling became aggro!")


func alert_nearby_siblings(aggro_target: Node3D) -> void:
	for sibling in get_tree().get_nodes_in_group("enemies"):
		if sibling == self:
			continue
		if not sibling.has_method("become_aggro"):
			continue
		if global_position.distance_to(sibling.global_position) <= aggro_alert_range:
			sibling.become_aggro(aggro_target)
