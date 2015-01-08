class Tracking

def self.time_difference(start_time, end_time)
	@difference = start_time - end_time
	
end

def self.get_time
	Time.now
end

end