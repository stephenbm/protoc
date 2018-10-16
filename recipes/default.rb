#
# Cookbook:: protoc
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


remote_file "#{node['protoc']['cache']}/protoc-#{node['protoc']['version']}-#{node['protoc']['arch']}.zip" do
  source "#{node['protoc']['url']}/v#{node['protoc']['version']}/protoc-#{node['protoc']['version']}-#{node['protoc']['arch']}.zip"
  checksum node['protoc']['checksum']
  owner node['dotfiles']['user']
  group node['dotfiles']['group']
  notifies :run, 'execute[unzip-protoc]', :delayed
end

execute 'unzip-protoc' do
  command "unzip -n #{node['protoc']['cache']}/protoc-#{node['protoc']['version']}-#{node['protoc']['arch']} -d /usr/local"
  action :nothing
end


proto_perms '/usr/local/include/google/protobuf' do
  match '*.proto'
  mode 00644
end
