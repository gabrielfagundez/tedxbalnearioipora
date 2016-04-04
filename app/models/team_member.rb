class TeamMember < ActiveRecord::Base

  def self.load_seeds
    TeamMember.create(name: 'Gabriel Fagundez', role: 'Team Leader')
    TeamMember.create(name: 'Santiago Estrago', role: 'Developer')
    TeamMember.create(name: 'Patricio Maite', role: 'Developer')
    TeamMember.create(name: 'Pablo Ifrán', role: 'Technical Architect')
    TeamMember.create(name: 'Andreas Fast', role: 'Team Leader')
    TeamMember.create(name: 'Lesly Acuña', role: 'Developer')
    TeamMember.create(name: 'Agustín Daguerre', role: 'Developer')
    TeamMember.create(name: 'JR González', role: 'Developer')
    TeamMember.create(name: 'Lucía Carozzi', role: 'Developer')
    TeamMember.create(name: 'Checho', role: 'Developer')
    TeamMember.create(name: 'Virgnia Rodríguez', role: 'Technical Architect')
  end

end
