-- Play single sound function.

-- Soundtrack manager

function PP_BroadcastSound(sound_file, volume)

	volume = volume or 1

	net.Start("PP_PlaySound")
		net.WriteString(sound_file)
		net.WriteFloat(volume)
	net.Broadcast()
end

local Player = FindMetaTable("Player")
function Player:PP_PlaySound(sound_file, volume)

	volume = volume or 1

	net.Start("PP_PlaySound")
		net.WriteString(sound_file)
		net.WriteFloat(volume)
	net.Send(self)
end


PP_Music = PP_Music or nil
function Player:PP_SoundtrackStart(song_file, stop_autoplay )
	net.Start("PP_PlaySoundtrack")
		net.WriteString(song_file or "")
		net.WriteBool(tobool(stop_autoplay))
	net.Send(self)
end

function PP_SoundtrackStop()
	if not CLIENT then return end
	if IsValid(PP_Music) then
		PP_Music:Stop()
	end
end

function PP_SoundtrackForce( song_file )
	if not CLIENT then return end
	if IsValid(PP_Music) then
		PP_Music:Stop()
		PP_SoundtrackStart(song_file)
	end
end

function PP_SoundtrackSkip()
	if not CLIENT then return end
	if IsValid(PP_Music) then
		PP_Music:Stop()
		PP_SoundtrackStart()
	end
end

function PP_SoundtrackPause()
	if not CLIENT then return end
	if IsValid(PP_Music) then
		PP_Music:Pause()
	end
end

function PP_SoundtrackPlay()
	if not CLIENT then return end
	if IsValid(PP_Music) then
		PP_Music:Play()
	end
end

if SERVER then
	util.AddNetworkString("PP_PlaySound")
	util.AddNetworkString("PP_PlaySoundtrack")
end

if CLIENT then
	net.Receive("PP_PlaySound", function(len, ply) 

		local sound_file = net.ReadString()
		local volume = net.ReadFloat()

		sound.PlayFile( sound_file, "noplay", function( play_station, errCode, errStr )
			if ( IsValid( play_station ) ) then
				play_station:Play()
				play_station:SetVolume(volume)
			end
		end )

	end )

	function PP_PlaySoundtrack(sound_file, stop_autoplay)
		if PP_Music then
			PP_SoundtrackStop()
		end

		sound.PlayFile( sound_file or table.Random(PP["Soundtrack"]), "noplay", function( station, errCode, errStr )
			if ( IsValid( station ) ) then

				station:SetVolume(0.05)

				PP_Music = station
				PP_Music:Play()

				if not stop_autoplay then
					timer.Create("PP_Sound_Manager", station:GetLength() + 1, 1, function()
						PP_SoundtrackStop()
						PP_PlaySoundtrack()
					end )
				end

			end
		end )
	end

	net.Receive("PP_PlaySoundtrack", function(len, ply) 
		local song_file = net.ReadString()
		
		if song_file == "" then
			song_file = nil
		end

		local stop_autoplay = net.ReadBool()

		PP_PlaySoundtrack(song_file, stop_autoplay)
	end )
end