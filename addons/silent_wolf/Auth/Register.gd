extends TextureRect

const SWLogger = preload("../utils/SWLogger.gd")

func _ready():
	#var auth_node = get_tree().get_root().get_node("res://addons/silent_wolf/Auth/Auth")
	SilentWolf.Auth.connect("sw_registration_succeeded", self, "_on_registration_succeeded")
	SilentWolf.Auth.connect("sw_registration_failed", self, "_on_registration_failed")
	
func _on_RegisterButton_pressed():
	var player_name = $"Background/FormContainer/MainFormContainer/FormInputFields/PlayerName".text
	var email = $"Background/FormContainer/MainFormContainer/FormInputFields/Email".text
	var password = $"Background/FormContainer/MainFormContainer/FormInputFields/Password".text
	var confirm_password = $"Background/FormContainer/MainFormContainer/FormInputFields/ConfirmPassword".text
	SilentWolf.Auth.register_player(player_name, email, password, confirm_password)
	show_processing_label()
	
func _on_registration_succeeded():
	#get_tree().change_scene("res://addons/silent_wolf/Auth/Login.tscn")
	# redirect to configured scene (user is logged in after registration)
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	# if doing email verification, open scene to confirm email address
	if ("email_confirmation_scene" in SilentWolf.auth_config) and (SilentWolf.auth_config.email_confirmation_scene) != "":
		SWLogger.info("registration succeeded, waiting for email verification...")
		scene_name = SilentWolf.auth_config.email_confirmation_scene
	else:
		SWLogger.info("registration succeeded, logged in player: " + str(SilentWolf.Auth.logged_in_player))
	get_tree().change_scene(scene_name)
	
func _on_registration_failed(error):
	hide_processing_label()
	SWLogger.info("registration failed: " + str(error))
	$"Background/FormContainer/ErrorMessage".text = error
	$"Background/FormContainer/ErrorMessage".show()

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
	
func show_processing_label():
	$"Background/FormContainer/ProcessingLabel".show()
	
func hide_processing_label():
	$"Background/FormContainer/ProcessingLabel".hide()
	
func _on_UsernameToolButton_mouse_entered():
	$"Background/FormContainer/InfoBox".text = "Username should contain at least 6 characters (letters or numbers) and no spaces."
	$"Background/FormContainer/InfoBox".show()

func _on_UsernameToolButton_mouse_exited():
	$"Background/FormContainer/InfoBox".hide()

func _on_PasswordToolButton_mouse_entered():
	$"Background/FormContainer/InfoBox".text = "Password should contain at least 8 characters including uppercase and lowercase letters, numbers and (optionally) special characters."
	$"Background/FormContainer/InfoBox".show()

func _on_PasswordToolButton_mouse_exited():
	$"Background/FormContainer/InfoBox".hide()
