stock bool ClassMatchesComplex(int entity, const char[] match)
{
	static char name[36];
	
	if (!GetEntityClassname(entity, name, sizeof name))
		return false;
		
	return strcmp(name, match) == 0;
}

stock float fabs(float value)
{
	return value < 0.0 ? -value : value;
}

stock void StoreToAddressOffsVector(any ptr, any offset, float data[3])
{
	StoreToAddressOffs(ptr, offset, data[0], NumberType_Int32);
	StoreToAddressOffs(ptr, offset + 4, data[1], NumberType_Int32);
	StoreToAddressOffs(ptr, offset + 8, data[2], NumberType_Int32);
}

stock void StoreToAddressOffs(any ptr, any offset, any data, NumberType type = NumberType_Int32)
{
	StoreToAddress(ptr + offset, data, type);
}

stock any Dereference(any ptr, any offset, NumberType type = NumberType_Int32)
{
	return LoadFromAddress(ptr + offset, type);
}

stock void DereferenceVector(any data, any offset, float vec[3])
{
	vec[0] = view_as<float>(Dereference(data, offset, NumberType_Int32));
	vec[1] = view_as<float>(Dereference(data, offset + 4, NumberType_Int32));
	vec[2] = view_as<float>(Dereference(data, offset + 8, NumberType_Int32));
}

stock any EntityFromHandle(any data, any offset)
{
	any handle = LoadFromAddress(data + offset, NumberType_Int32);
	
	if (handle == -1)
		return -1;
	
	return handle & 0xFFF;
}

stock int GetEntityHandle(int entity)
{
	return EntIndexToEntRef(entity) & ~(1 << 31);
}

stock void DebugLineUP(const float start[3], const int color[4] = { 255, 255, 255, 255 })
{
	float end[3]
	end = start;
	end[2] += 500.0;
	DebugLine(start, end, color);
}

stock void DebugLine(const float start[3], const float end[3], const int color[4] = { 255, 255, 255, 255 })
{
	TE_SendBeam(start, end, 5.0, 0.0, 1.5, color );
}

stock void TE_SendBeam(const float start[3], const float end[3], float aliveTime, float amplitude, float width, const int color[4])
{
	static int g_iLaserMaterial;
	
	// if (!g_iLaserMaterial)
	{
		g_iLaserMaterial = PrecacheModel("materials/sprites/laserbeam.vmt");
	}
	
	TE_SetupBeamPoints(start, end, g_iLaserMaterial, 0, 0, 0, aliveTime, width, width, 1, amplitude, color, 0);
	TE_SendToAll();
}