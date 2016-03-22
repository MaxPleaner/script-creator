class Script < ActiveRecord::Base
  validates :name, :content, presence: true
  def self.create_default_script
    Script.create(
      name: "example script",
      # make sure to escape #{} as \#{} in the heredoc for content
      content: <<-Script
# from stdlib
require 'shell'
sh = Shell.new

# see github.com/maxpleaner/ruby-cli-skeleton
script_dir = "./lib/ruby-cli-skeleton"
script_file = "\#{script_dir}/ruby-cli-skeleton"
script_caller_cmd = "bundle exec ruby"

# pipe stdin to the script
result = (
  sh.system("
    cd \#{script_dir} && echo '
      help 
      hello_world 
      puts %Q[Simulating user input from a a script]  
      exit
    '
  ") |\
  sh.system("\#{script_caller_cmd} \#{script_file}")
).to_s
puts result
      Script
    )
  end
end
