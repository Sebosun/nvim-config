local status_ok, dbee = pcall(require, "dbee")
if not status_ok then
	return
end


---@mod dbee.ref.config Dbee Configuration

-- Configuration object.
---@class Config
---@field default_connection? string
---@field sources? Source[] list of connection sources
---@field extra_helpers? table<string, table<string, string>>
---@field float_options? table<string, any>
---@field drawer? drawer_config
---@field editor? editor_config
---@field result? result_config
---@field call_log? call_log_config
---@field window_layout? Layout

---@class Candy
---@field icon string
---@field icon_highlight string
---@field text_highlight string

---Keymap options.
---@alias key_mapping { key: string, mode: string, opts: table, action: string|fun() }

---@divider -

---Configuration for result UI tile.
---@alias result_config { mappings: key_mapping[], page_size: integer, progress: progress_config, window_options: table<string, any>, buffer_options: table<string, any> }

---Configuration for editor UI tile.
---@alias editor_config { directory: string, mappings: key_mapping[], window_options: table<string, any>, buffer_options: table<string, any> }

---Configuration for call log UI tile.
---@alias call_log_config { mappings: key_mapping[], disable_candies: boolean, candies: table<string, Candy>, window_options: table<string, any>, buffer_options: table<string, any> }

---Configuration for drawer UI tile.
---@alias drawer_config { disable_candies: boolean, candies: table<string, Candy>, mappings: key_mapping[], disable_help: boolean, window_options: table<string, any>, buffer_options: table<string, any> }

---@divider -

-- DOCGEN_START
---Default configuration.
---To see defaults, run :lua= require"dbee.config".default
dbee.setup()
