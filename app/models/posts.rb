class Posts < ActiveRecord::Base
  belongs_to :users

  has_one :files, :dependent => :destroy
end
