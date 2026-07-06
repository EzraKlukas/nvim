-- Expand a snippet on a new line only.
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
s({trig="template", dscr="Basic template", condition = line_begin, snippetType="autosnippet"},
  fmta(
    [[
\input{~/.config/nvim/lua/snippets/tex/preambles/basic.tex}
\begin{document}
	<>
\end{document}
    ]],
    { i(1), } 
  )
),
}
