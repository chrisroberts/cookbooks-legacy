# This recipe only exists because the Lucid package is broken.

package "xulrunner-dev"

link "/usr/lib/libmozjs.so" do
  to "/usr/lib/xulrunner-1.9*/libmozjs.so"
end

package "mongodb"
