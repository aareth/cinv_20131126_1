def exit_if_on_the_branch(branch)
  exit_if_branch_condition_fails(lambda{|expression,status|expression =~ status},branch,lambda{|item|  "You cant run this command on the branch #{item}"})
end

def exit_if_not_on_the_branch(branch)
  exit_if_branch_condition_fails(lambda{|expression,status|expression !~ status},branch,lambda{|item| "You need to run this on the branch #{item}"})
end

def exit_if_branch_condition_fails(specification_block,branch,message_block)
  status = run_git_command("branch",true)
  match_expression = %r/\* #{branch}/

  if (specification_block.call(match_expression,status))
    puts message_block.call(branch)
    exit
  end
end

def run_git_command(command,capture_ouptut = false)
    full_command = "git #{command}"
    if (capture_ouptut)
        `#{full_command}`
    else
        system(full_command)
    end
end

def checkout(branch_name)
  run_git_command("checkout -b #{branch_name}")
  run_git_command("checkout #{branch_name}")
end


def pick_item_from(items,prompt)
  items.each_with_index{|item,index| p "#{index + 1} - #{item}"}
  p prompt
  index = gets.chomp.to_i
  return index == 0 ? "": items[index-1]
end
