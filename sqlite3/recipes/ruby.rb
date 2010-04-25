include_recipe "sqlite3"

gem_package "sqlite3-ruby" do
  action :upgrade
end

