vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true -- Automatische Einrückung
vim.opt.smartindent = true -- Smarte Einrückung
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true -- Tabs durch Leerzeichen ersetzen
vim.opt.smarttab = true -- Smarte Tab-Einrückung
vim.opt.shiftwidth = 2 -- Anzahl der Leerzeichen bei Einrückung
vim.opt.tabstop = 2 -- Wie viele Leerzeichen ein Tabulator entspricht
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- Weitere Optionen für noch besseres Einrückverhalten
vim.opt.smartcase = true -- Verbessert die Groß-/Kleinschreibungserkennung bei der Suche
vim.opt.autoindent = true -- Automatische Einrückung beibehalten
vim.opt.copyindent = true -- Kopiert die Einrückung aus der vorherigen Zeile
vim.opt.preserveindent = true -- Behalte die Einrückung, wenn du in eine neue Zeile springst
