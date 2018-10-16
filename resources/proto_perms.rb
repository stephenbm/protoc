resource_name :proto_perms
property :path, String, name_property: true
property :match, String, default: '*'
property :mode, [String,Integer], default: 00644

action :update do
  Dir["#{new_resource.path}/#{new_resource.match}"].each do |fn|
    file fn do
      mode new_resource.mode
    end
  end
end
