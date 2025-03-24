extends Node2D
class_name Card

signal hovered
signal hovered_off
#Onreadies
@onready var card_artwork: Sprite2D = $"Card artwork"
@onready var card_background: Sprite2D = $"Card background"
@onready var health_number: Label = $Stats/Health/number
@onready var damage_sprite: Sprite2D = $Stats/Damage
@onready var damage_number: Label = $Stats/Damage/number
@onready var healing_number: Label = $Stats/Healing/number
@onready var cost_number: Label = $Stats/Cost/number

@onready var name_label: Label = $"Lower part/Card name"
@onready var description_label: Label = $"Lower part/Card description"

#All card characteristic
@export var artwork : CompressedTexture2D = preload("res://Resources/Image/Artwork/archer.png")
enum Race {
	HUMAN, GOBLIN, OBJECT, ANIMAL, ARCANIAN, UNDEAD
}
@export var selected_race: Race = Race.HUMAN
@export var card_name:String = "Archer"
@export var card_description:String = "Random Archer"

@export var health:int = 4
enum Damage_type {
	PHYSICAL, MAGICAL, NONE
}
@export var damage:int = 4
@export var selected_damage: Damage_type = Damage_type.PHYSICAL

@export var healing:int = 0
@export var cost:int = 4


var starting_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect_card_signal(self)
	card_artwork.texture = artwork
	if card_background:
		card_background.apply_race_palette(selected_race)  # Call the function in CardBackground
	name_label.text = card_name
	description_label.text = card_name
	health_number.text = str(health)
	damage_number.text = str(damage)
	if selected_damage == Damage_type.PHYSICAL:
		damage_sprite.texture = preload("res://Resources/Image/sword.png")
	if selected_damage == Damage_type.MAGICAL:
		damage_sprite.texture = preload("res://Resources/Image/staff.png")
	if selected_damage == Damage_type.NONE:
		damage_sprite.queue_free()
	healing_number.text = str(healing)
	cost_number.text = str(cost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)


func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)
