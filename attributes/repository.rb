#
# Cookbook Name:: newrelic
# Attributes:: repository
#
# Copyright (c) 2016, David Joos
#

default['newrelic']['repository']['key'] = 'http://download.newrelic.com/548C16BF.gpg'
default['newrelic']['repository']['ssl_verify'] = true
case node['platform_family']
when 'debian'
  default['newrelic']['repository']['uri'] = 'http://download.newrelic.com/debian/'
  default['newrelic']['repository']['distribution'] = 'newrelic'
  default['newrelic']['repository']['components'] = ['non-free']
when 'rhel', 'fedora'
  default['newrelic']['repository']['uri'] = 'http://download.newrelic.com/pub/newrelic/el5/$basearch/'
end

# New Relic infrastructure repository
default['newrelic']['repository']['infrastructure']['key'] = 'https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg'
default['newrelic']['repository']['infrastructure']['ssl_verify'] = true
case node['platform_family']
when 'debian'
  default['newrelic']['repository']['infrastructure']['uri'] = 'https://download.newrelic.com/infrastructure_agent/linux/apt'
  default['newrelic']['repository']['infrastructure']['components'] = ['main']
when 'rhel', 'fedora'
  case node['platform']
  when 'amazon'
    case node['platform_version'].to_i
    when 2013, 2014, 2015, 2016, 2017
      rhel_version = 6
    end
  else
    rhel_version = node['platform_version'].to_i
  end

  default['newrelic']['repository']['infrastructure']['uri'] = "https://download.newrelic.com/infrastructure_agent/linux/yum/el/#{rhel_version}/x86_64"
end
