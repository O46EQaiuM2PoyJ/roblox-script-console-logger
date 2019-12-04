-- O46EQaiuM2PoyJ Dec 4 2019
-- Put this in game.ReplicatedFirst

local remote = game:GetService('ReplicatedStorage'):WaitForChild('Spectate2');

local function base64encode(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+._';
    return ((data:gsub('.', function(x) 
        local r,b = '', x:byte();
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0'); end;
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return ''; end;
        local c = 0;
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0); end;
        return b:sub(c+1,c+1);
    end)..({ '', '--', '-' })[#data%3+1]);
end;

game:GetService('ScriptContext').Error:Connect(function(message,stacktrace)
	remote:FireServer(base64encode(message..' @ '..stacktrace));
end);
