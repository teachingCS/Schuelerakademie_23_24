extends Node2D


func _on_goal_body_entered(body):
	call_deferred("remove_child", body)
	GameState.current_level += 1
	GameState.load_level()
