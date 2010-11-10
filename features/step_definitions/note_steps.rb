Dado /^que existen los siguientes usuarios:$/ do |usuarios|
  usuarios.hashes.each do |credenciales|
    User.new(credenciales).save!
  end
end

Dado /^que existen las siguientes notas:$/ do |notas|
  notas.hashes.each do |nota|
    #es un hash de la forma {:content=>"contenido", :title=>"título", :user=>"correo@dominio.com"}
    n = Note.new(:content=>nota[:content])
    n.title = nota[:title] unless nota[:title].blank?
    n.user = User.find_by_email(nota[:user])
    n.save
  end
end

Dado /^que voy a la página de notas de "([^"]*)"$/ do |correo|
  visit user_notes_path(User.find_by_email(correo))
end

Dado /^borro la (\d+)(?:er(a)?) nota$/ do |pos|
  visit notes_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Entonces /^debería ver las siguientes notas:$/ do |tabla_esperada|
    tabla_esperada.diff!(tableish('table tr', 'td,th'))
end
