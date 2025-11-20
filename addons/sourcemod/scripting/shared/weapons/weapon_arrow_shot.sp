#pragma semicolon 1
#pragma newdecls required


#define SPLIT_ANGLE_OFFSET 2.0

#define SOUND_ARROW_SHOOT		"weapons/bow_shoot.wav"

public void Weapon_Arrow_Shoot_Map_Precache()
{
	PrecacheSound(SOUND_ARROW_SHOOT);
}

public void Weapon_Shoot_Arrow(int client, int weapon, bool crit, int slot)
{
	float damage = 100.0;
	damage *= Attributes_Get(weapon, 2, 1.0);

		
	float fAng[3], fPos[3];
	GetClientEyeAngles(client, fAng);
	GetClientEyePosition(client, fPos);
	float Charge_Time = GetGameTime();
	
	Charge_Time -= GetEntPropFloat(weapon, Prop_Send, "m_flChargeBeginTime");
	
	Charge_Time += 0.6;
	
	if(Charge_Time > 1.0)
		Charge_Time = 1.0;
		
	if(Charge_Time < 0.3)
		Charge_Time = 0.3;
		
	Charge_Time /= 1.0;
	
	damage *= Charge_Time;
	/*
		1 - Bullet
	2 - Rocket
	3 - Pipebomb
	4 - Stickybomb (Stickybomb Launcher)
	5 - Syringe
	6 - Flare
	8 - Huntsman Arrow
	11 - Crusader's Crossbow Bolt
	12 - Cow Mangler Particle
	13 - Righteous Bison Particle
	14 - Stickybomb (Sticky Jumper)
	17 - Loose Cannon
	18 - Rescue Ranger Claw
	19 - Festive Huntsman Arrow
	22 - Festive Jarate
	23 - Festive Crusader's Crossbow Bolt
	24 - Self Aware Beuty Mark
	25 - Mutated Milk
	*/
	float speed = 2600.0;
	speed *= Charge_Time;
	float storedAngle[3];
	float storedAngle_2[3];
	storedAngle = fAng;
	storedAngle_2 = fAng;
	int Arrow = SDKCall_CTFCreateArrow(fPos, fAng, speed, 0.1, 8, client, client);
	if(IsValidEntity(Arrow))
	{
		SetEntityCollisionGroup(Arrow, 27);
		SetEntDataFloat(Arrow, FindSendPropInfo("CTFProjectile_Rocket", "m_iDeflected")+4, damage, true);	// Damage
		SetEntPropEnt(Arrow, Prop_Send, "m_hOriginalLauncher", weapon);
		SetEntPropEnt(Arrow, Prop_Send, "m_hLauncher", weapon);
		SetEntProp(Arrow, Prop_Send, "m_bCritical", false);
		fAng[0] = storedAngle[0];
		fAng[1] = fixAngle(storedAngle[1] + SPLIT_ANGLE_OFFSET);
		fAng[2] = storedAngle[2];
		
		Arrow = SDKCall_CTFCreateArrow(fPos, fAng, speed, 0.1, 8, client, client);
		if(IsValidEntity(Arrow))
		{
			SetEntDataFloat(Arrow, FindSendPropInfo("CTFProjectile_Rocket", "m_iDeflected")+4, damage, true);	// Damage
			SetEntPropEnt(Arrow, Prop_Send, "m_hOriginalLauncher", weapon);
			SetEntPropEnt(Arrow, Prop_Send, "m_hLauncher", weapon);
			SetEntProp(Arrow, Prop_Send, "m_bCritical", false);
			SetEntityCollisionGroup(Arrow, 27);
			storedAngle_2[0] = storedAngle[0];
			storedAngle_2[1] = fixAngle(storedAngle[1] - SPLIT_ANGLE_OFFSET);
			storedAngle_2[2] = storedAngle[2];
			Arrow = SDKCall_CTFCreateArrow(fPos, storedAngle_2, speed, 0.1, 8, client, client);
			if(IsValidEntity(Arrow))
			{
				SetEntDataFloat(Arrow, FindSendPropInfo("CTFProjectile_Rocket", "m_iDeflected")+4, damage, true);	// Damage
				SetEntPropEnt(Arrow, Prop_Send, "m_hOriginalLauncher", weapon);
				SetEntPropEnt(Arrow, Prop_Send, "m_hLauncher", weapon);
				SetEntProp(Arrow, Prop_Send, "m_bCritical", false);
				SetEntityCollisionGroup(Arrow, 27);
			}		
		}
	}
}
