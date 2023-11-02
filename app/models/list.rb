class List < ApplicationRecord
  def self.texts 
  scope=self.pluck(:text)
  end
end
