%w( libxml2-dev libxslt1-dev ).each do |p|
  package p do
    action :upgrade
  end
end

ree_gem "nokogiri"
