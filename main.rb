require 'backlog_kit'
require 'dotenv'

Dotenv.load

client = BacklogKit::Client.new(
  space_id: ENV['SPACE_ID'],
  api_key: ENV['API_KEY']
)

tickets = File.read('./tickets.md')

tickets.split('TICKET_END').each{
    title = _1.match(/^### .+$/).to_s.sub(/### /, '')
    client.create_issue(title, {project_id: ENV['PROJECT_ID'], issue_type_id: ENV['ISSUE_TYPE_ID'], priority_id: ENV['PRIORITY_ID'], description: _1})
}
