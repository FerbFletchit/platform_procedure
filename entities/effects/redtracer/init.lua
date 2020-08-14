
EFFECT.Mat = Material( "pp_assets/particle_chest1.png" )

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
	
	self.Dir = self.EndPos - self.StartPos
	
	self.Alpha = 255
	self.Life = 0

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )
	
	self.TracerTime = math.min( 1, self.StartPos:Distance( self.EndPos ) / 10000 )//math.Rand( 0.2, 0.3 )
	self.Length = math.Rand( 0.1, 0.15 )

	-- Die when it reaches its target
	self.DieTime = CurTime() + self.TracerTime

end

--[[---------------------------------------------------------
   THINK
-----------------------------------------------------------]]
function EFFECT:Think( )

		if ( CurTime() > self.DieTime ) then

		-- Awesome End Sparks
		local effectdata = EffectData()
		effectdata:SetOrigin( self.EndPos + self.Dir:GetNormalized() * -2 )
		effectdata:SetNormal( self.Dir:GetNormalized() * -3 )
		effectdata:SetMagnitude( 1 )
		effectdata:SetScale( 1 )
		effectdata:SetRadius( 6 )
		util.Effect( "pp_impact", effectdata )

		return false 
	end
	
		self.Life = self.Life + FrameTime() * 4
	self.Alpha = 255 * ( 1 - self.Life )
	
	return ( self.Life < 1 )

end

--[[---------------------------------------------------------
   Draw the effect
-----------------------------------------------------------]]
function EFFECT:Render()

	if ( self.Alpha < 1 ) then return end
	
	local fDelta = ( self.DieTime - CurTime() ) / self.TracerTime
	fDelta = math.Clamp( fDelta, 0, 1 ) ^ 0.5
	

	local sinWave = math.sin( fDelta * math.pi )
	
	render.SetMaterial( self.Mat )
	local texcoord = math.Rand( 0, 1 )
	
	
	local norm = (self.StartPos - self.EndPos) * self.Life

	self.Length = norm:Length()

	--local box_Size = Vector(1,1,1)
	--render.DrawBox( self.StartPos - norm, Angle( 0,0,0 ), -box_Size, box_Size, Color( 255, 255, 255 ) )
	
	for i = 1, 3 do
		
		
		render.DrawBeam( self.StartPos - norm,		-- Start
					self.EndPos,					-- End
					8,								-- Width
					texcoord,						-- Start tex coord
					texcoord + self.Length / 128,	-- End tex coord
					Color( 255, 50, 0 ) )		-- Color (optional)
	end

	render.DrawBeam( self.StartPos,
					self.EndPos,
					8,
					texcoord,
					texcoord + ((self.StartPos - self.EndPos):Length() / 128),
					Color( 255, 50, 0, 128 * ( 1 - self.Life ) ) )

end
