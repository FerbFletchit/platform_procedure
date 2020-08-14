PP_Effects = {

	["defusal"] = {
		["Rate"] = 1, -- Seconds.
	},

	["pp_acidimpact"] = {
		["Rate"] = 0.1, -- Seconds.
	},

	["ritual"] = {
		["Rate"] = 0.1, -- Seconds.
	},

	["pp_teleport"] = {
		["Rate"] = 0.6, -- Seconds.
	},

	["pp_fire"] = {
		["Rate"] = 0.6, -- Seconds.
	},

	["pp_explode"] = {
		["Rate"] = 0.6, -- Seconds.
	},

	["pp_jump"] = {
		["Rate"] = 0.6, -- Seconds.
	},

	["pp_smoke"] = {
		["Rate"] = 0.6, -- Seconds.
	},

	["pp_impact"] = {
		["Rate"] = 0.6, -- Seconds.
	},

	["generic"] = {
		["Rate"] = 0.25, -- Seconds.
	},

	["chest"] = {
		["Rate"] = 0.5, -- Seconds.
	},

	["enemy_spawn"] = {
		["Rate"] = 0.2, -- Seconds.
	}
}

function PP_ActionEffect(pos, effect, repetitons)
	if IsEntity( pos ) then 
		pos = pos:GetPos()
	elseif not isvector( pos ) then
		return
	end
		
	repetitons = repetitons or 1

	for i=1, repetitons do
		local effectdata = EffectData()
		effectdata:SetOrigin( pos )
		util.Effect( effect, effectdata )
	end
end

function AddEffectBlock(ent, effect)
	if SERVER then
		if not IsValid(ent) then return end
		local emitter = ents.Create("pp_effect_emitter")
		local Bounds_Min, Bound_Max = ent:GetModelBounds()
		emitter:SetPos(ent:GetPos()+Vector(0,0,Bound_Max[3]))
		emitter:SetParent(ent)
		emitter:SetEffect( effect )

		if IsValid(emitter) then
			emitter:Spawn()
		end
	end
end

function PauseEffects(ent)
	if IsValid(ent) and not table.IsEmpty(ent:GetChildren()) then
		for key, value in pairs(ent:GetChildren()) do
			if value:GetClass() == "pp_effect_emitter" then
				value:SetEnabled(false)
			end
		end
	end
end

function ResumeEffects(ent)
	if IsValid(ent) and not table.IsEmpty(ent:GetChildren()) then
		for key, value in pairs(ent:GetChildren()) do
			if value:GetClass() == "pp_effect_emitter" then
				value:SetEnabled(true)
			end
		end
	end
end

hook.Add("InitPostEntity", "PP_Star_Generator", function()

	timer.Simple(10, function()
		if not PP then return end
		print("[ Platform Procedure ] Generating Stars")
		PP_ActionEffect(PP["Start_Point"], "pp_stars", 1)

	end )

end )