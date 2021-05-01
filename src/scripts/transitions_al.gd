extends Node

var transitions_anim_names: Dictionary = {
		0: "Circle",
		1: "Diagonal1",
		2: "Diagonal2",
		3: "Diagonal3",
		4: "Diagonal4",
		5: "Down-Top",
		6: "Fade",
		7: "LEFTandRIGHT",
		8: "Left-right",
		9: "Right-Left",
		10: "Top-down"
}

enum transition_type {
	Circle = 0,
	Diagonal1,
	Diagonal2,
	Diagonal3,
	Diagonal4,
	DownTop,
	Fade,
	LEFTandRIGHT,
	LeftRight,
	RightLeft,
	TopDown
}

export (transition_type) var select_transition;

var _new_scene_dir: String;
var _load_state: int = 0;

func next_state() -> void:
	match _load_state:
		0:
			get_tree().paused = true;
			$trans_anim.play(transitions_anim_names[select_transition]);
			_load_state = 1;
			$timer.wait_time = $trans_anim.current_animation_length;
			$timer.start();
		1:
			# warning-ignore:return_value_discarded
			get_tree().change_scene(_new_scene_dir);
			$timer.wait_time = 0.05;
			$timer.start();
			_load_state = 2;
		2:
			$trans_anim.play_backwards(transitions_anim_names[select_transition]);
			$timer.wait_time = $trans_anim.current_animation_length;
			$timer.start();
			_load_state = 3;
		3:
			_load_state = 0;
			get_tree().paused = false;


func last_scene():
	_new_scene_dir = "";


func next_scene(scene : String, transition = null):
	_new_scene_dir = scene;
	if _load_state != 0:
		_load_state = 0;
		push_warning('Last scene was not fully apply')
	if transition:
		select_transition = transition
	next_state();


func _on_timer_timeout():
	next_state();
