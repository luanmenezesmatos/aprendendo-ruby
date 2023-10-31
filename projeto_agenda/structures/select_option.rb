class SelectOption
    def initialize(question, options)
        @question = question
        @options = options
    end
  
    def display
        puts @question
        @options.each_with_index do |option, index|
            puts "#{index + 1} - #{option}"
        end
      puts
    end
  
    def choose
        begin
            display
            input = gets.chomp.to_i
            if input <= 0 || input > @options.length
            raise "Opção inválida! Tente novamente."
            end
            input
         rescue => exception
            puts exception
            exit
      end
    end
  end