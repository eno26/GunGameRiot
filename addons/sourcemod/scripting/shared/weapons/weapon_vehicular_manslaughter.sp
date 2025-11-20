#pragma semicolon 1
#pragma newdecls required

static char g_strKartSounds[][] = {
	")weapons/bumper_car_accelerate.wav",
	")weapons/bumper_car_decelerate.wav",
	")weapons/bumper_car_decelerate_quick.wav",
	")weapons/bumper_car_go_loop.wav",
	")weapons/bumper_car_hit_ball.wav",
	")weapons/bumper_car_hit_ghost.wav",
	")weapons/bumper_car_hit_hard.wav",
	")weapons/bumper_car_hit_into_air.wav",
	"weapons/bumper_car_hit1.wav",
	"weapons/bumper_car_hit2.wav",
	"weapons/bumper_car_hit3.wav",
	"weapons/bumper_car_hit4.wav",
	"weapons/bumper_car_hit5.wav",
	"weapons/bumper_car_hit6.wav",
	"weapons/bumper_car_hit7.wav",
	"weapons/bumper_car_hit8.wav",
	")weapons/bumper_car_jump.wav",
	")weapons/bumper_car_jump_land.wav",
	")weapons/bumper_car_screech.wav",
	")weapons/bumper_car_spawn.wav",
	")weapons/bumper_car_spawn_from_lava.wav",
	")weapons/bumper_car_speed_boost_start.wav",
	")weapons/bumper_car_speed_boost_stop.wav"
};

public void VehicularManslaughter_WeaponCreated(int client, int weapon)
{
	TF2_AddCondition(client, TFCond_HalloweenKart);
}

public void VehicularManslaughter_WeaponRemoved(int client, int weapon)
{
	TF2_RemoveCondition(client, TFCond_HalloweenKart);
}

public void VehicularManslaughter_Precache()
{
	for (int i = 0; i < sizeof(g_strKartSounds); i++)
		PrecacheSound(g_strKartSounds[i]);
}