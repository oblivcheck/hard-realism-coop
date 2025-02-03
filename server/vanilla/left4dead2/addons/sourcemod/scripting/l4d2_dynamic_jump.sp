
#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <actions>

#include "l4d2_dynamic_jump_tools.sp" // debug & dereference functions
#include "l4d2_dynamic_jump_sdk.sp" // sdkcalls & their wrappers
#include "l4d2_dynamic_jump_path.sp" // Path methodmap
#include "l4d2_dynamic_jump_infected_attack.sp" // InfectedAttack methodmap
#include "l4d2_dynamic_jump_chase_victim.sp" // ChaseVictim methodmap
#include "l4d2_dynamic_jump_jump_across.sp" // New action JumpAcross for actual jump

public Plugin myinfo = 
{
	name = "[L4D2] Common Infected Dynamic Jump",
	author = "BHaType",
	description = "Makes common infected jump to segment goal position during chase",
	version = "1.1",
	url = ""
};

ConVar z_dynamic_jump_check_interval, z_dynamic_jump_climb_up_range, 
z_dynamic_jump_debug, z_dynamic_jump_think_interval,
z_dynamic_jump_velocity, z_dynamic_jump_chance, z_dynamic_jump_chance_throttle;

ConVar nb_gravity;

enum SegmentType
{
	ON_GROUND, 
	DROP_DOWN, 
	CLIMB_UP, 
	JUMP_OVER_GAP, 
	LADDER_UP, 
	LADDER_DOWN, 
	
	NUM_SEGMENT_TYPES
};

enum ActivityType 
{ 
	MOTION_CONTROLLED_XY	= 0x0001,	// XY position and orientation of the bot is driven by the animation.
	MOTION_CONTROLLED_Z		= 0x0002,	// Z position of the bot is driven by the animation.
	ACTIVITY_UNINTERRUPTIBLE= 0x0004,	// activity can't be changed until animation finishes
	ACTIVITY_TRANSITORY		= 0x0008,	// a short animation that takes over from the underlying animation momentarily, resuming it upon completion
	ENTINDEX_PLAYBACK_RATE	= 0x0010,	// played back at different rates based on entindex
};

public void OnPluginStart()
{
	SetupSDKCalls();
	
	z_dynamic_jump_debug = CreateConVar("z_dynamic_jump_debug", "0");
	z_dynamic_jump_think_interval = CreateConVar("z_dynamic_jump_think_interval", "0.2");
	z_dynamic_jump_check_interval = CreateConVar("z_dynamic_jump_check_interval", "0.3");
	z_dynamic_jump_climb_up_range = CreateConVar("z_dynamic_jump_climb_up_range", "350.0");
	z_dynamic_jump_velocity = CreateConVar("z_dynamic_jump_velocity", "750.0");
	z_dynamic_jump_chance = CreateConVar("z_dynamic_jump_chance", "20.0");
	z_dynamic_jump_chance_throttle = CreateConVar("z_dynamic_jump_chance_throttle", "1.0");
	
	nb_gravity = FindConVar("nb_gravity");
}

public void OnActionCreated(BehaviorAction action, int actor, const char[] name)
{
	if (strcmp(name, "ChaseVictim") == 0)
	{
		action.Update = ChaseVictim_Update;
	}
}

public Action ChaseVictim_Update(ChaseVictim chase, int actor, float interval, ActionResult result)
{
	if (result.IsRequestingChange() || chase.IsClimbingOrJumping() || chase.IsSuspended)
		return Plugin_Continue;
	
	// it's how frequently we can jump
	float jumpInterval = z_dynamic_jump_check_interval.FloatValue;
	
	// it's how frequently we can calculate jump
	float thinkInterval = z_dynamic_jump_think_interval.FloatValue;
	
	// We recently tried to jump but rng said no
	float throttleInterval = z_dynamic_jump_chance_throttle.FloatValue;
	
	if (!chase.CanJumpAgain(jumpInterval) || !chase.CanThinkAgain(thinkInterval) || chase.IsJumpThrottled(throttleInterval))
		return Plugin_Continue;
	
	chase.m_flLastThink = GetGameTime();
	
	float actualOrigin[3];
	float climbUp_range = z_dynamic_jump_climb_up_range.FloatValue;
	
	if (chase.TryJump_ClimbUp(climbUp_range, actualOrigin))
	{
		chase.m_flLastJumpAttempt = GetGameTime();
		
		if (z_dynamic_jump_chance.FloatValue < GetRandomFloat(1.0, 100.0))
		{
			chase.m_flJumpThrottle = GetGameTime();
			return Plugin_Continue;
		}
		
		JumpAcross jump = JumpAcross(actualOrigin);
		return chase.SuspendFor(jump);
	}
	
	return Plugin_Continue;
}

stock bool IsJumpTravesable(int entity, const float velocity[3], float actualOrigin[3])
{
	float source[3], origin[3], vel[3], mins[3], maxs[3];
	CollisionBounds(entity, mins, maxs);
	GetEntPropVector(entity, Prop_Send, "m_vecOrigin", source);
	source[2] += 5.0;
	origin = source;
	vel = velocity;
	
	for (;;)
	{
		origin[0] = vel[0] * GetGameFrameTime() + origin[0];
		origin[1] = vel[1] * GetGameFrameTime() + origin[1];
		origin[2] = vel[2] * GetGameFrameTime() + origin[2];
		
		vel[2] -= nb_gravity.FloatValue * GetGameFrameTime();
		
		TR_TraceHullFilter(source, origin, mins, maxs, MASK_PLAYERSOLID & (~CONTENTS_MONSTER), TraceFilter, entity);
		
		if (z_dynamic_jump_debug.BoolValue)
			DebugLine(source, origin);
		
		source = origin;
		
		if (TR_DidHit())
		{ 
			TR_GetEndPosition(actualOrigin);
			
			float normal[3];
			TR_GetPlaneNormal(null, normal);
			
			if (normal[2] <= -0.5)
				return false;
				
			break;
		}
	}
	
	float collision[3];
	bool block = ResolveFlyCollision(entity, actualOrigin, source, collision);

	//if (block)
	{
		if (z_dynamic_jump_debug.BoolValue)
		{
			DebugLineUP(collision, {255, 255, 0, 255});
		}
		
		// 
	}
	
	return !block;
}

bool ResolveFlyCollision(int entity, const float actualOrigin[3], const float source[3], float out[3])
{
	float collisionCheck[3], normal[3];
	
	VectorMA(actualOrigin, source, 20.0, collisionCheck);
	TR_TraceRayFilter(actualOrigin, collisionCheck, MASK_PLAYERSOLID & (~CONTENTS_MONSTER), RayType_EndPoint, TraceFilter, entity);

	if (TR_DidHit())
	{
		TR_GetEndPosition(out);
		TR_GetPlaneNormal(null, normal);
		
		int collisionEntity = TR_GetEntityIndex();
		if (collisionEntity > 0 && collisionEntity <= MaxClients)
			return false;
		
		if (fabs(normal[2]) < 0.7) // players can't stand on ground steeper than 0.7
			return true;
	}
	
	return false;
}

void VectorMA(const float start[3], const float end[3], float scale, float out[3])
{
	float fwd[3];
	MakeVectorFromPoints(start, end, fwd);
	NormalizeVector(fwd, fwd);
	ScaleVector(fwd, scale);
	AddVectors(start, fwd, out);
}

void CollisionBounds(int entity, float mins[3], float maxs[3])
{
	any nextbot = CBaseEntity_MyNextBotPointer(entity);
	
	if (!nextbot)
		return;
	
	any body = INextBot_GetBodyInterface(nextbot);
	
	if (body)
	{
		IBody_GetHullMins(body, mins);
		IBody_GetHullMaxs(body, maxs);
	}
}

bool TraceFilter(int entity, int mask, int data)
{
	if (entity > 0 && entity < MaxClients && IsClientInGame(entity) && IsPlayerAlive(entity))
		return GetClientTeam(entity) == 2;
	
	if (ClassMatchesComplex(entity, "infected"))
		return false;
		
	return entity != data;
}

bool JumpAcrossGap(int entity, const float landingGoal[3], float velocity[3] = NULL_VECTOR)
{
	any nextbot = CBaseEntity_MyNextBotPointer(entity);
	any locomotion = INextBot_GetLocomotionInterface(nextbot);

	int groundEnt = GetEntPropEnt(entity, Prop_Data, "m_hGroundEntity");
	if ( groundEnt == -1 )
		return false;
	
	any body = INextBot_GetBodyInterface(nextbot);
	if ( !IBody_StartActivity(body, ACT_JUMP, 0) )
		return false;
	
	float feet[3], ahead[3];
	ILocomotion_GetFeet(locomotion, feet);

	if (!ApproximateVelocity(feet, landingGoal, ahead))
		return false;

	if (!IsNullVector(velocity))
		velocity = ahead;
	
	StoreToAddressOffsVector(locomotion, g_locomotion_velocity_offset, ahead);
	StoreToAddressOffsVector(locomotion, g_locomotion_acceleration_offset, {0.0, 0.0, 0.0});
	
	StoreToAddressOffs(locomotion, g_locomotion_isJumping_offset, 0x01, NumberType_Int8);
	StoreToAddressOffs(locomotion, g_locomotion_isJumpingAcrossGap_offset, 0x01, NumberType_Int8);
	StoreToAddressOffs(locomotion, g_locomotion_isClimbingUpToLedge_offset, 0x00, NumberType_Int8);
	
	INextBotEventResponder_OnLeaveGround(nextbot, groundEnt);
	return true;
}

bool ApproximateVelocity(const float source[3], const float landingGoal[3], float velocity[3])
{
	float s0[3], s1[3];
	float range = z_dynamic_jump_velocity.FloatValue;
	float gravity = nb_gravity.FloatValue;
	
	int solutions = solve_ballistic_arc(source, range, landingGoal, gravity, s0, s1);
		
	if (solutions == 0)
		return false;
	
	if (solutions == 2 && fabs(landingGoal[2] - source[2]) > 20.0)
	{
		velocity = s1;
	}
	else
	{
		velocity = s0;
	}
	
	return true;
}

// Credits: https://github.com/forrestthewoods/lib_fts/blob/350529579db315c3d0c579f70d871ef13400d418/code/fts_ballistic_trajectory.cs#L285
int solve_ballistic_arc(const float proj_pos[3], float proj_speed, const float target[3], float gravity, float s0[3], float s1[3])
{
	float diff[3], diffXZ[3], groundDir[3];
	float up[3] = { 0.0, 0.0, 1.0 };
	
	SubtractVectors(target, proj_pos, diff);
	diffXZ[0] = diff[0];
	diffXZ[1] = diff[1];
	
	float groundDist = GetVectorLength(diffXZ);
	
	float speed2 = proj_speed * proj_speed;
	float speed4 = proj_speed * proj_speed * proj_speed * proj_speed;
	float y = diff[2];
	float x = groundDist;
	float gx = gravity * x;
	
	float root = speed4 - gravity * (gravity * x * x + 2 * y * speed2);
	
	if (root < 0)
		return 0;
	
	root = SquareRoot(root);
	
	float lowAng = ArcTangent2(speed2 - root, gx);
	float highAng = ArcTangent2(speed2 + root, gx);
	int numSolutions = lowAng != highAng ? 2 : 1;
	
	NormalizeVector(diffXZ, groundDir);
	
	s0[0] = groundDir[0] * Cosine(lowAng) * proj_speed + up[0] * Sine(lowAng) * proj_speed;
	s0[1] = groundDir[1] * Cosine(lowAng) * proj_speed + up[1] * Sine(lowAng) * proj_speed;
	s0[2] = groundDir[2] * Cosine(lowAng) * proj_speed + up[2] * Sine(lowAng) * proj_speed;
	
	if (numSolutions > 1)
	{
		s1[0] = groundDir[0] * Cosine(highAng) * proj_speed + up[0] * Sine(highAng) * proj_speed;
		s1[1] = groundDir[1] * Cosine(highAng) * proj_speed + up[1] * Sine(highAng) * proj_speed;
		s1[2] = groundDir[2] * Cosine(highAng) * proj_speed + up[2] * Sine(highAng) * proj_speed;
	}
	
	return numSolutions;
}