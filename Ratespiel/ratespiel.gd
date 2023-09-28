extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	greet_player()
	$Titel.text = "Ratespiel"
func greet_player():
	var name
	name = "Godot"
	print("Hello " + name)


func _on_button_pressed():
	print("Der Button wurde gedrückt!")


# Hausaufgabe: Verwandelt den Button in einen Click-counter Button
# Bei jedem Klick auf den Button wird auf dem Button angezeigt, wie oft
# der Button geklickt wurde. Viel Spaß und Erfolg dabei! 
