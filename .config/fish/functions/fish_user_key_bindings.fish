function fish_user_key_bindings
  bind \cs\cb scrapbook

  bind \cg\ca __select_git_add
  bind \cga   __select_git_add
  bind \cgc __select_ghq_cd
  bind \cr __select_history

  bind \cg\cg\cb __git_recent_all_branches
  bind \cgb   __git_recent_branches
  bind \cg\cb __git_recent_branches

  bind \cj __execute_wrapper
  bind \r  __execute_wrapper
end
