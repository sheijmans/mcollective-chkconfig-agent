module MCollective
  module Agent
    class Chkconfig<RPC::Agent

      action "list" do
        validate :service, String

        reply.fail! "Cannot find chkconfig at /sbin/chkconfig" unless File.exist?("/sbin/chkconfig")

        reply[:exitcode] = run("/sbin/chkconfig --list #{request[:service]}", :stdout => :output, :chomp => true)

        reply.fail! "chkconfig failed, exit code was #{reply[:exitcode]}" unless reply[:exitcode] == 0
      end

    end
  end
end

# vi:tabstop=2:expandtab:ai:filetype=ruby
