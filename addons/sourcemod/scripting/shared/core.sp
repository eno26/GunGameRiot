#pragma semicolon 1
#pragma newdecls required

#include <tf2_stocks>
#include <sdkhooks>
#include <clientprefs>
#include <dhooks>
#if defined ZR || defined RPG
#undef AUTOLOAD_EXTENSIONS
#tryinclude <tf2items>
#define AUTOLOAD_EXTENSIONS
#include <tf_econ_data>
#endif
#if !defined RTS
#include <tf2attributes>
#endif
#include <morecolors>
#include <tf2utils>
#include <collisionhook>
#include <sourcescramble>
//#include <handledebugger>
#undef REQUIRE_EXTENSIONS
#undef REQUIRE_PLUGIN

#pragma dynamic	131072


#include "global_arrays.sp"
#include "weapons.sp"
#include "configs.sp"



public void OnPluginStart()
{
	Core_DoTickrateChanges();
}

public void OnMapStart()
{
	//precache or fastdl
}

public void OnConfigsExecuted()
{
	Configs_ConfigsExecuted();
	Weapons_ConfigsExecuted();
}


public void OnEntityCreated(int entity, const char[] classname)
{
	if (entity < 0)
		return;
	if (entity > 2048)
		return;
	if (!IsValidEntity(entity))
		return;

}

public void OnEntityDestroyed(int entity)
{

}
void Core_DoTickrateChanges()
{
	//needs to get called a few times just incase.
	//it isnt expensive so it really doesnt matter.
	float tickrate = 1.0 / GetTickInterval();
	TickrateModifyInt = RoundToNearest(tickrate);

	TickrateModify = tickrate / 66.0;
}




public Action TF2Items_OnGiveNamedItem(int client, char[] classname, int index, Handle &item)
{
	//strip players of all weapons at all times
	if(!StrContains(classname, "tf_wear"))
	{
		switch(index)
		{	
			case 57, 131, 133, 231, 405, 406, 444, 608, 642, 1099, 1144:
			{
				if(!item)
					return Plugin_Stop;
				
				TF2Items_SetFlags(item, OVERRIDE_ATTRIBUTES);
				TF2Items_SetNumAttributes(item, 0);
				return Plugin_Changed;
			}
		}
	}
	else
	{
		return Plugin_Stop;
	}
	return Plugin_Continue;
}