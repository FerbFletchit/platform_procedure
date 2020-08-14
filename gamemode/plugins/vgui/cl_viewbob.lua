--Created ByPoLaT
HeadBobAng = 0;
HeadBobX = 0;
HeadBobY = 0;
function PP_headBob( ply, origin, angles, fov )
	if( IsValid( LocalPlayer() ) and not ply["Camera_Viewing"] ) then
		if (ply:Alive()) and (!ply:InVehicle()) then
			if( HeadBobAng > 360 ) then HeadBobAng = 0; end
				if( ( ply:KeyDown( IN_FORWARD ) or
					ply:KeyDown( IN_BACK ) or
					ply:KeyDown( IN_MOVERIGHT ) or
					ply:KeyDown( IN_MOVELEFT ) ) and ply:IsOnGround() ) then
					local view = { }
					view.origin = origin;
					view.angles = angles;
					
					if( ply:GetVelocity():Length() > 150 ) then

						HeadBobAng = HeadBobAng + 10 * FrameTime();
						view.angles.pitch = view.angles.pitch + math.sin( HeadBobAng ) * .5;
						view.angles.yaw = view.angles.yaw + math.cos( HeadBobAng ) * .2;

					else
						
						HeadBobAng = HeadBobAng + 6 * FrameTime();
						view.angles.pitch = view.angles.pitch + math.sin( HeadBobAng ) * .5;
						view.angles.yaw = view.angles.yaw + math.cos( HeadBobAng ) * .3;
					
					end
					return view;
				end
				if( ply:KeyDown( IN_JUMP )) then
					
					local view = { }
					view.origin = origin;
					view.angles = angles;
					
					if (!ply:IsOnGround()) then
						if( ply:GetVelocity():Length() > 150 ) then
							
							HeadBobAng = HeadBobAng + 13 * FrameTime();
							view.angles.pitch = view.angles.pitch + math.sin( HeadBobAng ) * .8;
						
						else
							
							HeadBobAng = HeadBobAng + 9 * FrameTime();
							view.angles.pitch = view.angles.pitch + math.sin( HeadBobAng ) * .8;
						end
						
						return view;
					end
				end

				local view = { }
				view.origin = origin;
				view.angles = angles;
				view.angles.pitch = view.angles.pitch + math.sin( HeadBobAng );
				return view;

			end
		end
	end
hook.Add( "CalcView", "PP_headBob", PP_headBob );