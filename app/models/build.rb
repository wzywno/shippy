class Build < ActiveRecord::Base
  enum status: [:queued, :in_progress, :fail, :success]
end
