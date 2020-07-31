-- The following recipe system was made under duress, as time on the competition is running out.

if SERVER then
	util.AddNetworkString("PP_RecipeOpen")
end

local Player = FindMetaTable("Player")

function Player:GetRecipes()
	self["PP_Recipes"] = self["PP_Recipes"] or {}
	return self["PP_Recipes"]
end

function Player:HasRecipe( Recipe_Key )
	self["PP_Recipes"] = self["PP_Recipes"] or {}

	if self["PP_Recipes"][Recipe_Key] then
		return true
	end

	return false
end

function Player:HasAllRecipes()
	self["PP_Recipes"] = self["PP_Recipes"] or {}

	if #self["PP_Recipes"] >= #PP_WB_Recipes then
		self:SendNotification("Dialouge", "I have every recipe there is!")
		return true
	end
	return false
end

function Player:GiveRecipe(Recipe_key, Recipe_table)
	self["PP_Recipes"] = self["PP_Recipes"] or {}

	table.insert(self["PP_Recipes"], Recipe_key, Recipe_table)
end

function Player:GiveRandomRecipe()
	self["PP_Recipes"] = self["PP_Recipes"] or {}
	if self:HasAllRecipes() then return end

	local Recipe_To_Give = math.random(1,#PP_WB_Recipes)

	if table.HasValue(self["PP_Recipes"], PP_WB_Recipes[Recipe_To_Give]) then
		self:GiveRandomRecipe()
	else
		table.insert(self["PP_Recipes"], PP_WB_Recipes[Recipe_To_Give])
	end
end

function Player:OpenRecipeBook()
	self["PP_Recipes"] = self["PP_Recipes"] or {}

	if table.IsEmpty(self["PP_Recipes"]) then

		self:SendNotification("Dialouge", "I don't have any recipes!")
		return
	end

	if SERVER then
		local Recipes = util.TableToJSON( self["PP_Recipes"] )
		net.Start("PP_RecipeOpen")
			net.WriteString(Recipes)
		net.Send(self)
	end
end

function Player:ClearRecipes()
	self["PP_Recipes"] = {}
end
