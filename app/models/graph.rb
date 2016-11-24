# == Schema Information
#
# Table name: graphs
#
#  id            :integer          not null, primary key
#  name          :string
#  max_value     :float
#  min_value     :float
#  values        :float            default([]), is an Array
#  values_in_sec :integer
#  size          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Graph < ApplicationRecord
  
end
