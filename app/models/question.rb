# == Schema Information
#
# Table name: questions
#
#  id          :bigint           not null, primary key
#  contents    :string
#  sensitivity :string
#  title       :string
#
class Question < ApplicationRecord
end
