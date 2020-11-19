extends Panel

onready var _music_bus = AudioServer.get_bus_index("Music")
onready var _sfx_bus = AudioServer.get_bus_index("SFX")

func _ready():
	pass # Replace with function body.



func _on_MusicVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_music_bus,int(value))


func _on_SFXVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_sfx_bus,int(value))


func _on_OptionsBackButton_pressed():
	hide()
