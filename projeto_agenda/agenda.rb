# Adicionar, Editar e Remover Contato;
# Contato terão as seguintes informações: Nome e telefone;
# Poderemos ver todos os contatos registrados ou somente um contato (fitlro por nome);

require("json")

require_relative "./structures/select_option"
require_relative "./structures/select_contacts"

# Chamando a classe "select_option" e passando os parâmetros
# Instanciando a classe "select_option"
question = "Seja bem-vindo(a) a agenda de contatos, o que deseja fazer?\n\n"
options = ["Adicionar contato", "Editar contato", "Remover contato", "Ver todos os contatos", "Ver um contato", "Sair"]
option_selector = SelectOption.new(question, options)

agenda_database_file = File.open("./database/database.json", "r")
agenda_database = agenda_database_file.read

@agenda = JSON.parse(agenda_database)

def add_contact
    puts "Digite o nome do contato:"
    nome = gets.chomp

        # Verificar se já existe um contato com o nome informado
    if @agenda["agenda"].any? { |contact| contact["nome"] == nome }
        puts "Já existe um contato com esse nome!"
        return add_contact # Retornar para a digitação do nome do contato
    else
        puts "Digite o telefone do contato:"
        telefone = gets.chomp
    end

    # Verificar se já existe um contato com o telefone informado
    if @agenda["agenda"].any? { |contact| contact["telefone"] == telefone }
        puts "Já existe um contato com esse telefone!"
        return add_contact # Retornar para a digitação do nome do contato
    end

    # Verificar se já existe um contato com o nome e telefone informados
    if @agenda["agenda"].any? { |contact| contact["nome"] == nome && contact["telefone"] == telefone }
        puts "Já existe um contato com esse nome e telefone!"
        return add_contact # Retornar para a digitação do nome do contato
    end

    # Verificar se o telefone informado possui 11 dígitos
    if telefone.length != 11
        puts "O telefone deve conter 11 dígitos!"
        return add_contact # Retornar para a digitação do nome do contato
    end

    puts nome
    puts telefone

    # Verificar se a agenda está cheia
    if @agenda["agenda_cheia"] == true
        puts "A agenda está cheia!"
    else
        @agenda["agenda"] << { nome: nome, telefone: telefone }

        agenda_database_file = File.open("./database/database.json", "w")
        agenda_database_file.write(@agenda.to_json)
        agenda_database_file.close

        puts "Contato adicionado com sucesso!"
    end
end

def edit_contact
    contact_question = "Selecione um contato para editar (ou digite '0' para cancelar):\n\n"
    contact_selector = SelectContacts.new(contact_question, @agenda["agenda"])
    contact_index = contact_selector.choose

    input = gets.chomp.to_i

    case input
    when 0
        puts "Operação cancelada!"
    else
        puts "Digite o novo nome do contato:"
        nome = gets.chomp

        puts "Digite o novo telefone do contato:"
        telefone = gets.chomp

        # Verificar se o novo contato já existe
        if @agenda["agenda"].any? { |contact| contact["nome"] == nome && contact["telefone"] == telefone }
            puts "Já existe um contato com esse nome e telefone!"
        else
            @agenda["agenda"][contact_index - 1]["nome"] = nome
            @agenda["agenda"][contact_index - 1]["telefone"] = telefone

            agenda_database_file = File.open("./database/database.json", "w")
            agenda_database_file.write(@agenda.to_json)
            agenda_database_file.close

            puts "Contato editado com sucesso!"
        end
    end
end

def remove_contact
    contact_question = "Selecione um contato para editar (ou digite '0' para cancelar):\n\n"
    contact_selector = SelectContacts.new(contact_question, @agenda["agenda"])
    contact_index = contact_selector.choose

    input = gets.chomp.to_i

    if input
        @agenda["agenda"].delete_at(contact_index - 1)

        agenda_database_file = File.open("./database/database.json", "w")
        agenda_database_file.write(@agenda.to_json)
        agenda_database_file.close

        puts "Contato removido com sucesso!"
    else
        puts "Operação cancelada!"
    end
end

def all_contacts
    @agenda["agenda"].each do |contact|
        puts "\nNome: #{contact["nome"]}"
        puts "Telefone: #{contact["telefone"]}"
        puts "-" * 20
        puts
    end
end

def view_contact
    puts "Digite o nome do contato:"
    nome = gets.chomp

    contact = @agenda["agenda"].find { |contact| contact["nome"] == nome }

    if contact
        puts "Nome: #{contact["nome"]}"
        puts "Telefone: #{contact["telefone"]}"
        puts "-" * 20
        puts
    else
        puts "Contato não encontrado!"
    end
end

loop do
    choice = option_selector.choose
    puts "Você escolheu: #{options[choice - 1]}"

    case choice
    when 1
        add_contact
    when 2
        edit_contact
    when 3
        remove_contact
    when 4
        all_contacts
    when 5
        view_contact
    when 6
        puts "Até logo!"
        break
    end
end
