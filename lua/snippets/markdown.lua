local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local function today()
	return os.date("%Y-%m-%d")
end

return {
	s(
		{ trig = "dailylog", dscr = "Daily note template" },
		fmta(
			[[
# {date}

## Focus
> {focus}

## Progress
- 

## Next Steps
- [ ] 
]],
			{
				date = f(today),
				focus = i(1),
			},
			{ delimiters = "{}" }
		)
	),

	s(
		{ trig = "topiclog", dscr = "New dated topic log section" },
		fmta(
			[[
---

## <>

### What I did
- <>

### Notes
- 

### Results
- 

### Questions / Confusions
- 

### Next steps
- 
]],
			{
				f(today),
				i(1),
			}
		)
	),

	s(
		{ trig = "topicnote", dscr = "New topic note template" },
		fmta(
			[[
# <>

## Overview
- Goal:
- Context:

## Key Takeaways
- 

## Open Questions
- 

---

## <>

### What I did
- <>

### Notes
- 

### Results
- 

### Questions / Confusions
- 

### Next steps
- 
]],
			{
				i(1, "Topic Title"),
				f(today),
				i(2),
			}
		)
	),
}
