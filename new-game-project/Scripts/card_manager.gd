extends Node2D

const COLLISION_MASK_CARD =1
const COLLISION_MASK_SLOT =2
var screen_size
var card_dragged
var is_hovering_on_card
var player_hand_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_hand_reference = $"../Player hand"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if card_dragged:
		var mouse_pos = get_global_mouse_position()
		card_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x), clamp(mouse_pos.y, 0, screen_size.y))

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = raycast_check()
			if card:
				drag_on(card)
				
		else:
			if card_dragged:
				drag_off()
			
			
			
func raycast_check():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point(parameters)
	if result.size() > 0 :
		return get_bigest_z_card(result)
	return null
func raycast_check_slot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_SLOT
	var result = space_state.intersect_point(parameters)
	if result.size() > 0 :
		return result[0].collider.get_parent()
	return null

func get_bigest_z_card(cards):
	var highest_z = cards[0].collider.get_parent()
	var highest_index = highest_z.z_index
	for i in range (1, cards.size()):
		var current_card = cards[i].collider.get_parent()
		if current_card.z_index > highest_index:
			highest_z = current_card
			highest_index = current_card.z_index
	return highest_z

func connect_card_signal(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)
	
func on_hovered_over_card(card):
	if !is_hovering_on_card:
		is_hovering_on_card = true
		highlight_card(card, true)
func on_hovered_off_card(card):
	highlight_card(card, false)
	var new_card_hovered = raycast_check()
	if new_card_hovered:
		highlight_card(new_card_hovered, true)
	else:
		is_hovering_on_card = false
	
func highlight_card(card, hovered):
	if hovered:
		card.position.y = card.position.y - 3
		card.z_index = 2
	else:
		card.position.y = card.position.y + 3
		card.z_index = 1
func drag_on(card):
	card_dragged = card
	card_dragged.scale = Vector2(1.05,1.05)
	
func drag_off():
	if card_dragged:
		card_dragged.scale = Vector2(1,1)
		var card_slot_found = raycast_check_slot()
		if card_slot_found and not card_slot_found.card_in_slot:
			player_hand_reference.remove_card_from_hand(card_dragged)
			card_dragged.position = card_slot_found.position
			highlight_card(card_dragged, true)
			card_dragged.get_node("Area2D/CollisionShape2D").disabled = true
			card_slot_found.card_in_slot = true
		else:
			player_hand_reference.add_card_to_hand(card_dragged)
		card_dragged = null
