extends Control

# Attribut zur Hausaufgabe
var counter : int = 0

# Attribute für unser Ratespiel
var computer_number : int
var player_number : int

# Called when the node enters the scene tree for the first time.
func _ready():
	computer_number = randi_range(0, 200)
	print(computer_number)
	greet_player()
	%Titel.text = "Rate eine Zahl zwischen 0 und 200"
	
func greet_player():
	var name
	name = "Godot"
	print("Hello " + name)


func _on_button_pressed():
	# Teil der Hausaufgabe
	counter = counter + 1
	$Button.text = "Klicks: " + str(counter)
#	print("Der Button wurde gedrückt!")



func _on_check_button_pressed():
	# counter, also Anzahl der Versuche wird um eins erhöht
	counter = counter + 1
	refresh_counterlabel()
	player_number = $VBoxContainer/SpinBox.value
	if (player_number < computer_number):
		%InfoLabel.text = "Die geratene Zahl ist zu klein."
	elif (player_number > computer_number):
		%InfoLabel.text = "Die geratene Zahl ist zu groß."
	else:
		%InfoLabel.text = "RICHTIG!!!"
		restart_game()

func restart_game():
	%RestartButton.show()
	%CheckButton.hide()

# Programmierherausforderungen bis zum nächsten Treffen am 12.10:
# Herausforderung 1:
# Beim anklicken des RestartButtons soll das Spiel mit allen 
# nötigen Werten wieder zurückgesetzt werden, so dass das Spiel
# nicht ständig neu gestartet werden muss
func _on_restart_button_pressed():
	# Anzahl der geratenen Versuche auf 0 zurücksetzen
	counter = 0
	refresh_counterlabel()
	# Eine neue Zufallszahl bestimmen lassen
	computer_number = randi_range(0, 200)
	# SpinBox zurücksetzen
	%SpinBox.value = 0
	# Das Infolabel auf den Startwert setzen
	%InfoLabel.text = "Infolabel"
	%RestartButton.hide()
	%CheckButton.show()


# Herausforderung 2:
# An geeigneter Stelle soll mittels eines passenden Nodes angezeigt werden
# wie viele Rateversuche bereits gebraucht wurden
func refresh_counterlabel():
	%CounterLabel.text = "Anzahl der Versuche: " + str(counter)

