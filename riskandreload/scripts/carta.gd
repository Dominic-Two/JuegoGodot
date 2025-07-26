extends Node3D

@onready var cuerpo := $CuerpoCarta
var tipo_carta: int = 0

# Lista de materiales precargados
var materiales = [
	preload("res://materiales/material_carta_0.tres"),
	preload("res://materiales/material_carta_1.tres"),
	preload("res://materiales/material_carta_2.tres"),
	preload("res://materiales/material_carta_3.tres"),
	preload("res://materiales/material_carta_4.tres")
]
	
func set_tipo(tipo: int):
	tipo_carta = tipo
	if tipo >= 0 and tipo < materiales.size():
		cuerpo.set_surface_override_material(0, materiales[tipo])
		print(materiales)
