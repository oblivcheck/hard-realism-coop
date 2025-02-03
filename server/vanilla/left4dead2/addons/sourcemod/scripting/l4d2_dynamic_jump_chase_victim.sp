methodmap ChaseVictim < BehaviorAction
{
	public ChaseVictim(BehaviorAction action)
	{
		return view_as<ChaseVictim>(action);
	}
	
	property Path m_path
	{
		public get()
		{
			return Path(view_as<Address>(this) + view_as<Address>(0x38));
		}
	}
	
	property InfectedAttack m_attack
	{
		public get()
		{
			return view_as<InfectedAttack>(this.Get(0x34));
		}
	}
	
	property float m_flLastThink
	{
		public get()
		{
			return this.GetUserData("m_flLastThink");
		}
		
		public set(float value)
		{
			this.SetUserData("m_flLastThink", value);
		}
	}
	
	property float m_flJumpThrottle
	{
		public get()
		{
			return this.GetUserData("m_flJumpThrottle");
		}
		
		public set(float value)
		{
			this.SetUserData("m_flJumpThrottle", value);
		}
	}
	
	property float m_flLastJumpAttempt
	{
		public get()
		{
			return this.GetUserData("m_flLastJumpAttempt");
		}
		
		public set(float value)
		{
			this.SetUserData("m_flLastJumpAttempt", value);
		}
	}
	
	public bool CanThinkAgain(float interval)
	{
		return GetGameTime() - this.m_flLastThink >= interval;
	}
	
	public bool CanJumpAgain(float interval)
	{
		return GetGameTime() - this.m_flLastJumpAttempt >= interval;
	}
	
	public bool IsJumpThrottled(float interval)
	{
		return !(GetGameTime() - this.m_flJumpThrottle >= interval);
	}
	
	public bool IsClimbingOrJumping()
	{
		Address nextbot = CBaseEntity_MyNextBotPointer(this.Actor);
		
		if (!nextbot)
			return false;
			
		Address locomotion = INextBot_GetLocomotionInterface(nextbot);
		
		if (!locomotion)
			return false;
		
		return ILocomotion_IsClimbingOrJumping(locomotion);
	}
	
	public bool HasDiscontinuity(SegmentType type, float range = 0.0)
	{
		return this.m_path.IsDiscontinuityAhead(this.Actor, type, range);
	}
	
	public Segment GetDiscontinuitySegment(SegmentType type)
	{
		return this.m_path.GetDiscontinuitySegment(type);
	}
	
	public Segment CheckDiscontinuity(SegmentType type, float range)
	{
		if (!this.HasDiscontinuity(type, range))
			return Segment(Address_Null);
			
		return this.GetDiscontinuitySegment(type);
	}
	
	public bool TryJump_ClimbUp(float range, float actualOrigin[3])
	{
		Segment segment = this.CheckDiscontinuity(CLIMB_UP, range);

		if (!segment)
			return false;
		
		float source[3], landingGoal[3], velocity[3];
		int actor = this.Actor;
		
		GetEntPropVector(actor, Prop_Send, "m_vecOrigin", source);
		segment.GetPos(landingGoal);
	
		return ApproximateVelocity(source, landingGoal, velocity) && IsJumpTravesable(actor, velocity, actualOrigin);
	}
}

