#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'yum-epel'

template '/etc/yum.repos.d/nginx.repo' do
  mode 0644
  user 'root'
  group 'root'
end

package 'nginx' do
  action :upgrade
end

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

template '/etc/nginx/nginx.conf' do
  source 'conf/nginx.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'service[nginx]'
end

directory '/etc/nginx/ssl/' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

directory '/var/log/nginx/' do
  owner 'nginx'
  group 'root'
  mode 0755
  action :create
end

directory '/var/www' do
  owner 'nginx'
  group 'root'
  mode 0777
  action :create
end
