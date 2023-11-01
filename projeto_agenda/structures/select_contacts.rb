class SelectContacts
    def initialize(question, contacts)
        @question = question
        @contacts = contacts
    end
    
    def call(selected = nil)
        @contacts.each_with_index do |contact, index|
            puts "ID: #{index + 1} - Nome: #{contact["nome"]} - Telefone: #{contact["telefone"]}"
        end
    end

    def choose
        begin
            call
            input = gets.chomp.to_i
            if input <= 0 || input > @contacts.length
                raise "Opção inválida! Tente novamente."
            end
            input
        rescue => exception
            puts exception
            exit
        end
    end
end