local auto_adjustjump= true

minetest.register_chatcommand("setgrav", {
	params = "",
	description = "Set players gravity: /setgrav <name> <number>",
	privs={ban=true},
	func = function(name, param)
		local a=param
		local splted=0
		local num=0
		if param:find(" ",1)~=nil then
			a=param.split(param," ")
			splted=1
		end
		if param:find(",",1)~=nil then
			a=param.split(param,",")
			splted=1
		end

		if splted==0 then
			minetest.chat_send_player(name, "No player or gravity: /setgrav <name> <number>")
			return false
		end
		local player=minetest.get_player_by_name(a[1])
		if player==nil or player:is_player()==false then
			minetest.chat_send_player(name, a[1] .." is not a player: /setgrav <name> <number>")
			return false
		end
		num=tonumber(a[2])
		if a[2]==nil then
			minetest.chat_send_player(name, "No gravity: /setgrav <name> <number>")
			return false
		end
		if num==nil then
			minetest.chat_send_player(name, a[2] .. " is not gravity: /setgrav <name> <number>")
			return false
		end
		player:set_physics_override({gravity=a[2]})

		if auto_adjustjump==true then

			-- The automatically jump adjust
			local aa= 1 - ((1-a[2])*0.5)
			player:set_physics_override({jump=aa})
		end
		return true
	end
})