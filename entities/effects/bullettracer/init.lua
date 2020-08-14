
EFFECT.Mat = Material( "effects/spark" )

--[[---------------------------------------------------------
	Init( data table )
-----------------------------------------------------------]]
function EFFECT:Init( data )

	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	
	-- Keep the start and end pos - we're going to interpolate between them
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()
	
	self.Alpha = 255
	self.Life = 0

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )

	self.Dir = self.EndPos - self.StartPos

	self.TracerTime = math.min( 1, self.StartPos:Distance( self.EndPos ) / 10000 )//math.Rand( 0.2, 0.3 )
	self.Length = math.Rand( 0.1, 0.15 )

	-- Die when it reaches its target
	self.DieTime = CurTime() + self.TracerTime

end

--[[---------------------------------------------------------
	Think
-----------------------------------------------------------]]
function EFFECT:Think()

	if ( CurTime() > self.DieTime ) then

		-- Awesome End Sparks
		local effectdata = EffectData()
		effectdata:SetOrigin( self.EndPos + self.Dir:GetNormalized() * -2 )
		effectdata:SetNormal( self.Dir:GetNormalized() * -3 )
		effectdata:SetMagnitude( 1 )
		effectdata:SetScale( 100 )
		effectdata:SetRadius( 6 )
		util.Effect( "pp_impact", effectdata )

		return false 
	end

	return true

end

--[[---------------------------------------------------------
	Draw the effect
-----------------------------------------------------------]]
function EFFECT:Render()

	local fDelta = ( self.DieTime - CurTime() ) / self.TracerTime
	fDelta = math.Clamp( fDelta, 0, 1 ) ^ 0.5

	render.SetMaterial( self.Mat )

	local sinWave = math.sin( fDelta * math.pi )

	render.DrawBeam( self.EndPos - self.Dir * ( fDelta - sinWave * self.Length ),
		self.EndPos - self.Dir * ( fDelta + sinWave * self.Length ),
		2 + sinWave * 8, 1, 0, Color( 249, 225, 165, 255 ) )

end
