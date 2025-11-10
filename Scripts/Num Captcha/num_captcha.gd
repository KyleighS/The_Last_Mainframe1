extends Node2D
var one_pressed = false
@onready var one: Button = $Control/One
var two_pressed = false
@onready var two: Button = $Control/Two
var three_pressed = false
@onready var three: Button = $Control/Three
var four_pressed = false
@onready var four: Button = $Control/Four
var five_pressed = false
@onready var five: Button = $Control/Five
var six_pressed = false
@onready var six: Button = $Control/Six
var seven_pressed = false
@onready var seven: Button = $Control/Seven
var eight_pressed = false
@onready var eight: Button = $Control/Eight
var nine_pressed = false
@onready var nine: Button = $Control/Nine

var captcha_cleared

func _ready() -> void:
	reset()

func _on_one_pressed() -> void:
	one.hide()
	if !two_pressed && !three_pressed && !four_pressed && !five_pressed && !six_pressed && !seven_pressed && !eight_pressed && !nine_pressed:
		one_pressed = true
	else:
		captcha_cleared = false

func _on_two_pressed() -> void:
	two.hide()
	if one_pressed:
		if !three_pressed && !four_pressed && !five_pressed && !six_pressed && !seven_pressed && !eight_pressed && !nine_pressed:
			two_pressed = true
	else:
		captcha_cleared = false

func _on_three_pressed() -> void:
	three.hide()
	if one_pressed && two_pressed:
		if !four_pressed && !five_pressed && !six_pressed && !seven_pressed && !eight_pressed && !nine_pressed:
			three_pressed = true
	else:
		captcha_cleared = false

func _on_four_pressed() -> void:
	four.hide()
	if one_pressed && two_pressed && three_pressed:
		if !five_pressed && !six_pressed && !seven_pressed && !eight_pressed && !nine_pressed:
			four_pressed = true
	else:
		captcha_cleared = false

func _on_five_pressed() -> void:
	five.hide()
	if one_pressed && two_pressed && three_pressed && four_pressed:
		if !six_pressed && !seven_pressed && !eight_pressed && !nine_pressed:
			five_pressed = true
	else:
		captcha_cleared = false

func _on_six_pressed() -> void:
	six.hide()
	if one_pressed && two_pressed && three_pressed && four_pressed && five_pressed:
		if !seven_pressed && !eight_pressed && !nine_pressed:
			six_pressed = true
	else:
		captcha_cleared = false

func _on_seven_pressed() -> void:
	seven.hide()
	if one_pressed && two_pressed && three_pressed && four_pressed && five_pressed && six_pressed:
		if !eight_pressed && !nine_pressed:
			seven_pressed = true
	else:
		captcha_cleared = false

func _on_eight_pressed() -> void:
	eight.hide()
	if one_pressed && two_pressed && three_pressed && four_pressed && five_pressed && six_pressed && seven_pressed:
		if !nine_pressed:
			eight_pressed = true
	else:
		captcha_cleared = false

func _on_nine_pressed() -> void:
	nine.hide()
	if one_pressed && two_pressed && three_pressed && four_pressed && five_pressed && six_pressed && seven_pressed && eight_pressed:
		nine_pressed = true
		captcha_cleared = true
	else:
		captcha_cleared = false

func reset():
	captcha_cleared = false
	one_pressed = false
	two_pressed = false
	three_pressed = false
	four_pressed = false
	five_pressed = false
	six_pressed = false
	seven_pressed = false
	eight_pressed = false
	nine_pressed = false
	one.show()
	two.show()
	three.show()
	four.show()
	five.show()
	six.show()
	seven.show()
	eight.show()
	nine.show()
