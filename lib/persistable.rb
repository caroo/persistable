require "persistable/version"
require "persistable/xt/hash"

require "persistable/factory"

##
# Persistable defines an abstract interface to save, retrieve and delete data from a storage.
# Currently memory, mogile_fs, file and cloud adapters are supported.
# The latter is powered by the {http://fog.io/storage/ fog gem}, so any fog storage provider can be used.
# Persistable has also a {Persistable::Factory factory class}, so you can use it to build your adapter using yml files.
module Persistable

end
