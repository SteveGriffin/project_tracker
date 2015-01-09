json.array!(@sessions) do |session|
  json.extract! session, :id, :project_id, :start_time, :end_time, :task_id
  json.url session_url(session, format: :json)
end
