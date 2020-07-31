net.Receive("PP_UpdateState", function(len, ply)
	PP["CurrentState"] = net.ReadInt(4)
	PP["StartStateTime"] = CurTime()
end ) 