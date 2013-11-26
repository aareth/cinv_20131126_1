guard 'rspec', :cli => "--color --format nested" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}){ |item| "spec/specs/#{item[1]}_spec.rb" }
  watch('spec/spec_helper.rb'){ "spec" }
end

notification :tmux,
  :display_message => true,
  :timeout => 5,
  :default_message_format => '%s >> %s',
  :line_separator => ' > ', 
  :color_location => 'status-left-bg'

