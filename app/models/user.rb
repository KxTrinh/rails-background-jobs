class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_commit :update_with_clearbit_api
  
  private

  def update_with_clearbit_api
    UpdateUserJob.perform_later(id)
  end
end
