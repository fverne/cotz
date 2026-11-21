-- Syntax-only check used by tests/run.sh --syntax: compiles each file without running it.
local failed = false
for _, path in ipairs(arg) do
	local chunk, err = loadfile(path)
	if not chunk then
		print(err)
		failed = true
	end
end

os.exit(failed and 1 or 0)
