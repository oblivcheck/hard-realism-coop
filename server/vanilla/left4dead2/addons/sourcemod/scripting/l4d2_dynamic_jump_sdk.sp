Handle g_hCBaseEntity_MyNextBotPointer, g_hINextBot_GetLocomotionInterface, 
	g_hINextBot_GetBodyInterface, g_hILocomotion_GetFeet, 
	g_hIBody_GetHullMins, g_hIBody_GetHullMaxs, 
	g_hPathFollower_IsDiscontinuityAhead, g_hPath_GetCurrentGoal, 
	g_hPath_NextSegment, g_hPath_IsValid,
	g_hPathFollower_Invalidate, g_hILocomotion_IsClimbingOrJumping, g_hINextBotEventResponder_OnLeaveGround,
	g_hIBody_StartActivity;

int g_locomotion_velocity_offset, g_locomotion_acceleration_offset,
	g_locomotion_isJumping_offset, g_locomotion_isJumpingAcrossGap_offset,
	g_locomotion_isClimbingUpToLedge_offset;
	
int ACT_JUMP;

void SetupSDKCalls()
{
	GameData data = new GameData("l4d2_dynamic_jump");
	
	g_locomotion_velocity_offset = data.GetOffset("ILocomotion::m_velocity");
	g_locomotion_acceleration_offset = data.GetOffset("ILocomotion::m_acceleration");
	g_locomotion_isJumping_offset = data.GetOffset("ILocomotion::m_isJumping");
	g_locomotion_isJumpingAcrossGap_offset = data.GetOffset("ILocomotion::m_isJumpingAcrossGap");
	g_locomotion_isClimbingUpToLedge_offset = data.GetOffset("ILocomotion::m_isClimbingUpToLedge");
	
	ACT_JUMP = data.GetOffset("ACT_JUMP");
	
	StartPrepSDKCall(SDKCall_Entity);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "CBaseEntity::MyNextBotPointer");
	PrepSDKCall_SetReturnInfo(SDKType_PlainOldData, SDKPass_Plain);
	g_hCBaseEntity_MyNextBotPointer = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "INextBot::GetLocomotionInterface");
	PrepSDKCall_SetReturnInfo(SDKType_PlainOldData, SDKPass_Plain);
	g_hINextBot_GetLocomotionInterface = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "INextBot::GetBodyInterface");
	PrepSDKCall_SetReturnInfo(SDKType_PlainOldData, SDKPass_Plain);
	g_hINextBot_GetBodyInterface = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "ILocomotion::IsClimbingOrJumping");
	PrepSDKCall_SetReturnInfo(SDKType_Bool, SDKPass_Plain);
	g_hILocomotion_IsClimbingOrJumping = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "IBody::GetHullMins");
	PrepSDKCall_SetReturnInfo(SDKType_Vector, SDKPass_ByRef);
	g_hIBody_GetHullMins = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "IBody::GetHullMaxs");
	PrepSDKCall_SetReturnInfo(SDKType_Vector, SDKPass_ByRef);
	g_hIBody_GetHullMaxs = EndPrepSDKCall();

	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "IBody::StartActivity");
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);
	PrepSDKCall_SetReturnInfo(SDKType_Bool, SDKPass_Plain);
	g_hIBody_StartActivity = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "ILocomotion::GetFeet");
	PrepSDKCall_SetReturnInfo(SDKType_Vector, SDKPass_ByRef);
	g_hILocomotion_GetFeet = EndPrepSDKCall();	
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "INextBotEventResponder::OnLeaveGround");
	PrepSDKCall_AddParameter(SDKType_CBaseEntity, SDKPass_Pointer, VDECODE_FLAG_ALLOWNULL | VDECODE_FLAG_ALLOWWORLD);
	g_hINextBotEventResponder_OnLeaveGround = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "PathFollower::IsDiscontinuityAhead");
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);
	PrepSDKCall_AddParameter(SDKType_Float, SDKPass_Plain);
	PrepSDKCall_SetReturnInfo(SDKType_Bool, SDKPass_Plain);
	g_hPathFollower_IsDiscontinuityAhead = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "Path::GetCurrentGoal");
	PrepSDKCall_SetReturnInfo(SDKType_PlainOldData, SDKPass_Plain);
	g_hPath_GetCurrentGoal = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "Path::NextSegment");
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);
	PrepSDKCall_SetReturnInfo(SDKType_PlainOldData, SDKPass_Plain);
	g_hPath_NextSegment = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "Path::IsValid");
	PrepSDKCall_SetReturnInfo(SDKType_Bool, SDKPass_Plain);
	g_hPath_IsValid = EndPrepSDKCall();
	
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(data, SDKConf_Virtual, "PathFollower::Invalidate");
	g_hPathFollower_Invalidate = EndPrepSDKCall();
	
	delete data;
}

any CBaseEntity_MyNextBotPointer(int entity)
{
	return SDKCall(g_hCBaseEntity_MyNextBotPointer, entity);
}

any INextBot_GetBodyInterface(any nextbot)
{
	return SDKCall(g_hINextBot_GetBodyInterface, nextbot);
}

any INextBot_GetLocomotionInterface(any nextbot)
{
	return SDKCall(g_hINextBot_GetLocomotionInterface, nextbot);
}

void IBody_GetHullMins(any body, float mins[3])
{
	SDKCall(g_hIBody_GetHullMins, body, mins);
}

void IBody_GetHullMaxs(any body, float maxs[3])
{
	SDKCall(g_hIBody_GetHullMaxs, body, maxs);
}

stock bool IBody_StartActivity(any body, int activity, any flags = 1)
{
	return SDKCall(g_hIBody_StartActivity, body, activity, flags);
}

bool ILocomotion_IsClimbingOrJumping(any locomotion)
{
	return SDKCall(g_hILocomotion_IsClimbingOrJumping, locomotion);
}

void ILocomotion_GetFeet(any locomotion, float feet[3])
{
	SDKCall(g_hILocomotion_GetFeet, locomotion, feet);
}

void INextBotEventResponder_OnLeaveGround(any nextbot, int entity)
{
	SDKCall(g_hINextBotEventResponder_OnLeaveGround, nextbot, entity);
}

any Path_GetCurrentGoal(any path)
{
	return SDKCall(g_hPath_GetCurrentGoal, path);
}

any Path_NextSegment(any path, any current)
{
	return SDKCall(g_hPath_NextSegment, path, current);
}

bool Path_IsValid(any path)
{
	return SDKCall(g_hPath_IsValid, path);
}

bool PathFollower_Invalidate(any path)
{
	return SDKCall(g_hPathFollower_Invalidate, path);
}

bool Path_IsDiscontinuityAhead(any path, any nextbot, any type, float range)
{
	return SDKCall(g_hPathFollower_IsDiscontinuityAhead, path, nextbot, type, range);
}
