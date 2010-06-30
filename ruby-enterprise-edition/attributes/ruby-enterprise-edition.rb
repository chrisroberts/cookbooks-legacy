if kernel[:machine] == "x86_64"
  deb = "ruby-enterprise_1.8.7-2010.02_amd64_ubuntu10.04.deb"
  default[:ree][:project_url] = "http://rubyforge.org/frs/download.php/71098/#{deb}"
  default[:ree][:checksum] = "583c085d"
else
  deb = "ruby-enterprise_1.8.7-2010.02_i386_ubuntu10.04.deb"
  default[:ree][:project_url] = "http://rubyforge.org/frs/download.php/71100/#{deb}"
  default[:ree][:checksum] = "39f01e42"
end

default[:ree][:deb] = deb
