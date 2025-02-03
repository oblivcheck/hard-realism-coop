enum { MAX_PATH_SEGMENTS = 256 };
static stock const int g_iSegmentSize = 0x44;

methodmap Segment
{
	public Segment(any segment)
	{
		return view_as<Segment>(segment);
	}
	
	public void GetPos(float out[3])
	{
		DereferenceVector(this, 8, out);
	}
	
	property int how
	{
		public get() { return Dereference(this, 4); }
	}
	
	property SegmentType type
	{
		public get() { return Dereference(this, 24); }
	}
	
	public void GetForward(float out[3])
	{
		DereferenceVector(this, 28, out);
	}
	
	property float length
	{
		public get() { return Dereference(this, 40); }
	}
	
	property float distanceFromStart
	{
		public get() { return Dereference(this, 44); }
	}
	
	property float curvature
	{
		public get() { return Dereference(this, 48); }
	}
	
	public void GetPortalCenter(float out[3])
	{
		DereferenceVector(this, 52, out);
	}
	
	property float portalHalfWidth
	{
		public get() { return Dereference(this, 64); }
	}
}

methodmap Path
{
	public Path(any path)
	{
		return view_as<Path>(path);
	}
	
	public Segment GetCurrentGoal()
	{
		return Segment(Path_GetCurrentGoal(this));
	}
	
	public Segment NextSegment(Segment current)
	{
		return Segment(Path_NextSegment(this, current));
	}
	
	public bool IsValid()
	{
		return Path_IsValid(this);
	}
	
	public void Invalidate()
	{
		PathFollower_Invalidate(this);
	}
	
	public bool IsDiscontinuityAhead(int entity, SegmentType type, float range)
	{
		return Path_IsDiscontinuityAhead(this, CBaseEntity_MyNextBotPointer(entity), type, range);
	}
	
	public Segment GetDiscontinuitySegment(SegmentType type)
	{
		Segment m_goal = this.GetCurrentGoal();
		
		if (m_goal)
		{
			for (Segment s = m_goal; s; s = this.NextSegment(s))
			{
				if (s.type == type)
				{
					return this.NextSegment(s);
				}
			}
		}
		
		return Segment(Address_Null);
	}
}