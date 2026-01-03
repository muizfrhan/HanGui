if _G.HANZ_COOL_LOADED then return end
_G.HANZ_COOL_LOADED = true

local base = "https://raw.githubusercontent.com/USERNAME/HANZ-COOL/main/"
loadstring(game:HttpGet(base.."engine.lua"))()
loadstring(game:HttpGet(base.."scheduler.lua"))()
loadstring(game:HttpGet(base.."config.lua"))()
loadstring(game:HttpGet(base.."ui.lua"))()

loadstring(game:HttpGet(base.."features/fishing.lua"))()
loadstring(game:HttpGet(base.."features/blatant.lua"))()
loadstring(game:HttpGet(base.."features/misc.lua"))()

_G.Engine:Start()
