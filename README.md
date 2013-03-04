# MCollective Agent chkconfig

MCollective Agent to manage/use chkconfig.

To use this agent you need:

  * MCollective 2.2.1 at least

# TODO

  * ???

## Agent Installation

Follow the basic [plugin install guide](http://projects.puppetlabs.com/projects/mcollective-plugins/wiki/InstalingPlugins)

## Usage

All options and filters are available.

### List

chkconfig list a service wiith the MCollective Agent:

    $ mco rpc chkconfig list service=auditd

