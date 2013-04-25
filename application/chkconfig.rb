class MCollective::Application::Chkconfig<MCollective::Application
   description "MCollective Agent to manage/use chkconfig"

    usage <<-END_OF_USAGE
mco chkconfig [OPTIONS] [FILTERS] <ACTION> <service>

The ACTION can be one of the following:

    list <service> - list the service
    END_OF_USAGE

    def post_option_parser(configuration)
      if ARGV.size < 2
        raise "Please specify action"
      else
        action  = ARGV.shift
        service  = ARGV.shift

        unless action.match(/^(list)$/)
          raise "Action can only be list."
        end

        configuration[:action]  = action
        configuration[:service]  = service
      end
    end

    def validate_configuration(configuration)
      if MCollective::Util.empty_filter?(options[:filter])
        print "Do you really want to operate on " +
          "chkconfig unfiltered? (y/n): "

        STDOUT.flush

        # Only match letter "y" or complete word "yes" ...
        exit! unless STDIN.gets.strip.match(/^(?:y|yes)$/i)
      end
    end

    def main
      action  = configuration[:action]
      service = configuration[:service]

      mc = rpcclient("chkconfig", {:options => options})

      #printrpc mc.version(:options => options)
      mc.send(action, { :service => service }).each do |node|

        sender = node[:sender]
        data = node[:data]

        if data[:exitcode] == 1
          found = "chkconfig command failed!"
        else
          found = data[:output]
          printf("%-40s:\n", sender)
          printf("%-80s\n\n", found)
        end

      end

      mc.disconnect

      puts
      printrpcstats :summarize => true

    end
end
