%w( libxml2-dev libxslt1-dev ).each do |p|
  package p do
    action :upgrade
  end
end

gem_package "nokogiri" do
  action :upgrade
end
