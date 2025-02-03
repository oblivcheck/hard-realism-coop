methodmap JumpAcross < BehaviorAction
{
	public JumpAcross(const float landingGoal[3])
	{
		JumpAcross jump = view_as<JumpAcross>(ActionsManager.Create("JumpAcross"));
		
		jump.SetLandingGoal(landingGoal);
		jump.OnStart = JumpAcross_OnStart;
		jump.Update = JumpAcross_Update;
		jump.OnLandOnGround = JumpAcross_OnLandOnGround;
		
		return jump;
	}
	
	property float m_flJumpTime
	{
		public get() 
		{
			return this.GetUserData("m_flJumpTime");
		}
		
		public set(float value)
		{
			this.SetUserData("m_flJumpTime", value);
		}
	}
	
	public void SetLandingGoal(const float goal[3])
	{
		this.SetUserData("m_fLandingGoalX", goal[0]);
		this.SetUserData("m_fLandingGoalY", goal[1]);
		this.SetUserData("m_fLandingGoalZ", goal[2]);
	}
	
	public void GetLandingGoal(float goal[3])
	{
		goal[0] = this.GetUserData("m_fLandingGoalX");
		goal[1] = this.GetUserData("m_fLandingGoalY");
		goal[2] = this.GetUserData("m_fLandingGoalZ");
	}
	
	public bool JumpAcrossGap(const float landingGoal[3] = NULL_VECTOR, float velocity[3] = NULL_VECTOR)
	{
		float goal[3];
		any nextbot = CBaseEntity_MyNextBotPointer(this.Actor);
		
		if (!nextbot)
			return false;
		
		any locomotion = INextBot_GetLocomotionInterface(nextbot);
		
		if (!locomotion)
			return false;
		
		goal = landingGoal;
		if (IsNullVector(landingGoal))
			this.GetLandingGoal(goal);
		
		return JumpAcrossGap(this.Actor, goal);
	}
}

public Action JumpAcross_OnStart(JumpAcross jump, int actor, BehaviorAction priorAction, ActionResult result)
{
	if (!jump.JumpAcrossGap())
		return jump.Done("Failed to jump across");

	ChaseVictim chase = ChaseVictim(jump.Under);
	if (chase != INVALID_ACTION && chase.m_path && chase.m_path.IsValid())
		chase.m_path.Invalidate();
	
	
	jump.m_flJumpTime = GetGameTime();
	return jump.Continue();
}

public Action JumpAcross_Update(JumpAcross jump, int actor, float interval, ActionResult result)
{
	// if we recently jumped wait a bit
	if (GetGameTime() - jump.m_flJumpTime > 0.5)
		return jump.Done("Succesfully jumped");
		
	return jump.Continue();
}

public Action JumpAcross_OnLandOnGround(JumpAcross jump, int actor, int ground, ActionDesiredResult result)
{
	return jump.TryDone(RESULT_TRY, "Succesfully landed");
}