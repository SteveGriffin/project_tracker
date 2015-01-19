json.array!(@collaborators) do |collaborator|
  json.extract! collaborator, :id, :user_id, :project_id
  json.url collaborator_url(collaborator, format: :json)
end
