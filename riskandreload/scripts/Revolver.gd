extends Node3D

var balas : int = 0

func cargar(n_balas : int):
	balas = clamp(n_balas, 0, 6)
	print("Revólver cargado con %d balas" % balas)

func disparar() -> bool:
	if balas <= 0:
		print("¡Clic! No hay balas")
		return false
	else:
		balas -= 1
		print("¡Bang! Quedan %d balas" % balas)
		return true
