class HomeController < InheritedResources::Base
  respond_to :html, :json
  actions :index
  defaults resource_class: User, collection_name: 'users', instance_name: 'user'
end
