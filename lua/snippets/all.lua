return {
-- Italic font implementing visual selection
s({trig = "tii", regTrig = true, wordTrig = false, snippetType = "autosnippet", dscr = "Expands 'tii' into LaTeX's textit{} command."},
	fmta("\\textit{<>}",
		{
			d(1, get_visual),
		}
	)
),

s({trig = "uu", regTrig = true, wordTrig = false, snippetType = "autosnippet", dscr = "Expands 'uu' into LaTeX's underline{} command."},
	fmta("\\underline{<>}",
		{
			d(1, get_visual),
		}
	)
),

-- Bold font implementing visual selection
s({trig = "tb", snippetType = "autosnippet", dscr = "Expands 'tbb' into LaTeX's textbf{} command."},
	fmta("\\textbf{<>}",
		{
			d(1, get_visual),
		}
	)
),
}
