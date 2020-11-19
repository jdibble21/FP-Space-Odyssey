# Controls music and sfx volume, and muting of both buses
extends Panel

onready var _music_bus = AudioServer.get_bus_index("Music")
onready var _sfx_bus = AudioServer.get_bus_index("SFX")

func _on_MusicVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_music_bus,int(value))


func _on_SFXVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_sfx_bus,int(value))


func _on_OptionsBackButton_pressed():
	hide()


func _on_MusicMuteCheck_toggled(button_pressed):
	AudioServer.set_bus_mute(_music_bus,button_pressed)


func _on_SFXMuteCheck_toggled(button_pressed):
	if button_pressed:
		AudioServer.set_bus_mute(_sfx_bus,true)
	if !button_pressed:
		AudioServer.set_bus_mute(_sfx_bus,false)
