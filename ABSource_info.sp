#pragma semicolon 1

// ===================
// >>> DEFINE
// ===================

#define DEBUG

#define PLUGIN_AUTHOR "Bioly | bioly.sh"
#define PLUGIN_VERSION "0.1 (pre-alpha)"

// ====================
// >>> INCLUDE
// ====================

#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <sdkhooks>

// ======================================
// >>> HANDLE || CHAR || CVARY || BOOLE
// ======================================

Handle Message;
char MessageS[1024];

#pragma newdecls required

EngineVersion g_Game;

// ===========================
// >>> PLUGIN INFO
// ===========================

public Plugin myinfo = 
{
	name = "ABSource_InfoOTS", 
	author = PLUGIN_AUTHOR, 
	description = "N/A", 
	version = PLUGIN_VERSION, 
	url = "http://absource.pl/"
};

// ====================
// >>> OnPluginStart
// ====================

public void OnPluginStart()
{
	g_Game = GetEngineVersion();
	if (g_Game != Engine_CSGO && g_Game != Engine_CSS)
	{
		SetFailState("Ten plugin jest tylko do CSGO/CSS.");
	}
	
	Message = CreateConVar("absource_info_hud", "Zapraszamy na nasz nowo otwarty serwer TS3: <font color='#00ff04'>ts3.eskill.pl<font color='#ffffff'>", "Treść wiadomości pokazywana w hint.");
	
	// =============================
	// >>> TWORZENIE PLIKU CFG
	// =============================
	
	AutoExecConfig(true, "absource_infoots");
	
	HookEvent("round_start", roundStart);
}

public Action roundStart(Handle event, const char[] name, bool dontBroadcast)
{
	CreateTimer(5.0, PokazInfo);
}

public Action PokazInfo(Handle timer)
{
	GetConVarString(Message, MessageS, sizeof(MessageS));
	PrintHintTextToAll("%s", MessageS);
}


/*

	GetConVarString(TAG, TAGS, sizeof(TAGS));
	PrintToChatAll("%s <-- TAG", TAGS);
*/
