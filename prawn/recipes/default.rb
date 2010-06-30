include_recipe "rmagick"

%w( prawn prawn-fast-png ).each do |g|
  gem_package g do
    action :upgrade
  end
end
