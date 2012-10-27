local setupGuide = require "setup"

setupGuide(2, {})

local Output = require "output/recommended_items"

local n = 0
for _, guide in pairs(Guides) do
	local hero = guide.hero
	if hero.valveId then
		print(hero.id, hero.valveGuide)
		n = n + 1
		withOutput('../results/itembuilds/'..(hero.valveGuide), 'w', function()
			Output.print_hero_guide( guide )
		end)
	end
end
print("Wrote "..n.." guides")