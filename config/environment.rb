# Load the rails application
require File.expand_path('../application', __FILE__)
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
"$KCODE = 'u'"
# Initialize the rails application
TaskApp::Application.initialize!
