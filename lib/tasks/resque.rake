require "resque/tasks"

task "resque:setup" => :environment # Load up rails environment when worker starts up. Have access to all models in workers.
