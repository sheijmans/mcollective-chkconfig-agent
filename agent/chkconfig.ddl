metadata    :name        => "chkconfig",
            :description => "MCollective Agent to manage/use chkconfig",
            :author      => "S. Heijmans",
            :license     => "ASL2",
            :version     => "0.0.3",
            :url         => "https://github.com/sheijmans/mcollective-chkconfig-agent",
            :timeout     => 30

action "list", :description => "chkconfig list a service" do
    display :always

    input :service,
          :prompt      => "service to list",
          :description => "service to list",
          :type        => :string,
          :validation  => '.',
          :optional    => false,
          :maxlength   => 30

    output :output,
           :description => "Output from chkconfig command",
           :display_as  => "Output"

    output :exitcode,
           :description => "The exitcode from the chkconfig command",
           :display_as => "Exit Code"

    if respond_to?(:summarize)
        summarize do
            aggregate summary("output")
        end
    end
end
