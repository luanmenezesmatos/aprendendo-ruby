# Adicionar, Editar e Remover Contato;
# Contato terão as seguintes informações: Nome e telefone;
# Poderemos ver todos os contatos registrados ou somente um contato (fitlro por nome);

require('json')

require_relative './structures/select_option'

# Chamando a classe "select_option" e passando os parâmetros
# Instanciando a classe "select_option"
question = "Seja bem-vindo(a) a agenda de contatos, o que deseja fazer?\n\n"
options = ["Adicionar contato", "Editar contato", "Remover contato", "Ver todos os contatos", "Ver um contato", "Sair"]
option_selector = SelectOption.new(question, options)

agenda_database_file = File.open('./database/database.json', 'r')
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

        agenda_database_file = File.open('./database/database.json', 'w')
        agenda_database_file.write(@agenda.to_json)
        agenda_database_file.close

        puts "Contato adicionado com sucesso!"
    end
end

def edit_contact
    puts "Digite o nome do contato que deseja editar:"
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
def all_contacts
    @agenda.each do |contact|
        puts "Nome: #{contact[:nome]}"
        puts "Telefone: #{contact[:telefone]}"
        puts "-" * 20
        puts
    end
end

loop do
  choice = option_selector.choose
  puts "Você escolheu: #{options[choice - 1]}"

  case choice
  when 1
        add_contact
  when 2
      puts "Editar contato"
  when 3
      puts "Remover contato"
  when 4
        all_contacts
  when 5
      puts "Ver um contato"
  when 6
      puts "Até logo!"
      break
  end
end