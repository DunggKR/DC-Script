gg.setVisible(false)
gg.clearResults()
local SAVE_FILE = gg.EXT_STORAGE .. "/saved_id.txt"
-- Function to read saved ID from file
function readSavedID()
    local f = io.open(SAVE_FILE, "r")
    if not f then return nil end
    local line = f:read("*l"); f:close()
    return tonumber(line)
end


-- Function to save ID to file
local function saveID(id)
    local f = io.open(SAVE_FILE, "w")
    if f then f:write(tostring(id)):close() end
end

-- Function to request user ID
function requestUserID()
    while true do
        local input = gg.prompt(
            {"Enter User ID:", "Exit program if cancel?"},
            {nil, false}, -- Default values (ID = nil, checkbox = false)
            {"number", "checkbox"} -- Input types
        )

        if input then
            if input[1] then
                saveID(input[1]) -- Save ID
                return input[1] -- Return valid ID
            end
        else
            -- Nếu người dùng đóng bảng mà không nhập, ẩn GG và đợi mở lại
        
            while not gg.isVisible() do
                gg.sleep(100) -- Wait for user to reopen GG
            end
            -- Khi GG được mở lại, hiển thị bảng nhập tiếp tục
        end
    end
end




-- Check for existing ID
local userID = readSavedID()

if not userID then
    userID = requestUserID()
else
    local choice = gg.choice({
        "Use registered ID",
        "Enter a new ID"
    }, nil, "Select an option:")

    if choice == 2 then
        userID = requestUserID()
    end
end

-- Function to fetch team data
function getTeamData(id)
    local url = "https://dragoncitytips.com/scripts/checkteam?id=" .. id
    local http = gg.makeRequest(url)
    if not http or not http.content then
        gg.alert("Failed to retrieve data from API.")
        return nil
    end

    -- Fix "<br>" being inserted
    local content = http.content:gsub("<br>", "\n")

    local lines = {}
    for line in content:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    if #lines < 5 then
        return nil
    end

    return {
        dragonCode = lines[1],
        firstDragonLevel = tonumber(lines[2]) or 1,
        firstDragonGrade = tonumber(lines[3]) or 1,
        secondDragonLevel = tonumber(lines[4]) or 1,
        secondDragonGrade = tonumber(lines[5]) or 1
    }
end

-- Luôn request API với ID được chọn
local teamData = getTeamData(userID)
if not teamData then return end

local selectedCode = teamData.dragonCode
local datos = {teamData.firstDragonLevel, teamData.firstDragonGrade}
local data = {teamData.secondDragonLevel, teamData.secondDragonGrade}

gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
gg.searchNumber(selectedCode .. ";" .. datos[1] .. ";" .. datos[2] .. ";" .. data[1] .. ";" .. data[2] .. "::500", gg.TYPE_DWORD)
gg.refineNumber(selectedCode .. ";" .. datos[1] .. ";" .. datos[2] .. ";" .. data[1] .. "::250", gg.TYPE_DWORD)
gg.refineNumber(selectedCode .. ";" .. datos[1] .. ";" .. datos[2] .. "::125", gg.TYPE_DWORD)
gg.refineNumber(selectedCode .. ";" .. datos[1] .. "::60", gg.TYPE_DWORD)
gg.refineNumber(selectedCode, gg.TYPE_DWORD)

local t = gg.getResults(100)
local valuesToFreeze = {}


  for i, v in ipairs(t) do
    gg.setValues({
      {address = v.address + 0x0, flags = gg.TYPE_DWORD, value = 1011},
      {address = v.address + 0x4, flags = gg.TYPE_DWORD, value = 1},
	  {address = v.address + 0x8, flags = gg.TYPE_DWORD, value = 0},
      {address = v.address + 0x24, flags = gg.TYPE_DWORD, value = 0},
      {address = v.address + 0x60, flags = gg.TYPE_DWORD, value = 1011},
      {address = v.address + 0x64, flags = gg.TYPE_DWORD, value = 1},
	  {address = v.address + 0x68, flags = gg.TYPE_DWORD, value = 0},
      {address = v.address + 0x84, flags = gg.TYPE_DWORD, value = 0},
      {address = v.address + 0xC0, flags = gg.TYPE_DWORD, value = 1011},
      {address = v.address + 0xC4, flags = gg.TYPE_DWORD, value = 1},
	  {address = v.address + 0xC8, flags = gg.TYPE_DWORD, value = 0},
      {address = v.address + 0xE4, flags = gg.TYPE_DWORD, value = 0}
    })
    table.insert(valuesToFreeze, {address = v.address + 0x0, flags = gg.TYPE_DWORD, value = 1011, freeze = true})
    table.insert(valuesToFreeze, {address = v.address + 0x4, flags = gg.TYPE_DWORD, value = 1, freeze = true})
	table.insert(valuesToFreeze, {address = v.address + 0x8, flags = gg.TYPE_DWORD, value = 0, freeze = true})
    table.insert(valuesToFreeze, {address = v.address + 0x24, flags = gg.TYPE_DWORD, value = 0, freeze = true})
    table.insert(valuesToFreeze, {address = v.address + 0x60, flags = gg.TYPE_DWORD, value = 1011, freeze = true})
    table.insert(valuesToFreeze, {address = v.address + 0x64, flags = gg.TYPE_DWORD, value = 1, freeze = true})
	table.insert(valuesToFreeze, {address = v.address + 0x68, flags = gg.TYPE_DWORD, value = 0, freeze = true})
    table.insert(valuesToFreeze, {address = v.address + 0x84, flags = gg.TYPE_DWORD, value = 0, freeze = true})
    table.insert(valuesToFreeze, {address = v.address + 0xC0, flags = gg.TYPE_DWORD, value = 1011, freeze = true})
    table.insert(valuesToFreeze, {address = v.address + 0xC4, flags = gg.TYPE_DWORD, value = 1, freeze = true})
	table.insert(valuesToFreeze, {address = v.address + 0xC8, flags = gg.TYPE_DWORD, value = 0, freeze = true})
    table.insert(valuesToFreeze, {address = v.address + 0xE4, flags = gg.TYPE_DWORD, value = 0, freeze = true})
  end

if #valuesToFreeze > 0 then
    gg.addListItems(valuesToFreeze)
    gg.toast(string.format('Saved %d values to freeze list!', #valuesToFreeze), true)
else
    gg.alert('No values found to freeze!')
end

gg.toast('Battle Arena modification complete!', true)
gg.sleep(1500)
