methodmap InfectedAttack < BehaviorAction
{
	property int m_hTarget
	{
		public get()
		{
			return EntityFromHandle(this, 0x34);
		}
		
		public set(int target)
		{
			this.Set(0x34, GetEntityHandle(target), NumberType_Int32);
		}
	}
}