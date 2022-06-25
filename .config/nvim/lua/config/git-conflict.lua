local status_ok, git_conflict = pcall(require, "git-conflict")
if not status_ok then
	return
end

git_conflict.setup()
