require 'i18n'

path = Dir["#{File.expand_path('locales', __dir__)}/*.yml"]
I18n.load_path += path
