class Reader < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

def  reader_materials_count
  @reader_materials_count = Text.where(reader_id: self.id).count
end

def  reader_materials_list
  @reader_materials_list = Text.where(reader_id: self.id)
end

end
