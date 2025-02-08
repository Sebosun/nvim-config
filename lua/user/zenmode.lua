local status_ok, zenmode = pcall(require, "zenmode")
if not status_ok then
	return
end

require("catppuccin").setup(zenmode)
