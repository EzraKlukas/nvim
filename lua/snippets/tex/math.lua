local ls = require("luasnip")
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local sn = ls.snippet_node
local r = ls.restore_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local helpers = require('utils.luasnip')
local get_visual = helpers.get_visual
-- Include in any pertinent snippets file
local in_mathzone = function()
	return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
-- Include 'condition = in_mathzone' to any snippet you want to
-- expand only in math contexts.

return {
-- \texttt
s({trig="([^%a])tt", regTrig = true, wordTrig = false, snippetType = "autosnippet", dscr="Expands 'tt' into '\texttt{}'"},
	fmta(
		"\\texttt{<>}",
		{i(1)}
	)
),

-- Equation
s({trig="eq,", snippetType = "autosnippet", dscr="Expands 'eq,' into an equation environment"},
	fmta(
		[[
			\begin{equation*}
				<>
			\end{equation*}
		]],
		{ i(0) }
	)
),

s({trig="aln", snippetType = "autosnippet", dscr="Expands 'al8' into an align* environment"},
	fmta(
		[[
			\begin{align}
				<>
			\end{align}
		]],
		{ i(0) }
	)
),
-- Conditional snippet expansion
-- Makes mm expand to math mode (including visual selection) but not within a word.
s({trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet"},
	fmta(
		"<>$<>$",
		{
			f( function(_, snip) return snip.captures[1] end ),
			d(1, get_visual),
		}
	)
),
--Makes ee expand to e^{}, but not be triggered within words.
s({trig = '([^%a])ee', regTrig = true, wordTrig = false},
	fmta(
		"<>e^{<>}",
		{
			f( function(_, snip) return snip.captures[1] end ),
			d(1, get_visual)
		}
	)
),

--Makes ;e expand to ^{}, but not be triggered within words, and only within a math environment
s({trig = '(.);e', regTrig = true, wordTrig = false, snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "<>^{<>}",
    {
      f( function(_, snip) return snip.captures[1] end ),
      d(1, get_visual)
    }
  )
),

--Makes ;u expand to _{}, but not be triggered within words, and only within a math environment
s({trig = '(.);u', regTrig = true, wordTrig = false, snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "<>_{<>}",
    {
      f( function(_, snip) return snip.captures[1] end ),
      d(1, get_visual)
    }
  )
),

-- A fun zero subscript snippet
s({trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType="autosnippet"},
	fmta(
		"<>_{<>}",
		{
			f( function(_, snip) return snip.captures[1] end ),
			t("0")
		}
	)
),

-- GROUP THEORY SNIPPETS
s({trig = "zmod", snippetType="autosnippet", condition=in_mathzone},
  fmta(
    "\\Z/<>\\Z",
    {
      i(1, "n")
    }
  )
),

s({trig = "zxmod", snippetType="autosnippet", condition=in_mathzone},
  fmta(
    "\\left(\\Z/<>\\Z\\right)^{\\times}",
    {
      i(1, "n")
    }
  )
),

s({trig = ";z", snippetType="autosnippet", condition=in_mathzone},
  fmta(
    "\\Z",
    {}
  )
),

s({trig = "inz", snippetType="autosnippet", condition=in_mathzone},
  fmta(
    "\\in\\Z",
    {}
  )
),

s({trig = "sbar", snippetType="autosnippet", condition=in_mathzone},
  fmta(
    "\\bar{<>}",
    {
      i(1)
    }
  )
),

s({trig = "ism", snippetType="autosnippet", condition=in_mathzone},
  fmta(
    "\\cong",
    {}
  )
),

s({trig = "gen", snippetType = "autosnippet", condition=in_mathzone},
  fmta(
    "\\langle <> \\rangle",
    {
      i(1)
    }
  )
),

s({trig = "R+", snippetType = "autosnippet", condition=in_mathzone},
  fmta(
    "\\R^{+}",
    {}
  )
),
  

-- SOME PHYS 304 SNIPPETS
s({trig="ket", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "| <> \\rangle",
    {
      d(1, get_visual)
    }
  )
),

s({trig="bra", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\langle <> |",
    {
      d(1, get_visual)
    }
  )
),

s({trig="brkt", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\langle <> | <> \\rangle",
    {
      i(1),
      i(2),
    }
  )
),

s({trig="hrm", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "^{\\dagger}",
    {}
  )
),

s({trig="comm", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "[\\hat{<>}, \\hat{<>}]",
    {
      i(1),
      i(2),
    }
  )
),

s({trig=";h", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\hbar ",
    {}
  )
),

s({trig=";w", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\omega ",
    {}
  )
),

s({trig="ep", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\epsilon ",
    {}
  )
),

s({trig="nep", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\epsilon_{0} ",
    {}
  )
),

s({trig="nmu", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\mu_{0} ",
    {}
  )
),

s({trig="pt", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\frac{\\partial}{\\partial <>} ",
    {
      d(1, get_visual)
    }
  )
),

s({trig="tpt", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\frac{\\partial^{2}}{\\partial <>^{2}} ",
    {
      d(1, get_visual)
    }
  )
),

s({trig="fpt", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\frac{\\partial <>}{\\partial <>}",
    {
      i(1),
      i(2),
    }
  )
),

s({trig="tpft", snippetType = "autosnippet", condition = in_mathzone}, 
  fmta(
    "\\frac{\\partial^{2} <>}{\\partial <>^{2}}",
    {
      i(1),
      i(2),
    }
  )
),

s({trig="vc", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\vec{<>}",
    {
      d(1, get_visual)
    }
  )
),

s({trig="tl", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\tilde{<>}",
    {
      d(1, get_visual)
    }
  )
),

s({trig="L|", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\lVert",
    {}
  )
),

s({trig="R|", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\rVert",
    {}
  )
),

s({trig="sz", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\lVert <> \\rVert ",
    {
      d(1, get_visual)
    }
  )
),

s({trig="flr", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\lfloor <> \\rfloor ",
    {
      d(1, get_visual)
    }
  )
),

s({trig="cl", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\lceil <> \\rceil ",
    {
      d(1, get_visual)
    }
  )
),

s({trig="sep", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "|\\vec{r} -\\vec{r}'|",
    {}
  )
),

s({trig="lr", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\left( <> \\right)",
    {
      d(1, get_visual)
    }
  )
),

s({trig="ls", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\left[ <> \\right]",
    {
      d(1, get_visual)
    }
  )
),

s({trig="rp", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\vec{r}'",
    {}
  )
),

s({trig="dot", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\dot{<>}",
    {
      d(1, get_visual)
    }
  )
),

s({trig="ddt", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\ddot{<>}",
    {
      d(1, get_visual)
    }
  )
),

s({trig="bm", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\bm{<>}",
    {
      d(1, get_visual)
    }
  )
),
  
s({trig="pr", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "^{\\prime}",
    {}
  )
),

s({trig="pll", snippetType = "autosnippet", condition = in_mathzone},
  fmta(
    "\\parallel",
    {}
  )
),
}
