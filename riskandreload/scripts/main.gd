extends Node3D

@onready var camara_pivot: PathFollow3D = get_node_or_null("CaminoCamara/CamaraPivot")

var progreso_actual := 0.0

func _ready():
	if camara_pivot == null:
		push_error("❌ No se encontró CamaraPivot")
	else:
		# No la colocamos directamente, sino con animación (tipo intro)
		mover_camara_a_jugador(-.25)  # Jugador 1 por defecto


# Función para mover la cámara a un jugador específico (0 o 1)
func mover_camara_a_jugador(numero: float):
	var progreso_objetivo = numero  # 0.0 para jugador 1, 0.5 para jugador 2
	var tween := create_tween()
	tween.tween_property(
		camara_pivot,
		"progress_ratio",
		progreso_objetivo,
		1.5  # duración en segundos
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	progreso_actual = progreso_objetivo

func posicionar_camara_directamente(numero: int):
	if camara_pivot == null:
		push_error("❌ camara_pivot es null. No se puede posicionar.")
		return

	var progreso = numero * 0.5
	camara_pivot.progress_ratio = progreso
	progreso_actual = progreso
