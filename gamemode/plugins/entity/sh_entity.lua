function PP_LoadEntityModel( Core_Entity ) -- Loops through all children props in a table and assigns their positions, attributes, and functions.
	if not IsValid(Core_Entity) then 
		print("[Platform Procedure] Tried to build model for an entity that did not exist!")
		return 
	end

	if not Core_Entity["Build_Components"] then 
		print("[Platform Procedure] Tried to build model for ".. Core_Entity:GetClass().. ", but build components weren't found!")
		return
	end

	local Entity_Base = Core_Entity["Build_Components"][1]
	Core_Entity:SetID(Entity_Base[1])
	Core_Entity:SetModel( PP_SizeToModelString( Entity_Base[2] ) )
	Core_Entity:SetPos(Entity_Base[3](Core_Entity))
	Core_Entity:SetAngles(Entity_Base[4])
	Core_Entity:SetRenderMode(1) -- Supports Transparency.
	Core_Entity:SetColor(Entity_Base[5])
	Core_Entity:SetMaterial(Entity_Base[6] or PP["Default_Material"])

	local PhysicsObject = Core_Entity:GetPhysicsObject()
	
	if IsValid(PhysicsObject) then
		PhysicsObject:EnableGravity( false )
		PhysicsObject:SetMaterial(Entity_Base[7])
	end

	Core_Entity["Component_Table"] = Entity_Base

	for key, value in ipairs(Core_Entity["Build_Components"]) do
		if key > 1 then 

			local Entity_Build_Component = ents.Create("pp_ent_component")

			Entity_Build_Component["Component_Table"] = value
			Entity_Build_Component:SetParent(Core_Entity)
			Entity_Build_Component:Spawn()

		end
	end
end

function PP_GetComponentByID(Core_Entity, ID)
	if not Core_Entity:GetChildren() then
		print("Provided Entity has no build components.")
		return nil
	end

	for key, value in pairs(Core_Entity:GetChildren()) do
		if value:GetClass() == "pp_ent_component" then
			if value:GetID() then
				if value:GetID() == ID then
					return value
				end
			end
		end
	end

	print("Build Component ID search for "..ID.." yielded no results!")
	return nil
end

function PP_GetComponentByKey(Core_Entity, key)
	
	local Children = Core_Entity:GetChildren()
	
	if not Children then
		print("Provided Entity has no build components.")
		return nil
	end

	if Children[key] then
		return Children[key]
	end

	print("Build Component key search for "..key.." yielded no results!")
	return nil
end