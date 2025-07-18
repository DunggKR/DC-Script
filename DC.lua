-- Combined Dragon City Ultimate Mod with Test Skill Integration &amp; Revert Paste Feature
gg.setVisible(false)

local path = "/storage/emulated/0/Download/1.8.0.txt"
local oldPath = "/storage/emulated/0/Download/1.7.0.txt"
local file = io.open(path, "r")

if file then
    file:close()
else
    gg.alert("A new update V1.8.0 is available! Please update now!\n Update for more feature!", "Update Now")
    
    gg.toast("Updating...")
    gg.searchNumber(":updateversion", gg.TYPE_AUTO)
    gg.sleep(2000)
    
    -- Delete old version file
    os.remove(oldPath)
    
    local newFile = io.open(path, "w")
    if newFile then
        newFile:write("Dungg V1.8.0")
        newFile:close()
        gg.alert("Update successful!")
    else
        gg.alert("Error during update!")
    end
end

gg.setVisible(false)
-------------------------------------------------------------------------
-------------------------------------------------------------------------
local MD5 = gg.makeRequest('').content
function Main()
menu = gg.choice({
'⚔️ Battle Arena Mod',
'🔓 Unfreeze Value',
'🗡️ Quest Mod ( Rankup )',
'🐲 Recall Dragon',
'🔑 Dragon Rescue Mod',
'➡️ Test/Train Skill Mod',
'🏁 Event Battle Speed',
'📞 Help ❓',
'❌ Exit Script'
},nil, 'Dragon City Tools\nOriginal and Inspired by Thiện Uzumaki Clan\nRescripted by Comet 💫💗\nFanmade Script')
if menu == 1 then DragonCityHack1() end
if menu == 2 then DragonCityHack2() end
if menu == 3 then DragonCityHack3() end
if menu == 4 then DragonCityHack4() end
if menu == 5 then DragonCityHack5() end
if menu == 6 then DragonCityHack6() end
if menu == 7 then DragonCityHack7() end
if menu == 8 then DragonCityHack8() end
if menu == 9 then DragonCityHack9() end
if menu == 10 then DragonCityHack10() end
if menu == 11 then DragonCityHack11() end
if menu ==nil then NoSelect() end
end
function DragonCityHack1()
L = gg.makeRequest('https://raw.githubusercontent.com/DunggComet/DC-Script/main/Arena.lua').content
if not L then gg.alert('SERVER: Allow Internet Connection...') else
pcall(load(L)) end
end

function DragonCityHack2()
  gg.setVisible(false)
  local frozenItems = gg.getListItems()
  if #frozenItems > 0 then
    gg.removeListItems(frozenItems)
    gg.toast('All values have been unfrozen!')
  else
    gg.toast('No frozen values found!')
  end
end

function DragonCityHack3()
L = gg.makeRequest('https://raw.githubusercontent.com/DunggComet/DC-Script/main/Quest.lua').content
if not L then gg.alert('SERVER: Allow Internet Connection...') else
pcall(load(L)) end
end

function DragonCityHack4()
L = gg.makeRequest('https://raw.githubusercontent.com/DunggComet/DC-Script/main/Recall.lua').content
if not L then gg.alert('SERVER: Allow Internet Connection...') else
pcall(load(L)) end
end

function DragonCityHack5()
L = gg.makeRequest('https://raw.githubusercontent.com/DunggComet/DC-Script/main/Rescue.lua').content
if not L then gg.alert('SERVER: Allow Internet Connection...') else
pcall(load(L)) end
end

function DragonCityHack6()
L = gg.makeRequest('https://raw.githubusercontent.com/DunggComet/DC-Script/main/TrainSkill.lua').content
if not L then gg.alert('SERVER: Allow Internet Connection...') else
pcall(load(L)) end
end

function DragonCityHack7()
L = gg.makeRequest('https://raw.githubusercontent.com/DunggComet/DC-Script/main/EventBattleSkip.lua').content
if not L then gg.alert('SERVER: Allow Internet Connection...') else
pcall(load(L)) end
end

function DragonCityHack8()
L = gg.makeRequest('https://raw.githubusercontent.com/DunggComet/DC-Script/main/Help.lua').content
if not L then gg.alert('SERVER: Allow Internet Connection...') else
pcall(load(L)) end
end

function DragonCityHack9()
os.exit()
end

function NoSelect()
gg.sleep(100)
gg.toast('Script Made By Comet 💫💗')
end

-------------------------------------------------------------------------
gg.setVisible(true)
while true do
if gg.isVisible() then
gg.setVisible(false)
Main() end end
-------------------------------------------------------------------------
