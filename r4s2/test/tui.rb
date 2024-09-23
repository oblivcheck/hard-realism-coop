require 'cli/ui'
CLI::UI::StdoutRouter.enable


#CLI::UI.ask('What language/framework do you use?', options: %w(rails go ruby python))
CLI::UI::SpinGroup.new do |spin_group|
  spin_group.add('Title')   { |spinner| sleep 3.0 }
 # spin_group.add('Title 2') { |spinner| sleep 3.0; spinner.update_title('New Title'); sleep 3.0 }
end
