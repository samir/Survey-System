# ---------------------------------------------------------------------------------------
# Ruby’s ThreadError: deadlock; recursive locking bug
# http://blog.stochasticbytes.com/2011/01/rubys-threaderror-deadlock-recursive-locking-bug/
# ---------------------------------------------------------------------------------------
require "thread"
class Mutex
  def lock_with_hack
    lock_without_hack
  rescue ThreadError => e
    if e.message != "deadlock; recursive locking"
      raise
    else
      unlock
      lock_without_hack
    end
  end
  alias_method :lock_without_hack, :lock
  alias_method :lock, :lock_with_hack
end
# ---------------------------------------------------------------------------------------

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SurveySystem::Application.initialize!
