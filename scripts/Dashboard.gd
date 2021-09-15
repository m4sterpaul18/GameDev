extends Control


onready var greetText = $Greet;
var currentUser = SilentWolf.Auth.logged_in_player;

func _ready():
	greetText.text = "Hello " + str(currentUser);


