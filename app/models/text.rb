require 'prose' # определям латиница / кириллица

class Text < ApplicationRecord
  belongs_to :reader
  validates :description, presence: true, length: { maximum: 2500 }
 


# описание текста    
def text_description
  #@text_description =  "поэтому необходмо бежать "
  @text_description =  self.description
end

# определям латиница / кириллица
def text_language
    @text_description.prose
end

# метод подсчета кол-ва слов во всем тексте
def total_words_in_the_text
  @total_words_in_the_text = @text_description.split.count {|i| i.size}
end

# метод подсчета общего кол-ва слогов
def total_syllables_in_the_text
  @text_description.downcase!
  return 1 if @text_description.length <= 3
  @text_description.sub!(/(?:[^laeiouy]es|ed|[^laeiouy]e)$/, '')
  @text_description.sub!(/^y/, '')
  @total_syllables_in_the_text = @text_description.scan(/[aeiouy]{1,2}/).size + @text_description.scan(/[аїіеоёиэуыяю]{1,2}/).size   
end


# метод подсчета общего кол-ва символов (размер массива слов текста)
def total_letters_in_the_text
    @total_letters_in_the_text = @text_description.size
end

# метод подсчета общего кол-ва печатных  символов ( кол-во латинских + кол-во кирилический)
def total_print_letters_in_the_text
    @total_print_letters_in_the_text = @text_description.scan(/[A-z]/).size + @text_description.scan(/[А-я]/).size
end

# метод подсчета общего кол-ва предложений (считаем по количеству точек с пробелом после нее)
def total_sentence_in_the_text
    #@text_description = @text_description.sub!("[...]", "") # исключим много точия из расчета 
    @total_sentence_in_the_text = @text_description.scan(/\.|\?|!/).size 
end

# метод подсчета средней дляины слова в тексте
def middle_word_length_in_the_text
 @middle_word_length_in_the_text = self.total_print_letters_in_the_text / self.total_words_in_the_text
end

# метод создания массива предложений со всего текса
def list_of_sentence_in_the_text
  @list = self.text_description.split(/\.|\?|!/)
  massive_dlin = []
  @list.each do |sentence|
   @p = sentence
    #print @p, ' длина:', @p.length
    massive_dlin = massive_dlin.push(@p.length)
  end
  #p massive_dlin
  srednee = massive_dlin.reduce(:+) / massive_dlin.size.to_f
  #p srednee
 end
 
 #средняя длина предожения в символах 
def middle_length_of_sentence_in_the_text
  @list = self.text_description.strip.split(/\.|\?|!/)
  massive_dlin = []
  @list.each do |sentence|
   @p = sentence
    print @p, ' длина:', @p.length
    massive_dlin = massive_dlin.push(@p.length)
  end
  #p massive_dlin
  srednee = massive_dlin.reduce(:+) / massive_dlin.size.to_f
  #p srednee
  @middle_length_of_sentence_in_the_text  = srednee
end


# ASL средняя длина предожения в словах  (поделить кол-во слов на кол-во предложений)
def middle_length_of_sentence_in_words_in_the_text
  (self.total_words_in_the_text.to_f / self.total_sentence_in_the_text.to_f).round(4)
end

# ASW метод подсчета средней длины слова в слогах (общее кол-во слогов/ общее кол-во слов)
def middle_length_of_word_in_the_syllables
  @middle_length_of_word_in_the_syllables = (self.total_syllables_in_the_text.to_f / self.total_words_in_the_text.to_f).round(4)
end


# коэф-т отношения кол-ва слогов к кол-ву слов
def total_words_in_the_text_with_syllables
   ( ( self.text_description.scan(/[аїіеоёиэуыяю]/).size + self.text_description.scan(/[aiouy]+e*|e(?!d$|ly).|[td]|ed|le$/).size ) / self.total_words_in_the_text.to_f ).round(2)
end

# метод определения сложности текста математическим методом
def difficulty_method
  case self.rudolf_flesh_method
  when  100 .. 200 
    p "очень легко читается"
  when  65 .. 99 
    p "простой"
  when  30 .. 64 
    p "немного трудно читать"
  else 
     p "очень трудно читать"
  end
end

# метод определения сложности текста  методом Рудольфа Флеша
def rudolf_flesh_method
  case self.text_description.prose
  when 'latin'
    (206.835 - 1.015 * self.middle_length_of_sentence_in_words_in_the_text - 84.6 * self.middle_length_of_word_in_the_syllables).round(2)
  else
    (206.835 - 1.3 * self.middle_length_of_sentence_in_words_in_the_text - 60.1 * self.middle_length_of_word_in_the_syllables).round(2)
  end
end

end
